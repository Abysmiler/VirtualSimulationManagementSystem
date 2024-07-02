<template>
    <div>
        <el-input class="device-input" placeholder="请输入设备名称" v-model="name" clearable></el-input>
        <el-button class="device-btn" type="primary" plain @click="searchDevices()">搜索</el-button>
        <el-button v-if="user.type == '管理员'" class="device-btn" icon="el-icon-circle-plus-outline"
            @click="dialogAddVisible = true">新建</el-button>
        <el-dialog title="添加设备" :visible.sync="dialogAddVisible">
            <el-form ref="addForm" :model="addform" :rules="rules">
                <el-form-item label="序号" :label-width="formLabelWidth" prop="id">
                    <el-input class="input-length" v-model="addform.id"></el-input>
                </el-form-item>
                <el-form-item label="设备名称" :label-width="formLabelWidth">
                    <el-input class="input-length" v-model="addform.name"></el-input>
                </el-form-item>
                <el-form-item label="所在实验室id" :label-width="formLabelWidth">
                    <el-input class="input-length" v-model="addform.lab_id"></el-input>
                </el-form-item>
                <el-form-item label="类型" :label-width="formLabelWidth">
                    <el-select v-model="addform.type" placeholder="请选择">
                        <el-option label="物理" value="物理"></el-option>
                        <el-option label="化学" value="化学"></el-option>
                        <el-option label="电子" value="电子"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="状态" :label-width="formLabelWidth">
                    <el-select v-model="addform.status" placeholder="请选择">
                        <el-option label="良好" value="良好"></el-option>
                        <el-option label="一般" value="一般"></el-option>
                        <el-option label="合格" value="合格"></el-option>
                    </el-select>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogAddVisible = false">取 消</el-button>
                <el-button type="primary" @click="addDevice">确 定</el-button>
            </div>
        </el-dialog>
        <div class="table-container">
            <el-table :data="pagedData" style="width: 100%">
                <el-table-column prop="id" label="ID" width="120">
                </el-table-column>
                <el-table-column prop="name" label="设备名称" width="120">
                </el-table-column>
                <el-table-column prop="lab_id" label="所在实验室id" width="120">
                </el-table-column>
                <el-table-column prop="type" label="类型" width="120">
                </el-table-column>
                <el-table-column prop="status" label="状态" width="120">
                </el-table-column>
                <el-table-column prop="create_time" label="创建时间" :formatter="formatDate">
                </el-table-column>
                <el-table-column prop="update_time" label="更新时间" :formatter="formatDate">
                </el-table-column>
                <el-table-column label="操作" v-if="user.type == '管理员'">
                    <template slot-scope="scope">
                        <el-button class="device-btn" type="primary" @click="edit(scope.row)">编辑</el-button>
                        <el-popconfirm title="是否删除该设备?" @confirm="del(scope.row.id)">
                            <el-button slot="reference" class="device-btn" type="danger">删除</el-button>
                        </el-popconfirm>
                    </template>
                </el-table-column>
            </el-table>
            <el-dialog title="修改设备信息" :visible.sync="dialogFormVisible">
                <el-form ref="editForm" :model="editform" :rules="rules">
                    <el-form-item label="序号" :label-width="formLabelWidth" prop="id">
                        <el-input class="input-length" v-model="editform.id"></el-input>
                    </el-form-item>
                    <el-form-item label="设备名称" :label-width="formLabelWidth">
                        <el-input class="input-length" v-model="editform.name" autocomplete="off"></el-input>
                    </el-form-item>
                    <el-form-item label="所在实验室id" :label-width="formLabelWidth">
                        <el-input class="input-length" v-model="editform.lab_id"></el-input>
                    </el-form-item>
                    <el-form-item label="类型" :label-width="formLabelWidth">
                        <el-select v-model="editform.type" placeholder="请选择">
                            <el-option label="物理" value="物理"></el-option>
                            <el-option label="化学" value="化学"></el-option>
                            <el-option label="电子" value="电子"></el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="状态" :label-width="formLabelWidth">
                        <el-select v-model="editform.status" placeholder="请选择">
                            <el-option label="良好" value="良好"></el-option>
                            <el-option label="一般" value="一般"></el-option>
                            <el-option label="合格" value="合格"></el-option>
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
            currentPage: 1,
            pageSize: 5,
            dialogFormVisible: false,
            dialogAddVisible: false,
            tableData: [],
            pagedData: [],
            formLabelWidth: '120px',
            editform: {
                id: '',
                name: '',
                lab_id: '',
                type: '',
                status: '',
                update_time: '',  // 设置初始值为当前时间
            },
            addform: {
                id: '',
                name: '',
                lab_id: '',
                type: '物理',
                status: '良好',
                create_time: '',
            },
            rules: {
                id: [
                    { required: true, message: '请输入序号', trigger: 'blur' },
                    { pattern: /^[1-9]\d*$/, message: '序号必须为正整数', trigger: 'blur' }
                ]
            }
        }
    },
    methods: {
        searchDevices() {
            let params = {
                name: this.name,
            }
            request.get("/device/searchDevices", { params }).then(res => {
                if (res.code == 0) {
                    this.tableData = res.data;
                    this.handlePagination();
                } else {
                    this.$message.error(res.msg)
                }
            })
        },
        del(id) {
            request.delete('/device/delete/' + id).then(res => {
                if (res.code == 0) {
                    this.$message.success('删除成功');
                    this.searchDevices(); // 更新表格数据
                } else {
                    this.$message.error(res.msg);
                }
            })
        },
        addDevice() {
            this.$refs.addForm.validate((valid) => {
                if (!valid) return;
                this.addform.create_time = new Date();
                request.post("/device/addDevice", this.addform).then(res => {
                    if (res.code == 0) {
                        this.$message.success('添加成功');
                        this.dialogAddVisible = false;
                        this.searchDevices();
                        // 重置addform
                        this.addform = {
                            id: '',
                            name: '',
                            type: '',
                            status: '',
                            create_time: '',
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
                this.editform.update_time = new Date();
                request.post('/device/update', this.editform).then(res => {
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
        this.searchDevices()
    }
}
</script>
<style scoped>
.device-input {
    width: 12%;
    margin-right: 10px;
}

.device-btn {
    width: 80px;
    margin-right: 5px;
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