import Vue from 'vue'
import VueRouter from 'vue-router'
import HomeView from '../views/HomeView.vue'
import AboutView from '../views/AboutView.vue'
import UserView from '../views/UserView.vue'
import RegisterView from '../views/Register.vue'
import LayoutView from '../views/LayoutView.vue'
import LoginView from '../views/Login.vue'
import AdminView from '../views/AdminView.vue'
import LabView from '@/views/LabView.vue'
import CourseView from '@/views/CourseView.vue'
import FindPassword from '@/views/FindPassword.vue'
import ResourceView from '@/views/ResourceView.vue'
import UserInfoView from '@/views/UserInfoView.vue'
import DeviceView from '@/views/DeviceView.vue'

Vue.use(VueRouter)

const routes = [

  {
    //注册页面
    path:'/register',
    name:'register',
    component:RegisterView
  } ,
  {
    //登录页面
    path:'/login',
    name:'login',
    component:LoginView
  } ,
  {
    //找回密码页面
    path: '/findpassword',
    name: 'findpassword',
    component: FindPassword
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
        component: UserView,
      },
      {
        //管理员页面
        path: '/admin',
        name: 'admin',
        component: AdminView
      },
      {
        //实验室页面
        path:'/lab',
        name:'lab',
        component: LabView
      },
      {
        //设备页面
        path: '/device',
        name: 'device',
        component: DeviceView
      },
      {
        //课程界面
        path: '/course',
        name: 'course',
        component: CourseView
      },
      {
        //资源界面
        path: '/resource',
        name: 'resource',
        component: ResourceView
      },
      {
        path: '/userinfo',
        name: 'userinfo',
        component: UserInfoView
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

//导出路由
export default router

