<template>
    <h1>LeetCode</h1>
    <div class="posts-container">
      <div v-for="post in posts" :key="post.data.CreatedAt" class="post-card">
        <router-link :to="{ path: `/post/${post.data.slug}` }">
            <p>{{ new Date(post.data.CreatedAt).toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' }) }}</p>

          <div class="post-content">
            <h1 class="title">{{ post.data.Title }}</h1>
            <p class="summary">{{ post.data.Summary || "Summary not available" }}</p>
            <div class="tags">
              <p v-for="tag in post.data.tags" :key="tag" class="tag">{{ tag }}</p>
            </div>
            <p class="read-more">read more -></p>
          </div>
        </router-link>
      </div>
    </div>
  </template>
  
  
  <script>
  import { ref, onMounted } from "vue";
  
  export default {
    name: "HomeView",
    setup() {
      const posts = ref([]);
  
      const fetchPosts = async () => {
  try {
    // Fetch the JSON file containing the posts
    const response = await fetch('/blog-posts-paths.json');
    if (!response.ok) {
      throw new Error('Failed to load blog-posts-paths.json');
    }

    const postsData = await response.json(); // Parse the JSON response

    // Iterate over each object in the array
    for (const postObject of postsData) {
      // Extract the key (post slug) and content
      const postKey = Object.keys(postObject)[0]; // Get the dynamic key
      const post = postObject[postKey]; // Get the post data

      // Add the post to the posts array
      posts.value.push(post);
    }

    // Sort posts by CreatedAt in descending order (latest first)
    posts.value.sort((a, b) => {
      const dateA = new Date(a.data.CreatedAt);
      const dateB = new Date(b.data.CreatedAt);
      return dateB - dateA; // Sort in descending order
    });

  } catch (error) {
    console.error("Error fetching blog-posts-paths.json:", error);
  }
};

  
      // Fetch the posts when the component is mounted
      onMounted(() => {
        fetchPosts();
      });
  
      return {
        posts,
      };
    },
  };
  </script>
  
  <style>

.tags {
  display: flex;
  flex-wrap: wrap;
  gap: 0.8rem;
}

.tag {
  width: fit-content;
  display: inline-block;
  padding: 1rem;
  font-size: small;
  font-weight: 600;
  color:#f4f4f4;
  background-color: #777777;
  border-radius: 5px;
}

.posts-container {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(250px, 1fr)); /* Automatically adjusts columns based on space */
  gap: 2rem; /* Space between items */
  padding: 20px;
}

.post-card {
  background-color: #f4f4f4;
  padding: 15px;
  border-radius: 8px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.5);
  transition: transform 0.3s ease; /* Adjusted timing function and duration */
  cursor: pointer; /* Fixed the typo */
}

.post-card:hover {
  transform: translateY(-5px); /* Add hover effect for elevation */
}

.post-content {
    width: 100%;
    height: 100%
}

.title {
  font-size: 1.5rem;
  margin: 0;
}

.summary, .read-more {
  font-size: 1rem;
  color: #555;
}

.post-card a {
  text-decoration: none;
  color: inherit;
}

@media (max-width: 768px) {
  .posts-container {
    grid-template-columns: 1fr; /* On smaller screens, stack everything in a single column */
  }
}

  </style>
  
