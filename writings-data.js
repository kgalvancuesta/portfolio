// Writings Data
const writingsData = [
  {
    title: "Hello",
    date: "2025-11-18",
    category: "Nonsense",
    excerpt: "Just absolutely nothing yet. I wish I saved some of my writings...",
    image: "", // Optional: path to image (e.g., "Site/img/writings/ai-future.jpg")
    url: "", // Optional: link to full article or external URL
    external: false, // Set to true if linking to external site
    readingTime: 1, // Optional: estimated reading time in minutes (auto-calculated if not provided)
    tags: [":^)",]
  },
];

// Instructions for adding new writings:
//
// 1. Add a new object to the writingsData array above
// 2. Fill in the required fields: title, date, excerpt
// 3. Optional fields:
//    - category: Type of writing (e.g., "Research", "Tutorial", "Opinion")
//    - image: Path to thumbnail image (place images in Site/img/writings/)
//    - url: Link to full article (can be relative path to HTML file or external URL)
//    - external: Set to true if url points to external website
//    - readingTime: Estimated minutes to read (auto-calculated if omitted)
//    - tags: Array of relevant tags/keywords
// 4. Save this file
// 5. The writings page will automatically update!
//
// Date format: "YYYY-MM-DD" (e.g., "2024-01-15")
// Writings are automatically sorted by date (newest first)
