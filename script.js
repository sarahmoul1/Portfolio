let menuIcon = document.querySelector('#menu-icon');
let navbar = document.querySelector('.nvabar');
let sections = document.querySelectorAll('section');
let navLinks = document.querySelectorAll('header nav a')

window.onscroll = () => {
    sections.forEach(sec => {
        let top = window.scrollY;
        let offset = sec.offsetTop - 150;
        let height = sec.offsetHeight;
        let id = sec.getAttribute('id');

        if (top >= offset && top < offset + height) {
            navLinks.forEach(link => {
                link.classList.remove('active');
            });
            document.querySelector('header nav a[href*="' + id + '"]').classList.add('active');
        }
    });
};

 


menuIcon.onclick = () => {
    menuIcon.classList.toggle('bx-x');
    navbar.classList.toggle('active');
}


document.addEventListener('DOMContentLoaded', (event) => {
    const redirections = {
        'traiter': 'traiter.html',
        'analyser': 'analyser.html',
        'valoriser': 'valoriser.html',
        'modeliser': 'modeliser.html'
    };

    Object.keys(redirections).forEach(key => {
        const box = document.querySelector(`.${key}`);
        if (box) {
            console.log(`Adding click event listener to .${key}`);
            box.addEventListener('click', () => {
                console.log(`Redirecting to ${redirections[key]}`);
                window.location.href = redirections[key];
            });
        } else {
            console.log(`Element with class .${key} not found`);
        }
    });
});
