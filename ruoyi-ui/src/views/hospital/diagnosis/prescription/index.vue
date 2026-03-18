<template>
  <div class="app-container">
    <el-form :inline="true" :model="queryParams" class="demo-form-inline">
      <el-form-item label="患者ID" prop="patientId">
        <el-input
          v-model="queryParams.patientId"
          placeholder="请输入患者ID"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="处方状态" prop="prescriptionStatus">
        <el-select v-model="queryParams.prescriptionStatus" placeholder="请选择状态" clearable>
          <el-option label="草稿" value="draft" />
          <el-option label="已确认" value="confirmed" />
          <el-option label="未配药" value="unfilled" />
          <el-option label="已配药" value="filled" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" @click="handleQuery">查询</el-button>
        <el-button icon="el-icon-refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          @click="handleAdd"
          v-hasPermi="['hospital:prescription:add']"
        >新增处方</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          @click="handleEdit"
          v-hasPermi="['hospital:prescription:edit']"
          :disabled="single"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          @click="handleDelete"
          v-hasPermi="['hospital:prescription:remove']"
          :disabled="multiple"
        >删除</el-button>
      </el-col>
    </el-row>

    <el-table
      v-loading="loading"
      :data="prescriptionList"
      @selection-change="handleSelectionChange"
      border
      fit
      highlight-current-row
    >
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="处方ID" prop="prescriptionId" align="center" width="80" />
      <el-table-column label="处方编号" prop="prescriptionNo" align="center" width="120" />
      <el-table-column label="患者ID" prop="patientId" align="center" width="80" />
      <el-table-column label="患者姓名" prop="patient.patientName" align="center" width="100" />
      <el-table-column label="医生姓名" prop="staff.staffName" align="center" width="100" />
      <el-table-column label="总金额" prop="totalAmount" align="center" width="100" />
      <el-table-column label="状态" prop="prescriptionStatus" align="center" width="100">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.prescriptionStatus === 'draft'" type="warning">草稿</el-tag>
          <el-tag v-else-if="scope.row.prescriptionStatus === 'confirmed'" type="primary">已确认</el-tag>
          <el-tag v-else-if="scope.row.prescriptionStatus === 'unfilled'" type="info">未配药</el-tag>
          <el-tag v-else type="success">已配药</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="primary"
            icon="el-icon-edit"
            @click="handleEdit(scope.row)"
            v-hasPermi="['hospital:prescription:edit']"
            v-if="scope.row.prescriptionStatus === 'draft'"
          >修改</el-button>
          <el-button
            size="mini"
            type="danger"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['hospital:prescription:remove']"
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

    <!-- 新增/修改处方对话框 -->
    <el-dialog :title="title" v-model="open" width="600px" append-to-body>
      <el-form ref="prescriptionForm" :model="prescriptionForm" :rules="rules" label-width="100px">
        <el-row>
          <el-col :span="12">
            <el-form-item label="患者ID" prop="patientId">
              <el-input v-model="prescriptionForm.patientId" placeholder="请输入患者ID" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="医生ID" prop="staffId">
              <el-input v-model="prescriptionForm.staffId" placeholder="请输入医生ID" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="处方类型" prop="prescriptionType">
              <el-select v-model="prescriptionForm.prescriptionType" placeholder="请选择处方类型">
                <el-option label="普通处方" value="common" />
                <el-option label="急诊处方" value="emergency" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="总金额" prop="totalAmount">
              <el-input v-model="prescriptionForm.totalAmount" placeholder="请输入总金额" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="诊断结果" prop="diagnosis">
          <el-input v-model="prescriptionForm.diagnosis" type="textarea" :rows="2" placeholder="请输入诊断结果" />
        </el-form-item>
        <el-form-item label="用法用量说明" prop="usageInstructions">
          <el-input v-model="prescriptionForm.usageInstructions" type="textarea" :rows="3" placeholder="请输入用法用量说明" />
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
import { listPrescription, getPrescription, delPrescription, addPrescription, updatePrescription } from "@/api/hospital/diagnosis/prescription";

export default {
  name: "Prescription",
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
      // 总条数
      total: 0,
      // 处方表格数据
      prescriptionList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        patientId: null,
        prescriptionStatus: null
      },
      // 表单数据
      prescriptionForm: {
        prescriptionId: null,
        prescriptionNo: "",
        patientId: null,
        staffId: null,
        recordId: null,
        diagnosis: "",
        usageInstructions: "",
        totalAmount: 0.00,
        prescriptionType: "common",
        prescriptionStatus: "draft"
      },
      // 表单校验
      rules: {
        patientId: [
          { required: true, message: "患者ID不能为空", trigger: "blur" }
        ],
        staffId: [
          { required: true, message: "医生ID不能为空", trigger: "blur" }
        ],
        prescriptionType: [
          { required: true, message: "处方类型不能为空", trigger: "change" }
        ],
        totalAmount: [
          { required: true, message: "总金额不能为空", trigger: "blur" },
          { type: 'number', message: "总金额必须为数字", trigger: "blur" }
        ],
        diagnosis: [
          { required: true, message: "诊断结果不能为空", trigger: "blur" }
        ]
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询处方列表 */
    getList() {
      this.loading = true;
      listPrescription(this.queryParams).then(response => {
        this.prescriptionList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.prescriptionForm = {
        prescriptionId: null,
        prescriptionNo: "",
        patientId: null,
        staffId: null,
        recordId: null,
        diagnosis: "",
        usageInstructions: "",
        totalAmount: 0.00,
        prescriptionType: "common",
        prescriptionStatus: "draft"
      };
      this.resetForm("prescriptionForm");
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    },
    // 多选框选中数据
    handleSelectionChange(val) {
      this.ids = val.map(item => item.prescriptionId);
      this.single = val.length !== 1;
      this.multiple = val.length === 0;
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "新增处方";
    },
    /** 修改按钮操作 */
    handleEdit(row) {
      this.reset();
      const prescriptionId = row.prescriptionId || this.ids;
      getPrescription(prescriptionId).then(response => {
        this.prescriptionForm = response.data;
        this.open = true;
        this.title = "修改处方";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["prescriptionForm"].validate(valid => {
        if (valid) {
          if (this.prescriptionForm.prescriptionId != null) {
            updatePrescription(this.prescriptionForm).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addPrescription(this.prescriptionForm).then(response => {
              this.$modal.msgSuccess("新增成功");
              this.open = false;
              this.getList();
            });
          }
        }
      });
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const prescriptionIds = row.prescriptionId || this.ids;
      this.$modal.confirm('是否确认删除处方编号为"' + prescriptionIds + '"的数据项？').then(function() {
        return delPrescription(prescriptionIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    }
  }
};
</script>