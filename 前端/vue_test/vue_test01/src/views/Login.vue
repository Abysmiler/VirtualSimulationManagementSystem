<template>
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
import request from '@/utils/request';

export default {
    data() {
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
                }
            });
        },
        toRegister() {
            this.$router.push('/register')
        }
    }
}
</script>



<style>
button {
    width: 150px;
}

.login-btn {
    text-align: center;
}

/* .home{
    display: flex;
    justify-content: center;
    align-content: center;
    height: 100vh;
} */

.login-div {
    margin-top: 20%;
    /* width:100%;
    max-width: 400px; */
}

.login-form {
    width: 90%;
    background-color: rgba(255, 255, 255, 0.10);
    padding: 30px;
    border-radius: 15px;
}

.bg-img {
    position: fixed;
    top: 0;
    left: 0;
    height: 100%;
    width: 100%;
    background-image: url('../assets/loginbg.png');
    background-size: cover;
    background-position: center;
    z-index: -10;
}

.login-label .el-form-item__label {
    color: aliceblue;
}
</style>
