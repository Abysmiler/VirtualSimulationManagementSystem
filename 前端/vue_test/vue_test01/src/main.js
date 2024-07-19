import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import ElementUI from 'element-ui';//引入elementui
import 'element-ui/lib/theme-chalk/index.css';//引入elementui
import '../src/assets/global.css'


Vue.config.productionTip = false
Vue.use(ElementUI, { size: 'small', zIndex: 3000 })
Vue.use(ElementUI);//引入elementui



new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
