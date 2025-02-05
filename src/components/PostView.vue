<template>
    <div class="holder">
      <!-- Go Back Button -->
      <!-- <button @click="goBack">Go Back</button> -->
  
      <!-- Markdown Content -->
      <vue-markdown :source="src" :plugins="plugins" class="markdown-content" />
    </div>
  </template>
  
  <script>
  import { ref, onMounted } from "vue";
  import VueMarkdown from "vue-markdown-render";
  import MarkdownItAnchor from "markdown-it-anchor";
  import { useRoute, useRouter } from "vue-router";  // Import useRouter
  
  export default {
    name: "PostView",
    components: {
      VueMarkdown,
    },
    setup() {
      const src = ref("");
      const plugins = [MarkdownItAnchor];
      const router = useRouter();  // Create a router instance
  
      // Function to go back to the previous page
      const goBack = () => {
        router.go(-1);  // This takes the user back to the previous page
      };
  
      const fetchMarkdown = async (id) => {
        try {
          const response = await fetch('/blog-posts-paths.json');
          if (response.ok) {
            const posts = await response.json();
            const post = posts.find(postObject => Object.keys(postObject)[0] === id);
            
            const content = post[id].content;
            src.value = content;
          } else {
            console.error(`Error fetching markdown file: ${response.statusText}`);
          }
        } catch (error) {
          console.error("Error fetching markdown:", error);
        }
      };
  
      // Fetch markdown content when the component is mounted
      onMounted(() => {
        const route = useRoute();
        fetchMarkdown(route.params.id);
      });
  
      return {
        src,
        plugins,
        goBack,  // Make the goBack method available in the template
      };
    },
  };
  </script>
  
  <style scoped>

  .holder {
    width: 100%;
    display: flex;
    justify-content: center;
    font-size: large;
  }

img {
  max-width: 50%;     /* Set max-width to 50% of the container */
  height: auto;       /* Maintain aspect ratio */
  display: block;     /* Make the image a block element */
  margin: 0 auto;     /* Center the image horizontally */
}

  /* Add custom styles for lists */
.markdown-content ul,
.markdown-content ol {
  padding-left: 20px; /* Adjust this value as needed */
}

.markdown-content li {
  margin-left: 0; /* Remove any additional margin */
  list-style-position: inside; /* Ensures bullets align properly */
}

/* Resize and center images specifically in markdown content */
.markdown-content img {
  max-width: 50%;     /* Set max-width to 50% of the container */
  height: auto;       /* Maintain aspect ratio */
  display: block;     /* Make the image a block element */
  margin: 0 auto;     /* Center the image horizontally */
}

/* Optionally center content inside the markdown */
.markdown-content {
  width: 60%;
  text-align: left;   /* Ensures everything is aligned to the left */
  padding: 0 10px;    /* Add some padding if needed */
  display: flex;
  flex-direction: column;
  gap: 0;
}



  </style>
  