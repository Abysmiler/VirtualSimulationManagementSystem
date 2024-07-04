<template>
    <div>
        <el-input class="admin-input" placeholder="请输入姓名" v-model="name" clearable></el-input>
        <el-input class="admin-input" placeholder="请输入电话" v-model="phone" clearable></el-input>
        <el-button class="admin-btn" type="primary" plain @click="selectAllSuper()">搜索</el-button>
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
                <el-table-column label="操作">
                    <template slot-scope="scope">
                        <el-button class="admin-btn" type="primary" @click="edit(scope.row)">编辑</el-button>
                        <el-popconfirm title="是否删除该管理员?" @confirm="del(scope.row.id)">
                            <el-button slot="reference" class="admin-btn" type="danger">删除</el-button>
                        </el-popconfirm>
                    </template>
                </el-table-column>
            </el-table>
            <!-- 编辑弹出框 -->
            <el-dialog title="修改管理员权限" :visible.sync="dialogFormVisible" class="dialogWidth">
                <el-form :model="editform">
                    <el-form-item label="用户类型" :label-width="formLabelWidth">
                        <el-select v-model="editform.userType" placeholder="请选择用户类型">
                            <el-option label="学生" value="学生"></el-option>
                            <el-option label="教师" value="教师"></el-option>
                            <el-option label="管理员" value="管理员"></el-option>
                        </el-select>
                    </el-form-item>
                </el-form>
                <div slot="footer" class="dialog-footer">
                    <el-button @click="dialogFormVisible = false">取 消</el-button>
                    <el-button type="primary" @click="confirmEdit()">确 定</el-button>
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
    data() {
        return {
            user: localStorage.getItem('user') ? JSON.parse(localStorage.getItem('user')) : {},
            name: '',
            phone: '',
            username: '',
            dialogFormVisible: false,
            currentPage: 1,//当前页
            pageSize: 5, //每页显示5条数据
            tableData: [],//表格数据
            pagedData: [],//分页后的数据
            editform: {
                userType: ''
            },
            formLabelWidth: '120px'
        }
    },
        methods: {
            //删除数据的方法
            del(id) {
                request.delete('/user/del/' + id).then(res => {
                    if (res.code == 0) {
                        this.$message.success("删除成功")
                        this.selectAllSuper()
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
            selectAllSuper() {
                let params = {
                    name: this.name,
                    phone: this.phone
                }
                //调用封装好的request(axios)发送请求后端接口
                request.get("/user/selectAllSuper", { params }).then(res => {
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
        //页面加载完成后，调用查询所有的方法
        this.selectAllSuper()
    }
}
</script>

<style scoped>
.admin-input {
    width: 10%;
    margin-right: 10px;
}

.admin-btn {
    width: 80px;
    margin-right: 5px;
    border-radius: 50px;
}

.table-container {
    height: 300px;
    /*表格容器的高度*/
    overflow: auto;
}

.pagination {
    position: sticky;
    top: 0;
    text-align: center;
}
.dialogWidth{
    margin: auto;
    width: 50%;
}
</style>