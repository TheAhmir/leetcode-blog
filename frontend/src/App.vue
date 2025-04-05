<script setup lang="ts">
import {ref, onMounted, watch, provide} from 'vue'
import { RouterLink, RouterView } from 'vue-router'

const isLight = ref(true)
provide('isLight', isLight)

const toggleTheme = () => {
  isLight.value = !isLight.value

}

watch(isLight, (newValue) => {
  document.documentElement.style.backgroundColor = newValue ? '#F9FAFB':'#181818'
  document.documentElement.style.color = newValue ? '#1F2937' : '#E5E7EB'

});

</script>

<template>

  <button class="theme-button-position text-2xl grayscale bg-gray-500 hover:bg-gray-800 hover:cursor-pointer h-fit p-2 rounded-full" @click="toggleTheme" v-if="isLight">🌙</button>
  <button class="theme-button-position text-2xl bg-gray-300 hover:bg-gray-100 hover:cursor-pointer h-fit p-2 rounded-full" @click="toggleTheme" v-else>☀️</button>
  <RouterView />
</template>

<style>
.theme-button-position {
  position: absolute;  
  right: 3rem;
  top: 3rem;
}
</style>

