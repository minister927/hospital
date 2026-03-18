<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="患者编号" prop="patientNo">
        <el-input
          v-model="queryParams.patientNo"
          placeholder="请输入患者编号"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="性别" prop="gender">
        <el-select v-model="queryParams.gender" placeholder="请选择性别" clearable @change="handleQuery" style="width:160px">
          <el-option label="男" value="0"></el-option>
          <el-option label="女" value="1"></el-option>
          <el-option label="未知" value="2"></el-option>
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
          v-hasPermi="['hospital:patient:add']"
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
          v-hasPermi="['hospital:patient:edit']"
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
          v-hasPermi="['hospital:patient:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['hospital:patient:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="patientList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="患者ID" align="center" prop="patientId" />
      <el-table-column label="关联用户ID" align="center" prop="userId" />
      <el-table-column label="患者编号" align="center" prop="patientNo" />
      <el-table-column label="身份证号" align="center" prop="idCard" />
      <el-table-column label="性别" align="center">
        <template slot-scope="scope">
          <span>{{ genderText(scope.row.gender) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="出生日期" align="center" prop="birthDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.birthDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="年龄" align="center" prop="age" />
      <el-table-column label="血型" align="center" prop="bloodType" />
      <el-table-column label="婚姻状况" align="center" prop="marriageStatus" />
      <el-table-column label="职业" align="center" prop="occupation" />
      <el-table-column label="民族" align="center" prop="nation" />
      <el-table-column label="现住址" align="center" prop="address" />
      <el-table-column label="联系电话" align="center" prop="phone" />
      <el-table-column label="过敏史" align="center" prop="allergyHistory" />
      <el-table-column label="慢性病史" align="center" prop="chronicDisease" />
      <el-table-column label="家族病史" align="center" prop="familyHistory" />
      <el-table-column label="医保卡号" align="center" prop="insuranceNo" />
      <el-table-column label="患者状态" align="center" prop="status" />
      <el-table-column label="备注" align="center" prop="remark" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['hospital:patient:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['hospital:patient:remove']"
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

    <!-- 添加或修改患者信息对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="800px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="120px">
        <el-row :gutter="16">
          <el-col :span="12">
            <el-form-item label="关联用户ID" prop="userId">
              <el-input v-model="form.userId" placeholder="请输入关联用户ID" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="患者编号" prop="patientNo">
              <el-input v-model="form.patientNo" placeholder="请输入患者编号" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="16">
          <el-col :span="12">
            <el-form-item label="身份证号" prop="idCard">
              <el-input v-model="form.idCard" placeholder="请输入身份证号" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="性别" prop="gender">
              <el-select v-model="form.gender" placeholder="请选择性别">
                <el-option label="男" value="0"></el-option>
                <el-option label="女" value="1"></el-option>
                <el-option label="未知" value="2"></el-option>
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="16">
          <el-col :span="12">
            <el-form-item label="出生日期" prop="birthDate">
              <el-date-picker clearable
                v-model="form.birthDate"
                type="date"
                value-format="yyyy-MM-dd"
                placeholder="请选择出生日期">
              </el-date-picker>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="年龄" prop="age">
              <el-input v-model="form.age" placeholder="请输入年龄" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="16">
          <el-col :span="12">
            <el-form-item label="职业" prop="occupation">
              <el-input v-model="form.occupation" placeholder="请输入职业" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="民族" prop="nation">
              <el-input v-model="form.nation" placeholder="请输入民族" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="16">
          <el-col :span="12">
            <el-form-item label="现住址" prop="address">
              <el-input v-model="form.address" placeholder="请输入现住址" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="联系电话" prop="phone">
              <el-input v-model="form.phone" placeholder="请输入联系电话" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="16">
          <el-col :span="12">
            <el-form-item label="过敏史" prop="allergyHistory">
              <el-input v-model="form.allergyHistory" type="textarea" placeholder="请输入内容" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="慢性病史" prop="chronicDisease">
              <el-input v-model="form.chronicDisease" type="textarea" placeholder="请输入内容" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="16">
          <el-col :span="12">
            <el-form-item label="家族病史" prop="familyHistory">
              <el-input v-model="form.familyHistory" type="textarea" placeholder="请输入内容" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="医保卡号" prop="insuranceNo">
              <el-input v-model="form.insuranceNo" placeholder="请输入医保卡号" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="16">
          <el-col :span="24">
            <el-form-item label="备注" prop="remark">
              <el-input v-model="form.remark" type="textarea" placeholder="请输入内容" />
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listPatient, getPatient, delPatient, addPatient, updatePatient } from "@/api/hospital/patient/patient"

export default {
  name: "Patient",
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
      // 患者信息表格数据
      patientList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        userId: null,
        patientNo: null,
        idCard: null,
        gender: null,
        birthDate: null,
        age: null,
        bloodType: null,
        marriageStatus: null,
        occupation: null,
        nation: null,
        address: null,
        phone: null,
        allergyHistory: null,
        chronicDisease: null,
        familyHistory: null,
        insuranceNo: null,
        status: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        userId: [
          { required: true, message: "关联用户ID不能为空", trigger: "blur" }
        ],
        patientNo: [
          { required: true, message: "患者编号不能为空", trigger: "blur" }
        ],
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询患者信息列表 */
    getList() {
      this.loading = true
      listPatient(this.queryParams).then(response => {
        this.patientList = response.rows
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
        patientId: null,
        userId: null,
        patientNo: null,
        idCard: null,
        gender: null,
        birthDate: null,
        age: null,
        bloodType: null,
        marriageStatus: null,
        occupation: null,
        nation: null,
        address: null,
        phone: null,
        allergyHistory: null,
        chronicDisease: null,
        familyHistory: null,
        insuranceNo: null,
        status: null,
        createBy: null,
        createTime: null,
        updateBy: null,
        updateTime: null,
        remark: null
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
      this.ids = selection.map(item => item.patientId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加患者信息"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const patientId = row.patientId || this.ids
      getPatient(patientId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改患者信息"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.patientId != null) {
            updatePatient(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addPatient(this.form).then(response => {
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
      const patientIds = row.patientId || this.ids
      this.$modal.confirm('是否确认删除患者信息编号为"' + patientIds + '"的数据项？').then(function() {
        return delPatient(patientIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('hospital/patient/export', {
        ...this.queryParams
      }, `patient_${new Date().getTime()}.xlsx`)
    }
    ,
    /** 性别代码转中文 */
    genderText(code) {
      if (code === null || code === undefined) return '';
      const s = String(code);
      if (s === '0') return '男';
      if (s === '1') return '女';
      if (s === '2') return '未知';
      return s;
    }
  }
}
</script>
