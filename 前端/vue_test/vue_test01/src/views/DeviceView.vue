<template>
    <div>
        <div class="input-container">
            <input class="input-linght" style="height: 40px;" placeholder="请输入设备名称" v-model="simulationDeviceName">
            <div class="highlight"></div>
            <el-button class="confirm-btn btn" style="height: 40px;" type="primary" icon="el-icon-search" plain
                @click="searchDevices()">搜索</el-button>
            <el-button v-if="user.userType == '管理员'" class="add-btn" icon="el-icon-circle-plus-outline"
                @click="dialogAddVisible = true">新建</el-button>
            <el-button v-if="user.userType == '管理员'" class="add-btn"
                :class="{ 'confirm-btn btn': isSelectMode && selectedRows.length > 0 }" @click="toggleSelectMode">
                {{ isSelectMode ? (selectedRows.length > 0 ? '确认删除' : '取消') : '批量删除' }}
            </el-button>
            <el-button v-if="user.userType == '管理员'" class="add-btn" type="primary" icon="el-icon-download" plain
                @click="exportData()">导出</el-button>
            <el-upload action="http://localhost:8080/api/device/upload" :on-success="successUpload">
                <el-button v-if="user.userType == '管理员'" class="add-btn" style="margin-left: 10px;" type="primary"
                    icon="el-icon-upload2">导入</el-button>
            </el-upload>
            <el-button v-if="user.userType == '教师'" class="add-btn" type="primary" icon="el-icon-download" plain
                @click="exportData()">导出</el-button>
        </div>
        <el-dialog title="添加设备" :visible.sync="dialogAddVisible">
            <el-form ref="addForm" :model="addform" :rules="rules">
                <el-form-item label="序号" :label-width="formLabelWidth" prop="simulationDeviceId">
                    <el-input class="input-length" v-model="addform.simulationDeviceId"></el-input>
                </el-form-item>
                <el-form-item label="设备名称" :label-width="formLabelWidth">
                    <el-input class="input-length" v-model="addform.simulationDeviceName"></el-input>
                </el-form-item>
                <el-form-item label="所在实验室id" :label-width="formLabelWidth">
                    <el-input class="input-length" v-model="addform.simulationDeviceLabId"></el-input>
                </el-form-item>
                <el-form-item label="类型" :label-width="formLabelWidth">
                    <el-select v-model="addform.simulationDeviceType" placeholder="请选择">
                        <el-option label="计算机仿真系统" value="计算机仿真系统"></el-option>
                        <el-option label="机械仿真设备" value="机械仿真设备"></el-option>
                        <el-option label="电子仿真设备" value="电子仿真设备"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="状态" :label-width="formLabelWidth">
                    <el-select v-model="addform.simulationDeviceStatus" placeholder="请选择">
                        <el-option label="可用" value="可用"></el-option>
                        <el-option label="维修中" value="维修中"></el-option>
                    </el-select>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogAddVisible = false" class="btn">取 消</el-button>
                <el-button type="primary" @click="addDevice" class="btn">确 定</el-button>
            </div>
        </el-dialog>
        <div class="table-container">
            <el-table :data="pagedData" style="width: 100%" border :row-key="row => row.simulationDeviceId"
                :span-method="isSelectMode ? spanMethod : null" @selection-change="handleSelectionChange">
                <el-table-column type="expand">
                    <template slot-scope="props">
                        <el-form label-position="left" inline class="demo-table-expand"
                            style="display: flex; flex-direction: column;">
                            <el-form-item label="设备描述：" style="margin-left: 20px;">
                                <span>{{ props.row.simulationDeviceDescription }}</span>
                            </el-form-item>
                        </el-form>
                    </template>
                </el-table-column>
                <el-table-column type="selection" width="55" v-if="isSelectMode"></el-table-column>
                <el-table-column prop="simulationDeviceId" label="ID" width="80" align="center" header-align="center">
                    <template slot-scope="scope">
                        <span style="font-size: 14.4px; font-weight: normal;">{{ scope.row.simulationDeviceId }}</span>
                    </template>
                </el-table-column>
                <el-table-column prop="simulationDeviceName" label="设备名称" width="160" align="center"
                    header-align="center">
                    <template slot-scope="scope">
                        <span style="font-size: 14.4px; font-weight: normal;">{{ scope.row.simulationDeviceName
                            }}</span>
                    </template>
                </el-table-column>
                <el-table-column prop="simulationDeviceLabId" label="所在实验室id" width="100" align="center"
                    header-align="center">
                    <template slot-scope="scope">
                        <span style="font-size: 14.4px; font-weight: normal;">{{ scope.row.simulationDeviceLabId
                            }}</span>
                    </template>
                </el-table-column>
                <el-table-column prop="simulationDeviceType" label="类型" width="160" align="center"
                    header-align="center">
                    <template slot-scope="scope">
                        <span style="font-size: 14.4px; font-weight: normal;">{{ scope.row.simulationDeviceType
                            }}</span>
                    </template>
                </el-table-column>
                <el-table-column prop="simulationDeviceStatus" label="状态" width="120" align="center"
                    header-align="center">
                    <template slot-scope="scope">
                        <span style="font-size: 14.4px; font-weight: normal;">{{ scope.row.simulationDeviceStatus
                            }}</span>
                    </template>
                </el-table-column>
                <el-table-column prop="simulationDeviceCreateTime" label="创建时间" :formatter="formatDate" width="180"
                    align="center" header-align="center">
                </el-table-column>
                <el-table-column prop="simulationDeviceUpdateTime" label="更新时间" :formatter="formatDate" align="center"
                    header-align="center">
                </el-table-column>
                <el-table-column label="操作" v-if="user.userType == '管理员'" align="center" header-align="center">
                    <template slot-scope="scope">
                        <el-button class="ctrl-btn edit-btn" type="primary" @click="edit(scope.row)">编辑</el-button>
                        <el-popconfirm title="是否删除该设备?" @confirm="del(scope.row.simulationDeviceId)">
                            <el-button slot="reference" type="danger" class="ctrl-btn del-btn">删除</el-button>
                        </el-popconfirm>
                    </template>
                </el-table-column>
            </el-table>
            <el-dialog title="修改设备信息" :visible.sync="dialogFormVisible">
                <el-form ref="editForm" :model="editform" :rules="rules">
                    <el-form-item label="序号" :label-width="formLabelWidth" prop="simulationDeviceId">
                        <el-input class="input-length" v-model="editform.simulationDeviceId"></el-input>
                    </el-form-item>
                    <el-form-item label="设备名称" :label-width="formLabelWidth">
                        <el-input class="input-length" v-model="editform.simulationDeviceName"
                            autocomplete="off"></el-input>
                    </el-form-item>
                    <el-form-item label="所在实验室id" :label-width="formLabelWidth">
                        <el-input class="input-length" v-model="editform.simulationDeviceLabId"></el-input>
                    </el-form-item>
                    <el-form-item label="类型" :label-width="formLabelWidth">
                        <el-select v-model="editform.simulationDeviceType" placeholder="请选择">
                            <el-option label="计算机仿真系统" value="计算机仿真系统"></el-option>
                            <el-option label="机械仿真设备" value="机械仿真设备"></el-option>
                            <el-option label="电子仿真设备" value="电子仿真设备"></el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="状态" :label-width="formLabelWidth">
                        <el-select v-model="editform.simulationDeviceStatus" placeholder="请选择">
                            <el-option label="可用" value="可用"></el-option>
                            <el-option label="维修中" value="维修中"></el-option>
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
import * as XLSX from 'xlsx';

export default {
    data() {
        return {
            user: localStorage.getItem('user') ? JSON.parse(localStorage.getItem('user')) : {},
            simulationDeviceName: '',
            currentPage: 1,
            pageSize: 10,
            dialogFormVisible: false,
            dialogAddVisible: false,
            tableData: [],
            pagedData: [],
            formLabelWidth: '120px',
            isSelectMode: false,
            selectedRows: [],
            editform: {
                simulationDeviceId: '',
                simulationDeviceName: '',
                simulationDeviceLabId: '',
                simulationDeviceType: '',
                simulationDeviceStatus: '',
                simulationDeviceUpdateTime: '',  // 设置初始值为当前时间
            },
            addform: {
                simulationDeviceId: '',
                simulationDeviceName: '',
                simulationDeviceLabId: '',
                simulationDeviceType: '',
                simulationDeviceStatus: '可用',
                simulationDeviceCreateTime: '',
            },
            rules: {
                simulationDeviceId: [
                    { required: true, message: '请输入序号', trigger: 'blur' },
                    { pattern: /^[1-9]\d*$/, message: '序号必须为正整数', trigger: 'blur' }
                ]
            }
        }
    },
    methods: {
        // 导出数据
        exportData() {
            location.href = 'http://localhost:8080/api/device/export'
        },
        //    导入数据
        successUpload(res) {
            if (res.code === '0') {
                this.$message.success("导入成功")
                this.searchDevices()
            } else {
                this.$message.error(res.msg);
            }
        },
        toggleSelectMode() {
            if (this.isSelectMode && this.selectedRows.length > 0) {
                this.deleteSelectedRows();
            } else {
                this.isSelectMode = !this.isSelectMode;
                this.selectedRows = [];
            }
        },
        deleteSelectedRows() {
            const simulationDeviceIds = this.selectedRows.map(row => row.simulationDeviceId).join(',');
            request.delete('/device/deleteDevices/' + simulationDeviceIds).then(res => {
                if (res.code == 0) {
                    this.$message.success('删除成功');
                    this.isSelectMode = false;
                    location.reload(); // 更新表格数据
                } else {
                    this.$message.error(res.msg);
                }
            })
        },
        handleSelectionChange(selected) {
            this.selectedRows = selected;
        },
        searchDevices() {
            let params = {
                simulationDeviceName: this.simulationDeviceName,
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
        del(simulationDeviceId) {
            request.delete('/device/delete/' + simulationDeviceId).then(res => {
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
                this.addform.simulationDeviceCreateTime = new Date();
                request.post("/device/addDevice", this.addform).then(res => {
                    if (res.code == 0) {
                        this.$message.success('添加成功');
                        this.dialogAddVisible = false;
                        this.searchDevices();
                        // 重置addform
                        this.addform = {
                            simulationDeviceId: '',
                            simulationDeviceName: '',
                            simulationDeviceType: '',
                            simulationDeviceStatus: '',
                            simulationDeviceCreateTime: '',
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
                this.editform.simulationDeviceUpdateTime = new Date();
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

</style>