// Shared Navigation Component
document.addEventListener('DOMContentLoaded', function() {
  // Insert navigation HTML
  const navHTML = `
    <button class="mobile-menu-toggle" id="mobileMenuToggle" aria-label="Toggle menu">
      <i class="fas fa-bars"></i>
    </button>

    <aside class="sidebar" id="sidebar">
      <div class="sidebar-header">
        <a href="index.html" class="logo">Kevin<br>Galvan Cuesta</a>
        <p class="logo-subtitle">AI/ML Researcher in Medicine</p>
      </div>

      <nav>
        <ul class="nav-menu">
          <li class="nav-item">
            <a href="index.html" class="nav-link" data-page="home">
              <i class="fas fa-home"></i>
              <span>Home</span>
            </a>
          </li>
          <li class="nav-item">
            <a href="education.html" class="nav-link" data-page="education">
              <i class="fas fa-graduation-cap"></i>
              <span>Education</span>
            </a>
          </li>
          <li class="nav-item">
            <a href="work.html" class="nav-link" data-page="work">
              <i class="fas fa-diagram-project"></i>
              <span>Projects</span>
            </a>
          </li>
          <li class="nav-item">
            <a href="keyboard.html" class="nav-link" data-page="keyboard">
              <i class="fas fa-keyboard"></i>
              <span>Keyboard</span>
            </a>
          </li>
          <li class="nav-item">
            <a href="writings.html" class="nav-link" data-page="writings">
              <i class="fas fa-pen-fancy"></i>
              <span>Writings</span>
            </a>
          </li>
        </ul>
      </nav>

      <div class="sidebar-footer">
        <div class="social-links">
          <a href="https://www.linkedin.com/in/kgalvancuesta/" class="social-link" target="_blank" aria-label="LinkedIn">
            <i class="fab fa-linkedin-in"></i>
          </a>
          <a href="https://github.com/kgalvancuesta" class="social-link" target="_blank" aria-label="GitHub">
            <i class="fab fa-github"></i>
          </a>
        </div>
        <div class="contact-info">
          <p><strong>Contact</strong></p>
          <p><a href="mailto:kevin.galvan.cuesta@gmail.com">kevin.galvan.cuesta@gmail.com</a></p>
          <p><a href="tel:+16308909256">(630) 890-9256</a></p>
        </div>
      </div>
    </aside>
  `;

  // Insert navigation at the beginning of body
  document.body.insertAdjacentHTML('afterbegin', navHTML);

  // Set active page
  const currentPage = document.body.dataset.page;
  if (currentPage) {
    const activeLink = document.querySelector(`[data-page="${currentPage}"]`);
    if (activeLink) {
      activeLink.classList.add('active');
    }
  }

  // Mobile menu toggle
  const mobileToggle = document.getElementById('mobileMenuToggle');
  const sidebar = document.getElementById('sidebar');

  if (mobileToggle && sidebar) {
    mobileToggle.addEventListener('click', function() {
      sidebar.classList.toggle('open');
    });

    // Close sidebar when clicking outside on mobile
    document.addEventListener('click', function(event) {
      if (window.innerWidth <= 992) {
        if (!sidebar.contains(event.target) && !mobileToggle.contains(event.target)) {
          sidebar.classList.remove('open');
        }
      }
    });

    // Close sidebar when clicking a link on mobile
    const navLinks = sidebar.querySelectorAll('.nav-link');
    navLinks.forEach(link => {
      link.addEventListener('click', function() {
        if (window.innerWidth <= 992) {
          sidebar.classList.remove('open');
        }
      });
    });
  }

  // Smooth scroll for anchor links
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
      const href = this.getAttribute('href');
      if (href !== '#' && href.length > 1) {
        const target = document.querySelector(href);
        if (target) {
          e.preventDefault();
          target.scrollIntoView({
            behavior: 'smooth',
            block: 'start'
          });
        }
      }
    });
  });

  // Add fade-in animation to cards
  const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px'
  };

  const observer = new IntersectionObserver(function(entries) {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('fade-in');
        observer.unobserve(entry.target);
      }
    });
  }, observerOptions);

  document.querySelectorAll('.card, .project-card, .writing-card').forEach(card => {
    observer.observe(card);
  });
});
