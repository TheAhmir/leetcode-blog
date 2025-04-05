<script setup lang="ts">
import {inject, ref} from 'vue'

const isLight = ref(inject('isLight'))

</script>
<template>
    <div class="flex flex-col gap-4 w-full h-[50vh] items-center justify-center  bg-green-300 shadow-sm">
    <div
      class="flex flex-col gap-4 p-12 pr-32 pl-32 items-center justify-center"

      :style="{ backgroundColor: isLight ? '#F9FAFB':'#181818' }">
        <h1 class="text-3xl font-bold">LeetCode</h1>
        <p class="text-xl">My Solved Problems</p>
      </div>
    </div>
</template>
