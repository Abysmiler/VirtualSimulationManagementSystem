<template>
    <div>
        <div class="input-container">
            <input class="input-linght" placeholder="请输入姓名" v-model="name">
            <div class="highlight"></div>
            <input class="input-linght" placeholder="请输入电话" v-model="phone">
            <div class="highlight-1"></div>
            <el-button class="confirm-btn btn" type="primary" icon="el-icon-search" @click="selectAllSuper()">搜索</el-button>
        </div>
        <div class="table-container">
            <el-table :data="pagedData" style="width: 100%" border>
                <el-table-column prop="id" label="ID" width="100" align="center" header-align="center">
                    <template slot-scope="scope">
                        <span style="font-size: 14.4px; font-weight: normal;">{{ scope.row.id }}</span>
                    </template>
                </el-table-column>
                <el-table-column prop="name" label="姓名" width="100" align="center" header-align="center">
                    <template slot-scope="scope">
                        <span style="font-size: 14.4px; font-weight: normal;">{{ scope.row.name }}</span>
                    </template>
                </el-table-column>
                <el-table-column prop="username" label="用户名" width="100" align="center" header-align="center">
                    <template slot-scope="scope">
                        <span style="font-size: 14.4px; font-weight: normal;">{{ scope.row.username }}</span>
                    </template>
                </el-table-column>
                <el-table-column prop="password" label="密码" width="100" align="center" header-align="center">
                    <template slot-scope="scope">
                        <span style="font-size: 14.4px; font-weight: normal;">{{ scope.row.password }}</span>
                    </template>
                </el-table-column>
                <el-table-column prop="email" label="邮箱" width="200" align="center" header-align="center">
                    <template slot-scope="scope">
                        <span style="font-size: 14.4px; font-weight: normal;">{{ scope.row.email }}</span>
                    </template>
                </el-table-column>
                <el-table-column prop="phone" label="手机号" width="150" align="center" header-align="center">
                    <template slot-scope="scope">
                        <span style="font-size: 14.4px; font-weight: normal;">{{ scope.row.phone }}</span>
                    </template>
                </el-table-column>
                <el-table-column prop="userType" label="用户类型" align="center" header-align="center">
                    <template slot-scope="scope">
                        <el-tag>{{ scope.row.userType }}</el-tag>
                    </template>
                </el-table-column>
                <el-table-column label="操作" align="center" header-align="center">
                    <template slot-scope="scope">
                        <el-button class="ctrl-btn edit-btn" type="primary" @click="edit(scope.row)">编辑</el-button>
                        <el-popconfirm title="是否删除该管理员?" @confirm="del(scope.row.id)">
                            <el-button slot="reference" class="ctrl-btn del-btn" type="danger">删除</el-button>
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
                    <el-button @click="dialogFormVisible = false" class="btn">取 消</el-button>
                    <el-button type="primary" @click="confirmEdit()" class="btn">确 定</el-button>
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
            pageSize: 10, //每页显示10条数据
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
.highlight-1 {
  position: absolute;
  bottom: 0;
  left: 17.5%;
  width: 0;
  height: 2px;
  background-color: #409EFF;
  transition: width 0.3s ease;
}

.input-linght:focus + .highlight-1 {
  width: 14.6%;
}
</style>