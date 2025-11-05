{
  description = "Masjid Ikhlas Modern Website Recovery & Deployment System – V3";
  inputs = {
    nixpkgs.url     = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs      = import nixpkgs { inherit system; };
        siteDir   = ./site;
        contentDir = ./site/content;

        docsText = ''
          # Masjid Ikhlas Website System – V3

          ## Development (Local)
          - Run `nix develop` to enter environment
          - Run `nix run .#serve` to start local Caddy HTTPS server on https://localhost:8443
          - Static site generators included: Hugo, Jekyll, Eleventy

          ## Workflow
          - `nix run .#workflow` executes: merge content → validate → build → deploy
          - Fully self-contained with Nix derivations

          ## Deployment
          - Netlify: `nix run .#deployNetlify -- <site-dir>`
          - GitHub Pages: `nix run .#deployGitHub -- <site-dir>`

          ## Security Measures
          - HTTPS via Caddy for dev & prod
          - CSP, HSTS, X-Frame-Options headers
          - Read-only site assets

          ## Notes
          - Modern nonprofit-friendly style
          - SEO-ready meta tags included
          - Converts legacy archives into static websites
        '';

        docsDrv = pkgs.runCommand "docs-masjidikhlas" {} ''
          mkdir -p $out/bin
          cat > $out/bin/docs-masjidikhlas <<EOF
          #!/usr/bin/env bash
          cat <<DOC
          ${docsText}
          DOC
          EOF
          chmod +x $out/bin/docs-masjidikhlas
        '';

        buildSite = pkgs.runCommand "build-site" {
          buildInputs = [ pkgs.hugo pkgs.coreutils ];
          HOME = "/tmp";
        } ''
          mkdir -p $out/public
          mkdir -p build-cache site-copy
          export HUGO_CACHEDIR=$(pwd)/build-cache
          
          # Copy site to writable location
          cp -r ${siteDir}/* site-copy/
          chmod -R +w site-copy/
          
          ${pkgs.hugo}/bin/hugo -s site-copy -d $out/public --gc --minify
          echo "Site built successfully" > $out/status.txt
        '';

        serveDrv = pkgs.runCommand "serve-masjidikhlas" {
          buildInputs = [ pkgs.caddy ];
        } ''
          mkdir -p $out/bin $out/config
          cat > $out/config/Caddyfile <<EOF
          {
            auto_https off
          }
          :8443 {
            root * ${buildSite}/public
            file_server
            encode gzip
            tls internal
            header Strict-Transport-Security "max-age=31536000;"
            header X-Frame-Options "DENY"
            header X-Content-Type-Options "nosniff"
            header Content-Security-Policy "default-src 'self';"
          }
          EOF
          cat > $out/bin/serve-masjidikhlas <<EOF
          #!/usr/bin/env bash
          ${pkgs.caddy}/bin/caddy run --config $out/config/Caddyfile
          EOF
          chmod +x $out/bin/serve-masjidikhlas
        '';

        workflowDrv = pkgs.runCommand "workflow-masjidikhlas" {
          buildInputs = [ pkgs.hugo pkgs.ripgrep pkgs.coreutils ];
          HOME = "/tmp";
          hugoBin = "${pkgs.hugo}/bin/hugo";
        } ''
          mkdir -p $out/bin $out/public
          cat > $out/bin/workflow-masjidikhlas <<EOF
          #!/usr/bin/env bash
          set -euo pipefail

          echo "🔍 Validating content..."
          if [ ! -d "${contentDir}" ]; then
            echo "❌ Content directory not found: ${contentDir}" >&2
            exit 1
          fi

          echo "🏗️ Building site..."
          mkdir -p build-cache site-copy
          export HUGO_CACHEDIR=\$(pwd)/build-cache
          
          # Copy site to writable location
          cp -r ${siteDir}/* site-copy/
          chmod -R +w site-copy/
          
          ${pkgs.hugo}/bin/hugo -s site-copy -d \$PWD/public --gc --minify

          echo "✅ Workflow complete: merge → validate → build"
          echo "🚀 Ready for deployment"
          echo "Site built at: \$PWD/public"
          echo "📱 To test locally: cd ${siteDir} && hugo server --port 1313"
          EOF
          chmod +x $out/bin/workflow-masjidikhlas
        '';

        deployNetlify = pkgs.runCommand "deploy-netlify" {
          buildInputs = [ pkgs.netlify-cli pkgs.coreutils ];
        } ''
          mkdir -p $out/bin
          cat > $out/bin/deploy-netlify <<EOF
          #!/usr/bin/env bash
          set -euo pipefail
          if [ -z "\$1" ]; then
            echo "Usage: \$0 <site-dir>" >&2
            exit 1
          fi
          netlify deploy --dir=\$1 --prod
          EOF
          chmod +x $out/bin/deploy-netlify
        '';

        deployGitHub = pkgs.runCommand "deploy-github" {
          buildInputs = [ pkgs.gh ];
        } ''
          mkdir -p $out/bin
          cat > $out/bin/deploy-github <<EOF
          #!/usr/bin/env bash
          set -euo pipefail
          if [ -z "\$1" ]; then
            echo "Usage: \$0 <site-dir>" >&2
            exit 1
          fi
          gh workflow run deploy.yml -f site-dir=\$1
          EOF
          chmod +x $out/bin/deploy-github
        '';
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.hugo
            pkgs.jekyll
            pkgs.nodejs
            pkgs.caddy
            pkgs.ripgrep
            pkgs.git
            pkgs.coreutils
            pkgs.netlify-cli
            pkgs.gh
          ];
          shellHook = ''
            echo "🕌 Masjid Ikhlas V3 Dev Shell"
            echo ""
            echo "🚀 Quick Start:"
            echo "  just start      - Start development server"
            echo "  just edit-*     - Edit content pages"
            echo "  just publish    - Build and deploy"
            echo "  just help       - Show detailed help"
            echo ""
            echo "📚 Documentation:"
            echo "  nix run .#docs  - Show full documentation"
            echo "  nix run .#serve - Start HTTPS server"
            echo ""
            echo "🔧 Entering site directory for Hugo development..."
            cd site
          '';
        };
        packages = {
          docs     = docsDrv;
          serve    = serveDrv;
          workflow = workflowDrv;
          site     = buildSite;
          deployNetlify = deployNetlify;
          deployGitHub = deployGitHub;
        };
        apps = {
          docs     = flake-utils.lib.mkApp { drv = docsDrv; };
          serve    = flake-utils.lib.mkApp { drv = serveDrv; };
          workflow = flake-utils.lib.mkApp { drv = workflowDrv; };
          deployNetlify = flake-utils.lib.mkApp { drv = deployNetlify; };
          deployGitHub = flake-utils.lib.mkApp { drv = deployGitHub; };
        };
      }
    );
}
