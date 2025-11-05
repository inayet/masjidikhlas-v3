// Mobile Menu Toggle
document.addEventListener('DOMContentLoaded', function() {
    const mobileMenuToggle = document.querySelector('.mobile-menu-toggle');
    const mainNav = document.querySelector('.main-nav');
    
    if (mobileMenuToggle && mainNav) {
        mobileMenuToggle.addEventListener('click', function() {
            mainNav.classList.toggle('active');
            
            // Animate hamburger menu
            const spans = mobileMenuToggle.querySelectorAll('span');
            if (mainNav.classList.contains('active')) {
                spans[0].style.transform = 'rotate(-45deg) translate(-5px, 6px)';
                spans[1].style.opacity = '0';
                spans[2].style.transform = 'rotate(45deg) translate(-5px, -6px)';
            } else {
                spans[0].style.transform = 'none';
                spans[1].style.opacity = '1';
                spans[2].style.transform = 'none';
            }
        });
    }
    
    // Close mobile menu when clicking outside
    document.addEventListener('click', function(event) {
        if (!event.target.closest('.site-header') && mainNav.classList.contains('active')) {
            mainNav.classList.remove('active');
            const spans = mobileMenuToggle.querySelectorAll('span');
            spans[0].style.transform = 'none';
            spans[1].style.opacity = '1';
            spans[2].style.transform = 'none';
        }
    });
    
    // Smooth scrolling for anchor links
    const anchorLinks = document.querySelectorAll('a[href^="#"]');
    anchorLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const targetId = this.getAttribute('href').substring(1);
            const targetElement = document.getElementById(targetId);
            
            if (targetElement) {
                targetElement.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });
    
    // Add scroll effect to header
    const header = document.querySelector('.site-header');
    if (header) {
        window.addEventListener('scroll', function() {
            if (window.scrollY > 100) {
                header.style.boxShadow = '0 4px 6px rgba(0,0,0,0.1)';
            } else {
                header.style.boxShadow = '0 2px 4px rgba(0,0,0,0.1)';
            }
        });
    }
    
    // Form validation
    const forms = document.querySelectorAll('form');
    forms.forEach(form => {
        form.addEventListener('submit', function(e) {
            let isValid = true;
            const requiredFields = form.querySelectorAll('[required]');
            
            requiredFields.forEach(field => {
                if (!field.value.trim()) {
                    isValid = false;
                    field.style.borderColor = '#dc3545';
                    
                    // Remove error styling on input
                    field.addEventListener('input', function() {
                        this.style.borderColor = '';
                    }, { once: true });
                }
            });
            
            if (!isValid) {
                e.preventDefault();
                alert('Please fill in all required fields.');
            }
        });
    });
    
    // Prayer times countdown (optional enhancement)
    function updatePrayerTimes() {
        const prayerTimes = {
            fajr: '05:30',
            dhuhr: '13:00',
            asr: '16:30',
            maghrib: '19:00',
            isha: '20:30'
        };
        
        const now = new Date();
        const currentTime = now.getHours().toString().padStart(2, '0') + ':' + 
                           now.getMinutes().toString().padStart(2, '0');
        
        // Find next prayer time
        let nextPrayer = null;
        let nextTime = null;
        
        for (const [prayer, time] of Object.entries(prayerTimes)) {
            if (time > currentTime) {
                nextPrayer = prayer;
                nextTime = time;
                break;
            }
        }
        
        // If all prayers have passed, show tomorrow's Fajr
        if (!nextPrayer) {
            nextPrayer = 'fajr';
            nextTime = prayerTimes.fajr;
        }
        
        // Update UI if elements exist
        const nextPrayerElement = document.getElementById('next-prayer');
        const nextTimeElement = document.getElementById('next-prayer-time');
        
        if (nextPrayerElement && nextTimeElement) {
            nextPrayerElement.textContent = nextPrayer.charAt(0).toUpperCase() + nextPrayer.slice(1);
            nextTimeElement.textContent = nextTime;
        }
    }
    
    // Update prayer times every minute
    updatePrayerTimes();
    setInterval(updatePrayerTimes, 60000);
    
    // Lazy loading for images (if needed)
    if ('IntersectionObserver' in window) {
        const imageObserver = new IntersectionObserver((entries, observer) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const img = entry.target;
                    img.src = img.dataset.src;
                    img.classList.remove('lazy');
                    imageObserver.unobserve(img);
                }
            });
        });
        
        document.querySelectorAll('img[data-src]').forEach(img => {
            imageObserver.observe(img);
        });
    }
});

// Utility functions
function formatTime(time) {
    const [hours, minutes] = time.split(':');
    const hour = parseInt(hours);
    const ampm = hour >= 12 ? 'PM' : 'AM';
    const displayHour = hour > 12 ? hour - 12 : hour;
    return `${displayHour}:${minutes} ${ampm}`;
}

function calculateTimeDifference(currentTime, targetTime) {
    const [currentHours, currentMinutes] = currentTime.split(':').map(Number);
    const [targetHours, targetMinutes] = targetTime.split(':').map(Number);
    
    const currentTotalMinutes = currentHours * 60 + currentMinutes;
    const targetTotalMinutes = targetHours * 60 + targetMinutes;
    
    let difference = targetTotalMinutes - currentTotalMinutes;
    if (difference < 0) {
        difference += 24 * 60; // Add 24 hours if target time is tomorrow
    }
    
    const hours = Math.floor(difference / 60);
    const minutes = difference % 60;
    
    return `${hours}h ${minutes}m`;
}