<script setup lang="ts">
import {ref, onMounted, watch} from 'vue'
import {marked}from 'marked'
import "markdown-it-vue/dist/markdown-it-vue.css";
import MarkdownIt from "markdown-it";

const isDark = ref(true)
const markdown = new MarkdownIt()
const props = defineProps<{slug: string}>()
const metadata = ref({})
const tags = ref([])
const renderedMarkdown = ref("")
const title = ref("")

const fetch_post = async () => {
  try {
    const response = await fetch(`${import.meta.env.VITE_APP_API}/${props.slug}`)
    const data = await response.json()
    metadata.value = data
    title.value = data.title[0]
    tags.value = data.tags
    renderedMarkdown.value = markdown.render(data.content[0])
  } catch (error) {
      console.error('Error fetching data:', error)
  }
}

const toggleTheme = () => {
  isDark.value = !isDark.value
}

onMounted(() => {
  fetch_post()
})

watch(isDark, (newValue) => {
  document.documentElement.style.backgroundColor = newValue ? '#F9FAFB':'#181818'
  document.documentElement.style.color = newValue ? '#1F2937' : '#E5E7EB'
});

</script>

<template>
  <div>
    <div>
      <div class="flex w-full justify-between items-center">
        <a class="backlink flex w-fit text-2xl font-bold" href="/"><</a>
        <button class="text-2xl grayscale bg-gray-500 hover:bg-gray-800 hover:cursor-pointer h-fit p-2 rounded-full" @click="toggleTheme" v-if="isDark">🌙</button>
        <button class="text-2xl bg-gray-300 hover:bg-gray-100 hover:cursor-pointer h-fit p-2 rounded-full" @click="toggleTheme" v-else>☀️</button>
      </div>
      <h1 class="title flex w-full justify-center items-center">{{title}}</h1>
      <div class="flex w-full justify-center items-center">
        <div v-if="tags" class="grid grid-cols-[repeat(auto-fit,minmax(150px,1fr))] justify-center items-center text-center gap-x-3 mb-2 mt-2 w-full max-w-screen-lg px-4">
            <span :class="['p-2 font-semibold bg-blue-200 rounded-full text-[#1F2937]', /^#\d+$/.test(tag) ? 'post-leet-tag' : '']" v-for="tag in tags">{{tag}}</span>
          </div>
      </div>
    </div>
    <div v-if="renderedMarkdown" v-html="renderedMarkdown"></div>
  </div>
</template>

<style>
.backlink {
  padding: 1rem;
}

.read-more-tag {
  margin-top: 0;
  margin-bottom: 0;
  height: 100%;
  display: flex;
  font-weight: 500;
  align-items: end;
  color: dimgray;
}

a:hover .read-more-tag {
  color: black;
}

.post-leet-tag {
  background-color: #FFA116;
  border: solid #1F2937;
}

</style>
