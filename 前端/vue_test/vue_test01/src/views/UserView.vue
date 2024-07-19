<template>
    <div>
        <!-- <h1>这里是用户界面</h1> -->
        <div class="input-container">
            <input class="input-linght" placeholder="请输入姓名" v-model="name">
            <div class="highlight"></div>
            <input class="input-linght" placeholder="请输入电话" v-model="phone">
            <div class="highlight-1"></div>
            <el-button class="confirm-btn btn" plain @click="selectAll()" type="primary"
                icon="el-icon-search">搜索</el-button>
        </div>
        <div class="table-container">
            <el-table :data="pagedData" style="width: 100% " border>
                <el-table-column type="expand">
                    <template slot-scope="props">
                        <el-form label-position="left" inline class="demo-table-expand"
                            style="display: flex; flex-direction: column;">
                            <el-form-item label="年龄" style="margin-left: 20px;">
                                <span>{{ props.row.age }}</span>
                            </el-form-item>
                            <el-form-item label="性别" style="margin-left: 20px;">
                                <span>{{ props.row.sex }}</span>
                            </el-form-item>
                            <el-form-item label="联系地址" style="margin-left: 20px;">
                                <span>{{ props.row.address }}</span>
                            </el-form-item>
                        </el-form>
                    </template>
                </el-table-column>
                <el-table-column prop="id" label="ID" width="80" align="center" header-align="center">
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
                <el-table-column label="操作" v-if="user.userType == '管理员'" align="center" header-align="center">
                    <template slot-scope="scope">
                        <el-button class="ctrl-btn edit-btn" type="primary" @click="edit(scope.row)">编辑</el-button>
                        <el-popconfirm title="是否删除该用户?" @confirm="del(scope.row.id)">
                            <el-button slot="reference" class="ctrl-btn del-btn" type="danger">删除</el-button>
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
import request from '../utils/request';

export default {
    data() {
        return {
            tableData: [],
            name: '',
            phone: '',
            username: '',
            dialogFormVisible: false,//编辑弹出框是否显示
            currentPage: 1,//当前页
            pageSize: 10, //每页显示5条数据
            pagedData: [],//分页后的数据
            editform: {
                name: '',
                username: '',
                password: '',
                email: '',
                userType: ''
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
                } else{
                    this.$message.error("删除失败")
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
.highlight-1 {
  position: absolute;
  bottom: 0;
  left: 17.5%;
  width: 0;
  height: 2px;
  background-color: #409EFF;
  transition: width 0.3s ease;
}

.input-linght:focus+.highlight-1 {
    width: 14.6%;
}

.demo-table-expand {
    font-size: 0;
}

.demo-table-expand label {
    width: 90px;
    color: #99a9bf;
}

.demo-table-expand .el-form-item {
    margin-right: 0;
    margin-bottom: 0;
    width: 50%;
}
</style>