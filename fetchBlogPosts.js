const fs = require('fs');
const path = require('path');
const glob = require('glob');
const matter = require('gray-matter'); // Used for parsing frontmatter in Markdown files

const blogPostsDir = path.resolve(__dirname, 'public/blog-posts');
const posts = glob.sync(`${blogPostsDir}/**/*.md`); // Get all markdown files

// Extract metadata (title, slug, etc.) from the Markdown files
const blogPostDetails = posts.map(file => {
  // Read the Markdown file content
  const post = fs.readFileSync(file, 'utf-8');
  
  // Parse the frontmatter
  const { content, data } = matter(post);

  return { [`${data.slug}`]: 
    {
      data,
      content
    }
  };
});

// Save the extracted metadata as a JSON file
fs.writeFileSync(path.resolve(__dirname, './public/blog-posts-paths.json'), JSON.stringify(blogPostDetails, null, 2));

console.log('Blog posts metadata saved to blog-posts-paths.json');
