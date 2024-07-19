<template>
    <section>
        <div class="color"></div>
        <div class="color"></div>
        <div class="color"></div>
        <div class="box">
            <div id="app" class="container">
                <div class="form">
                    <h2>注册</h2>
                    <div class="inputBox">
                        <input type="text" v-model="ruleForm.name" placeholder="用户姓名" @blur="validateField('name')">
                        <p v-if="rules.nameError" class="error">用户名不能为空</p>
                    </div>
                    <div class="inputBox">
                        <input type="text" v-model="ruleForm.username" placeholder="账户"
                            @blur="validateField('username')">
                        <p v-if="rules.usernameError" class="error">账户名不能为空</p>
                    </div>
                    <div class="inputBox">
                        <input type="email" v-model="ruleForm.email" placeholder="邮箱" @blur="validateField('email')">
                        <p v-if="rules.emailError" class="error">{{ rules.emailErrorMessage }}</p>
                    </div>
                    <div class="inputBox">
                        <input type="tel" v-model="ruleForm.phone" placeholder="手机号" @blur="validateField('phone')">
                        <p v-if="rules.phoneError" class="error">{{ rules.phoneErrorMessage }}</p>
                    </div>
                    <div class="inputBox">
                        <input type="password" v-model="ruleForm.password" placeholder="密码"
                            @blur="validateField('password')">
                        <p v-if="rules.passwordError" class="error">长度在 6 到 12 个字符</p>
                    </div>
                    <div class="inputBox">
                        <input type="password" v-model="ruleForm.checkPass" placeholder="确认密码"
                            @blur="validateField('checkPass')">
                        <p v-if="rules.checkPassError" class="error">两次输入密码不一致!</p>
                    </div>
                    <div class="inputBox">
                        <select v-model="ruleForm.userType" @blur="validateField('type')" class="custom-select">
                            <option disabled value="">请选择用户类型</option>
                            <option v-for="item in options" :key="item.value" :value="item.value">{{ item.label }}
                            </option>
                        </select>
                        <p v-if="rules.typeError" class="error">请选择用户类型</p>
                    </div>
                    <div class="inputBox">
                        <input type="submit" value="提交" @click.prevent="register">
                        <input type="reset" value="重置" @click.prevent="resetForm">
                    </div>
                    <p class="forget">已有账号? <a href="#" @click.prevent="toLogin">去登录</a></p>
                </div>
            </div>
        </div>
    </section>
</template>


<script>
//引入
import request from '@/utils/request';

export default {
    data() {
        return {
            options: [
                { value: '学生', label: '学生' },
                { value: '教师', label: '教师' },
                { value: '管理员', label: '管理员' }
            ],
            ruleForm: {
                name: '',
                username: '',
                age: '',
                email: '',
                phone: '',
                password: '',
                checkPass: '',
                userType: ''
            },
            rules: {
                nameError: false,
                usernameError: false,
                emailError: false,
                emailErrorMessage: '',
                phoneError: false,
                phoneErrorMessage: '',
                passwordError: false,
                checkPassError: false,
                typeError: false
            }
        };
    },
    methods: {
        validateField(field) {
            switch (field) {
                case 'name':
                    this.rules.nameError = this.ruleForm.name.trim() === '';
                    break;
                case 'username':
                    this.rules.usernameError = this.ruleForm.username.trim() === '';
                    break;
                case 'email':
                    const emailReg = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
                    this.rules.emailError = !emailReg.test(this.ruleForm.email);
                    this.rules.emailErrorMessage = this.rules.emailError ? '邮箱格式有误，请输入正确的邮箱' : '';
                    break;
                case 'phone':
                    const phoneReg = /^[1][3,4,5,6,7,8,9][0-9]{9}$/;
                    this.rules.phoneError = !phoneReg.test(this.ruleForm.phone);
                    this.rules.phoneErrorMessage = this.rules.phoneError ? '手机号格式有误，请输入正确的手机号' : '';
                    break;
                case 'password':
                    this.rules.passwordError = this.ruleForm.password.length < 6 || this.ruleForm.password.length > 12;
                    break;
                case 'checkPass':
                    this.rules.checkPassError = this.ruleForm.checkPass !== this.ruleForm.password;
                    break;
                case 'type':
                    this.rules.typeError = this.ruleForm.userType === '';
                    break;
            }
        },
        register() {
            Object.keys(this.ruleForm).forEach(field => this.validateField(field));
            if (!Object.values(this.rules).some(error => error)) {
                request.post('/user/register', this.ruleForm).then(res => {
                    if (res.code == 0) {
                        this.$message.success("注册成功,即将跳转到登录页");
                        this.$router.push('/login');
                    } else {
                        this.$message.error(res.msg);
                    }
                });
            }
        },
        resetForm() {
            this.ruleForm = {
                name: '',
                username: '',
                email: '',
                phone: '',
                password: '',
                checkPass: '',
                userType: ''
            };
            this.rules = {
                nameError: false,
                usernameError: false,
                emailError: false,
                emailErrorMessage: '',
                phoneError: false,
                phoneErrorMessage: '',
                passwordError: false,
                checkPassError: false,
                typeError: false
            };
        },
        toLogin() {
            this.$router.push('/login');
        }
    }
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
    background-color: rgba(3, 111, 244, 0.804);
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
    box-shadow: 25px 25px 25px rgb(13, 83, 255, 0.5);
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
    margin-bottom: 20px;
    position: relative;
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

.form .inputBox select {
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
    background-image: url('data:image/svg+xml;utf8,<svg fill="white" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path d="M7 10l5 5 5-5z"/></svg>');
    background-repeat: no-repeat;
    background-position: calc(100% - 20px) center; 
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;   
}
.form .inputBox option {
    background: #40a0ff87;
    color: #fff;
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
    margin-right: 10px;
}

.form .inputBox input[type="reset"] {
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
    top: 106%;
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
