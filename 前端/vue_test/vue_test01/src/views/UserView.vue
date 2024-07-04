<template>
    <div>
        <!-- <h1>这里是用户界面</h1> -->
        <el-input class="user-input" placeholder="请输入姓名" v-model="name" clearable></el-input>
        <el-input class="user-input" placeholder="请输入电话" v-model="phone" clearable></el-input>
        <el-button class="user-btn" type="primary" plain @click="selectAll()">搜索</el-button>
        <div class="table-container">
            <el-table :data="pagedData" style="width: 100%">
                <el-table-column prop="id" label="ID" width="120">
                </el-table-column>
                <el-table-column prop="name" label="姓名" width="120">
                </el-table-column>
                <el-table-column prop="username" label="用户名" width="120">
                </el-table-column>
                <el-table-column prop="password" label="密码" width="120">
                </el-table-column>
                <el-table-column prop="email" label="邮箱" width="120">
                </el-table-column>
                <el-table-column prop="phone" label="手机号">
                </el-table-column>
                <el-table-column prop="userType" label="用户类型">
                </el-table-column>
                <!-- 无法判断是否为管理员身份，需要解决 -->
                <el-table-column label="操作" v-if="user.userType == '管理员'">
                    <template slot-scope="scope">
                        <el-button class="user-btn" type="primary" @click="edit(scope.row)">编辑</el-button>
                        <el-popconfirm title="是否删除该用户?" @confirm="del(scope.row.id)">
                            <el-button slot="reference" class="user-btn" type="danger">删除</el-button>
                        </el-popconfirm>
                    </template>
                </el-table-column>
            </el-table>
            <!-- 编辑弹出框 -->
            <el-dialog title="修改用户信息" :visible.sync="dialogFormVisible">
                <el-form :model="editform">
                    <el-form-item label="姓名" :label-width="formLabelWidth">
                        <el-input class="input-length" v-model="editform.name" autocomplete="off"></el-input>
                    </el-form-item>
                    <el-form-item label="用户名" :label-width="formLabelWidth">
                        <el-input class="input-length" v-model="editform.username" autocomplete="off"></el-input>
                    </el-form-item>
                    <el-form-item label="密码" :label-width="formLabelWidth">
                        <el-input class="input-length" v-model="editform.password" autocomplete="off"></el-input>
                    </el-form-item>
                    <el-form-item label="邮箱" :label-width="formLabelWidth">
                        <el-input class="input-length" v-model="editform.email" autocomplete="off"></el-input>
                    </el-form-item>
                    <el-form-item label="电话" :label-width="formLabelWidth">
                        <el-input class="input-length" v-model="editform.phone" autocomplete="off"></el-input>
                    </el-form-item>
                    <el-form-item label="用户类型" :label-width="formLabelWidth">
                        <el-select v-model="editform.userType" placeholder="请选择用户类型">
                            <el-option label="学生" value="学生"></el-option>
                            <el-option label="教师" value="教师"></el-option>
                        </el-select>
                    </el-form-item>
                </el-form>
                <div slot="footer" class="dialog-footer">
                    <el-button type="primary" @click="confirmEdit()">确 定</el-button>
                    <el-button @click="dialogFormVisible = false">取 消</el-button>
                </div>
            </el-dialog>
        </div>
        <el-pagination class="pagination" @size-change="handleSizeChange" @current-change="handleCurrentChange"
            :current-page="currentPage" :page-size="pageSize" layout="total, prev, pager, next, jumper"
            :total="tableData.length">
        </el-pagination>
    </div>
</template>

<script>
import request from '@/utils/request'

export default {
    //数据
    data() {
        return {
            user: localStorage.getItem('user') ? JSON.parse(localStorage.getItem('user')) : {},//当前登录用户的信息
            tableData: [],
            name: '',
            phone: '',
            username: '',
            dialogFormVisible: false,//编辑弹出框是否显示
            currentPage: 1,//当前页
            pageSize: 5, //每页显示5条数据
            pagedData: [],//分页后的数据
            editform: {
                name: '',
                region: '',
                phone: '',
                username: '',
                email: '',
                userType: ''
            },
            formLabelWidth: '120px'
        }
    },
    //方法
    methods: {
        //删除数据的方法
        del(id) {
            request.delete('/user/del/' + id).then(res => {
                if (res.code == 0) {
                    this.$message.success("删除成功")
                    this.selectAll()
                }
            })
        },
        confirmEdit() {
            //发送请求，修改对应的用户信息
            request.post('/user/update', this.editform).then(res => {
                if (res.code == 0) {
                    this.$message.success("修改成功");
                } else {

                }
            })
            this.dialogFormVisible = false
        },
        //编辑按钮方法
        edit(row) {
            this.dialogFormVisible = true
            this.editform = row
        },
        selectAll() {
            let params = {
                name: this.name,
                phone: this.phone
            }
            //调用封装好的request(axios)发送请求后端接口
            request.get("/user/selectAll", { params }).then(res => {
                if (res.code == 0) {
                    //查询成功，将数据绑定到表格的data中
                    this.tableData = res.data;
                    //分页
                    this.handlePagination();
                    // alert("查询成功");
                } else {
                    this.$message.error(res.msg)
                }
            })
        },
        //分页
        handleSizeChange(val) {
            this.pageSize = val;
            this.handlePagination();
        },
        //分页
        handleCurrentChange(val) {
            this.currentPage = val;
            this.handlePagination();
        },
        //分页
        handlePagination() {
            const start = (this.currentPage - 1) * this.pageSize;
            const end = start + this.pageSize;
            this.pagedData = this.tableData.slice(start, end);
        },
    },
    mounted() {
        this.selectAll()
    }
}
</script>

<style scoped>
.user-input {
    width: 10%;
    margin-right: 10px;
}

.user-btn {
    width: 80px;
    margin-right: 5px;
    border-radius: 50px;
}

.table-container {
    height: 300px;/*表格容器的高度*/
    overflow: auto;
}

.pagination {
    position: sticky;
    top: 0;
    text-align: center;
}

.input-length {
    width: 90%; /* 你可以根据需要调整这个值 */
}

.dialogWidth{
    margin: auto;
    width: 50%;
}
</style>