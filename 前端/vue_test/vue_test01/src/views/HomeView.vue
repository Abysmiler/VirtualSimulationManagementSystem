<template>
  <div class="app">
    <el-container class="container">
      <!-- 定义头部 -->
      <el-main class="main">
        <el-tabs>
          <el-tab-pane label="宿舍" >
            <!-- 使用el-carousel组件实现轮播图  
                  :interval="3000"表示3000毫秒也就是3秒后跳转下一张图片
            -->
            <el-carousel :interval="3000" height="55vh" type="card">
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
          <el-tab-pane label="教学">
            <!-- 使用el-carousel组件实现轮播图 -->
            <el-carousel :interval="3000" height="55vh" type="card">
              <el-carousel-item v-for="item in teachingImages" :key="item">
                <img :src="item" style="width: 100%; height: 100%;" />
              </el-carousel-item>
            </el-carousel>
          </el-tab-pane>
          <el-tab-pane label="公园">
            <el-carousel :interval="3000" height="60vh" type="card">
              <el-carousel-item v-for="item in parkImages" :key="item">
                <img :src="item" style="width: 100%; height: 100%;" />
              </el-carousel-item>
            </el-carousel>
          </el-tab-pane>
          <el-tab-pane label="食堂">
            <el-carousel :interval="3000" height="60vh" type="card">
              <el-carousel-item v-for="item in canteenImages" :key="item">
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
      <br />备案号:京2341572
    </el-footer>
  </div>
</template>

<script>
export default {
  data() {
    return {
      //数组,包含有轮播图中多张图片的地址
      dormitoryImages: [
        require("@/assets/宿舍1.jpg"),
        require("@/assets/宿舍2.jpg"),
        require("@/assets/宿舍3.jpg"),
        require("@/assets/宿舍4.jpg")
        /* 宿舍场景图片链接数组 */
      ],
      teachingImages: [
        /* 教学场景图片链接数组 */
        "https://img0.baidu.com/it/u=1862198944,2714928797&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=321",
        "https://img2.baidu.com/it/u=2001347590,3549401043&fm=253&fmt=auto&app=120&f=JPEG?w=541&h=301"
      ],
      parkImages: [
        /* 公园场景图片链接数组 */
      ],
      canteenImages: [
        /* 食堂场景图片链接数组 */
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
  height: 100vh;
}

.main {
  height: 80vh;
}

.footer {
  background-color: #999;
  color: white;
  text-align: center;
  padding: 10px 0;
  font-size: 10px;
}

.header {
  background-color: #333;
  color: white;
}

.nav {
  display: flex;
  justify-content: flex-end;
  height: 60px;
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
</style>