import router from './router';
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
          <el-submenu index="2" v-if="user.userType != '学生'">
            <template slot="title">
              <i class="el-icon-location"></i>
              <span>用户管理</span>
            </template>
            <el-menu-item-group>
              <el-menu-item index="/admin" v-if="user.userType == '超级管理员'">管理员信息</el-menu-item>
              <el-menu-item index="/user" v-if="user.userType != '超级管理员'">用户信息</el-menu-item>
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
              <el-menu-item index="/device">设备信息</el-menu-item>
            </el-menu-item-group>
          </el-submenu>
        </el-menu>
      </el-aside>

      <el-container>
        <el-header style="background-color: #1E90FF;">
          <el-dropdown trigger="click"
            style="color: black; font-size: 16px; float: right; height:60px; line-height:60px">
            <span class="el-dropdown-link">
              <!-- el-icon-user  用户图标 -->
              <i class="el-icon-user header-user"></i>
              <span class="header-user">{{ user.name }} {{ user.userType }}</span><i
                class="el-icon-arrow-down el-icon--right header-user"></i>
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
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {}
    }
  },

  methods: {
    //清除当前浏览器的登录状态信息
    loginout() {
      localStorage.removeItem("user");
      setTimeout(() => {
        this.$router.push("/login")
      }, 1000)
    },
    userinfo() {
      this.$router.push('/userinfo').catch(err => {
        if (err.name !== 'NavigationDuplicated') {
          throw err
        }
      })
    },
    handleOpen(key, keyPath) {
      console.log(key, keyPath);
    },
    handleClose(key, keyPath) {
      console.log(key, keyPath);
    }
  }
}
</script>
<style lang="less">
.myHeader {
  background-color: #2b2b2b;
}

.el-dropdown-link {
  cursor: pointer;
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

.header-user{
  color: #FFFFFF;
}

.wrapper {
  background-color: #dddcdc; /* 设置背景色为灰色 */
  padding: 15px; /* 设置上下左右边距为10px */
  min-height: 94vh; /* 设置最小高度为视口的高度 */
}

.el-main {
  border-radius: 10px; /* 设置四角为圆角 */
  background-color: #ffffff; /* 设置背景色为白色 */
  min-height: calc(94vh - 30px); /* 设置最小高度为视口的高度减去上下边距 */
}


</style>
