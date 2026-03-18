<template>
  <div class="app-container">
    <el-row :gutter="12">
      <!-- 左侧：今日挂号队列 -->
      <el-col :span="6">
        <el-card>
          <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:8px;">
            <div style="display:flex;gap:8px;align-items:center;">
              <el-select v-model="filterStatus" size="mini" placeholder="状态" clearable @change="loadAppointments">
                <el-option label="待接诊" value="pending" />
                <el-option label="就诊中" value="confirmed" />
                <el-option label="已完成" value="completed" />
              </el-select>
              <el-date-picker size="mini" v-model="appointmentDateFilter" type="date" value-format="yyyy-MM-dd" placeholder="日期" @change="loadAppointments" />
            </div>
            <el-input v-model="keyword" size="mini" placeholder="病历号/姓名" clearable @keyup.enter.native="loadAppointments" style="width:140px;">
              <el-button slot="append" icon="el-icon-search" @click="loadAppointments" size="mini"></el-button>
            </el-input>
          </div>

          <el-scrollbar style="height:720px;">
            <el-timeline>
              <el-timeline-item v-for="appt in appointments" :key="appt.appointmentId" :timestamp="formatTime(appt.appointmentTime)" placement="top">
                <div style="display:flex;align-items:center;justify-content:space-between;">
                  <div style="flex:1;cursor:pointer" @click="selectAppointment(appt)">
                    <div><strong>#{{ appt.queueNumber || appt.appointmentNo }}</strong> {{ appt.patient ? appt.patient.patientName : (appt.patientName || '-') }}</div>
                    <div style="color:#888;font-size:12px;">{{ appt.patient ? (appt.patient.gender + ' ' + (appt.patient.age||'') + '岁') : '' }} · {{ appt.deptName || appt.deptId }} / {{ appt.staff ? appt.staff.staffName : (appt.staffName||'') }}</div>
                  </div>
                  <div style="margin-left:8px;white-space:nowrap;">
                    <el-tag size="mini" type="info" v-if="appt.appointmentStatus === 'pending'">待接诊</el-tag>
                    <el-tag size="mini" type="warning" v-else-if="appt.appointmentStatus === 'confirmed'">就诊中</el-tag>
                    <el-tag size="mini" type="success" v-else>已完成</el-tag>
                    <div style="margin-top:6px;text-align:right;">
                      <el-button v-if="appt.appointmentStatus === 'pending'" type="primary" size="mini" @click.stop="accept(appt)">接诊</el-button>
                    </div>
                  </div>
                </div>
              </el-timeline-item>
            </el-timeline>
          </el-scrollbar>
        </el-card>
      </el-col>

      <!-- 右侧：工作台 + 原有记录列表 -->
      <el-col :span="18">
        <el-card>
          <el-tabs v-model="activeTab" type="card">
            <el-tab-pane label="病历" name="medical">
              <div v-if="!currentAppointment" style="padding:24px;color:#999">请选择左侧患者以查看病历</div>
              <div v-else>
                <el-row :gutter="12">
                  <el-col :span="8">
                    <el-card>
                      <h4>基础信息</h4>
                      <div v-if="patient" style="line-height:28px">
                        <div><strong>{{ patient.patientName }}</strong> <span style="color:#888">{{ patient.gender }} {{ patient.age }}岁</span></div>
                        <div>病历号：{{ patient.recordNo || currentAppointment.patientId }}</div>
                        <div>联系方式：{{ patient.phone }}</div>
                        <div>身份证：{{ patient.idNo }}</div>
                      </div>
                      <div v-else style="color:#888">加载中...</div>
                    </el-card>
                  </el-col>
                  <el-col :span="16">
                    <el-card>
                      <h4>历史就诊记录</h4>
                      <el-table :data="historyRecords" size="mini" v-loading="loadingHistory" style="width:100%">
                        <el-table-column prop="recordId" label="ID" width="70" />
                        <el-table-column prop="visitDate" label="日期" width="120" :formatter="formatDateFormatter" />
                        <el-table-column prop="staff.staffName" label="医生" width="120" />
                        <el-table-column prop="finalDiagnosis" label="诊断" />
                      </el-table>
                      <pagination :total="historyTotal" :page.sync="historyQuery.pageNum" :limit.sync="historyQuery.pageSize" @pagination="loadHistory" v-show="historyTotal>0" />
                    </el-card>
                  </el-col>
                </el-row>
              </div>
            </el-tab-pane>

            <el-tab-pane label="处方开具" name="prescription">
              <div v-if="!currentAppointment" style="padding:24px;color:#999">请选择左侧患者以开处方</div>
              <div v-else>
                <el-row :gutter="12">
                  <el-col :span="12">
                    <el-card>
                      <el-form :model="prescriptionForm" label-width="100px" size="small">
                        <el-row :gutter="12">
                          <el-col :span="12">
                            <el-form-item label="患者ID">
                              <el-input v-model="prescriptionForm.patientId" disabled></el-input>
                            </el-form-item>
                          </el-col>
                          <el-col :span="12">
                            <el-form-item label="医生ID">
                              <el-input v-model="prescriptionForm.staffId"></el-input>
                            </el-form-item>
                          </el-col>
                        </el-row>

                        <el-row :gutter="12">
                          <el-col :span="24">
                            <el-form-item label="诊断">
                              <el-input type="textarea" v-model="prescriptionForm.diagnosis" rows="2"></el-input>
                            </el-form-item>
                          </el-col>
                        </el-row>
                      </el-form>
                      <el-divider />
                      <h5>药品选择</h5>
                      <el-row :gutter="12" style="margin-bottom:8px;">
                        <el-col :span="16">
                          <el-input v-model="drugKeyword" placeholder="按名称/拼音模糊搜索" size="small" clearable @keyup.enter.native="searchMedicines" />
                        </el-col>
                        <el-col :span="8" style="text-align:left">
                          <el-button type="primary" size="small" @click="searchMedicines">搜索</el-button>
                        </el-col>
                      </el-row>
                      <el-table :data="medicines" size="mini" style="margin-top:8px;height:200px;overflow:auto" @row-dblclick="addDrug">
                        <el-table-column prop="medicineId" label="ID" width="60"/>
                        <el-table-column prop="medicineName" label="药品"/>
                        <el-table-column prop="spec" label="规格" width="100"/>
                        <el-table-column prop="retailPrice" label="价格" width="80"/>
                      </el-table>
                    </el-card>
                  </el-col>
                  <el-col :span="12">
                    <h5>处方明细</h5>
                    <el-table :data="prescriptionItems" size="mini">
                      <el-table-column label="药品" prop="medicineName"/>
                      <el-table-column label="剂量" width="120">
                        <template slot-scope="scope">
                          <el-input v-model="scope.row.dose" size="mini"></el-input>
                        </template>
                      </el-table-column>
                      <el-table-column label="用法" width="120">
                        <template slot-scope="scope">
                          <el-input v-model="scope.row.usage" size="mini"></el-input>
                        </template>
                      </el-table-column>
                      <el-table-column label="备注" width="160">
                        <template slot-scope="scope">
                          <el-input v-model="scope.row.remark" size="mini"></el-input>
                        </template>
                      </el-table-column>
                      <el-table-column label="操作" width="80">
                        <template slot-scope="scope">
                          <el-button type="text" size="mini" @click="removeItem(scope.$index)">删除</el-button>
                        </template>
                      </el-table-column>
                    </el-table>
                    <div style="margin-top:8px;text-align:right;">
                      <el-button type="info" size="small" @click="saveDraft">暂存</el-button>
                      <el-button type="primary" size="small" @click="submitPrescription">提交</el-button>
                      <el-button type="warning" size="small" @click="printPrescription">打印</el-button>
                    </div>
                  </el-col>
                </el-row>
              </div>
            </el-tab-pane>
          </el-tabs>
  </el-card>

        

      </el-col>
    </el-row>
  </div>
</template>

<script>
import { 
  listMedicalRecord, 
  getMedicalRecord, 
  delMedicalRecord, 
  addMedicalRecord, 
  updateMedicalRecord, 
  getDraftPrescription 
} from '@/api/hospital/diagnosis/record'
import { listAppointment, updateAppointment } from '@/api/hospital/diagnosis/appointment'
import { getPatient } from '@/api/hospital/patient/patient'
import { listMedicine } from '@/api/hospital/medicine/info'
import { addPrescription } from '@/api/hospital/diagnosis/prescription'

export default {
  name: "Record",
  data() {
    return {
      // 遮罩层（参考预约页面）
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
      // 就诊记录表格数据
      recordList: [],
      // 草稿处方列表
      draftList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数（参考预约页面，补充完整条件）
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        recordNo: null,
        patientId: null,
        staffId: null,
        prescriptionId: null,
        visitDate: null,
        recordStatus: null
      },
      // 表单参数（参考预约页面，补充完整字段）
      form: {
        recordId: null,
        recordNo: null,
        patientId: null,
        staffId: null,
        prescriptionId: null,
        visitDate: null,
        visitType: "outpatient",
        chiefComplaint: "",
        presentIllness: "",
        preliminaryDiagnosis: "",
        finalDiagnosis: "",
        medicalAdvice: "",
        recordStatus: "draft",
        createTime: null,
        updateTime: null
      },
      // 表单校验（参考预约页面，补充完整规则）
      rules: {
        recordNo: [
          { required: true, message: "病历号不能为空", trigger: "blur" }
        ],
        patientId: [
          { required: true, message: "患者ID不能为空", trigger: "blur" }
        ],
        staffId: [
          { required: true, message: "医生ID不能为空", trigger: "blur" }
        ],
        visitDate: [
          { required: true, message: "就诊日期不能为空", trigger: "blur" }
        ],
        visitType: [
          { required: true, message: "就诊类型不能为空", trigger: "blur" }
        ],
        chiefComplaint: [
          { required: true, message: "主诉不能为空", trigger: "blur" }
        ]
      }
      ,
      // 挂号队列与工作台状态
      appointments: [],
      filterStatus: null,
  keyword: '',
  // 左侧挂号日期筛选（默认今天），用户可修改查看昨天或其他日期
  appointmentDateFilter: (() => { const d = new Date(); return `${d.getFullYear()}-${String(d.getMonth()+1).padStart(2,'0')}-${String(d.getDate()).padStart(2,'0')}` })(),
      currentAppointment: null,
      patient: null,
  // 回退尝试标志，防止无限重试
  attemptedAppointmentsFallback: false,
  attemptedRecordsFallback: false,
      activeTab: 'medical',
      historyRecords: [],
      historyTotal: 0,
      historyQuery: { pageNum: 1, pageSize: 5 },
      loadingHistory: false,
      prescriptionForm: { patientId: null, staffId: null, diagnosis: '', prescriptionStatus: 'draft' },
      medicines: [],
      drugKeyword: '',
      prescriptionItems: []
      ,
      // 查看对话框与当前查看记录
      viewDialogVisible: false,
      viewRecord: null,
      // 本地表格排序状态（客户端排序）
      tableSort: { prop: null, order: null }
    };
  },
  created() {
    // 默认页面进入时：设置主表查询的就诊日期为今天，并加载左侧挂号队列和主表列表
    this.queryParams.visitDate = this.appointmentDateFilter;
    this.loadAppointments();
    this.getList();
  },
  methods: {
    /** 查询就诊记录列表（参考预约页面，标准化逻辑） */
    getList() {
      this.loading = true;
      // Debug: 打印预期请求的完整路径与参数，便于在浏览器控制台对比 network 中的请求
      console.debug('request:', process.env.VUE_APP_BASE_API + '/hospital/record/list', this.queryParams);
      listMedicalRecord(this.queryParams).then(response => {
        console.debug('listMedicalRecord response:', response);
        // 支持两种返回结构：{ rows, total } 或 { data: { rows, total } }
        const rows = (response && response.rows) ? response.rows : (response && response.data && response.data.rows) ? response.data.rows : [];
        // 默认按就诊日期降序展示（最近在前）
        this.recordList = (rows || []).slice().sort((a, b) => {
          const ta = a.visitDate ? new Date(a.visitDate).getTime() : 0;
          const tb = b.visitDate ? new Date(b.visitDate).getTime() : 0;
          return tb - ta;
        });
        this.total = (response && response.total) ? response.total : (response && response.data && response.data.total) ? response.data.total : 0;
        this.loading = false;
        // 若按日期查询返回为空且未回退过，尝试不带 visitDate 再请求一次以展示更多数据（只尝试一次）
        if ((rows || []).length === 0 && this.queryParams.visitDate && !this.attemptedRecordsFallback) {
          this.attemptedRecordsFallback = true;
          const backup = { ...this.queryParams };
          delete backup.visitDate;
          this.$modal && this.$modal.msgInfo && this.$modal.msgInfo('当天无就诊记录，已尝试显示全部/最近就诊')
          listMedicalRecord(backup).then(resp2 => {
            const rows2 = (resp2 && resp2.rows) ? resp2.rows : (resp2 && resp2.data && resp2.data.rows) ? resp2.data.rows : [];
            this.recordList = (rows2 || []).slice().sort((a, b) => {
              const ta = a.visitDate ? new Date(a.visitDate).getTime() : 0;
              const tb = b.visitDate ? new Date(b.visitDate).getTime() : 0;
              return tb - ta;
            });
            this.total = (resp2 && resp2.total) ? resp2.total : (resp2 && resp2.data && resp2.data.total) ? resp2.data.total : 0;
          }).catch(() => {});
        }
      }).catch(err => {
        console.error('getList error:', err);
        this.$modal && this.$modal.msgError && this.$modal.msgError('加载就诊记录失败，请检查控制台或网络请求');
        this.recordList = [];
        this.total = 0;
        this.loading = false;
      });
    },
    // 取消按钮（参考预约页面，标准化逻辑）
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置（参考预约页面，标准化逻辑）
    reset() {
      this.form = {
        recordId: null,
        recordNo: null,
        patientId: null,
        staffId: null,
        prescriptionId: null,
        visitDate: null,
        visitType: "outpatient",
        chiefComplaint: "",
        presentIllness: "",
        preliminaryDiagnosis: "",
        finalDiagnosis: "",
        medicalAdvice: "",
        recordStatus: "draft",
        createTime: null,
        updateTime: null
      };
      this.resetForm("form");
    },
    /** 搜索按钮操作（参考预约页面） */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置按钮操作（参考预约页面） */
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    },
    // 多选框选中数据（参考预约页面）
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.recordId);
      this.single = selection.length !== 1;
      this.multiple = !selection.length;
    },
    /** 新增按钮操作（参考预约页面） */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加就诊记录";
    },
    /** 修改按钮操作（参考预约页面，标准化命名+逻辑） */
    handleUpdate(row) {
      this.reset();
      const recordId = row.recordId || this.ids;
      getMedicalRecord(recordId).then(response => {
        this.form = response.data;
        this.loadDraftPrescription();
        this.open = true;
        this.title = "修改就诊记录";
      });
    },
    /** 加载患者草稿处方（保留核心逻辑，优化异常处理） */
    async loadDraftPrescription() {
      if (!this.form.patientId) {
        this.draftList = [];
        return;
      }
      try {
        const res = await getDraftPrescription(this.form.patientId);
        this.draftList = res.data || [];
      } catch (e) {
        this.draftList = [];
        this.$modal.msgError("加载处方列表失败");
      }
    },
    /** 提交按钮（参考预约页面，标准化逻辑） */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.recordId != null) {
            updateMedicalRecord(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addMedicalRecord(this.form).then(response => {
              this.$modal.msgSuccess("新增成功");
              this.open = false;
              this.getList();
            });
          }
        }
      });
    },
    /** 删除按钮操作（参考预约页面，标准化提示+逻辑） */
    handleDelete(row) {
      const recordIds = row.recordId || this.ids;
      this.$modal.confirm('是否确认删除就诊记录编号为"' + recordIds + '"的数据项？').then(() => {
        return delMedicalRecord(recordIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 导出按钮操作（参考预约页面，补充导出功能） */
    handleExport() {
      this.download('diagnosis/record/export', {
        ...this.queryParams
      }, `record_${new Date().getTime()}.xlsx`);
    },

    /* ----------------- 挂号队列与工作台扩展方法 ----------------- */
    formatTime(t) { return t ? this.parseTime(t, '{h}:{i}') : '' },
    formatDateFormatter(row, column, cellValue) { return cellValue ? this.parseTime(cellValue, '{y}-{m}-{d}') : '' },

    async loadAppointments() {
      // 使用用户选择的日期（默认 today），允许用户查看昨天或任意日期
      const dateStr = this.appointmentDateFilter || (() => { const t = new Date(); return `${t.getFullYear()}-${String(t.getMonth()+1).padStart(2,'0')}-${String(t.getDate()).padStart(2,'0')}` })();
      const params = { pageNum:1, pageSize:200 };
      if (dateStr) params.appointmentDate = dateStr;
      if (this.filterStatus) params.appointmentStatus = this.filterStatus;
      if (this.keyword) params.keyword = this.keyword;
      try {
        const res = await listAppointment(params);
        const rows = res.rows || [];
        this.appointments = rows;
        // 若按日期查询有结果为 0，且之前没有回退过，则尝试不带日期再取一次（扩大范围）
        if ((!rows || rows.length === 0) && (params.appointmentDate) && !this.attemptedAppointmentsFallback) {
          this.attemptedAppointmentsFallback = true;
          // 提示用户并尝试回退查询
          this.$nextTick(() => this.$modal && this.$modal.msgInfo && this.$modal.msgInfo('当天无挂号，已尝试显示全部/最近挂号'))
          const broader = { pageNum:1, pageSize:200 };
          if (this.filterStatus) broader.appointmentStatus = this.filterStatus;
          if (this.keyword) broader.keyword = this.keyword;
          const res2 = await listAppointment(broader);
          this.appointments = res2.rows || [];
        }
      } catch (e) {
        this.$modal.msgError('加载挂号队列失败');
        this.appointments = [];
      }
    },

    async accept(appt) {
      try {
  await updateAppointment({ ...appt, appointmentStatus: 'confirmed' });
        this.$modal.msgSuccess('接诊成功');
        await this.loadAppointments();
        this.selectAppointment(appt);
      } catch (e) {
        this.$modal.msgError('接诊失败');
      }
    },

    async selectAppointment(appt) {
      this.currentAppointment = appt;
      this.prescriptionForm.patientId = appt.patientId || (appt.patient && appt.patient.patientId);
      this.prescriptionForm.staffId = appt.staffId || (appt.staff && appt.staff.staffId);
      this.activeTab = 'medical';
      if (this.prescriptionForm.patientId) {
        try {
          const res = await getPatient(this.prescriptionForm.patientId);
          this.patient = res.data || res;
          // 加载该患者的历史记录（右侧历史）
          this.loadHistory();
          // 同步主表查询条件：将主表列表（下方就诊记录）按 patientId 过滤，方便查看该患者所有记录
          this.queryParams.patientId = this.prescriptionForm.patientId;
          this.queryParams.pageNum = 1;
          this.getList();
        } catch (e) {
          this.$modal.msgError('加载患者信息失败');
        }
      }
    },

    async loadHistory() {
      if (!this.prescriptionForm.patientId) return;
      this.loadingHistory = true;
      const params = { pageNum: this.historyQuery.pageNum, pageSize: this.historyQuery.pageSize, patientId: this.prescriptionForm.patientId };
      try {
        const res = await listMedicalRecord(params);
        this.historyRecords = res.rows || [];
        this.historyTotal = res.total || 0;
      } catch (e) {
        this.historyRecords = [];
        this.historyTotal = 0;
      }
      this.loadingHistory = false;
    },

    async loadHistoryPage() { this.loadHistory() },

    async searchMedicines() {
      const params = { pageNum:1, pageSize:50 };
      if (this.drugKeyword) params.keyword = this.drugKeyword;
      try {
        const res = await listMedicine(params);
        this.medicines = res.rows || [];
      } catch (e) {
        this.medicines = [];
        this.$modal.msgError('药品检索失败');
      }
    },

    addDrug(row) {
      const item = { medicineId: row.medicineId, medicineName: row.medicineName, dose: '', usage: '', remark: '' };
      this.prescriptionItems.push(item);
    },

    removeItem(idx) { this.prescriptionItems.splice(idx,1) },

    saveDraft() { this.$modal.msgSuccess('已暂存（示意）') },

    async submitPrescription() {
      if (!this.prescriptionForm.patientId) { this.$modal.msgError('请选择患者'); return }
      if (this.prescriptionItems.length===0) { this.$modal.msgError('请添加处方明细'); return }
      const payload = {
        patientId: this.prescriptionForm.patientId,
        staffId: this.prescriptionForm.staffId,
        diagnosis: this.prescriptionForm.diagnosis,
        items: this.prescriptionItems,
        prescriptionStatus: 'confirmed'
      };
      try {
        await addPrescription(payload);
        if (this.currentAppointment) {
          await updateAppointment({ ...this.currentAppointment, appointmentStatus: 'completed' });
        }
        this.$modal.msgSuccess('处方提交成功，已完成就诊');
        this.loadAppointments();
      } catch (e) {
        this.$modal.msgError('提交失败');
      }
    },

    printPrescription() { this.$modal.msgInfo('触发打印（示意）') },

    /** 查看记录详情（打开弹窗） */
    viewRecordDetail(row) {
      this.viewRecord = row || null;
      this.viewDialogVisible = true;
    },

    /** 导出单条记录（使用已有 download helper） */
    exportRecord(row) {
      if (!row || !row.recordId) { this.$modal.msgError('记录ID不存在，无法导出'); return }
      const filename = `record_${row.recordId}_${new Date().getTime()}.xlsx`;
      this.download('diagnosis/record/export', { recordId: row.recordId }, filename);
    },

    handleDialogClose() {
      this.viewDialogVisible = false;
      this.viewRecord = null;
    },

    /** 客户端表格排序回调：对现有 recordList 做简单排序（服务端排序可另行扩展） */
    handleSortChange({ prop, order }) {
      this.tableSort.prop = prop;
      this.tableSort.order = order;
      if (!prop || !order) return;
      const dir = order === 'ascending' ? 1 : -1;
      this.recordList = (this.recordList || []).slice().sort((a, b) => {
        const va = a[prop] || '';
        const vb = b[prop] || '';
        // 尝试按时间排序
        if (prop.toLowerCase().includes('date') || prop.toLowerCase().includes('time')) {
          return (new Date(va).getTime() - new Date(vb).getTime()) * dir;
        }
        // 默认字符串比较
        return (va + '').localeCompare(vb + '') * dir;
      });
    }
  }
};
</script>
