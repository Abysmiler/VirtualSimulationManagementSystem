<template>
    <div>
        <el-descriptions class="margin-top" title="个人信息" :column="3" :size="size" border>
            <template slot="extra">
                <el-button type="primary" size="small" @click="edit" class="ctrl-btn edit-btn">编辑</el-button>
            </template>
            <el-descriptions-item>
                <template slot="label">
                    <i class="el-icon-user"></i>
                    用户名
                </template>
                {{ user.username }}
            </el-descriptions-item>
            <el-descriptions-item>
                <template slot="label">
                    <i class="el-icon-mobile-phone"></i>
                    手机号
                </template>
                {{ user.phone }}
            </el-descriptions-item>
            <el-descriptions-item>
                <template slot="label">
                    <i class="el-icon-message"></i>
                    邮箱
                </template>
                {{ user.email }}
            </el-descriptions-item>
            <el-descriptions-item>
                <template slot="label">
                    <i class="el-icon-key"></i>
                    权限
                </template>
                <el-tag size="small">{{ user.userType }}</el-tag>
            </el-descriptions-item>
            <el-descriptions-item>
                <template slot="label">
                    <i class="el-icon-guide"></i>
                    性别
                </template>
                {{ user.sex }}
            </el-descriptions-item>
            <el-descriptions-item>
                <template slot="label">
                    <i class="el-icon-sort"></i>
                    年龄
                </template>
                {{ user.age }}
            </el-descriptions-item>
            <el-descriptions-item>
                <template slot="label">
                    <i class="el-icon-office-building"></i>
                    联系地址
                </template>
                {{ user.address }}
            </el-descriptions-item>
        </el-descriptions>

        <el-dialog title="编辑个人信息" :visible.sync="dialogFormVisible">
            <el-form :model="editform">
                <el-form-item label="用户名" >&nbsp;&nbsp;&nbsp;
                    <el-input class="input-length" v-model="editform.username" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="手机号" >&nbsp;&nbsp;&nbsp;
                    <el-input class="input-length" v-model="editform.phone" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="邮箱" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <el-input class="input-length" v-model="editform.email" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="联系地址" >
                    <el-input class="input-length" v-model="editform.address" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="性别">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <el-select v-model="editform.sex" placeholder="请选择性别" class="select-sex">
                            <el-option label="男" value="男"></el-option>
                            <el-option label="女" value="女"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="年龄" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <el-input-number class="input-length-number" v-model="editform.age" :min="0" :step="1"
                        controls-position="right"></el-input-number>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogFormVisible = false" class="btn">取消</el-button>
                <el-button type="primary" @click="confirmEdit" class="btn">确定</el-button>
            </div>
        </el-dialog>
    </div>
</template>

<script>
import request from '@/utils/request';

export default {
    data() {
        return {
            user: localStorage.getItem('user') ? JSON.parse(localStorage.getItem('user')) : {},
            size: 'medium',
            dialogFormVisible: false,
            editform: {
                username:'',
                phone:'',
                email:'',
                address:'',
                sex:'',
                age:''
            }
        };
    },
    methods: {
        edit() {
            this.editform = Object.assign({}, this.user); // 复制用户信息到表单
            this.dialogFormVisible = true; // 打开编辑弹出框
        },
        confirmEdit() {
    //发送请求，修改对应的用户信息
    request.post('/user/update', this.editform).then(res => {
        if (res.code == 0) {
            this.$message.success("修改成功");
            // 更新本地存储的用户信息
            localStorage.setItem('user', JSON.stringify(this.editform));
            // 更新当前用户信息
            this.user = Object.assign({}, this.editform);
        } else {
            this.$message.error("修改失败");
        }
    })
    this.dialogFormVisible = false
},
    },
    mounted() {
        // 可以在这里进行更多的初始化操作
    },
};
</script>

<style scoped>
.margin-top {
    margin-top: 20px;
}

.input-length {
    width: 80%;
}

.input-length-number{
    width: 25%;
}

.sex-input{
    text-align: center;
}

.select-sex .el-input__inner {
  text-align: center;
}

</style>

