# How to Add New Writings

The writings page uses a simple file-based system that makes it easy to add new articles, blog posts, and research papers.

## Quick Start

1. Open `writings-data.js` in the root directory
2. Add a new entry to the `writingsData` array
3. Save the file
4. Your new writing will automatically appear on the writings page!

## Writing Entry Structure

Each writing entry should follow this format:

```javascript
{
  title: "Your Article Title",
  date: "2024-01-15",  // Format: YYYY-MM-DD
  category: "Category Name",  // Optional
  excerpt: "A brief description or preview of your writing...",
  image: "Site/img/writings/your-image.jpg",  // Optional
  url: "path/to/article.html",  // Optional: link to full article
  external: false,  // Set to true if linking to external site
  readingTime: 5,  // Optional: minutes (auto-calculated if omitted)
  tags: ["Tag1", "Tag2", "Tag3"]  // Optional
}
```

## Field Descriptions

### Required Fields

- **title**: The title of your writing
- **date**: Publication date in YYYY-MM-DD format
- **excerpt**: A brief description (2-3 sentences recommended)

### Optional Fields

- **category**: Type of writing (e.g., "Research", "Tutorial", "Opinion", "AI", "Philosophy")
- **image**: Path to a thumbnail image
  - Recommended size: 800x400px
  - Place images in `Site/img/writings/` directory
- **url**: Link to the full article
  - Can be a relative path to an HTML file in your portfolio
  - Can be an external URL to another site
  - If omitted, the card will display without a "Read more" link
- **external**: Set to `true` if url points to an external website (opens in new tab)
- **readingTime**: Estimated reading time in minutes (auto-calculated from excerpt if not provided)
- **tags**: Array of relevant keywords or topics

## Example: Adding a Research Paper

```javascript
{
  title: "Machine Learning Approaches to Climate Modeling",
  date: "2024-02-20",
  category: "Research",
  excerpt: "This paper explores novel machine learning techniques for improving climate prediction models, with a focus on deep learning and time-series analysis.",
  image: "Site/img/writings/climate-ml.jpg",
  url: "https://arxiv.org/paper/example",
  external: true,
  readingTime: 12,
  tags: ["Machine Learning", "Climate Science", "Deep Learning"]
}
```

## Example: Adding a Blog Post

```javascript
{
  title: "My Journey Learning Reinforcement Learning",
  date: "2024-01-10",
  category: "Personal",
  excerpt: "Reflections on learning RL from scratch, the challenges I faced, and resources that helped me along the way.",
  image: "",
  url: "writings/rl-journey.html",
  external: false,
  tags: ["Learning", "Reinforcement Learning"]
}
```

## Example: Adding a Thought Piece

```javascript
{
  title: "The Ethics of AI in Healthcare",
  date: "2023-12-15",
  category: "Philosophy",
  excerpt: "An exploration of the moral implications of using artificial intelligence in medical diagnosis and treatment decisions.",
  tags: ["Ethics", "AI", "Healthcare", "Philosophy"]
}
```

## Tips

1. **Images**: For best results, use images with a 2:1 aspect ratio (e.g., 800x400px)
2. **Excerpts**: Keep excerpts concise but informative (50-100 words is ideal)
3. **Categories**: Be consistent with category names across entries
4. **Tags**: Use 2-5 relevant tags per writing
5. **Dates**: Writings are automatically sorted by date (newest first)
6. **External Links**: Always set `external: true` when linking to other websites

## Creating Full Article Pages

If you want to write full articles hosted on your portfolio:

1. Create a new HTML file (e.g., `writings/my-article.html`)
2. You can use this template:

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Article Title - Kevin Galvan Cuesta</title>
  <link href="../Site/img/favicon.ico" rel="icon">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Space+Grotesk:wght@500;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="stylesheet" href="../css/main.css">
</head>
<body data-page="writings">
  <div class="layout">
    <main class="main-content">
      <div class="content-wrapper">
        <article class="card">
          <h1>Your Article Title</h1>
          <div class="writing-meta mb-4">
            <span><i class="far fa-calendar"></i> January 15, 2024</span>
            <span><i class="fas fa-tag"></i> Category</span>
          </div>

          <!-- Your article content here -->
          <p>Article content...</p>

          <div class="mt-4">
            <a href="../writings.html" class="btn btn-outline">
              <i class="fas fa-arrow-left"></i>
              Back to Writings
            </a>
          </div>
        </article>
      </div>
    </main>
  </div>
  <script src="../js/navigation.js"></script>
</body>
</html>
```

3. Reference it in your writings-data.js entry:
```javascript
url: "writings/my-article.html"
```

## Need Help?

If you have questions or run into issues, check the existing examples in `writings-data.js` or refer to the main portfolio documentation.
