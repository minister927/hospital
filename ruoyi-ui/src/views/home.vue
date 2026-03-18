<template>
  <div class="app-container">
    <!-- 导航栏 -->
    <nav class="nav-container">
      <div class="nav-content">
        <div class="nav-logo">
          <i class="el-icon-medical-service nav-icon"></i>
          <span class="logo-text">智慧医疗管理系统</span>
        </div>
        <div class="nav-menu">
          <a href="#" class="menu-item">首页</a>
          <a href="#" class="menu-item">服务项目</a>
          <a href="#" class="menu-item">就医指南</a>
          <a href="#" class="menu-item">健康资讯</a>
          <a href="#" class="menu-item">关于我们</a>
          <div class="nav-search">
            <el-input v-model="searchText" placeholder="搜索服务/科室" class="search-input">
              <i slot="prefix" class="el-icon-search"></i>
            </el-input>
            <div class="user-area">
              <a v-if="!isAuthenticated" 
                href="javascript:void(0);" 
                class="login-btn" 
                @click="goToLogin">
                登录 / 注册
              </a>
              <div v-else class="user-info">
                <el-dropdown>
                  <span class="user-dropdown">
                    <el-avatar :size="32" src="https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png"></el-avatar>
                    <span class="user-name">{{ userName }}</span>
                    <i class="el-icon-arrow-down ml-1"></i>
                  </span>
                  <el-dropdown-menu slot="dropdown">
                    <el-dropdown-item @click.native="">个人中心</el-dropdown-item>
                    <el-dropdown-item divided @click.native="logout">退出登录</el-dropdown-item>
                  </el-dropdown-menu>
                </el-dropdown>
              </div>
            </div>
          </div>
        </div>
      </div>
    </nav>
    
    <!-- Hero轮播区域 -->
    <div class="hero-container">
      <el-carousel height="600px" :interval="5000" arrow="always" indicator-position="none">
        <el-carousel-item v-for="banner in banners" :key="banner.id">
          <div class="banner-item">
            <div 
              class="banner-bg" 
              :style="{ backgroundImage: `url('${banner.image}')` }"
            ></div>
            <div class="banner-mask">
              <div class="banner-content">
                <h1 class="banner-title">{{ banner.title }}</h1>
                <p class="banner-subtitle">{{ banner.subtitle }}</p>
                <a href="#" class="banner-btn">{{ banner.buttonText }}</a>
              </div>
            </div>
          </div>
        </el-carousel-item>
      </el-carousel>
    </div>
    
    <!-- 核心服务 -->
    <div class="services-container">
      <h2 class="section-title">核心服务</h2>
      <div class="services-list">
        <div 
          v-for="(service, index) in coreServices" 
          :key="service.id"
          class="service-card"
          :style="{ transitionDelay: `${index * 200}ms` }"
          @click=""
        >
          <div class="service-img-box">
            <img 
              :src="service.image" 
              :alt="service.name"
              class="service-img"
            >
            <div class="service-mask"></div>
            <div class="service-info">
              <h3 class="service-name">{{ service.name }}</h3>
              <p class="service-desc">{{ service.description }}</p>
            </div>
          </div>
        </div>
      </div>
    </div>
    
    <!-- 特色功能 -->
    <div class="features-container">
      <h2 class="section-title">特色功能</h2>
      <div class="features-list">
        <div 
          v-for="(feature, index) in features" 
          :key="index"
          class="feature-card"
          :style="{ transitionDelay: `${index * 200}ms` }"
        >
          <i :class="['feature-icon', 'el-icon-' + feature.icon]"></i>
          <h3 class="feature-title">{{ feature.title }}</h3>
          <p class="feature-desc">{{ feature.description }}</p>
        </div>
      </div>
    </div>
    
    <!-- 页脚 -->
    <footer class="footer-container">
      <div class="footer-content">
        <div class="footer-col">
          <h3 class="footer-title">关于我们</h3>
          <p class="footer-text">智慧医疗管理系统致力于为医疗机构提供高效、安全、便捷的数字化管理解决方案，提升医疗服务质量和效率。</p>
        </div>
        <div class="footer-col">
          <h3 class="footer-title">快速链接</h3>
          <ul class="footer-links">
            <li><a href="#" class="link-item">服务项目</a></li>
            <li><a href="#" class="link-item">就医指南</a></li>
            <li><a href="#" class="link-item">健康资讯</a></li>
            <li><a href="#" class="link-item">关于我们</a></li>
          </ul>
        </div>
        <div class="footer-col">
          <h3 class="footer-title">联系我们</h3>
          <ul class="contact-list">
            <li class="contact-item">
              <i class="el-icon-location"></i>
              <span class="contact-text">北京市海淀区中关村医疗科技园</span>
            </li>
            <li class="contact-item">
              <i class="el-icon-phone"></i>
              <span class="contact-text">400-123-4567</span>
            </li>
            <li class="contact-item">
              <i class="el-icon-chat-dot-round"></i>
              <span class="contact-text">service@medsys.com</span>
            </li>
          </ul>
        </div>
        <div class="footer-col">
          <h3 class="footer-title">关注我们</h3>
          <div class="social-icons">
            <i class="el-icon-share social-icon"></i>
            <i class="el-icon-chat-dot-round social-icon"></i>
            <i class="el-icon-link social-icon"></i>
          </div>
        </div>
      </div>
      <div class="copyright">
        <p>&copy; 2025 智慧医疗管理系统. 保留所有权利.</p>
      </div>
    </footer>
  </div>
</template>

<script>
export default {
  name: 'MedicalHome',
  data() {
    return {
      searchText: '',
      isAuthenticated: false,
      userName: '用户',
      // 轮播图数据
      banners: [
        {
          id: 1,
          image: require('@/assets/images/banner1.jpg'), 
          title: '智慧医疗 便捷就医',
          subtitle: '一站式医疗管理解决方案，让就医更简单',
          buttonText: '了解详情'
        },
        {
          id: 2,
          image: require('@/assets/images/banner2.jpg'), 
          title: '数字化诊疗管理',
          subtitle: '高效的诊疗流程管理，提升医疗服务效率',
          buttonText: '立即体验'
        },
        {
          id: 3,
          image: require('@/assets/images/banner3.jpg'), 
          title: '健康档案云端管理',
          subtitle: '安全存储个人健康数据，随时随地查看',
          buttonText: '免费注册'
        }
      ],
      // 核心服务数据
      coreServices: [
        {
          id: 1,
          name: '在线挂号',
          description: '无需排队，随时随地预约挂号',
          image: 'https://pic1.zhimg.com/v2-8e1990c0990c5c89e10d109998877777_r.jpg'
        },
        {
          id: 2,
          name: '电子病历',
          description: '数字化管理病历，方便快捷调阅',
          image: 'https://pic2.zhimg.com/v2-9e2889d10990c5c89e10d109998877777_r.jpg'
        },
        {
          id: 3,
          name: '远程问诊',
          description: '足不出户，享受专业医生在线诊疗',
          image: 'https://pic3.zhimg.com/v2-0e3778c0990c5c89e10d109998877777_r.jpg'
        },
        {
          id: 4,
          name: '健康资讯',
          description: '提高个人健康意识，守护您的健康',
          image: 'https://pic4.zhimg.com/v2-1e4667c0990c5c89e10d109998877777_r.jpg'
        }
      ],
      // 特色功能
      features: [
        {
          icon: 'user',
          title: '患者管理',
          description: '全面的患者信息管理，支持快速查询和更新患者档案'
        },
        {
          icon: 'calendar',
          title: '预约管理',
          description: '智能预约排期系统，优化医生资源配置，减少患者等待时间'
        },
        {
          icon: 'document',
          title: '病历管理',
          description: '电子病历数字化存储，支持多终端访问和数据共享'
        },
        {
          icon: 'medicine-box',
          title: '药品管理',
          description: '智能药品库存管理，自动提醒补货，避免药品短缺'
        },
        {
          icon: 'chart-line',
          title: '数据分析',
          description: '多维度医疗数据统计分析，为管理决策提供数据支撑'
        },
        {
          icon: 'shield',
          title: '隐私保护',
          description: '严格的医疗数据加密保护，符合国家医疗数据安全规范'
        }
      ]
    };
  },
  methods: {
    //跳转登录页面
    goToLogin() {
      this.$router.push('/userLogin');
      },
    // 退出登录（模拟）
    logout() {
      this.isAuthenticated = false;
      this.userName = '用户';
    }


  }
};
</script>

<style scoped>
/* 全局基础样式 */
.app-container {
  min-height: 100vh;
  background: #fff;
  overflow-x: hidden;
}

/* 导航栏样式 */
.nav-container {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  background: rgba(255, 255, 255, 0.95);
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
  z-index: 999;
  backdrop-filter: blur(8px);
  height: 64px;
  line-height: 64px;
}

.nav-content {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.nav-logo {
  display: flex;
  align-items: center;
  gap: 8px;
}

.nav-icon {
  font-size: 24px;
  color: #165DFF;
}

.logo-text {
  font-size: 18px;
  font-weight: 600;
  color: #165DFF;
}

.nav-menu {
  display: flex;
  align-items: center;
  gap: 32px;
}

.menu-item {
  color: #333;
  text-decoration: none;
  position: relative;
  transition: color 0.3s ease;
}

.menu-item:hover {
  color: #165DFF;
}

.menu-item::after {
  content: '';
  position: absolute;
  bottom: -4px;
  left: 0;
  width: 0;
  height: 2px;
  background-color: #165DFF;
  transition: width 0.3s ease;
}

.menu-item:hover::after {
  width: 100%;
}

.nav-search {
  display: flex;
  align-items: center;
  gap: 16px;
}

.search-input {
  width: 192px;
}

.login-btn {
  padding: 6px 16px;
  background: #165DFF;
  color: #fff;
  border-radius: 4px;
  text-decoration: none;
  white-space: nowrap;
  transition: all 0.2s ease;
}

.login-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.user-info {
  display: flex;
  align-items: center;
  gap: 12px;
}

.user-dropdown {
  display: flex;
  align-items: center;
  cursor: pointer;
}

.user-name {
  margin-left: 8px;
}

/* Hero轮播区域 */
.hero-container {
  margin-top: 64px;
  height: 600px;
}

.banner-item {
  position: relative;
  height: 100%;
}

.banner-bg {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-size: cover;
  background-position: center;
}

.banner-mask {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: linear-gradient(to right, rgba(0, 0, 0, 0.6), transparent);
  display: flex;
  align-items: center;
}

.banner-content {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
  color: #fff;
  max-width: 480px;
  animation: fadeInUp 1s ease-out;
}

.banner-title {
  font-size: 40px;
  font-weight: bold;
  margin-bottom: 24px;
  transition: transform 0.7s ease;
}

.banner-title:hover {
  transform: scale(1.05);
}

.banner-subtitle {
  font-size: 18px;
  margin-bottom: 32px;
  transition: transform 0.5s ease;
}

.banner-subtitle:hover {
  transform: translateX(8px);
}

.banner-btn {
  padding: 12px 32px;
  background: #165DFF;
  color: #fff;
  border-radius: 4px;
  text-decoration: none;
  font-size: 18px;
  white-space: nowrap;
  transition: all 0.2s ease;
}

.banner-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

/* 核心服务区域 */
.services-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 64px 20px;
}

.section-title {
  font-size: 28px;
  font-weight: bold;
  text-align: center;
  margin-bottom: 48px;
  color: #333;
}

.services-list {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 24px;
}

.service-card {
  opacity: 0;
  transform: translateY(48px);
  transition: all 0.7s ease;
  cursor: pointer;
}

.service-card {
  opacity: 1;
  transform: translateY(0);
}

.service-img-box {
  position: relative;
  height: 256px;
  border-radius: 8px;
  overflow: hidden;
  margin-bottom: 16px;
}

.service-img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.3s ease;
}

.service-card:hover .service-img {
  transform: scale(1.1);
}

.service-mask {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: linear-gradient(to top, rgba(0, 0, 0, 0.6), transparent);
}

.service-info {
  position: absolute;
  bottom: 16px;
  left: 16px;
  color: #fff;
}

.service-name {
  font-size: 18px;
  font-weight: 600;
  margin-bottom: 4px;
}

.service-desc {
  font-size: 14px;
  opacity: 0.9;
}

/* 特色功能区域 */
.features-container {
  background: #f5f5f5;
  padding: 64px 20px;
}

.features-container .section-title {
  max-width: 1200px;
  margin: 0 auto 48px;
}

.features-list {
  max-width: 1200px;
  margin: 0 auto;
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 32px;
}

.feature-card {
  background: #fff;
  padding: 32px;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
  text-align: center;
  transform: translateY(48px);
  opacity: 0;
  transition: all 0.7s ease;
}

.feature-card {
  opacity: 1;
  transform: translateY(0);
}

.feature-card:hover {
  transform: scale(1.05);
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
}

.feature-icon {
  font-size: 36px;
  color: #165DFF;
  margin-bottom: 16px;
  transition: transform 0.3s ease;
}

.feature-card:hover .feature-icon {
  transform: translateY(-10px);
}

.feature-title {
  font-size: 18px;
  font-weight: 600;
  margin-bottom: 16px;
}

.feature-desc {
  color: #666;
  line-height: 1.6;
}

/* 页脚样式 */
.footer-container {
  background: #1f1f1f;
  color: #ccc;
  padding: 48px 20px;
}

.footer-content {
  max-width: 1200px;
  margin: 0 auto;
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 32px;
  margin-bottom: 32px;
}

.footer-title {
  font-size: 18px;
  font-weight: 600;
  color: #fff;
  margin-bottom: 16px;
}

.footer-text {
  font-size: 14px;
  line-height: 1.6;
}

.footer-links {
  list-style: none;
  padding: 0;
  margin: 0;
}

.link-item {
  color: #ccc;
  text-decoration: none;
  line-height: 2;
  transition: color 0.3s ease;
}

.link-item:hover {
  color: #fff;
}

.contact-list {
  list-style: none;
  padding: 0;
  margin: 0;
}

.contact-item {
  display: flex;
  align-items: center;
  margin-bottom: 8px;
}

.contact-text {
  margin-left: 8px;
  font-size: 14px;
}

.social-icons {
  display: flex;
  gap: 16px;
}

.social-icon {
  font-size: 24px;
  cursor: pointer;
  transition: color 0.3s ease;
}

.social-icon:hover {
  color: #fff;
}

.copyright {
  max-width: 1200px;
  margin: 0 auto;
  padding-top: 32px;
  border-top: 1px solid #333;
  text-align: center;
  font-size: 14px;
}

/* 动画 */
@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* 响应式适配 */
@media (max-width: 992px) {
  .services-list {
    grid-template-columns: repeat(2, 1fr);
  }
  .features-list {
    grid-template-columns: repeat(2, 1fr);
  }
  .footer-content {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (max-width: 576px) {
  .nav-menu {
    gap: 16px;
  }
  .search-input {
    width: 120px;
  }
  .services-list {
    grid-template-columns: 1fr;
  }
  .features-list {
    grid-template-columns: 1fr;
  }
  .footer-content {
    grid-template-columns: 1fr;
  }
  .banner-title {
    font-size: 28px;
  }
  .banner-subtitle {
    font-size: 16px;
  }
}
</style>