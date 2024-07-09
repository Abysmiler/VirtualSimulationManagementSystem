<template>
  <div class="app">
    <el-container class="container">
      <!-- 定义头部 -->
      <el-main class="main">
        <div class="home-title" >欢迎使用虚拟仿真管理系统</div>
        <el-tabs>
          <el-tab-pane  >
            <!-- 使用el-carousel组件实现轮播图  
                  :interval="3000"表示3000毫秒也就是3秒后跳转下一张图片
            -->
            <el-carousel :interval="3000" height="50vh" type="card">
              <!-- v-for:遍历数组  
                   item:是一个在v-for循环中迭代的变量 
                   dormitoryImages:data中定义的数组
                   :key:为循环生成的元素提供唯一标识
                   :src动态绑定图片地址 
              -->
              <el-carousel-item v-for="item in dormitoryImages" :key="item">
                <img :src="item" style="width: 100%; height: 100%;" />
              </el-carousel-item>
            </el-carousel>
          </el-tab-pane>
        </el-tabs>
      </el-main>
    </el-container>
    <!-- 定义尾部 -->
    <el-footer class="footer">
      说明:本网页由本公司自行开发编写,如有需要请联系我们
      <br />备案号:京123456
    </el-footer>
  </div>
</template>

<script>
export default {
  data() {
    return {
      //数组,包含有轮播图中多张图片的地址
      dormitoryImages: [
        require("@/assets/主页1.jpg"),
        require("@/assets/主页2.jpg"),
        require("@/assets/主页3.jpg"),
        require("@/assets/主页4.jpg")
        /* 宿舍场景图片链接数组 */
      ]
    };
  }
};
</script>


<style>
/* 设置内边距为0 */
.el-carousel {
  padding: 0;
}

/* 设置外边距为0 */
.el-carousel-item {
  margin: 0;
}

/* 设置布局为flex容器布局,垂直排列,高度为100vh占满整个视图 */
.app {
  display: flex;
  flex-direction: column;
  height: 50vh;
}

.main {
  margin-top: 30px;
  height: 80vh;
}

.footer {
  background-color: #0084ff3f;
  color: rgb(255, 255, 255);
  text-align: center;
  text-shadow: #d6d6d6 1px 1px 0;
  padding: 10px 0;
  font-size: 18px;
  border-radius: 10px;
}

.header {
  background-color: #333;
  color: white;
}

.nav {
  display: flex;
  justify-content: flex-end;
  height: px;
  line-height: 60px;
}

/* 去除列表元素默认样式 */
.nav-list {
  list-style: none;
  padding: 0;
  margin: 0;
}

.nav-list li {
  display: inline;
  margin-right: 10px;
}

.nav-link {
  color: white;
  text-decoration: none;
  transition: all 0.3s;
}

.nav-link:hover {
  font-size: 1.2em;
  color: #eee;
}

.home-title {
  color: rgb(46, 139, 237);
  font-size: 42px;
  font-weight: 550;
}
</style>
