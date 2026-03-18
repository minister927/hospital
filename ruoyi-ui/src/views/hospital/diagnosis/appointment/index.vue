<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="80px">
      <el-form-item label="病历号/患者" prop="keyword">
        <el-input
          v-model="queryParams.keyword"
          placeholder="病历号或患者姓名"
          clearable
          @keyup.enter.native="handleQuery"
          style="width:220px"
        />
      </el-form-item>
      <el-form-item label="科室ID" prop="deptId">
        <el-input
          v-model="queryParams.deptId"
          placeholder="科室ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="预约日期" prop="appointmentDate">
        <el-date-picker clearable
          v-model="queryParams.appointmentDate"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择预约日期">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="状态" prop="appointmentStatus">
        <el-select v-model="queryParams.appointmentStatus" placeholder="请选择状态" clearable style="width:140px">
          <el-option label="待接诊" value="pending" />
          <el-option label="就诊中" value="confirmed" />
          <el-option label="已完成" value="completed" />
        </el-select>
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
          v-hasPermi="['diagnosis:appointment:add']"
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
          v-hasPermi="['diagnosis:appointment:edit']"
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
          v-hasPermi="['diagnosis:appointment:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['diagnosis:appointment:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="appointmentList" @selection-change="handleSelectionChange" stripe>
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="预约ID" align="center" prop="appointmentId" />
      <el-table-column label="预约号" align="center" prop="appointmentNo" />
      <el-table-column label="患者ID" align="center" prop="patientId" />
      <el-table-column label="患者姓名" align="center" prop="patient.patientName" />
      <el-table-column label="性别/年龄" align="center" width="120">
        <template slot-scope="scope">
          <span v-if="scope.row.patient">{{scope.row.patient.gender}} {{scope.row.patient.age?scope.row.patient.age+'岁':''}}</span>
        </template>
      </el-table-column>
      <el-table-column label="医生ID" align="center" prop="staffId" />
      <el-table-column label="排班ID" align="center" prop="scheduleId" />
      <el-table-column label="科室ID" align="center" prop="deptId" />
      <el-table-column label="预约日期" align="center" prop="appointmentDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.appointmentDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="时间段" align="center" prop="timeSlot" />
      <el-table-column label="预约时间" align="center" prop="appointmentTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.appointmentTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="排队号" align="center" prop="queueNumber" />
      <el-table-column label="挂号时间" align="center" prop="appointmentTime" width="160">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.appointmentTime, '{y}-{m}-{d} {h}:{i}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="症状描述" align="center" prop="symptoms" />
      <el-table-column label="来源" align="center" prop="source" />
      <el-table-column label="挂号费" align="center" prop="fee" />
      <el-table-column label="缴费状态" align="center" prop="paymentStatus" />
      <el-table-column label="预约状态" align="center" prop="appointmentStatus" />
      <el-table-column label="取消原因" align="center" prop="cancelReason" />
      <el-table-column label="到院时间" align="center" prop="arriveTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.arriveTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="220">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['diagnosis:appointment:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['diagnosis:appointment:remove']"
          >删除</el-button>
          <el-button v-if="scope.row.appointmentStatus === 'pending'" type="primary" size="mini" @click.stop="accept(scope.row)" style="margin-left:6px">接诊</el-button>
          <el-button v-else type="text" size="mini" @click.stop="openMedical(scope.row)" style="margin-left:6px">查看病历</el-button>
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

    <!-- 添加或修改预约挂号对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="820px" append-to-body>
        <el-form ref="form" :model="form" :rules="rules" label-width="120px">
          <el-row :gutter="16">
            <el-col :span="12">
              <el-form-item label="预约号" prop="appointmentNo">
                <el-input v-model="form.appointmentNo" placeholder="请输入预约号" />
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="患者" prop="patientId">
                <el-select
                  v-model="form.patientId"
                  filterable
                  remote
                  clearable
                  reserve-keyword
                  remote-method="queryPatients"
                  @visible-change="onPatientVisibleChange"
                  placeholder="搜索并选择患者（编号/姓名）"
                  :loading="loadingPatients"
                  style="width:100%"
                >
                  <el-option v-for="p in patientOptions" :key="p.patientId" :label="p.patientName + ' (' + (p.patientNo||'') + ')'" :value="p.patientId" />
                </el-select>
              </el-form-item>
            </el-col>
          </el-row>

          <el-row :gutter="16">
            <el-col :span="12">
              <el-form-item label="医生" prop="staffId">
                <el-select
                  v-model="form.staffId"
                  filterable
                  remote
                  clearable
                  reserve-keyword
                  remote-method="queryStaff"
                  @visible-change="onStaffVisibleChange"
                  placeholder="搜索并选择医生（姓名/工号）"
                  :loading="loadingStaff"
                  style="width:100%"
                >
                  <el-option v-for="s in staffOptions" :key="s.staffId" :label="s.staffName + ' (' + (s.staffNo || '') + ')'" :value="s.staffId" />
                </el-select>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="排班" prop="scheduleId">
                <el-select
                  v-model="form.scheduleId"
                  filterable
                  remote
                  clearable
                  reserve-keyword
                  remote-method="querySchedules"
                  @visible-change="onScheduleVisibleChange"
                  placeholder="搜索并选择排班"
                  :loading="loadingSchedules"
                  style="width:100%"
                >
                  <el-option v-for="sch in scheduleOptions" :key="sch.scheduleId" :label="sch.scheduleNo + ' | ' + sch.scheduleDate" :value="sch.scheduleId" />
                </el-select>
              </el-form-item>
            </el-col>
          </el-row>

          <el-row :gutter="16">
            <el-col :span="12">
              <el-form-item label="科室" prop="deptId">
                <el-select
                  v-model="form.deptId"
                  filterable
                  remote
                  clearable
                  reserve-keyword
                  remote-method="queryDepts"
                  @visible-change="onDeptVisibleChange"
                  placeholder="搜索并选择科室"
                  :loading="loadingDepts"
                  style="width:100%"
                >
                  <el-option v-for="d in deptOptions" :key="d.deptId" :label="d.deptName" :value="d.deptId" />
                </el-select>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="预约日期" prop="appointmentDate">
                <el-date-picker clearable
                  v-model="form.appointmentDate"
                  type="date"
                  value-format="yyyy-MM-dd"
                  placeholder="请选择预约日期">
                </el-date-picker>
              </el-form-item>
            </el-col>
          </el-row>

        <el-row :gutter="16">
          <el-col :span="12">
            <el-form-item label="时间段" prop="timeSlot">
              <el-input v-model="form.timeSlot" placeholder="请输入时间段" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="预约时间" prop="appointmentTime">
              <el-date-picker clearable
                v-model="form.appointmentTime"
                type="datetime"
                value-format="yyyy-MM-dd HH:mm:ss"
                placeholder="请选择预约时间">
              </el-date-picker>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="16">
          <el-col :span="12">
            <el-form-item label="排队号" prop="queueNumber">
              <el-input v-model="form.queueNumber" placeholder="请输入排队号" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="挂号费" prop="fee">
              <el-input v-model="form.fee" placeholder="请输入挂号费" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="16">
          <el-col :span="24">
            <el-form-item label="症状描述" prop="symptoms">
              <el-input v-model="form.symptoms" type="textarea" placeholder="请输入内容" :rows="3" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="16">
          <el-col :span="12">
            <el-form-item label="来源" prop="source">
              <el-input v-model="form.source" placeholder="请输入来源" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="到院时间" prop="arriveTime">
              <el-date-picker clearable
                v-model="form.arriveTime"
                type="date"
                value-format="yyyy-MM-dd"
                placeholder="请选择到院时间">
              </el-date-picker>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row>
          <el-col :span="24" style="text-align:right">
            <el-button type="primary" @click="submitForm">确 定</el-button>
            <el-button @click="cancel">取 消</el-button>
          </el-col>
        </el-row>
      </el-form>
    </el-dialog>
  </div>
</template>

<script>
import { listAppointment, getAppointment, delAppointment, addAppointment, updateAppointment } from "@/api/hospital/diagnosis/appointment"
import { listPatient } from '@/api/hospital/patient/patient'
import { listInfo as listStaffInfo } from '@/api/hospital/doctor/info'
import request from '@/utils/request'

export default {
  name: "Appointment",
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
      // 预约挂号表格数据
      appointmentList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        appointmentNo: null,
        patientId: null,
        keyword: null,
        staffId: null,
        scheduleId: null,
        deptId: null,
        appointmentDate: null,
        source: null,
        appointmentStatus: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        appointmentNo: [
          { required: true, message: "预约号不能为空", trigger: "blur" }
        ],
        patientId: [
          { required: true, message: "患者ID不能为空", trigger: "blur" }
        ],
        staffId: [
          { required: true, message: "医生ID不能为空", trigger: "blur" }
        ],
        scheduleId: [
          { required: true, message: "排班ID不能为空", trigger: "blur" }
        ],
        deptId: [
          { required: true, message: "科室ID不能为空", trigger: "blur" }
        ],
        appointmentDate: [
          { required: true, message: "预约日期不能为空", trigger: "blur" }
        ],
        timeSlot: [
          { required: true, message: "时间段不能为空", trigger: "blur" }
        ],
        appointmentTime: [
          { required: true, message: "预约时间不能为空", trigger: "blur" }
        ],
      }
      ,
      // 远程检索选项
      patientOptions: [],
      staffOptions: [],
      scheduleOptions: [],
      deptOptions: [],
      loadingPatients: false,
      loadingStaff: false,
      loadingSchedules: false,
      loadingDepts: false,
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询预约挂号列表 */
    getList() {
      this.loading = true
      listAppointment(this.queryParams).then(response => {
        console.debug('listAppointment response:', response)
        this.appointmentList = (response.rows || []).slice().sort((a,b)=>{
          const ta = a.appointmentTime ? new Date(a.appointmentTime).getTime() : 0
          const tb = b.appointmentTime ? new Date(b.appointmentTime).getTime() : 0
          return ta - tb
        })
        this.total = response.total
        this.loading = false
      })
    },
    // 查询患者（远程搜索 / 初始加载）
    queryPatients(query) {
      this.loadingPatients = true
      const params = { pageNum: 1, pageSize: 20 }
      if (query) params.keyword = query
      listPatient(params).then(res => {
        const rows = res.rows || res.data || res || []
        this.patientOptions = Array.isArray(rows) ? rows : (rows.records || [])
      }).finally(() => { this.loadingPatients = false })
    },
    // 查询医生（远程搜索 / 初始加载）
    queryStaff(query) {
      this.loadingStaff = true
      const params = { pageNum: 1, pageSize: 20 }
      if (query) params.keyword = query
      listStaffInfo(params).then(res => {
        const rows = res.rows || res.data || res || []
        this.staffOptions = Array.isArray(rows) ? rows : (rows.records || [])
      }).finally(() => { this.loadingStaff = false })
    },
    // 查询排班（远程搜索 / 初始加载）
    querySchedules(query) {
      this.loadingSchedules = true
      const params = { pageNum: 1, pageSize: 20 }
      if (query) params.keyword = query
      request({ url: '/hospital/schedule/list', method: 'get', params }).then(res => {
        const rows = res.rows || res.data || res || []
        this.scheduleOptions = Array.isArray(rows) ? rows : (rows.records || [])
      }).finally(() => { this.loadingSchedules = false })
    },
    // 查询科室（远程搜索 / 初始加载）
    queryDepts(query) {
      this.loadingDepts = true
      const params = { pageNum: 1, pageSize: 20 }
      if (query) params.keyword = query
      // system dept list is commonly under /system/dept/list
      request({ url: '/system/dept/list', method: 'get', params }).then(res => {
        const rows = res.rows || res.data || res || []
        this.deptOptions = Array.isArray(rows) ? rows : (rows.records || [])
      }).finally(() => { this.loadingDepts = false })
    },

    // 下拉打开时加载默认选项（避免必须先输入关键字）
    onPatientVisibleChange(visible) {
      if (visible && (!this.patientOptions || this.patientOptions.length === 0)) {
        this.queryPatients('')
      }
    },
    onStaffVisibleChange(visible) {
      if (visible && (!this.staffOptions || this.staffOptions.length === 0)) {
        this.queryStaff('')
      }
    },
    onScheduleVisibleChange(visible) {
      if (visible && (!this.scheduleOptions || this.scheduleOptions.length === 0)) {
        this.querySchedules('')
      }
    },
    onDeptVisibleChange(visible) {
      if (visible && (!this.deptOptions || this.deptOptions.length === 0)) {
        this.queryDepts('')
      }
    },
    // 取消按钮
    cancel() {
      this.open = false
      this.reset()
    },
    // 表单重置
    reset() {
      this.form = {
        appointmentId: null,
        appointmentNo: null,
        patientId: null,
        staffId: null,
        scheduleId: null,
        deptId: null,
        appointmentDate: null,
        timeSlot: null,
        appointmentTime: null,
        queueNumber: null,
        symptoms: null,
        source: null,
        fee: null,
        paymentStatus: null,
        appointmentStatus: null,
        cancelReason: null,
        arriveTime: null,
        createTime: null,
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
      this.ids = selection.map(item => item.appointmentId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加预约挂号"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const appointmentId = row.appointmentId || this.ids
      getAppointment(appointmentId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改预约挂号"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.appointmentId != null) {
            updateAppointment(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addAppointment(this.form).then(response => {
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
      const appointmentIds = row.appointmentId || this.ids
      this.$modal.confirm('是否确认删除预约挂号编号为"' + appointmentIds + '"的数据项？').then(function() {
        return delAppointment(appointmentIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('diagnosis/appointment/export', {
        ...this.queryParams
      }, `appointment_${new Date().getTime()}.xlsx`)
    }
    ,
    async accept(row) {
      try {
        const appt = { ...row, appointmentStatus: 'confirmed' }
        await updateAppointment(appt)
        this.$modal.msgSuccess('接诊成功')
  // reload list and navigate to record page to start consultation
  await this.getList()
  this.$router.push({ path: '/hospital/diagnosis/record/index', query: { patientId: row.patientId, appointmentId: row.appointmentId } })
      } catch (e) {
        this.$modal.msgError('接诊失败')
      }
    },

    openMedical(row) {
      this.$router.push({ path: '/hospital/diagnosis/record/index', query: { patientId: row.patientId, appointmentId: row.appointmentId } })
    }
  }
}
</script>
