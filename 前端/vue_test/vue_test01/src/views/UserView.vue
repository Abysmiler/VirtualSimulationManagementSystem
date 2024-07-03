<template>
    <div>

        <el-input class="user-input" placeholder="请输入用户名" v-model="name" clearable></el-input>
        <el-input class="user-input" placeholder="请输入电话号码" v-model="phone" clearable></el-input>

        <el-button class="user-btn" type="success" @click="selectOne()">搜索</el-button>
        <!-- <el-button type="success" @click="selectAll()">查询所有用户</el-button> -->

        <el-table :data="tableData" style="width: 100%">
            <el-table-column prop="id" label="序号">
            </el-table-column>
            <el-table-column prop="name" label="用户姓名">
            </el-table-column>
            <el-table-column prop="username" label="账户">
            </el-table-column>
            <el-table-column prop="password" label="密码">
            </el-table-column>
            <el-table-column prop="email" label="邮箱" width="180">
            </el-table-column>
            <el-table-column prop="phone" label="电话">
            </el-table-column>
            <el-table-column prop="createTime" label="创建时间">
            </el-table-column>
            <el-table-column prop="updateTime" label="更新时间">
            </el-table-column>
            <el-table-column prop="type" label="用户类型">
            </el-table-column>
            <el-table-column label="操作" width="300">
                <template slot-scope="scope">
                    <el-button class="user-btn" type="primary" @click="edit(scope.row)">编辑</el-button>
                    <!-- 删除提示 -->
                    <el-popconfirm title="这段内容确定删除吗？" @confirm="del(scope.row.id)">
                        <el-button slot="reference" class="user-btn" type="danger">删除</el-button>
                    </el-popconfirm>

                </template>
            </el-table-column>
        </el-table>

        <!-- 编辑弹出框 -->
        <el-dialog title="修改用户信息" :visible.sync="dialogFormVisible">
            <el-form :model="editForm">
                <el-form-item label="姓名" :label-width="formLabelWidth">
                    <el-input v-model="editForm.name" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="用户名" :label-width="formLabelWidth">
                    <el-input v-model="editForm.username" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="密码" :label-width="formLabelWidth">
                    <el-input v-model="editForm.password" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="邮箱" :label-width="formLabelWidth">
                    <el-input v-model="editForm.email" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="电话" :label-width="formLabelWidth">
                    <el-input v-model="editForm.phone" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="用户类型" :label-width="formLabelWidth">
                    <el-select v-model="editForm.type" placeholder="请选择用户类型">
                        <el-option label="用户" value="role_user"></el-option>
                        <el-option label="管理员" value="role_admin"></el-option>
                        <el-option label="系统管理员" value="role_systemAdmin"></el-option>
                    </el-select> 
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogFormVisible = false">取 消</el-button>
                <el-button type="primary" @click="confirmEdit()">确 定</el-button>
            </div>
        </el-dialog>

    </div>
</template>

<script>
import request from '../utils/request';

export default {
    data() {
        return {
            tableData: [],
            name: '',
            phone: '',
            dialogFormVisible: false,
            editForm: {
                name: '',
                username: '',
                password: '',
                email: '',
                phone: '',
                type: 'role_user'
            },
            formLabelWidth: '80px'
        }
    },
    methods: {

        // 删除表单
        del(id) {
            request.delete('user/del/' + id).then(res => {
                if (res.code == 0) {
                    this.$message.success("删除成功")
                    this.selectAll()
                }
            })
        },

        // 表单修改确认
        confirmEdit() {
            // 发送请求修改对应的用户信息
            request.post('/user/update', this.editForm).then(res => {
                if (res.code == 0) {
                    this.$message.success("修改成功")
                }
            })
            this.dialogFormVisible = false
        },
        edit(row) {
            this.editForm = row
            this.dialogFormVisible = true
        },
        selectAll() {
            //调用封装好的request(axios)发送请求访问后端接口 
            request.get('/user/selectAll').then(res => {
                if (res.code == 0) {
                    //查询成功，将数据绑定到表格的data中
                    this.tableData = res.data;
                } else {
                    this.$message.error(res.msg)
                }
            })
        },

        // 按条件查询按钮方法
        selectOne() {
            let params = {
                name: this.name,
                phone: this.phone
            }
            //调用封装好的request(axios)发送请求访问后端接口
            // alert(111)   
            request.get('/user/selectOne', { params }).then(res => {
                if (res.code == 0) {
                    console.log(res)
                    //查询成功，将数据绑定到表格的data中
                    this.tableData = res.data;
                    console.log("搜索成功")
                } else {
                    this.$message.error(res.msg)
                }
            })
        }


    },

    //自动执行了作用域()中的代码 
    mounted() {
        this.selectAll()
    }
}

</script>

<style scoped>
.user-input {
    width: 20%;
    margin-right: 15px;
}

.user-btn {
    width: 80px;
    margin-right: 8px;
}
</style>