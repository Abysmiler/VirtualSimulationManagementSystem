<template>
    <div>
        <div class="input-container">
            <input class="input-linght" placeholder="请输入课程名称" v-model="courseName">
            <div class="highlight"></div>
            <el-button class="confirm-btn btn" type="primary" icon="el-icon-search" plain @click="selectAll()">搜索</el-button>
            <el-button v-if="user.userType == '管理员'" class="add-btn" icon="el-icon-circle-plus-outline"
            @click="dialogAddVisible = true">新建</el-button>
        </div>
        <el-dialog title="添加课程" :visible.sync="dialogAddVisible">
            <el-form ref="addForm" :model="addform" :rules="rules">
                <el-form-item label="序号" :label-width="formLabelWidth" prop="courseId">
                    <el-input class="input-length" v-model="addform.courseId"></el-input>
                </el-form-item>
                <el-form-item label="课程名称" :label-width="formLabelWidth" prop="courseName">
                    <el-input class="input-length" v-model="addform.courseName"></el-input>
                </el-form-item>
                <el-form-item label="授课教师id" :label-width="formLabelWidth" prop="instructorId">
                    <el-input class="input-length" v-model="addform.instructorId"></el-input>
                </el-form-item>
                <el-form-item label="课程资源id" :label-width="formLabelWidth" prop="resourceId">
                    <el-input class="input-length" v-model="addform.resourceId"></el-input>
                </el-form-item>
                <el-form-item label="学时" :label-width="formLabelWidth">
                    <el-input-number class="input-length-number" v-model="addform.creditHour" :min="0" :step="2"
                        controls-position="right"></el-input-number>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogAddVisible = false" class="btn">取 消</el-button>
                <el-button type="primary" @click="addCourse" class="btn">确 定</el-button>
            </div>
        </el-dialog>
        <div class="table-container">
            <el-table :data="pagedData" style="width: 100%" border>
                <el-table-column prop="courseId" label="ID" width="80" align="center" header-align="center">
                    <template slot-scope="scope">
                        <span style="font-size: 14.4px; font-weight: normal;">{{ scope.row.courseId }}</span>
                    </template>
                </el-table-column>
                <el-table-column prop="courseName" label="课程名称" width="160" align="center" header-align="center">
                    <template slot-scope="scope">
                        <span style="font-size: 14.4px; font-weight: normal;">{{ scope.row.courseName }}</span>
                    </template>
                </el-table-column>
                <el-table-column prop="instructorId" label="授课教师id" width="120" align="center" header-align="center">
                    <template slot-scope="scope">
                        <span style="font-size: 14.4px; font-weight: normal;">{{ scope.row.instructorId }}</span>
                    </template>
                </el-table-column>
                <el-table-column prop="resourceId" label="课程资源id" width="120" align="center" header-align="center">
                    <template slot-scope="scope">
                        <span style="font-size: 14.4px; font-weight: normal;">{{ scope.row.resourceId }}</span>
                    </template>
                </el-table-column>
                <el-table-column prop="creditHour" label="学时" width="120" align="center" header-align="center">
                    <template slot-scope="scope">
                        <span style="font-size: 14.4px; font-weight: normal;">{{ scope.row.creditHour }}</span>
                    </template>
                </el-table-column>
                <el-table-column prop="courseCreateTime" label="创建时间" :formatter="formatDate" width="150" align="center" header-align="center">
                </el-table-column>
                <el-table-column prop="courseUpdateTime" label="更新时间" :formatter="formatDate" align="center" header-align="center">
                </el-table-column>
                <el-table-column label="操作" v-if="user.userType == '管理员'" align="center" header-align="center">
                    <template slot-scope="scope">
                        <el-button class="ctrl-btn edit-btn" type="primary" @click="edit(scope.row)">编辑</el-button>
                        <el-popconfirm title="是否删除该课程?" @confirm="del(scope.row.courseId)">
                            <el-button slot="reference" type="danger" class="ctrl-btn del-btn">删除</el-button>
                        </el-popconfirm>
                    </template>
                </el-table-column>
            </el-table>
            <el-dialog title="修改课程信息" :visible.sync="dialogFormVisible">
                <el-form ref="editForm" :model="editform" :rules="rules">
                    <el-form-item label="课程名称" :label-width="formLabelWidth">
                        <el-input class="input-length" v-model="editform.courseName" autocomplete="off"></el-input>
                    </el-form-item>
                    <el-form-item label="授课教师id" :label-width="formLabelWidth" prop="instructorId">
                        <el-input class="input-length" v-model="editform.instructorId"></el-input>
                    </el-form-item>
                    <el-form-item label="课程资源id" :label-width="formLabelWidth" prop="resourceId">
                        <el-input class="input-length" v-model="editform.resourceId"></el-input>
                    </el-form-item>
                    <el-form-item label="学时" :label-width="formLabelWidth">
                        <el-input-number class="input-length-number" v-model="editform.creditHour" :min="0" :step="2"
                            controls-position="right"></el-input-number>
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
            courseName: '',
            currentPage: 1,
            pageSize: 10,
            dialogFormVisible: false,
            dialogAddVisible: false,
            tableData: [],
            pagedData: [],
            formLabelWidth: '120px',
            editform: {
                courseName: '',
                instructorId: '',
                resourceId: '',
                creditHour: '',
                courseUpdateTime: '',  // 设置初始值为当前时间
            },
            addform: {
                courseId: '',
                courseName: '',
                instructorId: '',
                resourceId: '',
                creditHour: '',
                courseCreateTime: '',
            },
            rules: {
                courseId: [
                    { required: true, message: '请输入序号', trigger: 'blur' },
                    { pattern: /^[1-9]\d*$/, message: '序号必须为正整数', trigger: 'blur' }
                ],
                instructorId: [
                    { required: true, message: '请输入授课教师id', trigger: 'blur' },
                    { pattern: /^[1-9]\d*$/, message: '授课教师id必须为正整数', trigger: 'blur' }
                ],
                resourceId: [
                    { required: true, message: '请输入课程资源id', trigger: 'blur' },
                    { pattern: /^[1-9]\d*$/, message: '课程资源id必须为正整数', trigger: 'blur' }
                ]
            }
        }
    },
    methods: {
        selectAll() {
            let params = {
                courseName: this.courseName,
            }
            request.get("/course/selectAll", { params }).then(res => {
                if (res.code == 0) {
                    this.tableData = res.data;
                    this.handlePagination();
                } else {
                    this.$message.error(res.msg)
                }
            })
        },
        del(courseId) {
            request.delete('/course/delete/' + courseId).then(res => {
                if (res.code == 0) {
                    this.$message.success('删除成功');
                    this.selectAll(); // 更新表格数据
                } else {
                    this.$message.error(res.msg);
                }
            })
        },
        addCourse() {
            this.$refs.addForm.validate((valid) => {
                if (!valid) return;
                this.addform.courseCreateTime = new Date();
                request.post("/course/addCourse", this.addform).then(res => {
                    if (res.code == 0) {
                        this.$message.success('添加成功');
                        this.dialogAddVisible = false;
                        this.searchCourses();
                        // 重置addform
                        this.addform = {
                            courseId: '',
                            courseName: '',
                            instructorId: '',
                            resourceId: '',
                            credit_id: '',
                            courseCreateTime: '',
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
                this.editform.courseUpdateTime = new Date();
                request.post('/course/update', this.editform).then(res => {
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
        this.selectAll()
    }
}
</script>
<style scoped>


</style>