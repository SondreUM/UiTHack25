// Load the takeover notice from a Markdown file...
fetch('notice.md')
    .then(response => response.text())
    .then(markdown => {
        const popup = document.createElement('div');
        popup.classList.add('takeover-notice');
        popup.innerHTML = marked(markdown); // Use a library like marked.js to render Markdown
        document.body.appendChild(popup);

        // Show the popup after a short delay...
        setTimeout(() => {
            popup.style.display = 'block';
        }, 500);
    })
    .catch(error => console.error('Error loading takeover notice:', error));