<template>
    <section>
      <!-- 背景颜色 -->
      <div class="color"></div>
      <div class="color"></div>
      <div class="color"></div>
      <div class="box">
        <!-- 登录框 -->
        <div id="app" class="container">
          <div class="form">
            <h2>重置密码</h2>
            <div class="inputBox">
              <input type="text" v-model="resetForm.email" placeholder="邮箱" @blur="validateEmail">
              <p v-if="emailError" class="error">请输入正确的邮箱</p>
            </div>
            <div class="inputBox">
              <input type="password" v-model="resetForm.newPassword" placeholder="新密码" @blur="validateNewPassword"
                @keyup.enter="resetPassword">
              <p v-if="newPasswordError" class="error">密码长度应在6到12位之间</p>
            </div>
            <div class="inputBox">
              <input type="submit" value="确认重置" @click.prevent="resetPassword">
            </div>
              <p class="forget">放弃重置?<a href="#" @click.prevent="backToLogin">点击返回</a></p>
          </div>
        </div>
      </div>
    </section>
  </template>
  
  <script>
  import request from '@/utils/request';
  
  export default {
    data() {
      return {
        resetForm: {
          email: '',
          newPassword: '',
        },
        emailError: false,
        newPasswordError: false,
      };
    },
    methods: {
      validateEmail() {
        const reg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
        this.emailError = !reg.test(this.resetForm.email);
      },
      validateNewPassword() {
        this.newPasswordError =
          this.resetForm.newPassword.length < 6 || this.resetForm.newPassword.length > 12;
      },
      resetPassword() {
        this.validateEmail();
        this.validateNewPassword();
        if (!this.emailError && !this.newPasswordError) {
          request
            .post('/user/findpassword', this.resetForm)
            .then((res) => {
              if (res.code == 0) {
                this.$message.success('密码重置成功, 2秒后跳转到登录界面');
                setTimeout(() => {
                  this.$router.push('/login');
                }, 2000);
              } else {
                this.$message.error('密码重置失败');
              }
            })
            .catch((error) => {
              this.$message.error('密码重置失败');
            });
        }
      },
      backToLogin() {
        this.$router.push('/login');
      },
    },
  };
  </script>
  

  <style scoped>
  /* 清除浏览器默认边距，
  使边框和内边距的值包含在元素的width和height内 */
  
  * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
  }
  
  /* 使用flex布局，让内容垂直和水平居中 */
  
  section {
      /* 相对定位 */
      position: relative;
      overflow: hidden;
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
    /* 背景颜色 */
    background-color: rgb(128, 192, 255);
  }

  
  .box {
      position: relative;
  }
  /* 登录框样式 */
  
  .container {
      position: relative;
      border-radius: 15px;
      width: 400px;
      min-height: 400px;
      background: rgba(255, 255, 255, 0.2);
      display: flex;
      justify-content: center;
      align-items: center;
      backdrop-filter: blur(5px);
      box-shadow: 25px 25px 25px rgb(13,83,255,0.5);
      border: 1px solid rgba(255, 255, 255, 0.5);
      border-right: 1px solid rgba(255, 255, 255, 0.2);
      border-bottom: 1px solid rgba(255, 255, 255, 0.2);
  }
  
  .form {
      position: relative;
      width: 100%;
      height: 100%;
      padding: 50px;
  }
  
  /* 登录标题样式 */
  
  .form h2 {
      position: relative;
      color: #ffffff;
      font-size: 34px;
      font-weight: 600;
      letter-spacing: 5px;
      margin-bottom: 30px;
      cursor: pointer;
  }
  
  /* 登录标题的下划线样式 */
  
  .form h2::before {
      content: "";
      position: absolute;
      left: 0;
      bottom: -10px;
      width: 0px;
      height: 3px;
      background: #409EFF;
      transition: 0.5s;
  }
  
  .form h2:hover:before {
      width: 50%;
  }
  
  .form .inputBox {
      width: 100%;
      margin-top: 20px;
      margin-bottom: 30px; 
  }
  
  /* 输入框样式 */
  
  .form .inputBox input {
      width: 100%;
      padding: 10px 20px;
      background: rgba(255, 255, 255, 0.2);
      outline: none;
      border: none;
      border-radius: 30px;
      border: 1px solid rgba(255, 255, 255, 0.5);
      border-right: 1px solid rgba(255, 255, 255, 0.2);
      border-bottom: 1px solid rgba(255, 255, 255, 0.2);
      font-size: 16px;
      letter-spacing: 1px;
      color: #fff;
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
  }
  
  .form .inputBox input::placeholder {
      color: #fff;
  }
  
  /* 登录按钮样式 */
  
  .form .inputBox input[type="submit"] {
      background: #fff;
      color: #666;
      max-width: 108px;
      margin-bottom: 20px;
      font-weight: 600;
      cursor: pointer;
  }
  
  .forget {
      margin-top: 6px;
      color: #fff;
      letter-spacing: 1px;
  }
  
  .forget a {
      color: #fff;
      font-weight: 600;
      text-decoration: none;
  }
  
  .inputBox {
      position: relative;
  }
  
  .error {
      position: absolute;
      bottom: -20px;
      left: 5%;
      top: 110%;
      color: rgb(255, 72, 72);
      font-size: 12px;
      animation: slideDown 0.5s ease-in-out;
  }
  
  @keyframes slideDown {
      0% {
          opacity: 0;
          transform: translateY(-20px);
      }
      100% {
          opacity: 1;
          transform: translateY(0);
      }
  }
  </style>