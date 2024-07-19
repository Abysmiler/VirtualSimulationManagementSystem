<template>
    <div class="home">
        <el-row>
            <div class="bg-img">

            </div>
            <el-col :span="8">
                <div class="grid-content bg-purple"></div>
            </el-col>
            <el-col :span="8">
                <div class="grid-content bg-purple-light"></div>
            </el-col>
            <el-col :span="8" :offset="16">
                <div class="register-div">
                    <el-form :model="ruleForm" status-icon :rules="rules" ref="ruleForm" label-width="80px"
                        class="register-form register-label">
                        <div style="text-align: center;">
                            <h1 style="color: aliceblue;"><pre>注    册</pre></h1>
                        </div>
                        <el-form-item label="用户姓名" prop="name">
                            <el-input v-model="ruleForm.name"></el-input>
                        </el-form-item>
                        <el-form-item label="账户" prop="username">
                            <el-input v-model="ruleForm.username"></el-input>
                        </el-form-item>
                        <el-form-item label="年龄" prop="age">
                            <el-input v-model.number="ruleForm.age"></el-input>
                        </el-form-item>
                        <el-form-item label="邮箱" prop="email">
                            <el-input v-model="ruleForm.email"></el-input>
                        </el-form-item>
                        <el-form-item label="手机号" prop="phone">
                            <el-input v-model="ruleForm.phone"></el-input>
                        </el-form-item>
                        <el-form-item label="密码" prop="pass">
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

        //邮箱校验
        var checkEmail = (rule, value, callback) => {
            // 定义正则表达式
            const emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
            //使用正则表达式，返回值为bool类型，满足为true，不满足为false
            if (!value) {
                callback(new Error('邮箱不能为空'));
            } else if (!emailPattern.test(value)) {
                callback(new Error('请输入正确的邮箱格式'))
            } else {
                callback();
            }
        };
        //手机号校验
        var checkPhone = (rule, value, callback) => {
            // 定义正则表达式
            const phonePattern = /^1[3-9]\d{9}$/;
            //使用正则表达式，返回值为bool类型，满足为true，不满足为false
            if (!value) {
                callback(new Error('手机号不能为空'));
            } else if (!phonePattern.test(value)) {
                callback(new Error('请输入正确的手机号格式'))
            } else {
                callback();
            }
        };
        //年龄校验
        var checkAge = (rule, value, callback) => {
            if (!value) {
                return callback(new Error('年龄不能为空'));
            }
            setTimeout(() => {
                if (!Number.isInteger(value)) {
                    callback(new Error('请输入数字值'));
                } else {
                    if (value < 18) {
                        callback(new Error('必须年满18岁'));
                    } else {
                        callback();
                    }
                }
            }, 1000);
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
                label: '教职工'
            }, {
                value: 3,
                label: '实验室管理员'
            }
            ],
            value: '',
            ruleForm: {
                name: '',
                username: '',
                age: '',
                email: '',
                phone: '',
                password: '',
                checkPass: '',
                type: ''
            },
            rules: {
                password: [
                    // validator:自定义表单校验规则  trigger: 'blur' 当失去焦点时触发校验
                    { min: 6, max: 12, message: '长度6到12位字符', trigger: 'blur' },
                    { validator: validatePass, trigger: 'blur' }
                ],
                checkPass: [
                    { validator: validatePass2, trigger: 'blur' }
                ],
                age: [
                    { validator: checkAge, trigger: 'blur' },
                    { required: true, message: '年龄不能为空' }
                ],
                phone: [
                    { validator: checkPhone, trigger: 'blur' },
                    { required: true, message: '手机号不能为空' }
                ],
                email: [
                    { validator: checkEmail, trigger: 'blur' },
                    { required: true, message: '邮箱不能为空' }
                ],
                username: [
                    { required: true, message: '账户不能为空' }
                ],
                name: [
                    { required: true, message: '用户姓名不能为空' }
                ],
                type: [
                    { validator: checkType, trigger: 'blur' }
                ]
            }
        };
    },
    methods: {
        // formName = ruleForm
        register(formName) {
            this.$refs[formName].validate((valid) => {
                if (valid) {
                    //如果校验用户输入的信息都正确，那么可以发送请求访问后台注册接口
                    request.post('/user/register', this.ruleForm).then(res => {
                        if (res.code == 0) {
                            this.$message({
                                showClose: true,
                                message: '注册成功，即将跳转登录页',
                                type: 'success'
                            });
                            this.$router.push('/')
                        } else {
                            let msg = res.msg;
                            this.$message.error(msg);
                        }
                    })
                } else {
                    console.log('error submit!!');
                    return false;
                }
            });
        },
        resetForm(formName) {
            this.$refs[formName].resetFields();
        }
    }
}
</script>

<style>
.register-form {
    margin-top: 25%;
}

.register-form {
    width: 80%;
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

.register-label .el-form-item__label {
    color: aliceblue;
}
</style>
