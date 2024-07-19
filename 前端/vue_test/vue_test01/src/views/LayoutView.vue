<template>
  <div class="app">
    <el-container>
      <el-aside style="background-color:#FFFFFF; width:300px;min-height: 94vh; ">
        <div class="top-title">
          <img src="@/assets/logo-2.png" style="width: 70px; height: 70px; position:absolute;left:20px;top:5px;">
          <div class="title">虚拟仿真管理系统</div>
        </div>
        <el-menu :default-active="$route.path" router class="el-menu-vertical-demo" @open="handleOpen"
          @close="handleClose">
          <el-menu-item index="/">
            <i class="el-icon-menu"></i>
            <span slot="title">系统首页</span>
          </el-menu-item>
          <el-submenu index="2" v-if="user.userType != '学生' && user.userType != '超级管理员'">
            <template slot="title">
              <i class="el-icon-location"></i>
              <span>用户管理</span>
            </template>
            <el-menu-item-group>
              <el-menu-item index="/user">用户信息</el-menu-item>
            </el-menu-item-group>
          </el-submenu>
          <el-submenu index="3">
            <template slot="title">
              <i class="el-icon-setting"></i>
              <span>实训管理</span>
            </template>
            <el-menu-item-group>
              <el-menu-item index="/course">课程信息</el-menu-item>
              <el-menu-item index="/resource">资源信息</el-menu-item>
            </el-menu-item-group>
          </el-submenu>
          <el-submenu index="4">
            <template slot="title">
              <i class="el-icon-office-building"></i>
              <span>实验室管理</span>
            </template>
            <el-menu-item-group>
              <el-menu-item index="/lab">实验室信息</el-menu-item>
            </el-menu-item-group>
          </el-submenu>
          <el-submenu index="5">
            <template slot="title">
              <i class="el-icon-printer"></i>
              <span>仿真设备管理</span>
            </template>
            <el-menu-item-group>
              <el-menu-item index="/device">设备信息</el-menu-item>
            </el-menu-item-group>
          </el-submenu>
          <el-submenu index="6"  v-if="user.userType == '超级管理员'">
            <template slot="title">
              <i class="el-icon-unlock"></i>
              <span>权限管理</span>
            </template>
            <el-menu-item-group>
              <el-menu-item index="/admin">权限信息</el-menu-item>
            </el-menu-item-group>
          </el-submenu>
        </el-menu>
      </el-aside>

      <el-container>
        <el-header style="background-color: #1E90FF;">
          <div class="current-time">{{ currentTime }}</div>
          <el-dropdown trigger="click"
            style="color: black; font-size: 16px; float: right; height:60px; line-height:60px">
            <span class="el-dropdown-link">
              <label class="hamburger">
                <i class="el-icon-user header-user"></i>
                <span class="header-user">
                  {{ user.name }} {{ user.userType }}
                </span>
                <input type="checkbox">
                <svg viewBox="0 0 32 32">
                  <path class="line line-top-bottom"
                    d="M27 10 13 10C10.8 10 9 8.2 9 6 9 3.5 10.8 2 13 2 15.2 2 17 3.8 17 6L17 26C17 28.2 18.8 30 21 30 23.2 30 25 28.2 25 26 25 23.8 23.2 22 21 22L7 22">
                  </path>
                  <path class="line" d="M7 16 27 16"></path>
                </svg>
              </label>
            </span>
            <el-dropdown-menu slot="dropdown">
              <el-dropdown-item>
                <div @click="loginout()">退出登录</div>
              </el-dropdown-item>
              <el-dropdown-item>
                <div @click="userinfo()">个人主页</div>
              </el-dropdown-item>
            </el-dropdown-menu>
          </el-dropdown>
        </el-header>
        <div class="wrapper">
          <el-main>
            <router-view />
          </el-main>
        </div>
      </el-container>
    </el-container>
  </div>
</template>

<script>
export default {
  data() {
    return {
      //获取到当前登录用户的信息
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},
      currentTime: '',
    }
  },
  created() {
    this.updateTime();
    setInterval(this.updateTime, 1000);
  },
  methods: {
    loginout() {
      // 清除浏览器当前的登录状态权限
      localStorage.removeItem("user")
      // 跳转到登录页
      setTimeout(() => {
        this.$router.push("/login")
      }, 1000)

    },
    handleOpen(key, keyPath) {
      console.log(key, keyPath);
    },
    handleClose(key, keyPath) {
      console.log(key, keyPath);
    },
    updateTime() {
      const date = new Date();
      const hours = date.getHours().toString().padStart(2, '0');
      const minutes = date.getMinutes().toString().padStart(2, '0');
      const seconds = date.getSeconds().toString().padStart(2, '0');
      this.currentTime = `${hours}:${minutes}:${seconds}`;
    },
  }
}
</script>

<style lang="less">
.current-time {
  font-size: 30px; // 设置大小
  font-weight: bold; // 设置粗细
  float: left; // 让时间显示在最左侧
  line-height: 70px; // 垂直居中
  padding-left: 10px; // 左侧留白
  color: #FFFFFF; // 文字颜色
}

.myHeader {
  background-color: #1B1D26;
}

.top-title {
  flex: 0.4;
  width: 100%;
  height: 80px;
  border-right: 1px solid #e6e6e6;
}

.title {
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: end;
  padding-right: 2vw;
  color: rgb(46, 139, 237);
  font-size: 20px;
  font-weight: 550;
}

.header-user {
  color: #FFFFFF;
  position: relative;
  top: -25%;
  /* 调整上下位置 */
  left: 0px;
  /* 调整左右位置 */

  /* 加粗字体 */
  font-weight: bold;
}

.wrapper {
  width: 100%;
  height: 100%;
  background: rgba(30,144,255);
  background-size: 20px 20px;
  padding: 10px;
  /* 设置上下左右边距为10px */
  min-height: 92.4vh;
  /* 设置最小高度为视口的高度 */
}

.el-main {
  border-radius: 10px;
  /* 设置四角为圆角 */
  background-color: rgba(255, 255, 255);
  /* 设置背景色为白色 */
  min-height: calc(100vh - 80px);
  overflow-y: auto;
}

.hamburger {
  cursor: pointer;
}

.hamburger input {
  display: none;
}

.hamburger svg {
  /* The size of the SVG defines the overall size */
  height: 3em;
  /* Define the transition for transforming the SVG */
  transition: transform 600ms cubic-bezier(0.4, 0, 0.2, 1);
}

.line {
  fill: none;
  stroke: white;
  stroke-linecap: round;
  stroke-linejoin: round;
  stroke-width: 3;
  /* Define the transition for transforming the Stroke */
  transition: stroke-dasharray 600ms cubic-bezier(0.4, 0, 0.2, 1),
    stroke-dashoffset 600ms cubic-bezier(0.4, 0, 0.2, 1);
}

.line-top-bottom {
  stroke-dasharray: 12 63;
}

.hamburger input:checked+svg {
  transform: rotate(-45deg);
}

.hamburger input:checked+svg .line-top-bottom {
  stroke-dasharray: 20 300;
  stroke-dashoffset: -32.42;
}
</style>
