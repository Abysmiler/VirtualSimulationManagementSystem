<template>
<<<<<<< HEAD
    <section>
        <div class="top-title-login">
            <img src="@/assets/logo-2.png" style="width: 90px; height: 90px; position:absolute;left:30px;top:5px;">
            <p style="position:absolute;left:150px;top:30px;color:white;font-size:35px; font-weight: 550; color: #ffff;">欢迎来到虚拟仿真管理系统</p>
        </div>
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
                    <p class="forget">忘记密码? <a href="#" @click.prevent="tofindpassword">点击这里</a></p>
                    <p class="forget">没有账户? <a href="#" @click.prevent="toRegister">注册</a></p>
                </div>
            </div>
        </div>
    </section>
</template>

<script>
=======
    <div class="home">
        <el-row type="flex" class="row-bg" justify="center">
            <div class="bg-img">

            </div>
            <el-col :span="2">
                <div class="grid-content bg-purple"></div>
            </el-col>
            <el-col :span="10">
                <!-- 登录表单 -->
                <div class="login-div">
                    <el-form :model="ruleForm" status-icon :rules="rules" ref="ruleForm" label-width="80px" @keyup.enter.native="login('ruleForm')"
                        class="login-form login-label">
                        <div style="text-align: center;">
                            <h1 style="color: aliceblue;">
                                <pre>欢迎登录虚拟仿真实训教学管理
    及资源共享云平台管理系统</pre>
                            </h1>
                        </div>
                        <el-form-item label="账户" prop="username">
                            <el-input v-model="ruleForm.username"></el-input>
                        </el-form-item>
                        <el-form-item label="密码" prop="pass">
                            <el-input type="password" v-model="ruleForm.password" autocomplete="off"></el-input>
                        </el-form-item>
                        <el-form-item label="用户类型" prop="type">
                            <el-select v-model="ruleForm.type" placeholder="请选择用户类型">
                                <el-option v-for="item in options" :key="item.value" :label="item.label"
                                    :value="item.value">
                                </el-option>
                            </el-select>
                        </el-form-item>
                        <el-form-item class="login-btn" label-width="0">
                            <el-button type="primary" @click="login('ruleForm')">登录</el-button>
                            <el-button @click="toRegister()">注册</el-button>
                        </el-form-item>
                    </el-form>
                </div>
            </el-col>
        </el-row>

    </div>
</template>

<script>
//引入
>>>>>>> afd39807310b478b99e055ed6c0bb1d0660bfaf8
import request from '@/utils/request';
export default {
    data() {
<<<<<<< HEAD
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
=======
        // 自定义密码验证规则
        var validatePass = (rule, value, callback) => {
            if (value === '') {
                callback(new Error('请输入密码'));
            } else {
                if (this.ruleForm.checkPass !== '') {
                    this.$refs.ruleForm.validateField('checkPass');
                }
                callback();
            }
        };
        //用户类型校验
        var checkType = (rule, value, callback) => {
            if (value === '') {
                callback(new Error('请选择'));
            } else {
                callback();
            }
        };
        return {
            options: [{
                value: 1,
                label: '学生'
            }, {
                value: 2,
                label: '管理员'
            }, {
                value: 3,
                label: '系统管理员'
            }
            ],
            value: '',
            ruleForm: {
                username: '',
                password: '',
                type: ''
            },
            rules: {
                password: [
                    // validator:自定义表单校验规则  trigger: 'blur' 当失去焦点时触发校验
                    { min: 6, max: 12, message: '长度6到12位字符', trigger: 'blur' },
                    { validator: validatePass, trigger: 'blur' }
                ],
                username: [
                    { required: true, message: '账户不能为空' }
                ],
            }
        };
    },
    methods: {
        // formName = ruleForm
        login(formName) {
            this.$refs[formName].validate((valid) => {

                if (valid) {
                    // alert(1111)
                    // console.log(this.ruleForm)
                    //如果校验用户输入的信息都正确，那么可以发送请求访问后台登录接口
                    request.post('/user/login', this.ruleForm).then(res => {
                        //code为0代表登录成功
                        if (res.code == 0) {
                            // 弹窗提示用户登录成功
                            this.$message.success('登录成功，即将跳转首页')
                            // this.$message({
                            //     showClose: true,
                            //     message: '登录成功，即将跳转首页',
                            //     type: 'success'
                            // });

                            // 登录成功得到用户信息，将其保存在浏览器的本地存储中
                            // localStorage.setItem("user",res.data)
                            localStorage.setItem("user", JSON.stringify(res.data))


                            //定时器 2s后跳转页面
                            setTimeout(() => {
                                this.$router.push('/')
                            }, 2000)

                        } else {
                            //code不为0弹出提示信息
                            let msg = res.msg
                            this.$message.error(msg)
                        }
                    })
                } else {
                    console.log('error submit!!')
                    return false
>>>>>>> afd39807310b478b99e055ed6c0bb1d0660bfaf8
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

.top-title-login {
  flex: 0.4;
  width: 100%;
  height: 80px;
}

/* 使用flex布局，让内容垂直和水平居中 */

section {
    /* 相对定位 */
    position: relative;
    overflow: hidden;
    display: flex;
    align-items: center;
    min-height: 100vh;
    /* 背景颜色 */
    background-color: rgba(3, 111, 244, 0.804);
}



.box {
    display: flex;
    margin-left: 13.2%;
    align-items: center;
    height: 100vh;
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
