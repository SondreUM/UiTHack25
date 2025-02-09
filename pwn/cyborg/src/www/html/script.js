// Initialize some JavaScript variables...
const ctaButton = document.querySelector('.cta-button');
const featuresList = document.querySelector('.features ul');

// Add event listeners for button clicks and scrolling...
ctaButton.addEventListener('click', () => {
    window.location.href = '#about';
});

window.addEventListener('scroll', () => {
    if (window.scrollY > 0) {
        document.body.classList.add('scrolled');
    } else {
        document.body.classList.remove('scrolled');
    }
});