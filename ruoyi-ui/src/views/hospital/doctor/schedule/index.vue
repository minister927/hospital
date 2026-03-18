<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="医生ID" prop="staffId">
        <el-input
          v-model="queryParams.staffId"
          placeholder="请输入医生ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="排班日期" prop="scheduleDate">
        <el-date-picker clearable
          v-model="queryParams.scheduleDate"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择排班日期">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="时间段" prop="timeSlot">
        <el-input
          v-model="queryParams.timeSlot"
          placeholder="请输入时间段"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="诊室号" prop="roomNo">
        <el-input
          v-model="queryParams.roomNo"
          placeholder="请输入诊室号"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['system:schedule:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['system:schedule:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['system:schedule:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:schedule:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="scheduleList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="排班ID" align="center" prop="scheduleId" />
      <el-table-column label="医生ID" align="center" prop="staffId" />
      <el-table-column label="排班日期" align="center" prop="scheduleDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.scheduleDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="时间段" align="center" prop="timeSlot" />
      <el-table-column label="诊室号" align="center" prop="roomNo" />
      <el-table-column label="最大接诊人数" align="center" prop="maxPatients" />
      <el-table-column label="当前预约人数" align="center" prop="currentPatients" />
      <el-table-column label="排班类型" align="center" prop="scheduleType" />
      <el-table-column label="挂号费" align="center" prop="fee" />
      <el-table-column label="状态" align="center" prop="status" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:schedule:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:schedule:remove']"
          >删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    
    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改医生排班对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="医生ID" prop="staffId">
          <el-input v-model="form.staffId" placeholder="请输入医生ID" />
        </el-form-item>
        <el-form-item label="排班日期" prop="scheduleDate">
          <el-date-picker clearable
            v-model="form.scheduleDate"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择排班日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="时间段" prop="timeSlot">
          <el-input v-model="form.timeSlot" placeholder="请输入时间段" />
        </el-form-item>
        <el-form-item label="诊室号" prop="roomNo">
          <el-input v-model="form.roomNo" placeholder="请输入诊室号" />
        </el-form-item>
        <el-form-item label="最大接诊人数" prop="maxPatients">
          <el-input v-model="form.maxPatients" placeholder="请输入最大接诊人数" />
        </el-form-item>
        <el-form-item label="当前预约人数" prop="currentPatients">
          <el-input v-model="form.currentPatients" placeholder="请输入当前预约人数" />
        </el-form-item>
        <el-form-item label="挂号费" prop="fee">
          <el-input v-model="form.fee" placeholder="请输入挂号费" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listSchedule, getSchedule, delSchedule, addSchedule, updateSchedule } from "@/api/hospital/doctor/schedule"

export default {
  name: "Schedule",
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 医生排班表格数据
      scheduleList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        staffId: null,
        scheduleDate: null,
        timeSlot: null,
        roomNo: null,
        maxPatients: null,
        currentPatients: null,
        scheduleType: null,
        fee: null,
        status: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        staffId: [
          { required: true, message: "医生ID不能为空", trigger: "blur" }
        ],
        scheduleDate: [
          { required: true, message: "排班日期不能为空", trigger: "blur" }
        ],
        timeSlot: [
          { required: true, message: "时间段不能为空", trigger: "blur" }
        ],
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询医生排班列表 */
    getList() {
      this.loading = true
      listSchedule(this.queryParams).then(response => {
        this.scheduleList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    // 取消按钮
    cancel() {
      this.open = false
      this.reset()
    },
    // 表单重置
    reset() {
      this.form = {
        scheduleId: null,
        staffId: null,
        scheduleDate: null,
        timeSlot: null,
        roomNo: null,
        maxPatients: null,
        currentPatients: null,
        scheduleType: null,
        fee: null,
        status: null,
        createBy: null,
        createTime: null,
        updateBy: null,
        updateTime: null
      }
      this.resetForm("form")
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm")
      this.handleQuery()
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.scheduleId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加医生排班"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const scheduleId = row.scheduleId || this.ids
      getSchedule(scheduleId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改医生排班"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.scheduleId != null) {
            updateSchedule(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addSchedule(this.form).then(response => {
              this.$modal.msgSuccess("新增成功")
              this.open = false
              this.getList()
            })
          }
        }
      })
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const scheduleIds = row.scheduleId || this.ids
      this.$modal.confirm('是否确认删除医生排班编号为"' + scheduleIds + '"的数据项？').then(function() {
        return delSchedule(scheduleIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('system/schedule/export', {
        ...this.queryParams
      }, `schedule_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
