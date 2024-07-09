<!-- 登录界面 -->
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
                    <h2>登录</h2>
                    <div class="inputBox">
                        <input type="text" v-model="username" placeholder="账户" @blur="validateUsername">
                        <p v-if="usernameError" class="error">账户名不能为空</p>
                    </div>
                    <div class="inputBox">
                        <input type="password" v-model="password" placeholder="密码" @blur="validatePassword"
                            @keyup.enter="login">
                        <p v-if="passwordError" class="error">密码长度在 6 到 12 个字符</p>
                    </div>
                    <div class="inputBox">
                        <input type="submit" value="登录" @click.prevent="login">
                    </div>
                    <p class="forget">忘记密码?<a href="#" @click.prevent="tofindpassword">点击这里</a></p>
                    <p class="forget">没有账户?<a href="#" @click.prevent="toRegister">注册</a></p>
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
            username: '',
            password: '',
            usernameError: false,
            passwordError: false
        };
    },
    methods: {
        validateUsername() {
            this.usernameError = this.username.trim() === '';
        },
        validatePassword() {
            this.passwordError = this.password.length < 6 || this.password.length > 12;
        },
        login() {
            this.validateUsername();
            this.validatePassword();
            if (!this.usernameError && !this.passwordError) {
                let params = {
                    username: this.username,
                    password: this.password
                }
                request.post('/user/login', params).then(res => {
                    if (res.code == 0) {
                        this.$message.success("登录成功,即将跳转到后台首页")
                        localStorage.setItem("user", JSON.stringify(res.data))
                        setTimeout(() => {
                            this.$router.push('/').catch(err => { })
                        }, 2000);
                    } else {
                        let msg = res.msg
                        this.$message.error(msg)
                    }
                })
            }
        },
        toRegister() {
            this.$router.push('/register')
        },
        tofindpassword() {
            this.$router.push('/findpassword')
        }
    }
}
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
    background-color: rgb(0, 125, 251);
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
    /* 登录框颜色 */
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
    width: 24%;
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
    background: rgb(255, 255, 255);
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
    max-width: 100px;
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