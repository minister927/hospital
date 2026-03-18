<template>
  <div class="login-container">
    <!-- 左侧登录区域 -->
    <div class="login-box">
      <div class="login-content">
        <div class="login-header">
          <h2 class="login-title animate-slide-up">欢迎回来</h2>
          <p class="login-subtitle animate-slide-up animation-delay-200">请登录您的账号以继续</p>
        </div>
        <el-form ref="formRef" :model="form" :rules="rules" class="login-form">
          <el-form-item prop="username" class="form-item">
            <el-input 
              v-model="form.username" 
              placeholder="请输入用户名/邮箱" 
              prefix-icon="el-icon-user" 
              class="login-input"
            />
          </el-form-item>
          <el-form-item prop="password" class="form-item">
            <el-input 
              v-model="form.password" 
              type="password" 
              placeholder="请输入密码" 
              prefix-icon="el-icon-lock" 
              class="login-input"
              show-password
            />
          </el-form-item>
          <div class="form-row">
            <el-checkbox v-model="form.remember" class="remember-checkbox">记住密码</el-checkbox>
            <a href="javascript:;" class="forgot-link">忘记密码？</a>
          </div>
          <el-button 
            type="primary"
            class="login-btn animate-slide-up animation-delay-200"
            :loading="loading" 
            @click="handleLogin"
          >
            登 录
          </el-button>

          <!-- 🔐 管理员登录  -->
          <div class="admin-login-wrapper">
            <a href="javascript:;" class="admin-login-link" @click="goToAdminLogin">
              <i class="el-icon-user-solid"></i> 管理员登录
            </a>
          </div>

          <div class="register-tip">
            还没有账号？
            <a href="javascript:;" class="register-link" @click="isRegister = true">立即注册</a>
          </div>
        </el-form>
      </div>
    </div>

    <!-- 右侧背景图区域 -->
    <div class="login-bg">
      <div class="bg-mask">
        <div class="bg-content">
          <h1 class="bg-title">智慧医疗管理系统</h1>
          <p class="bg-desc">高效 · 安全 · 便捷的医疗数字化解决方案</p>
        </div>
      </div>
    </div>

    <!-- 注册对话框 -->
    <el-dialog 
      v-model="isRegister" 
      title="注册新账号" 
      width="420px" 
      :close-on-click-modal="false" 
      center
      class="register-dialog"
    >
      <el-form ref="registerFormRef" :model="registerForm" :rules="registerRules" class="register-form">
        <el-form-item prop="username" class="register-item">
          <el-input v-model="registerForm.username" placeholder="请设置用户名" prefix-icon="el-icon-user" class="register-input"/>
        </el-form-item>
        <el-form-item prop="email" class="register-item">
          <el-input v-model="registerForm.email" placeholder="请输入邮箱" prefix-icon="el-icon-message" class="register-input"/>
        </el-form-item>
        <el-form-item prop="password" class="register-item">
          <el-input v-model="registerForm.password" type="password" placeholder="请设置密码（至少6位）" prefix-icon="el-icon-lock" show-password class="register-input"/>
        </el-form-item>
        <el-form-item prop="confirmPassword" class="register-item">
          <el-input v-model="registerForm.confirmPassword" type="password" placeholder="请确认密码" prefix-icon="el-icon-lock" show-password class="register-input"/>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="isRegister = false" class="dialog-btn cancel-btn">取 消</el-button>
        <el-button type="primary" :loading="registerLoading" @click="handleRegister" class="dialog-btn submit-btn">注 册</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: 'LoginPage',
  data() {
    const validateConfirmPassword = (rule, value, callback) => {
      if (value !== this.registerForm.password) {
        callback(new Error('两次输入的密码不一致'));
      } else {
        callback();
      }
    };
    return {
      loading: false,
      registerLoading: false,
      isRegister: false,
      form: { username: '', password: '', remember: false },
      registerForm: { username: '', email: '', password: '', confirmPassword: '' },
      rules: {
        username: [{ required: true, message: '请输入用户名', trigger: 'blur' }],
        password: [{ required: true, message: '请输入密码', trigger: 'blur' }]
      },
      registerRules: {
        username: [{ required: true, message: '请设置用户名', trigger: 'blur' }],
        email: [
          { required: true, message: '请输入邮箱', trigger: 'blur' },
          { type: 'email', message: '请输入正确的邮箱格式', trigger: 'blur' }
        ],
        password: [
          { required: true, message: '请设置密码', trigger: 'blur' },
          { min: 6, message: '密码长度不能少于6位', trigger: 'blur' }
        ],
        confirmPassword: [
          { required: true, message: '请确认密码', trigger: 'blur' },
          { validator: validateConfirmPassword, trigger: 'blur' }
        ]
      }
    };
  },
  methods: {
    // 处理登录
    async handleLogin() {
      const formRef = this.$refs.formRef;
      if (!formRef) return;
      await formRef.validate(async (valid) => {
        if (valid) {
          this.loading = true;
          setTimeout(() => {
            this.$message.success('登录成功');
            this.$router.push('/');
            this.loading = false;
          }, 1000);
        }
      });
    },
    // 处理注册
    async handleRegister() {
      const registerFormRef = this.$refs.registerFormRef;
      if (!registerFormRef) return;
      await registerFormRef.validate(async (valid) => {
        if (valid) {
          this.registerLoading = true;
          setTimeout(() => {
            this.$message.success('注册成功');
            this.isRegister = false;
            this.registerLoading = false;
          }, 1000);
        }
      });
    },
    // 👉 管理员登录跳转
    goToAdminLogin() {
      this.$router.push('/login');
    }
  }
};
</script>

<style scoped>
/* 全局布局 */
.login-container {
  min-height: 100vh;
  display: flex;
  width: 100%;
  overflow: hidden;
}

/* 左侧登录区域 */
.login-box {
  width: 45%;
  display: flex;
  align-items: center;
  justify-content: center;
  background: #fff;
  padding: 40px;
  animation: fadeIn 0.8s ease-out;
  order: 1;
}
.login-content {
  width: 100%;
  max-width: 420px;
}
.login-header {
  text-align: center;
  margin-bottom: 40px;
}
.login-title {
  font-size: 32px;
  font-weight: bold;
  color: #1f2937;
  margin-bottom: 8px;
}
.login-subtitle {
  font-size: 16px;
  color: #6b7280;
}

/* 表单 */
.login-form {
  width: 100%;
}
.form-item {
  margin-bottom: 20px !important;
}
.login-input {
  height: 50px !important;
  border-radius: 8px !important;
  font-size: 16px !important;
  border: 1px solid #e5e7eb !important;
}
::v-deep .login-input .el-input__wrapper {
  box-shadow: none !important;
  border: none !important;
  padding: 0 16px !important;
}
::v-deep .login-input .el-input__inner {
  height: 50px !important;
  line-height: 50px !important;
  font-size: 16px !important;
}
.form-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
}
.remember-checkbox {
  font-size: 14px;
  color: #4b5563;
}
.forgot-link {
  font-size: 14px;
  color: #165DFF;
  text-decoration: none;
  cursor: pointer;
}
.forgot-link:hover {
  color: #0e4bdb;
  text-decoration: underline;
}

.login-btn {
  width: 100%;
  height: 50px !important;
  font-size: 18px !important;
  border-radius: 8px !important;
  background: #165DFF !important;
  border: none !important;
  box-shadow: 0 4px 12px rgba(22, 93, 255, 0.3);
  transition: all 0.3s ease;
}
.login-btn:hover {
  background: #0e4bdb !important;
  transform: translateY(-2px);
  box-shadow: 0 6px 16px rgba(22, 93, 255, 0.4);
}

/* 🔐 管理员登录 样式 */
.admin-login-wrapper {
  text-align: center;
  margin: 12px 0 20px;
}
.admin-login-link {
  font-size: 14px;
  color: #555;
  text-decoration: none;
  cursor: pointer;
  display: inline-flex;
  align-items: center;
  gap: 4px;
  padding: 4px 8px;
  border-radius: 4px;
}
.admin-login-link i {
  font-size: 14px;
  color: #165DFF;
}
.admin-login-link:hover {
  color: #165DFF;
  background-color: #f5f7ff;
}

.register-tip {
  text-align: center;
  margin-top: 8px;
  font-size: 14px;
  color: #6b7280;
}
.register-link {
  font-size: 14px;
  color: #165DFF;
  text-decoration: none;
  cursor: pointer;
  margin-left: 4px;
}
.register-link:hover {
  color: #0e4bdb;
  text-decoration: underline;
}

/* 右侧背景 */
.login-bg {
  width: 55%;
  height: 100vh;
  background: url('https://pic1.zhimg.com/v2-7e88c915729190968099327f21809997_r.jpg') no-repeat center center;
  background-size: cover;
  position: relative;
  animation: fadeIn 0.8s ease-out;
  order: 2;
}
.bg-mask {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: linear-gradient(135deg, rgba(22, 93, 255, 0.8) 0%, rgba(22, 93, 255, 0.6) 100%);
  display: flex;
  align-items: center;
  justify-content: center;
}
.bg-content {
  text-align: center;
  color: #fff;
  padding: 0 40px;
}
.bg-title {
  font-size: 48px;
  font-weight: bold;
  margin-bottom: 24px;
  text-shadow: 0 2px 10px rgba(0,0,0,0.2);
}
.bg-desc {
  font-size: 20px;
  line-height: 1.6;
  opacity: 0.9;
}

/* 注册弹窗 */
::v-deep .register-dialog .el-dialog__header {
  padding: 20px 24px 16px;
  border-bottom: 1px solid #f0f0f0;
}
::v-deep .register-dialog .el-dialog__title {
  font-size: 20px;
  font-weight: bold;
  color: #1f2937;
}
::v-deep .register-dialog .el-dialog__body {
  padding: 20px 24px;
}
.register-form {
  width: 100%;
}
.register-item {
  margin-bottom: 16px !important;
}
.register-input {
  height: 46px !important;
  border-radius: 6px !important;
  font-size: 15px !important;
}
::v-deep .register-input .el-input__wrapper {
  box-shadow: none !important;
  border: 1px solid #e5e7eb !important;
  padding: 0 14px !important;
}
::v-deep .register-input .el-input__inner {
  height: 46px !important;
  line-height: 46px !important;
  font-size: 15px !important;
}
.dialog-footer {
  padding: 16px 24px 20px;
  border-top: 1px solid #f0f0f0;
  text-align: right;
  margin: 0;
}
.dialog-btn {
  padding: 8px 20px !important;
  border-radius: 6px !important;
  font-size: 15px !important;
}
.cancel-btn {
  color: #6b7280 !important;
  border-color: #e5e7eb !important;
}
.submit-btn {
  background: #165DFF !important;
  border-color: #165DFF !important;
}
.submit-btn:hover {
  background: #0e4bdb !important;
  border-color: #0e4bdb !important;
}

/* 动画 */
@keyframes fadeIn {
  from { opacity: 0; transform: translateX(20px); }
  to { opacity: 1; transform: translateX(0); }
}
@keyframes slideUp {
  from { opacity: 0; transform: translateY(20px); }
  to { opacity: 1; transform: translateY(0); }
}
.animate-slide-up {
  animation: slideUp 0.6s ease-out forwards;
  opacity: 0;
}
.animation-delay-200 {
  animation-delay: 200ms;
}

@media (max-width: 768px) {
  .login-bg { display: none; }
  .login-box { width: 100%; padding: 30px 20px; }
}
</style>