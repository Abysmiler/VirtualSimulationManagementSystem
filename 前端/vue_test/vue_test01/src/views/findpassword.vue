<template>
    <div class="home">
        <el-row type="flex" class="row-bg" justify="center">
            <div class="back-bg-img"></div>
            <el-col :span="2">
                <div class="grid-content bg-purple"></div>
            </el-col>
            <el-col :span="10">
                <div class="login-div">
                    <!-- 找回密码表单 -->
                    <el-form :model="resetForm" status-icon ref="resetForm" label-width="80px"
                        class="login-form custom-label" :rules="rules">
                        <div style="text-align: center;">
                            <h1>
                                <pre>重置密码</pre>
                            </h1>
                        </div>
                        <el-form-item label="邮箱" prop="email">
                            <el-input v-model="resetForm.email"></el-input>
                        </el-form-item>
                        <el-form-item label="新密码" prop="newPassword">
                            <el-input type="password" v-model="resetForm.newPassword" autocomplete="off"></el-input>
                        </el-form-item>
                        <el-form-item class="login-btn" label-width="0">
                            <el-button type="primary" @click="resetPassword('resetForm')">确认重置</el-button>
                        </el-form-item>
                    </el-form>
                    <el-tooltip content="返回登录" placement="top">
                        <el-button class="back-btn" type="text" icon="el-icon-back" @click="backToLogin"></el-button>
                    </el-tooltip>
                </div>
            </el-col>
        </el-row>
    </div>
</template>

<script>
import request from '@/utils/request'

export default {
    data() {
        var validateEmail = (rule, value, callback) => {
            var reg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
            if (value === '') {
                callback(new Error('请输入邮箱'));
            } else if (!reg.test(value)) {
                callback(new Error('请输入正确的邮箱'));
            } else {
                callback();
            }
        };
        var validatePassword = (rule, value, callback) => {
            if (value.length < 6 || value.length > 12) {
                callback(new Error('密码长度应在6到12位之间'));
            } else {
                callback();// 验证通过
            }
        };
        return {
            resetForm: {
                email: '',
                newPassword: '',
            },
            rules: {
                email: [
                    { required: true, message: '请输入邮箱', trigger: 'blur' },
                    { validator: validateEmail, trigger: 'blur' }
                ],
                newPassword: [
                    { required: true, message: '请输入新密码', trigger: 'blur' },
                    { validator: validatePassword, trigger: 'blur' }
                ]
            }
        };
    },
    methods: {
        resetPassword() {
            this.$refs['resetForm'].validate((valid) => {
                if (valid) {
                    request.post('/user/findpassword', this.resetForm)
                        .then(res => {
                            if (res.code == 0) {
                                this.$message.success("密码重置成功,2秒后跳转到登录界面");
                                setTimeout(() => {
                                    this.$router.push('/login');
                                }, 2000);
                            } else {
                                this.$message.error("密码重置失败");
                            }
                        })
                } else {
                    return false;
                }
            });
        },
        backToLogin() {
            this.$router.push('/login')
        }
    }
}
</script>

<style>
.back-bg-img {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-image: url('../assets/bg1.jpg');
    background-size: cover;
    background-position: center;
    z-index: -10;
}

.back-btn {
    /* 绝对定位 */
    position: absolute;
    top: 10px;
    left: 10px;
}

/* 自定义图标颜色 */
.el-icon-back {
    color: #ffffff;
    font-size: 24px;
}
</style>