import Vue from 'vue'
import VueRouter from 'vue-router'
import HomeView from '../views/HomeView.vue'
import AboutView from '../views/AboutView.vue'
import UserView from '../views/UserView.vue'
import RegisterView from '../views/Register.vue'
import LayoutView from '../views/LayoutView.vue'
import LoginView from '../views/Login.vue'

Vue.use(VueRouter)

const routes = [

  {
    path: '/register',
    name: 'register',
    component: RegisterView
  },
  {
    path: '/login',
    name: 'login',
    component: LoginView
  },
  {
    path: '/',
    component: LayoutView,
    children: [
      {
        path: '',
        name: 'home',
        component: HomeView
      },
      {
        path: 'about',
        name: 'about',
        component: AboutView
      },
      {
        path: 'user',
        name: 'user',
        component: UserView
      }
    ]
  },
]


// 定义路由守卫，如果没有登录，则不允许访问
const router = new VueRouter({
  routes
})

router.beforeEach((to,from,next) => {
  if(to.path === '/login'){
    next();
  }
  if(to.path === '/register'){
    next();
  }
  // 如果访问的路径不是登录或注册，
  const admin = localStorage.getItem("user");
  if(!admin && to.path !='/login' && to.path != '/register'){
    return next("/login");
  }
  next();
})    


export default router
