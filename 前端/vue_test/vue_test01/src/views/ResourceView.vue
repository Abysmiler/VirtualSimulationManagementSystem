<template>
    <div>
        <el-input class="resource-input" placeholder="请输入资源名称" v-model="resourceName" clearable></el-input>
        <el-button class="resource-btn" type="primary" plain @click="searchResources()">搜索</el-button>
        <el-button v-if="user.userType == '管理员'" class="resource-btn" icon="el-icon-circle-plus-outline"
            @click="dialogAddVisible = true">新建</el-button>
        <el-dialog title="添加资源" :visible.sync="dialogAddVisible">
            <el-form ref="addForm" :model="addform" :rules="rules">
                <el-form-item label="资源ID" :label-width="formLabelWidth" prop="resourceId">
                    <el-input class="input-length" v-model="addform.resourceId"></el-input>
                </el-form-item>
                <el-form-item label="资源名称" :label-width="formLabelWidth">
                    <el-input class="input-length" v-model="addform.resourceName"></el-input>
                </el-form-item>
                <el-form-item label="类型" :label-width="formLabelWidth">
                    <el-select v-model="addform.resourceType" placeholder="请选择">
                        <el-option label="音频" value="音频"></el-option>
                        <el-option label="视频" value="视频"></el-option>
                    </el-select>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogAddVisible = false">取 消</el-button>
                <el-button type="primary" @click="addResource">确 定</el-button>
            </div>
        </el-dialog>
        <div class="table-container">
            <el-table :data="pagedData" style="width: 100%">
                <el-table-column prop="resourceId" label="ID" width="120">
                </el-table-column>
                <el-table-column prop="resourceName" label="资源名称" width="120">
                </el-table-column>
                <el-table-column prop="resourceType" label="类型" width="120">
                </el-table-column>
                <el-table-column prop="resourceCreateTime" label="创建时间" :formatter="formatDate">
                </el-table-column>
                <el-table-column prop="resourceUpdateTime" label="更新时间" :formatter="formatDate">
                </el-table-column>
                <el-table-column label="操作" v-if="user.userType == '管理员'">
                    <template slot-scope="scope">
                        <el-button class="resource-btn" type="primary" @click="edit(scope.row)">编辑</el-button>
                        <el-popconfirm title="是否删除该资源?" @confirm="del(scope.row.resourceId)">
                            <el-button slot="reference" class="resource-btn" type="danger">删除</el-button>
                        </el-popconfirm>
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
                            <el-option label="音频" value="音频"></el-option>
                            <el-option label="视频" value="视频"></el-option>
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
    data() {
        return {
            user: localStorage.getItem('user') ? JSON.parse(localStorage.getItem('user')) : {},
            resourceName: '',
            currentPage: 1,
            pageSize: 5,
            dialogFormVisible: false,
            dialogAddVisible: false,
            tableData: [],
            pagedData: [],
            formLabelWidth: '120px',
            editform: {
                resourceName: '',
                resourceType: '',
                resourceUpdateTime: '',  // 设置初始值为当前时间
            },
            addform: {
                resourceId: '',
                resourceName: '',
                resourceType: '音频',
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
        },
        confirmEdit() {
            this.$refs.editForm.validate((valid) => {
                if (!valid) return;
                this.editform.resourceUpdateTime = new Date();
                request.post('/resource/update', this.editform).then(res => {
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
        this.searchResources()
    }
}
</script>
<style scoped>
.resource-input {
    width: 12%;
    margin-right: 10px;
}

.resource-btn {
    width: 80px;
    margin-right: 5px;
    border-radius: 50px;
}

.table-container {
    height: 300px;
    overflow: auto;
}

.pagination {
    position: sticky;
    top: 0;
    text-align: center;
}

.input-length {
    width: 90%;
    /* 你可以根据需要调整这个值 */
}

.dialogWidth {
    margin: auto;
    width: 50%;
}
</style>