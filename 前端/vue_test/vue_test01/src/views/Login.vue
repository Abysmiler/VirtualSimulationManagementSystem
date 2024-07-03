<!-- 登录界面 -->
<template>
    <div class="home">
        <el-row type="flex" class="row-bg" justify="center">
            <div class="bg-img"></div>
            <el-col :span="2">
                <div class="grid-content bg-purple"></div>
            </el-col>
            <el-col :span="10">
                <div class="login-div">
                    <!-- 登录表单 -->
                    <el-form :model="ruleForm" status-icon :rules="rules" ref="ruleForm" label-width="80px"
                        class="login-form custom-label">
                        <div style="text-align: center;">
                            <h1>
                                <pre>欢迎登录虚拟仿真实训教学管理
    及资源共享平台管理系统</pre>
                            </h1>
                        </div>

                        <el-form-item label="账户" prop="username">
                            <el-input v-model="ruleForm.username"></el-input>
                        </el-form-item>

                        <el-form-item label="密码" prop="password">
                            <el-input @keyup.enter.native="login('ruleForm')" type="password"
                                v-model="ruleForm.password" autocomplete="off"></el-input>
                        </el-form-item>

                        <el-form-item class="login-btn" label-width="0">
                            <el-button type="primary" @click="login('ruleForm')">登录</el-button>
                            <el-button @click="toRegister()">注册</el-button>
                        </el-form-item>
                        <el-form-item style="text-align: center;">
                            <a class="findpassword-link" style="margin-right: 17%;" @click="tofindpassword()">忘记密码?去找回</a>
                        </el-form-item>
                    </el-form>
                </div>
            </el-col>
        </el-row>
    </div>
</template>

<script>
// 引入了组件
import request from '@/utils/request';

export default {
    data() {
        // 自定义验证密码规则
        var validatePass = (rule, value, callback) => {
            if (value === '') {
                callback(new Error('密码不能为空'));
            } else {
                if (this.ruleForm.checkPass !== '') {
                    this.$refs.ruleForm.validateField('checkPass');
                }
                callback();
            }
        };

        return {
            options: [{
                value: 1,
                label: '学生'
            }, {
                value: 2,
                label: '教职工'
            }, {
                value: 3,
                label: '实验室管理员'
            }],
            value: '',
            ruleForm: {
                username: '',
                password: '',
                type: '1'            },
            rules: {
                password: [
                    {
                        min: 6,
                        max: 12,
                        message: '长度在 6 到 12 个字符',
                        trigger: 'blur'
                    },
                    { validator: validatePass, trigger: 'blur' },

                ],
                username: [
                    { required: true, message: '账户名不能为空' }
                ],
            }
        };
    },
    methods: {
        login(formName) {
            //刚刚的ref生效
            this.$refs[formName].validate((valid) => {
                if (valid) {
                    //获取select选择器中label的值
                    // let test1 = this.options.find(option => option.value ===  this.ruleForm.type);
                    // console.log(test1.label);
                    //如果校验用户输入的信息都正确,那么可以发送请求访问后台注册接口
                    let params = {
                        username: this.ruleForm.username,
                        password: this.ruleForm.password,
                        type: this.ruleForm.type
                    }
                    request.post('/user/login',params).then(res => {
                        //code为0代表登录成功
                        if (res.code == 0) {
                            //弹窗提示用户登录成功
                            this.$message.success("登录成功,即将跳转到后台首页")
                            //登录成功得到用户的登录信息，将其保存在浏览器的本地存储中
                            localStorage.setItem("user",JSON.stringify(res.data))
                            //定时器，两秒后跳转页面
                            setTimeout(() => {
                                this.$router.push('/')
                            }, 2000);
                        } else {
                            //code不为0代表失败，弹出提示信息
                            let msg = res.msg
                            this.$message.error(msg)
                        }
                    })
                } else {
                    console.log('error submit!!');
                    return false;
                }
            });
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

<style>
button{
    width: 120px;
    /* height: 50px; */
}
.login-btn{
    text-align: center;
}
.login-div {
    /* 设置表单距浏览器上边距 */
    margin-top: 20%;
    width: 770px;
}

/* 设置背景图片 */
.bg-img {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-image: url('../assets/loginbg.png');
    background-size: cover;
    background-position: center;
    z-index: -10; /*层级 */
}

/* 设置表单背景色 */
.login-form {
    width: 80%;
    padding: 30px;
    /* 设置透明背景 */
    background-color: rgba(255, 255, 255, 0.30);
    border-radius: 14px;
}

.custom-label .el-form-item__label {
    /*设置标签文字颜色为白色 */
    color: #ffffff;
}

.findpassword-link{
    color: #ffffff;
    text-decoration: underline;
    cursor: pointer;
}
</style>