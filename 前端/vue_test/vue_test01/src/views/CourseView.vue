<template>
    <div>
        <el-input class="course-input" placeholder="请输入课程名称" v-model="name" clearable></el-input>
        <el-button class="course-btn" type="primary" plain @click="searchCourses()">搜索</el-button>
        <el-button v-if="user.type == '管理员'" class="course-btn" icon="el-icon-circle-plus-outline"
            @click="dialogAddVisible = true">新建</el-button>
        <el-dialog title="添加课程" :visible.sync="dialogAddVisible">
            <el-form ref="addForm" :model="addform" :rules="rules">
                <el-form-item label="序号" :label-width="formLabelWidth" prop="id">
                    <el-input class="input-length" v-model="addform.id"></el-input>
                </el-form-item>
                <el-form-item label="课程名称" :label-width="formLabelWidth">
                    <el-input class="input-length" v-model="addform.name"></el-input>
                </el-form-item>
                <el-form-item label="授课教师id" :label-width="formLabelWidth" prop="instructor_id">
                    <el-input class="input-length" v-model="addform.instructor_id"></el-input>
                </el-form-item>
                <el-form-item label="课程资源id" :label-width="formLabelWidth" prop="resource_id">
                    <el-input class="input-length" v-model="addform.resource_id"></el-input>
                </el-form-item>
                <el-form-item label="学时" :label-width="formLabelWidth">
                    <el-input-number class="input-length-number" v-model="addform.schedule" :min="0" :step="2"
                        controls-position="right"></el-input-number>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogAddVisible = false">取 消</el-button>
                <el-button type="primary" @click="addCourse">确 定</el-button>
            </div>
        </el-dialog>
        <div class="table-container">
            <el-table :data="pagedData" style="width: 100%">
                <el-table-column prop="id" label="ID" width="120">
                </el-table-column>
                <el-table-column prop="name" label="课程名称" width="120">
                </el-table-column>
                <el-table-column prop="instructor_id" label="授课教师id" width="120">
                </el-table-column>
                <el-table-column prop="resource_id" label="课程资源id" width="120">
                </el-table-column>
                <el-table-column prop="schedule" label="学时" width="120">
                </el-table-column>
                <el-table-column prop="create_time" label="创建时间" :formatter="formatDate">
                </el-table-column>
                <el-table-column prop="update_time" label="更新时间" :formatter="formatDate">
                </el-table-column>
                <el-table-column label="操作" v-if="user.type == '管理员'">
                    <template slot-scope="scope">
                        <el-button class="course-btn" type="primary" @click="edit(scope.row)">编辑</el-button>
                        <el-popconfirm title="是否删除该课程?" @confirm="del(scope.row.id)">
                            <el-button slot="reference" class="course-btn" type="danger">删除</el-button>
                        </el-popconfirm>
                    </template>
                </el-table-column>
            </el-table>
            <el-dialog title="修改课程信息" :visible.sync="dialogFormVisible">
                <el-form ref="editForm" :model="editform" :rules="rules">
                    <el-form-item label="课程名称" :label-width="formLabelWidth">
                        <el-input class="input-length" v-model="editform.name" autocomplete="off"></el-input>
                    </el-form-item>
                    <el-form-item label="授课教师id" :label-width="formLabelWidth" prop="instructor_id">
                        <el-input class="input-length" v-model="editform.instructor_id"></el-input>
                    </el-form-item>
                    <el-form-item label="课程资源id" :label-width="formLabelWidth" prop="resource_id">
                        <el-input class="input-length" v-model="editform.resource_id"></el-input>
                    </el-form-item>
                    <el-form-item label="学时" :label-width="formLabelWidth">
                        <el-input-number class="input-length-number" v-model="editform.schedule" :min="0" :step="2"
                            controls-position="right"></el-input-number>
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
                name: '',
                instructor_id: '',
                resource_id: '',
                schedule: '',
                update_time: '',  // 设置初始值为当前时间
            },
            addform: {
                id: '',
                name: '',
                instructor_id: '',
                resource_id: '',
                schedule: '',
                create_time: '',
            },
            rules: {
                id: [
                    { required: true, message: '请输入序号', trigger: 'blur' },
                    { pattern: /^[1-9]\d*$/, message: '序号必须为正整数', trigger: 'blur' }
                ],
                instructor_id: [
                    { required: true, message: '请输入授课教师id', trigger: 'blur' },
                    { pattern: /^[1-9]\d*$/, message: '授课教师id必须为正整数', trigger: 'blur' }
                ],
                resource_id: [
                    { required: true, message: '请输入课程资源id', trigger: 'blur' },
                    { pattern: /^[1-9]\d*$/, message: '课程资源id必须为正整数', trigger: 'blur' }
                ]
            }
        }
    },
    methods: {
        searchCourses() {
            let params = {
                name: this.name,
            }
            request.get("/course/searchCourses", { params }).then(res => {
                if (res.code == 0) {
                    this.tableData = res.data;
                    this.handlePagination();
                } else {
                    this.$message.error(res.msg)
                }
            })
        },
        del(id) {
            request.delete('/course/delete/' + id).then(res => {
                if (res.code == 0) {
                    this.$message.success('删除成功');
                    this.searchCourses(); // 更新表格数据
                } else {
                    this.$message.error(res.msg);
                }
            })
        },
        addCourse() {
            this.$refs.addForm.validate((valid) => {
                if (!valid) return;
                this.addform.create_time = new Date();
                request.post("/course/addCourse", this.addform).then(res => {
                    if (res.code == 0) {
                        this.$message.success('添加成功');
                        this.dialogAddVisible = false;
                        this.searchCourses();
                        // 重置addform
                        this.addform = {
                            id: '',
                            name: '',
                            instructor_id: '',
                            resource_id: '',
                            schedule: '',
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
        this.searchCourses()
    }
}
</script>
<style scoped>
.course-input {
    width: 12%;
    margin-right: 10px;
}

.course-btn {
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
    width: 90%; /* 你可以根据需要调整这个值 */
}

.input-length-number{
    width: 40%;
}

.dialogWidth{
    margin: auto;
    width: 50%;
}
</style>