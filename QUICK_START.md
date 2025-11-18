# Quick Start Guide

Welcome to your redesigned portfolio! Here's everything you need to know to get started.

## What's New?

Your portfolio has been reorganized into a beautiful, modern multi-page site with:

✅ **5 Dedicated Pages**:
- Home (index.html) - Your profile and contact info
- Education (education.html) - Academic background
- Work & Projects (work.html) - All your projects
- Custom Keyboard (keyboard.html) - Your keyboard layout
- Writings (writings.html) - Blog-style articles

✅ **Modern Design**:
- Fixed sidebar navigation on desktop
- Mobile-responsive hamburger menu
- Consistent styling across all pages
- Smooth animations and transitions

✅ **Easy Content Management**:
- Simple file-based system for adding writings
- Template for creating new articles

## Viewing Your Site

1. Open `index.html` in your web browser
2. Use the sidebar to navigate between pages
3. On mobile, tap the menu icon in the top-left

## Next Steps

### 1. Add Your Keyboard Layout File

The keyboard page has a download button that needs your actual layout file:

1. Place your keyboard layout file in the `Site` directory
2. Open `keyboard.html`
3. Find line with: `onclick="alert('Please add your keyboard layout file...`
4. Update the `href` attribute to point to your file:
   ```html
   <a href="Site/your-keyboard-file.keylayout" class="btn" download>
   ```
5. Remove the `onclick` attribute

### 2. Add Writings/Articles

To add your first writing:

1. Open `writings-data.js`
2. Add a new entry (see examples in the file)
3. Save the file - it will appear automatically!

For full articles, see `WRITINGS_README.md` for detailed instructions.

### 3. Update Your Resume

Replace `Site/img/Resume_KGalvanCuesta.pdf` with your latest resume.

### 4. Customize Colors (Optional)

To change the color scheme:

1. Open `css/main.css`
2. Find the `:root` section at the top
3. Modify the color variables:
   ```css
   --primary: #0BCEAF;      /* Main brand color */
   --secondary: #2c3e50;    /* Dark accent */
   --accent: #3498db;       /* Secondary accent */
   ```

### 5. Add More Projects

To add new projects to the Work page:

1. Open `work.html`
2. Copy an existing project card structure
3. Update with your new project details
4. Add project image to `Site/img/`

## File Structure Overview

```
portfolio/
├── index.html              ← Home page
├── education.html          ← Education page
├── work.html              ← Projects page
├── keyboard.html          ← Keyboard page
├── writings.html          ← Writings page
│
├── writings-data.js       ← Add writings here!
│
├── css/
│   └── main.css          ← All styling
│
├── js/
│   ├── navigation.js     ← Shared navigation
│   └── writings.js       ← Writings logic
│
├── Site/
│   └── img/              ← Images
│       ├── profile.jpg
│       ├── Resume_KGalvanCuesta.pdf
│       └── ... project images
│
├── writings/             ← Full article HTML files
│   └── article-template.html
│
└── README.md             ← Full documentation
```

## Key Features

### Responsive Navigation
- **Desktop**: Fixed sidebar on the left
- **Mobile**: Hamburger menu (tap top-left icon)
- Auto-highlights current page

### Beautiful Cards
- Hover effects on all cards
- Smooth transitions
- Professional shadows and spacing

### Writing System
- No database needed
- Just edit `writings-data.js`
- Supports categories, tags, images
- Can link to external articles or local HTML

### Consistent Design
- All pages use the same styles
- Navigation appears on every page
- Professional color scheme throughout

## Common Tasks

### Update Your Bio
Edit `index.html`, search for "Hi there! I'm glad"

### Change Contact Info
Edit `js/navigation.js`, find the sidebar-footer section

### Add Social Links
Edit `js/navigation.js`, add to social-links section

### Add/Remove Navigation Items
Edit `js/navigation.js`, modify the nav-menu section

## Deployment

Your portfolio is ready to deploy to:
- **GitHub Pages** (free)
- **Netlify** (free)
- **Vercel** (free)
- Any static hosting service

Just upload all files to your chosen platform.

## Getting Help

- Check `README.md` for detailed documentation
- See `WRITINGS_README.md` for the writings system
- Use `writings/article-template.html` as a starting point for articles

## Tips

1. **Images**: Keep them optimized (< 500KB each)
2. **Writings**: Start with 2-3 example posts
3. **Mobile**: Test on your phone to see how it looks
4. **Updates**: Just edit the HTML/JS files - no build process needed!

## Questions?

If you need to customize something specific, all the code is well-commented.
The CSS uses clear variable names, making it easy to adjust colors, spacing,
and other design elements.

---

Enjoy your new portfolio! 🎉
