import router from './router';
<template>
  <div class="app">
    <el-container>
      <el-header style="background-color: #E1FFFF;">

        <img src="@/assets/logo.png" style="width: 60px; height: 60px; position:absolute;left:10px;top:10px;">
        <!--   font-size: 18px    字体大小 -->
        <span style=" position:absolute;left:80px;top:30px;font-size: 18px;">Vue管理系统</span>
        <!-- 退出登录 -->
        <el-dropdown trigger="click" style="color: black; font-size: 16px; float: right; height:60px; line-height:60px">
          <span class="el-dropdown-link">
            <!-- el-icon-user  用户图标 -->
            <i class="el-icon-user"></i>
            {{ user.name }}  {{ user.type }}<i class="el-icon-arrow-down el-icon--right"></i>
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
      <el-container>
        <el-aside style="background-color:#E1FFFF; width:200px;min-height: 100vh; ">
          <el-menu :default-active="$route.path" router class="el-menu-vertical-demo" @open="handleOpen"
            @close="handleClose" background-color="#E1FFFF" text-color="1E0000" active-text-color="#00BFFF">
            <el-menu-item index="/">
              <i class="el-icon-menu"></i>
              <span slot="title">系统首页</span>
            </el-menu-item>
            <el-submenu index="2" v-if="user.type != '学生'">
              <template slot="title">
                <i class="el-icon-location"></i>
                <span>用户管理</span>
              </template>
              <el-menu-item-group>
                <el-menu-item index="/admin" v-if="user.type == '超级管理员'">管理员信息</el-menu-item>
                <el-menu-item index="/user" v-if="user.type != '超级管理员'">用户信息</el-menu-item>
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
        <el-main>
          <router-view />
        </el-main>
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
</style>