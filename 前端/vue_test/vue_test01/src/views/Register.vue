<!-- 注册界面 -->
<template>
    <div class="home">
        <el-row type="flex" class="row-bg" justify="center">
            <div class="bg-img"></div>
            <el-col :span="2">
                <div class="grid-content bg-purple"></div>
            </el-col>
            <el-col :span="10">
                <div class="register-div">
                    <el-form :model="ruleForm" status-icon :rules="rules" ref="ruleForm" label-width="80px"
                        class="register-form custom-label">
                        <h1 style="text-align: center;">注&emsp;&emsp;&emsp;册</h1>
                        <el-form-item label="用户姓名" prop="name">
                            <el-input v-model="ruleForm.name"></el-input>
                        </el-form-item>
                        <el-form-item label="账户" prop="username">
                            <el-input v-model="ruleForm.username"></el-input>
                        </el-form-item>
                        <el-form-item label="邮箱" prop="email">
                            <el-input v-model="ruleForm.email"></el-input>
                        </el-form-item>
                        <el-form-item label="手机号" prop="phone">
                            <el-input v-model="ruleForm.phone"></el-input>
                        </el-form-item>
                        <el-form-item label="密码" prop="password">
                            <el-input type="password" v-model="ruleForm.password" autocomplete="off"></el-input>
                        </el-form-item>
                        <el-form-item label="确认密码" prop="checkPass">
                            <el-input type="password" v-model="ruleForm.checkPass" autocomplete="off"></el-input>
                        </el-form-item>
                        <el-form-item label="用户类型" prop="type">
                            <el-select v-model="ruleForm.type" placeholder="请选择用户类型">
                                <el-option v-for="item in options" :key="item.value" :label="item.label"
                                    :value="item.value">
                                </el-option>
                            </el-select>
                        </el-form-item>
                        <el-form-item>
                            <el-button type="primary" @click="register('ruleForm')">提交</el-button>
                            <el-button @click="resetForm('ruleForm')">重置</el-button>
                        </el-form-item>
                        <el-form-item>
                            <a class="login-link" @click="toLogin()">已有账号?去登录</a>
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
import HelloWorld from '../components/HelloWorld.vue'

export default {
    name: 'HomeView',
    //声明了组件，这样才可以作为标签来使用
    components: {
        HelloWorld
    },
    data() {
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
        var validatePass2 = (rule, value, callback) => {
            if (value === '') {
                callback(new Error('请再次输入密码'));
            } else if (value !== this.ruleForm.password) {
                callback(new Error('两次输入密码不一致!'));
            } else {
                callback();
            }
        };

        var checkEmail = (rule, value, callback) => {
            //定义正则表达式对输入的邮箱格式进行校验
            const reg = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
            var flag = reg.test(value);

            if (value === '') {
                callback(new Error('邮箱不能为空'));
            } else if (!flag) {
                callback(new Error('邮箱格式有误，请输入正确的邮箱'));
            } else {
                callback();
            }
        };
        var checkPhone = (rule, value, callback) => {
            //定义正则表达式对输入的电话格式进行校验
            const reg = /^[1][3,4,5,6,7,8,9][0-9]{9}$/;
            var flag = reg.test(value);

            if (value === '') {
                callback(new Error('手机号不能为空'));
            } else if (!flag) {
                callback(new Error('手机号格式有误，请输入正确的手机号'));
            } else {
                callback();
            }

        };
        var checkType = (rule, value, callback) => {
            if (value === '') {
                callback(new Error('请选择用户类型'))
            } else {
                callback();
            }
        };
        return {
            options: [{
                value: '学生',
                label: '学生'
            }, {
                value: '教师',
                label: '教师'
            }, {
                value: '管理员',
                label: '管理员'
            }],
            value: '',
            ruleForm: {
                name: '',
                username: '',
                email: '',
                phone: '',
                password: '',
                checkPass: '',
                type: ''
            },
            rules: {
                password: [
                    {
                        required: true,
                        message: '请输入密码',
                        trigger: 'blur'
                    },
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
                name: [
                    { required: true, message: '用户名不能为空' }
                ],
                checkPass: [
                    { validator: validatePass2, trigger: 'blur' }
                ],
                //自定义验证规则
                email: [
                    { required: true, validator: checkEmail, trigger: 'blur' }
                ],
                phone: [
                    {
                        required: true,
                        message: '请输入手机号',
                        trigger: 'blur'
                    },
                    { validator: checkPhone, trigger: 'blur' }
                ],
                type: [
                    { required: true, message: '用户类型不能为空' },
                    { validator: checkType, trigger: 'blur' }
                ],
            }
        };
    },
    methods: {
        register(formName) {
            //刚刚的ref生效
            this.$refs[formName].validate((valid) => {
                if (valid) {
                    //获取select选择器中label的值
                    // let test1 = this.options.find(option => option.value ===  this.ruleForm.type);
                    // console.log(test1.label);
                    //如果校验用户输入的信息都正确,那么可以发送请求访问后台注册接口
                    request.post('/user/register', this.ruleForm).then(res => {
                        //code为0代表用户成功
                        if (res.code == 0) {
                            //提示用戶注冊成功
                            this.$message({
                                showClose: true,
                                message: '注册成功,即将跳转到登录页',
                                type: 'success'
                            });
                            //并且跳转到登录页
                            this.$router.push('/login')
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

        toLogin() {
            this.$router.push('/login');
        },

        resetForm(formName) {
            this.$refs[formName].resetFields();
        }
    }
}
</script>

<style>
.register-div {
    /* 设置表单距浏览器上边距 */
    margin-top: 17.5%;
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
    z-index: -10;
}

/* 设置表单背景色 */
.register-form {
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

.login-link {
    color: white;
    text-decoration: underline;
    cursor: pointer;
}
</style>