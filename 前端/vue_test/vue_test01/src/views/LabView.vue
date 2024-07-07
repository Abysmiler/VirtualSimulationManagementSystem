<template>
    <div>
        <div class="input-container">
            <input class="input-linght" placeholder="请输入实验室名称" v-model="labName">
            <div class="highlight"></div>
            <el-button class="confirm-btn btn" type="primary" icon="el-icon-search" plain
                @click="searchLabs()">搜索</el-button>
            <el-button v-if="user.type == '管理员'" class="add-btn" icon="el-icon-circle-plus-outline"
                @click="dialogAddVisible = true">新建</el-button>
        </div>
        <el-dialog title="添加实验室" :visible.sync="dialogAddVisible">
            <el-form ref="addForm" :model="addform" :rules="rules">
                <el-form-item label="序号" :label-width="formLabelWidth" prop="labId">
                    <el-input class="input-length" v-model="addform.labId"></el-input>
                </el-form-item>
                <el-form-item label="实验室名称" :label-width="formLabelWidth">
                    <el-input class="input-length" v-model="addform.labName"></el-input>
                </el-form-item>
                <el-form-item label="位置" :label-width="formLabelWidth">
                    <el-input class="input-length" v-model="addform.labLocation"></el-input>
                </el-form-item>
                <el-form-item label="容量" :label-width="formLabelWidth" prop="labCapacity">
                    <el-input class="input-length" v-model="addform.labCapacity"></el-input>
                </el-form-item>
                <el-form-item label="管理员" :label-width="formLabelWidth">
                    <el-input class="input-length" v-model="addform.labManager"></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogAddVisible = false" class="btn">取 消</el-button>
                <el-button type="primary" @click="addLab" class="btn">确 定</el-button>
            </div>
        </el-dialog>
        <div class="table-container">
            <el-table :data="pagedData" style="width: 100%" border>
                <el-table-column prop="labId" label="ID" width="80" align="center" header-align="center">
                    <template slot-scope="scope">
                        <span style="font-size: 14.4px; font-weight: normal;">{{ scope.row.labId }}</span>
                    </template>
                </el-table-column>
                <el-table-column prop="labName" label="实验室名称" width="160" align="center" header-align="center">
                    <template slot-scope="scope">
                        <span style="font-size: 14.4px; font-weight: normal;">{{ scope.row.labName }}</span>
                    </template>
                </el-table-column>
                <el-table-column prop="labLocation" label="位置" width="120" align="center" header-align="center">
                    <template slot-scope="scope">
                        <span style="font-size: 14.4px; font-weight: normal;">{{ scope.row.labLocation }}</span>
                    </template>
                </el-table-column>
                <el-table-column prop="labCapacity" label="容量(人/室)" width="120" align="center" header-align="center">
                    <template slot-scope="scope">
                        <span style="font-size: 14.4px; font-weight: normal;">{{ scope.row.labCapacity }}</span>
                    </template>
                </el-table-column>
                <el-table-column prop="labManager" label="管理员" width="120" align="center" header-align="center">
                    <template slot-scope="scope">
                        <span style="font-size: 14.4px; font-weight: normal;">{{ scope.row.labManager }}</span>
                    </template>
                </el-table-column>
                <el-table-column prop="labCreateTime" label="创建时间" :formatter="formatDate" width="150"  align="center" header-align="center">
                </el-table-column>
                <el-table-column prop="labUpdateTime" label="更新时间" :formatter="formatDate"  align="center" header-align="center">
                </el-table-column>
                <el-table-column label="操作" v-if="user.userType == '管理员'"  align="center" header-align="center">
                    <template slot-scope="scope">
                        <el-button class="ctrl-btn edit-btn" type="primary" @click="edit(scope.row)">编辑</el-button>
                        <el-popconfirm title="是否删除该实验室?" @confirm="del(scope.row.labId)">
                            <el-button slot="reference" type="danger" class="ctrl-btn del-btn">删除</el-button>
                        </el-popconfirm>
                    </template>
                </el-table-column>
            </el-table>
            <el-dialog title="修改实验室信息" :visible.sync="dialogFormVisible">
                <el-form ref="editForm" :model="editform" :rules="rules">
                    <el-form-item label="实验室名称" :label-width="formLabelWidth">
                        <el-input class="input-length" v-model="editform.labName" autocomplete="off"></el-input>
                    </el-form-item>
                    <el-form-item label="位置" :label-width="formLabelWidth">
                        <el-input class="input-length" v-model="editform.labLocation" autocomplete="off"></el-input>
                    </el-form-item>
                    <el-form-item label="容量(人/室)" :label-width="formLabelWidth" prop="labCapacity">
                        <el-input class="input-length" v-model="editform.labCapacity" autocomplete="off"></el-input>
                    </el-form-item>
                    <el-form-item label="管理员" :label-width="formLabelWidth">
                        <el-input class="input-length" v-model="editform.labManager" autocomplete="off"></el-input>
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
            labName: '',
            currentPage: 1,
            pageSize: 10,
            dialogFormVisible: false,
            dialogAddVisible: false,
            tableData: [],
            pagedData: [],
            formLabelWidth: '120px',
            editform: {
                labName: '',
                labLocation: '',
                labCapacity: '',
                labManager: '',
                labUpdateTime: '',  // 设置初始值为当前时间
            },
            addform: {
                labId: '',
                labName: '',
                labLocation: '',
                labCapacity: '',
                labManager: '',
                labCreateTime: '',
            },
            rules: {
                labId: [
                    { required: true, message: '请输入序号', trigger: 'blur' },
                    { pattern: /^[1-9]\d*$/, message: '序号必须为正整数', trigger: 'blur' }
                ],
                labCapacity: [
                    { required: true, message: '请输入容量', trigger: 'blur' },
                    { pattern: /^[1-9]\d*$/, message: '容量必须为正整数', trigger: 'blur' }
                ]
            }
        }
    },
    methods: {
        searchLabs() {
            let params = {
                labName: this.labName,
            }
            request.get("/lab/searchLabs", { params }).then(res => {
                if (res.code == 0) {
                    this.tableData = res.data;
                    this.handlePagination();
                } else {
                    this.$message.error(res.msg)
                }
            })
        },
        del(labId) {
            request.delete('/lab/delete/' + labId).then(res => {
                if (res.code == 0) {
                    this.$message.success('删除成功');
                    this.searchLabs(); // 更新表格数据
                } else {
                    this.$message.error(res.msg);
                }
            })
        },
        addLab() {
            this.$refs.addForm.validate((valid) => {
                if (!valid) return;
                this.addform.labCreateTime = new Date();
                request.post("/lab/addLab", this.addform).then(res => {
                    if (res.code == 0) {
                        this.$message.success('添加成功');
                        this.dialogAddVisible = false;
                        this.searchLabs();
                        // 重置addform
                        this.addform = {
                            labId: '',
                            labName: '',
                            labLocation: '',
                            labCapacity: '',
                            labManager: '',
                            labCreateTime: '',
                        };
                    } else {
                        this.$message.error(res.msg);
                    }
                })
            });
        },
        // 在 methods 中添加一个格式化时间的方法
        formatDate(row, column, cellValue) {
            if (!cellValue) return '';
            return new Date(cellValue).toLocaleString();
        },
        edit(row) {
            this.dialogFormVisible = true
            this.editform = row
        },
        confirmEdit() {
            this.$refs.editForm.validate((valid) => {
                if (!valid) return;
                this.editform.labUpdateTime = new Date();
                request.post('/lab/update', this.editform).then(res => {
                    if (res.code == 0) {
                        this.$message.success("修改成功");
                        this.dialogFormVisible = false
                    } else {
                        this.$message.error(res.msg);
                    }
                })
            });
        },
        handleSizeChange(val) {
            this.pageSize = val;
            this.handlePagination();
        },
        handleCurrentChange(val) {
            this.currentPage = val;
            this.handlePagination();
        },
        handlePagination() {
            const start = (this.currentPage - 1) * this.pageSize;
            const end = start + this.pageSize;
            this.pagedData = this.tableData.slice(start, end);
        },
    },
    mounted() {
        this.searchLabs()
    }
}
</script>

<style scoped>
/* 调整表格整体样式 */
.el-table th, .el-table td {
  text-align: center; /* 让表格单元格内容居中 */
  font-size: 14px; /* 设置表格文字大小 */
  font-weight: normal; /* 设置表格文字粗细 */
}

/* 调整表格头部样式 */
.el-table th {
  font-weight: bold; /* 设置表头文字加粗 */
}

/* 调整表格内容样式 */
.el-table td {
  font-size: 13px; /* 设置表格内容文字大小 */
}

</style>