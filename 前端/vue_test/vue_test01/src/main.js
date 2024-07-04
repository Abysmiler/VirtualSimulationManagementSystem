import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import ElementUI from 'element-ui';//引入elementui
import 'element-ui/lib/theme-chalk/index.css';//引入elementui
import '@/assets/global.css'
import VTooltip from 'v-tooltip'

Vue.config.productionTip = false
Vue.use(ElementUI,{ size: 'small', zIndex: 3000 });//引入elementui
Vue.use(ElementUI);//引入elementui
Vue.use(VTooltip)

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
