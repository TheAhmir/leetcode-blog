import { createRouter, createWebHistory } from 'vue-router';
import HomeView from './components/HomeView.vue';
import PostView from './components/PostView.vue';

const routes = [
  {
    path: '/',
    name: 'Home',
    component: HomeView, // The component to render for this route
  },
  {
    path: '/post/:id',
    name: 'Post',
    component: PostView,
    props: true,
  },
];

const router = createRouter({
  history: createWebHistory(), // Use the HTML5 history mode
  routes,
});

export default router;
