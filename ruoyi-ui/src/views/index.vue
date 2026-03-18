<template>
  <div class="app-container home">
    <!-- 欢迎横幅 -->
    <el-card class="welcome-banner" shadow="never">
      <div class="banner-content">
        <div class="banner-left">
          <h1>欢迎使用 医院综合管理系统</h1>
          <p class="banner-desc">
            一套完整的医院管理平台，实现患者管理、门诊挂号、医生排班、药品管理、住院管理、收费结算、病历查询的全流程数字化管理
          </p>
          <div class="banner-tags">
            <el-tag type="success" size="medium">v1.0.0</el-tag>
            <el-tag type="info" size="medium">门诊管理</el-tag>
            <el-tag type="info" size="medium">住院管理</el-tag>
            <el-tag type="info" size="medium">药品管理</el-tag>
            <el-tag type="info" size="medium">患者管理</el-tag>
          </div>
        </div>
        <div class="banner-right">
          <i class="el-icon-user-solid banner-icon"></i>
        </div>
      </div>
    </el-card>

    <!-- 功能模块快速入口 -->
    <el-row :gutter="20" class="module-cards">
      <el-col :xs="12" :sm="12" :md="6" :lg="6">
        <el-card class="module-card" shadow="hover" @click.native="goToModule('/hospital/patient/list')">
          <div class="module-icon patient">
            <i class="el-icon-user"></i>
          </div>
          <h3>患者管理</h3>
          <p>患者档案、就诊记录、病历查询</p>
        </el-card>
      </el-col>
      <el-col :xs="12" :sm="12" :md="6" :lg="6">
        <el-card class="module-card" shadow="hover" @click.native="goToModule('/hospital/medicine/list')">
          <div class="module-icon medicine">
            <i class="el-icon-box"></i>
          </div>
          <h3>药品管理</h3>
          <p>药品信息、库存管理、出入库记录</p>
        </el-card>
      </el-col>
      <el-col :xs="12" :sm="12" :md="6" :lg="6">
      <el-card class="module-card" shadow="hover" @click.native="goToModule('/hospital/diagnosis/record/index')">
          <div class="module-icon outpatient">
            <i class="el-icon-s-custom"></i>
          </div>
          <h3>门诊管理</h3>
          <p>门诊挂号、医生排班、就诊流程</p>
        </el-card>
      </el-col>
      <el-col :xs="12" :sm="12" :md="6" :lg="6">
        <el-card class="module-card" shadow="hover" @click.native="goToModule('/hospital/inpatient/list')">
          <div class="module-icon inpatient">
            <i class="el-icon-house"></i>
          </div>
          <h3>住院管理</h3>
          <p>病房管理、床位分配、住院结算</p>
        </el-card>
      </el-col>
    </el-row>

    <!-- 系统特性 -->
    <el-row :gutter="20" class="features-section">
      <el-col :xs="24" :sm="24" :md="12" :lg="12">
        <el-card shadow="never" class="feature-card">
          <div slot="header" class="card-header">
            <span class="header-title">
              <i class="el-icon-star-on"></i>
              系统特性
            </span>
          </div>
          <div class="features-list">
            <div class="feature-item">
              <i class="el-icon-check feature-icon"></i>
              <div class="feature-content">
                <h4>全流程医疗管理</h4>
                <p>从患者建档 → 门诊挂号 → 医生诊断 → 开药缴费 → 住院治疗 → 出院结算的完整闭环</p>
              </div>
            </div>
            <div class="feature-item">
              <i class="el-icon-check feature-icon"></i>
              <div class="feature-content">
                <h4>药品库存实时监控</h4>
                <p>药品入库、出库、库存预警、有效期管理，确保用药安全</p>
              </div>
            </div>
            <div class="feature-item">
              <i class="el-icon-check feature-icon"></i>
              <div class="feature-content">
                <h4>智能排班管理</h4>
                <p>医生、护士自动排班，支持门诊、住院、急诊多场景调度</p>
              </div>
            </div>
            <div class="feature-item">
              <i class="el-icon-check feature-icon"></i>
              <div class="feature-content">
                <h4>电子病历一体化</h4>
                <p>病历电子化存储、快速查询、数据共享，提升诊疗效率</p>
              </div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :xs="24" :sm="24" :md="12" :lg="12">
        <el-card shadow="never" class="module-feature-card">
          <div slot="header" class="card-header">
            <span class="header-title">
              <i class="el-icon-info"></i>
              功能模块
            </span>
          </div>
          <div class="modules-list">
            <div class="module-item">
              <el-tag type="success" size="small">患者管理</el-tag>
              <span>患者档案、就诊记录、病历管理、历史查询</span>
            </div>
            <div class="module-item">
              <el-tag type="success" size="small">门诊管理</el-tag>
              <span>门诊挂号、分诊叫号、医生排班、门诊收费</span>
            </div>
            <div class="module-item">
              <el-tag type="success" size="small">住院管理</el-tag>
              <span>病房管理、床位分配、医嘱管理、住院结算</span>
            </div>
            <div class="module-item">
              <el-tag type="success" size="small">药品管理</el-tag>
              <span>药品信息、采购入库、库存管理、药品预警</span>
            </div>
            <div class="module-item">
              <el-tag type="success" size="small">医生管理</el-tag>
              <span>医生信息、职称管理、诊疗权限、工作统计</span>
            </div>
            <div class="module-item">
              <el-tag type="success" size="small">收费管理</el-tag>
              <span>门诊收费、住院缴费、发票管理、财务统计</span>
            </div>
            <div class="module-item">
              <el-tag type="success" size="small">系统管理</el-tag>
              <span>用户权限、角色分配、数据字典、系统设置</span>
            </div>
            <div class="module-item">
              <el-tag type="success" size="small">报表统计</el-tag>
              <span>就诊统计、收入报表、药品消耗、科室分析</span>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>

  </div>
</template>

<script>
export default {
  name: "Index",
  data() {
    return {
      version: "1.0.0"
    }
  },
  methods: {
    goToModule(path) {
      this.$router.push(path)
    }
  }
}
</script>

<style scoped lang="scss">
.home {
  padding: 24px;
  background-color: #f5f7fa;
  min-height: calc(100vh - 84px);
  
  // 欢迎横幅
  .welcome-banner {
    margin-bottom: 24px;
    background: linear-gradient(135deg, #4facfe 0%, #00c6ff 100%);
    border: none;
    border-radius: 12px;
    overflow: hidden;
    
    ::v-deep .el-card__body {
      padding: 32px 40px;
    }
    
    .banner-content {
      display: flex;
      justify-content: space-between;
      align-items: center;
      color: #fff;
      
      .banner-left {
        flex: 1;
        
        h1 {
          font-size: 36px;
          font-weight: 700;
          margin: 0 0 16px 0;
          color: #fff;
          letter-spacing: 0.5px;
        }
        
        .banner-desc {
          font-size: 16px;
          line-height: 1.8;
          margin: 0 0 24px 0;
          color: rgba(255, 255, 255, 0.95);
        }
        
        .banner-tags {
          display: flex;
          flex-wrap: wrap;
          gap: 10px;
          margin-top: 0;
          
          .el-tag {
            border: none;
            font-weight: 500;
            padding: 8px 16px;
            font-size: 14px;
          }
        }
      }
      
      .banner-right {
        margin-left: 40px;
        
        .banner-icon {
          font-size: 140px;
          opacity: 0.25;
          color: #fff;
        }
      }
    }
  }
  
  // 功能模块卡片
  .module-cards {
    margin-bottom: 24px;
    
    .module-card {
      text-align: center;
      cursor: pointer;
      transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
      border: 1px solid #e4e7ed;
      border-radius: 12px;
      height: 100%;
      background-color: #ffffff;
      
      ::v-deep .el-card__body {
        padding: 32px 24px;
      }
      
      &:hover {
        transform: translateY(-8px);
        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
        border-color: #409eff;
      }
      
      .module-icon {
        width: 72px;
        height: 72px;
        margin: 0 auto 20px;
        border-radius: 16px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 32px;
        color: #fff;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        
        &.patient {
          background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        
        &.medicine {
          background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        }
        
        &.outpatient {
          background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
        }
        
        &.inpatient {
          background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
        }
      }
      
      h3 {
        margin: 0 0 12px 0;
        font-size: 20px;
        font-weight: 600;
        color: #303133;
      }
      
      p {
        margin: 0;
        font-size: 14px;
        color: #909399;
        line-height: 1.6;
      }
    }
  }
  
  // 特性区域
  .features-section {
    margin-bottom: 24px;
    
    .el-card {
      border-radius: 12px;
      border: 1px solid #e4e7ed;
      background-color: #ffffff;
      
      ::v-deep .el-card__header {
        padding: 20px 24px;
        border-bottom: 1px solid #e4e7ed;
        background: linear-gradient(135deg, #f5f7fa 0%, #ffffff 100%);
      }
      
      ::v-deep .el-card__body {
        padding: 24px;
      }
    }
    
    .card-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      
      .header-title {
        font-size: 18px;
        font-weight: 600;
        color: #303133;
        display: flex;
        align-items: center;
        gap: 10px;
        
        i {
          color: #409eff;
          font-size: 20px;
        }
      }
    }
    
    .features-list {
      .feature-item {
        display: flex;
        margin-bottom: 24px;
        padding: 16px;
        border-radius: 8px;
        background-color: #fafafa;
        transition: all 0.3s;
        
        &:hover {
          background-color: #f0f9ff;
          transform: translateX(4px);
        }
        
        &:last-child {
          margin-bottom: 0;
        }
        
        .feature-icon {
          color: #67c23a;
          font-size: 22px;
          margin-right: 16px;
          margin-top: 2px;
          flex-shrink: 0;
        }
        
        .feature-content {
          flex: 1;
          
          h4 {
            margin: 0 0 8px 0;
            font-size: 16px;
            font-weight: 600;
            color: #303133;
          }
          
          p {
            margin: 0;
            font-size: 14px;
            color: #606266;
            line-height: 1.7;
          }
        }
      }
    }
    
    .modules-list {
      .module-item {
        display: flex;
        align-items: center;
        margin-bottom: 16px;
        padding: 12px 16px;
        border-radius: 8px;
        background-color: #fafafa;
        transition: all 0.3s;
        
        &:hover {
          background-color: #f0f9ff;
          transform: translateX(4px);
        }
        
        &:last-child {
          margin-bottom: 0;
        }
        
        .el-tag {
          margin-right: 12px;
          min-width: 90px;
          font-weight: 500;
          border: none;
        }
        
        span {
          font-size: 14px;
          color: #606266;
          flex: 1;
          line-height: 1.6;
        }
      }
    }
  }
}

// 响应式设计
@media (max-width: 1200px) {
  .home {
    .welcome-banner {
      .banner-content {
        .banner-right {
          .banner-icon {
            font-size: 100px;
          }
        }
      }
    }
  }
}

@media (max-width: 768px) {
  .home {
    padding: 16px;
    
    .welcome-banner {
      ::v-deep .el-card__body {
        padding: 24px 20px;
      }
      
      .banner-content {
        flex-direction: column;
        text-align: center;
        
        .banner-left {
          h1 {
            font-size: 28px;
          }
          
          .banner-desc {
            font-size: 14px;
          }
        }
        
        .banner-right {
          margin-top: 20px;
          margin-left: 0;
          
          .banner-icon {
            font-size: 80px;
          }
        }
      }
    }
    
    .module-cards {
      .module-card {
        ::v-deep .el-card__body {
          padding: 24px 16px;
        }
        
        .module-icon {
          width: 60px;
          height: 60px;
          font-size: 28px;
        }
        
        h3 {
          font-size: 18px;
        }
      }
    }
  }
}
</style>