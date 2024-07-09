<template>
    <div>
        <div class="input-container">
            <input class="input-linght" placeholder="请输入资源名称" v-model="resourceName">
            <div class="highlight"></div>
            <el-button class="confirm-btn btn" type="primary" icon="el-icon-search" plain
                @click="searchResources()">搜索</el-button>
            <el-button v-if="user.userType == '管理员'" class="add-btn" icon="el-icon-circle-plus-outline"
                @click="dialogAddVisible = true">新建</el-button>
        </div>
        <el-dialog title="添加资源" :visible.sync="dialogAddVisible">
            <el-form ref="addForm" :model="addform" :rules="rules">
                <el-form-item label="ID" :label-width="formLabelWidth" prop="resourceId">
                    <el-input class="input-length" v-model="addform.resourceId"></el-input>
                </el-form-item>
                <el-form-item label="资源名称" :label-width="formLabelWidth">
                    <el-input class="input-length" v-model="addform.resourceName"></el-input>
                </el-form-item>
                <el-form-item label="类型" :label-width="formLabelWidth">
                    <el-select v-model="addform.resourceType" placeholder="请选择">
                        <el-option label="PPT" value="PPT"></el-option>
                        <el-option label="WORD" value="WORD"></el-option>
                        <el-option label="EXCEL" value="EXCEL"></el-option>
                        <el-option label="PDF" value="PDF"></el-option>
                    </el-select>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogAddVisible = false" class="btn">取 消</el-button>
                <el-button type="primary" @click="addResource" class="btn">确 定</el-button>
            </div>
        </el-dialog>
        <div class="table-container">
            <el-table :data="pagedData" style="width: 100%" border>
                <el-table-column prop="resourceId" label="ID" width="80" align="center" header-align="center">
                    <template slot-scope="scope">
                        <span style="font-size: 14.4px; font-weight: normal;">{{ scope.row.resourceId }}</span>
                    </template>
                </el-table-column>
                <el-table-column prop="resourceName" label="资源名称" width="160" align="center" header-align="center">
                    <template slot-scope="scope">
                        <span style="font-size: 14.4px; font-weight: normal;">{{ scope.row.resourceName }}</span>
                    </template>
                </el-table-column>
                <el-table-column prop="resourceType" label="类型" width="120" align="center" header-align="center">
                    <template slot-scope="scope">
                        <span style="font-size: 14.4px; font-weight: normal;">{{ scope.row.resourceType }}</span>
                    </template>
                </el-table-column>
                <el-table-column prop="resourceCreateTime" label="创建时间" :formatter="formatDate" width="300"
                    align="center" header-align="center">
                </el-table-column>
                <el-table-column prop="resourceUpdateTime" label="更新时间" :formatter="formatDate" width="300"
                    align="center" header-align="center">
                </el-table-column>
                <el-table-column prop="remark" label="备注" align="center" header-align="center">
                    <template slot-scope="scope">
                        <span style="font-size: 14.4px; font-weight: normal;">{{ scope.row.remark }}</span>
                    </template>
                </el-table-column>
                <el-table-column label="操作" v-if="user.userType == '管理员'" align="center" header-align="center">
                    <template slot-scope="scope">
                        <div class="button-container">
                            <el-button class="ctrl-btn edit-btn" type="primary" @click="edit(scope.row)">编辑</el-button>
                            <el-popconfirm title="是否删除该资源?" @confirm="del(scope.row.resourceId)">
                                <el-button slot="reference" type="danger" class="ctrl-btn del-btn">删除</el-button>
                            </el-popconfirm>
                            <el-button class="ctrl-btn out-btn el-icon-download" type="success"
                                @click="downloadResource(scope.row.remark)">下载</el-button>
                        </div>
                    </template>
                </el-table-column>
            </el-table>
            <el-dialog title="修改资源信息" :visible.sync="dialogFormVisible">
                <el-form ref="editForm" :model="editform" :rules="rules">
                    <el-form-item label="资源名称" :label-width="formLabelWidth">
                        <el-input class="input-length" v-model="editform.resourceName" autocomplete="off"></el-input>
                    </el-form-item>
                    <el-form-item label="类型" :label-width="formLabelWidth">
                        <el-select v-model="editform.resourceType" placeholder="请选择">
                            <el-option label="PPT" value="PPT"></el-option>
                            <el-option label="WORD" value="WORD"></el-option>
                            <el-option label="EXCEL" value="EXCEL"></el-option>
                            <el-option label="PDF" value="PDF"></el-option>
                        </el-select>
                    </el-form-item>
                    <el-upload action="http://localhost:8080/api/files/upload"
                        :on-success="(res) => successUpload(res, currentRow)" class="  local">
                        <el-button class="ctrl-btn in-btn el-icon-upload" type="primary">上传</el-button>
                    </el-upload>
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
            resourceName: '',
            // remark: '', //资源时间戳
            currentPage: 1,
            pageSize: 10,
            dialogFormVisible: false,
            dialogAddVisible: false,
            tableData: [],
            pagedData: [],
            formLabelWidth: '120px',
            currentRow: null,
            editform: {
                resourceName: '',
                resourceType: '',
                resourceUpdateTime: '',  // 设置初始值为当前时间
                remark: '',
            },
            addform: {
                resourceId: '',
                resourceName: '',
                resourceType: 'PDF',
                resourceCreateTime: '',
            },
            rules: {
                resourceId: [
                    { required: true, message: '请输入序号', trigger: 'blur' },
                    { pattern: /^[1-9]\d*$/, message: '序号必须为正整数', trigger: 'blur' }
                ]
            }
        }
    },
    methods: {
        searchResources() {
            let params = {
                resourceName: this.resourceName,
            }
            request.get("/resource/searchResources", { params }).then(res => {
                if (res.code == 0) {
                    this.tableData = res.data;
                    this.handlePagination();
                } else {
                    this.$message.error(res.msg)
                }
            })
        },
        del(resourceId) {
            request.delete('/resource/delete/' + resourceId).then(res => {
                if (res.code == 0) {
                    this.$message.success('删除成功');
                    this.searchResources(); // 更新表格数据
                } else {
                    this.$message.error(res.msg);
                }
            })
        },
        addResource() {
            this.$refs.addForm.validate((valid) => {
                if (!valid) return;
                this.addform.resourceCreateTime = new Date();
                request.post("/resource/addResource", this.addform).then(res => {
                    if (res.code == 0) {
                        this.$message.success('添加成功');
                        this.dialogAddVisible = false;
                        this.searchResources();
                        // 重置addform
                        this.addform = {
                            resourceId: '',
                            resourceName: '',
                            instructor_id: '',
                            resource_id: '',
                            schedule: '',
                            resourceCreateTime: '',
                        };
                    } else {
                        this.$message.error(res.msg);
                    }
                })
            });
        },
        formatDate(row, column, cellValue) {
            if (!cellValue) return '';
            return new Date(cellValue).toLocaleString();
        },
        edit(row) {
            this.dialogFormVisible = true
            this.editform = row
            this.currentRow = row
        },
        // successUpload(res, row) {
        //     console.log(res);
        //     // 找到对应的资源数据并更新其 remark 字段
        //     const resource = this.tableData.find(item => item.resourceId === row.resourceId);
        //     if (resource) {
        //         resource.remark = res.data;
        //         // 手动触发重新渲染表格
        //         this.pagedData = [...this.pagedData];
        //         // 调用 confirmEdit 方法，将更新后的数据同步到后端
        //         // this.confirmEdit();
        //     }
        // },
        successUpload(res, row) {
            console.log(res);
            // 找到对应的资源数据并更新其 remark 字段
            const resource = this.tableData.find(item => item.resourceId === row.resourceId);
            if (resource) {
                resource.remark = res.data;
                // 手动触发重新渲染表格
                this.pagedData = [...this.pagedData];

                // 更新 editform 中的数据
                this.editform.resourceName = resource.resourceName;
                this.editform.resourceType = resource.resourceType;
                this.editform.resourceUpdateTime = new Date();

                // 调用 confirmEdit 方法，将更新后的数据同步到后端
                //this.confirmEdit();
            }
        },

        //文件下载
        downloadResource(flag) {
            location.href = 'http://localhost:8080/api/files/' + flag
        },

        confirmEdit() {
            this.$nextTick(() => {
                this.$refs.editForm.validate((valid) => {
                    if (!valid) return;
                    // 更新修改时间
                    this.editform.resourceUpdateTime = new Date();

                    // 发送更新请求到后端
                    request.post('/resource/update', this.editform).then(res => {
                        if (res.code == 0) {
                            this.$message.success("修改成功");
                            this.dialogFormVisible = false;
                        } else {
                            this.$message.error(res.msg);
                        }
                    });
                });
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
        this.searchResources()
    }
}
</script>
<style scoped>
.button-container {
    display: flex;
    justify-content: center;
}

.button-container>*:not(:last-child) {
    margin-right: 10px;
}

.local {
    margin-left: 13%;
}
</style>