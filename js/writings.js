// Writings Management System
// This file loads and displays writings from the writings-data.js file

document.addEventListener('DOMContentLoaded', function() {
  const container = document.getElementById('writings-container');

  if (!container) return;

  // Check if writings data is loaded
  if (typeof writingsData === 'undefined') {
    container.innerHTML = `
      <div class="card">
        <p class="text-center">No writings available yet. Check back soon!</p>
      </div>
    `;
    return;
  }

  // Sort writings by date (newest first)
  const sortedWritings = writingsData.sort((a, b) => {
    return new Date(b.date) - new Date(a.date);
  });

  // Create HTML for writings grid
  let html = '<div class="writings-grid">';

  sortedWritings.forEach(writing => {
    const formattedDate = formatDate(writing.date);
    const readingTime = writing.readingTime || calculateReadingTime(writing.excerpt);

    html += `
      <article class="writing-card">
        ${writing.image ? `
          <img src="${writing.image}" alt="${writing.title}" class="writing-image">
        ` : ''}

        <div class="writing-content">
          <div class="writing-meta">
            <span><i class="far fa-calendar"></i> ${formattedDate}</span>
            ${writing.category ? `<span><i class="fas fa-tag"></i> ${writing.category}</span>` : ''}
            <span><i class="far fa-clock"></i> ${readingTime} min read</span>
          </div>

          <h3 class="writing-title">
            ${writing.url ? `<a href="${writing.url}" ${writing.external ? 'target="_blank"' : ''}>${writing.title}</a>` : writing.title}
          </h3>

          <p class="writing-excerpt">${writing.excerpt}</p>

          ${writing.url ? `
            <a href="${writing.url}" class="read-more" ${writing.external ? 'target="_blank"' : ''}>
              ${writing.external ? 'Read more' : 'Continue reading'}
              <i class="fas fa-arrow-right"></i>
            </a>
          ` : ''}

          ${writing.tags && writing.tags.length > 0 ? `
            <div class="mt-3" style="display: flex; flex-wrap: wrap; gap: 0.5rem;">
              ${writing.tags.map(tag => `
                <span style="background: var(--primary-light); color: var(--primary); padding: 0.25rem 0.75rem; border-radius: 12px; font-size: 0.875rem;">
                  ${tag}
                </span>
              `).join('')}
            </div>
          ` : ''}
        </div>
      </article>
    `;
  });

  html += '</div>';
  container.innerHTML = html;
});

// Helper function to format date
function formatDate(dateString) {
  const options = { year: 'numeric', month: 'long', day: 'numeric' };
  return new Date(dateString).toLocaleDateString('en-US', options);
}

// Helper function to calculate reading time based on text length
function calculateReadingTime(text) {
  const wordsPerMinute = 200;
  const wordCount = text.split(/\s+/).length;
  const minutes = Math.ceil(wordCount / wordsPerMinute);
  return minutes;
}
