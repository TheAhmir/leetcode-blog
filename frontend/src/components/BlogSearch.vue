<script setup lang="ts">
import { ref, onMounted, watch, inject } from 'vue'

const isLight = ref(inject('isLight'))

interface Post {
  title: string[]
  tags: string[]
  summary: string[]
  createdat: string[]
  slug: string[]
  content: string[]
}

const results = ref<Post[]>([])
const search = ref('')
const posts = ref<Post[]>([])

const filterPosts = () => {
  if (!search.value) {
    posts.value = results.value
    return
  }
  posts.value = results.value.filter(post => {
    return post.title[0].toLowerCase().includes(search.value.toLowerCase())
  })
}

const fetchPosts = async () => {
  try {
    const response = await fetch(import.meta.env.VITE_APP_API)
    const data = await response.json()
    results.value = Object.values(data)
    filterPosts()
  } catch (error) {
    console.error('Error fetching data:', error)
  }
}

onMounted(fetchPosts)
watch(search, filterPosts)
</script>

<template>
  <div class="w-full flex flex-col justify-center items-center m-2 ">
      <input :class="['flex justify-center items-center text-center text-2xl m-8', isLight ? 'placeholder-text-light' : 'placeholder-text-dark']" v-model="search" placeholder="Search" ></input>
    <div v-if="results.length !== 0" class="flex grid md:grid-cols-2 lg:grid-cols-4 gap-8" >
      <router-link class="flex flex-col p-4 justify-top items-center text-center border-2 rounded-xs shadow-lg shadow-gray-500/50 hover:scale-110" :to="{name: 'postDetail', params: {slug: result.slug[0]}}" v-for="(result, index) in posts" :key="index">
        <p :class="['flex w-full font-semibold text-xs justify-end m-0 mr-4 p-0', result.createdat[0] ? '' : 'text-gray-500']">{{result.createdat[0] ? result.createdat[0] : "unknown"}}</p>
        <h2>{{result.title[0]}}</h2>
        
        <div class="flex w-full justify-center items-center">
          <div class="grid grid-cols-[repeat(auto-fit,minmax(90px,1fr))] justify-center items-center text-center gap-x-3 mb-2 mt-2 w-full" v-if="result.tags" >
            <div  v-for="tag in result.tags">
             <p :class="['text-[#181818] p-2 font-semibold bg-blue-200 text-xs', /^#\d+$/.test(tag) ? isLight ? 'leet-tag-light':'leet-tag-dark' : '']">{{tag}}</p>
            </div>
          </div>
        
        </div>
        
        <h3 class="text-sm font-medium m-4 ml-6 w-full p-1 text-start" v-if="result.summary">{{result.summary[0]}}</h3>   
        <p :class="['read-more-tag',isLight ? 'read-more-tag-light' : 'read-more-tag-dark']">read more</p>
        
      </router-link>
    </div>
    <div v-else>
      No posts available
    </div>
  </div>
</template>

<style>
.leet-tag-dark {
  background-color: #FFA116;
  border: solid #F9FAFB;
}
.leet-tag-light{
  background-color: #FFA116;
  border: solid #181818;
}
.placeholder-text-light::placeholder {
  color: rgba(0, 0, 0, 0.5); /* Blue with some transparency */
}
.placeholder-text-dark::placeholder {
  color: rgba(255, 255, 255, 0.5); /* Blue with some transparency */
}
a:hover .read-more-tag-light {
  color: #181818;
}
a:hover .read-more-tag-dark {
  color: #F9FAFB;
}
</style>
