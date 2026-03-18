/*
 Navicat Premium Data Transfer

 Source Server         : mywork
 Source Server Type    : MySQL
 Source Server Version : 80043 (8.0.43)
 Source Host           : localhost:3306
 Source Schema         : hospital

 Target Server Type    : MySQL
 Target Server Version : 80043 (8.0.43)
 File Encoding         : 65001

 Date: 10/03/2026 09:04:14
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ch_appointment
-- ----------------------------
DROP TABLE IF EXISTS `ch_appointment`;
CREATE TABLE `ch_appointment`  (
  `appointment_id` bigint NOT NULL AUTO_INCREMENT COMMENT '预约ID',
  `appointment_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '预约号',
  `patient_id` bigint NOT NULL COMMENT '患者ID',
  `staff_id` bigint NOT NULL COMMENT '医生ID',
  `schedule_id` bigint NOT NULL COMMENT '排班ID',
  `dept_id` bigint NOT NULL COMMENT '科室ID',
  `appointment_date` date NOT NULL COMMENT '预约日期',
  `time_slot` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '时间段',
  `appointment_time` datetime NOT NULL COMMENT '预约时间',
  `queue_number` int NULL DEFAULT NULL COMMENT '排队号',
  `symptoms` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '症状描述',
  `source` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'online' COMMENT '来源（online线上 offline线下）',
  `fee` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '挂号费',
  `payment_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '缴费状态（0未付 1已付）',
  `appointment_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'pending' COMMENT '预约状态（pending待确认 confirmed已确认 completed已完成 cancelled已取消 no_show未就诊）',
  `cancel_reason` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '取消原因',
  `arrive_time` datetime NULL DEFAULT NULL COMMENT '到院时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`appointment_id`) USING BTREE,
  UNIQUE INDEX `idx_appointment_no`(`appointment_no` ASC) USING BTREE,
  INDEX `idx_patient_id`(`patient_id` ASC) USING BTREE,
  INDEX `idx_staff_id`(`staff_id` ASC) USING BTREE,
  INDEX `idx_schedule_id`(`schedule_id` ASC) USING BTREE,
  INDEX `idx_dept_id`(`dept_id` ASC) USING BTREE,
  INDEX `idx_appointment_date`(`appointment_date` ASC) USING BTREE,
  INDEX `idx_appointment_status`(`appointment_status` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE,
  INDEX `idx_appointment_composite`(`patient_id` ASC, `appointment_date` ASC, `appointment_status` ASC) USING BTREE,
  INDEX `idx_appointment_doctor_date`(`staff_id` ASC, `appointment_date` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4001 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '预约挂号表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ch_appointment
-- ----------------------------
INSERT INTO `ch_appointment` VALUES (4000, '1', 1, 1, 1, 1, '2026-03-10', '1', '2026-03-10 00:00:00', 1, '1', '1', 1.00, '0', 'confirmed', NULL, '2026-03-10 00:00:00', '2026-03-09 11:41:02', '2026-03-10 08:50:52');

-- ----------------------------
-- Table structure for ch_charge_detail
-- ----------------------------
DROP TABLE IF EXISTS `ch_charge_detail`;
CREATE TABLE `ch_charge_detail`  (
  `detail_id` bigint NOT NULL AUTO_INCREMENT COMMENT '明细ID',
  `charge_id` bigint NOT NULL COMMENT '收费ID',
  `item_id` bigint NULL DEFAULT NULL COMMENT '收费项目ID',
  `item_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '项目名称',
  `item_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '项目类型',
  `quantity` int NOT NULL DEFAULT 1 COMMENT '数量',
  `unit_price` decimal(10, 2) NOT NULL COMMENT '单价',
  `subtotal` decimal(10, 2) NOT NULL COMMENT '小计',
  `medical_insurance_amount` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '医保报销金额',
  `self_pay_amount` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '自付金额',
  `notes` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`detail_id`) USING BTREE,
  INDEX `idx_charge_id`(`charge_id` ASC) USING BTREE,
  INDEX `idx_item_id`(`item_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12000 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '收费明细表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ch_charge_detail
-- ----------------------------

-- ----------------------------
-- Table structure for ch_charge_item
-- ----------------------------
DROP TABLE IF EXISTS `ch_charge_item`;
CREATE TABLE `ch_charge_item`  (
  `item_id` bigint NOT NULL AUTO_INCREMENT COMMENT '项目ID',
  `item_code` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '项目编码',
  `item_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '项目名称',
  `item_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'medicine' COMMENT '类型（medicine药品 service服务 check检查）',
  `unit` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '单位',
  `price` decimal(10, 2) NOT NULL COMMENT '单价',
  `medical_insurance` tinyint(1) NULL DEFAULT 1 COMMENT '是否医保项目',
  `insurance_ratio` decimal(5, 2) NULL DEFAULT 1.00 COMMENT '医保报销比例',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`item_id`) USING BTREE,
  UNIQUE INDEX `idx_item_code`(`item_code` ASC) USING BTREE,
  INDEX `idx_item_type`(`item_type` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10006 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '收费项目表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ch_charge_item
-- ----------------------------
INSERT INTO `ch_charge_item` VALUES (10001, 'REG_FEE', '普通挂号费', 'service', '次', 10.00, 1, 0.80, '0', '', '2026-01-27 19:13:33', '', NULL);
INSERT INTO `ch_charge_item` VALUES (10002, 'EXPERT_FEE', '专家挂号费', 'service', '次', 30.00, 1, 0.50, '0', '', '2026-01-27 19:13:33', '', NULL);
INSERT INTO `ch_charge_item` VALUES (10003, 'BLOOD_TEST', '血常规检查', 'check', '次', 25.00, 1, 0.90, '0', '', '2026-01-27 19:13:33', '', NULL);
INSERT INTO `ch_charge_item` VALUES (10004, 'URINE_TEST', '尿常规检查', 'check', '次', 15.00, 1, 0.90, '0', '', '2026-01-27 19:13:33', '', NULL);
INSERT INTO `ch_charge_item` VALUES (10005, 'ECG', '心电图', 'check', '次', 40.00, 1, 0.85, '0', '', '2026-01-27 19:13:33', '', NULL);

-- ----------------------------
-- Table structure for ch_charge_record
-- ----------------------------
DROP TABLE IF EXISTS `ch_charge_record`;
CREATE TABLE `ch_charge_record`  (
  `charge_id` bigint NOT NULL AUTO_INCREMENT COMMENT '收费ID',
  `charge_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '收费单号',
  `patient_id` bigint NOT NULL COMMENT '患者ID',
  `prescription_id` bigint NULL DEFAULT NULL COMMENT '关联处方ID',
  `appointment_id` bigint NULL DEFAULT NULL COMMENT '关联预约ID',
  `total_amount` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '总金额',
  `medical_insurance_amount` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '医保报销金额',
  `self_pay_amount` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '自付金额',
  `payment_method` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'cash' COMMENT '支付方式（cash现金 card刷卡 wechat微信 alipay支付宝）',
  `payment_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'unpaid' COMMENT '支付状态（unpaid未支付 paid已支付 refunded已退款）',
  `payer_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '缴费人姓名',
  `operator_id` bigint NULL DEFAULT NULL COMMENT '操作员ID',
  `charge_time` datetime NULL DEFAULT NULL COMMENT '收费时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`charge_id`) USING BTREE,
  UNIQUE INDEX `idx_charge_no`(`charge_no` ASC) USING BTREE,
  INDEX `idx_patient_id`(`patient_id` ASC) USING BTREE,
  INDEX `idx_prescription_id`(`prescription_id` ASC) USING BTREE,
  INDEX `idx_appointment_id`(`appointment_id` ASC) USING BTREE,
  INDEX `idx_charge_time`(`charge_time` ASC) USING BTREE,
  INDEX `idx_payment_status`(`payment_status` ASC) USING BTREE,
  INDEX `idx_charge_composite`(`patient_id` ASC, `payment_status` ASC, `charge_time` ASC) USING BTREE,
  INDEX `idx_charge_payment`(`payment_method` ASC, `payment_status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11000 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '收费记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ch_charge_record
-- ----------------------------

-- ----------------------------
-- Table structure for ch_department
-- ----------------------------
DROP TABLE IF EXISTS `ch_department`;
CREATE TABLE `ch_department`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '科室ID',
  `dept_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '科室编码',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '科室名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父科室ID',
  `dept_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'clinical' COMMENT '科室类型（clinical临床科室 pharmacy药房 check检验科）',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '科室负责人',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '科室状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dept_id`) USING BTREE,
  UNIQUE INDEX `idx_dept_code`(`dept_code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 106 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '科室信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ch_department
-- ----------------------------
INSERT INTO `ch_department` VALUES (100, 'GP', '全科门诊', 0, 'clinical', NULL, NULL, NULL, 1, '0', '0', '', '2026-01-27 19:13:33', '', NULL, NULL);
INSERT INTO `ch_department` VALUES (101, 'SURGERY', '外科', 0, 'clinical', NULL, NULL, NULL, 2, '0', '0', '', '2026-01-27 19:13:33', '', NULL, NULL);
INSERT INTO `ch_department` VALUES (102, 'PEDIATRICS', '儿科', 0, 'clinical', NULL, NULL, NULL, 3, '0', '0', '', '2026-01-27 19:13:33', '', NULL, NULL);
INSERT INTO `ch_department` VALUES (103, 'GYNECOLOGY', '妇科', 0, 'clinical', NULL, NULL, NULL, 4, '0', '0', '', '2026-01-27 19:13:33', '', NULL, NULL);
INSERT INTO `ch_department` VALUES (104, 'PHARMACY', '药房', 0, 'pharmacy', NULL, NULL, NULL, 5, '0', '0', '', '2026-01-27 19:13:33', '', NULL, NULL);
INSERT INTO `ch_department` VALUES (105, 'CHECK', '检验科', 0, 'check', NULL, NULL, NULL, 6, '0', '0', '', '2026-01-27 19:13:33', '', NULL, NULL);

-- ----------------------------
-- Table structure for ch_examination
-- ----------------------------
DROP TABLE IF EXISTS `ch_examination`;
CREATE TABLE `ch_examination`  (
  `exam_id` bigint NOT NULL AUTO_INCREMENT COMMENT '检查ID',
  `exam_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '检查单号',
  `patient_id` bigint NOT NULL COMMENT '患者ID',
  `staff_id` bigint NOT NULL COMMENT '申请医生ID',
  `exam_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '检查类型',
  `exam_items` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '检查项目',
  `clinical_diagnosis` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '临床诊断',
  `request_time` datetime NOT NULL COMMENT '申请时间',
  `exam_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'pending' COMMENT '状态（pending待检查 completed已完成）',
  `result` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '检查结果',
  `result_time` datetime NULL DEFAULT NULL COMMENT '结果时间',
  `operator_id` bigint NULL DEFAULT NULL COMMENT '操作员ID',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`exam_id`) USING BTREE,
  UNIQUE INDEX `idx_exam_no`(`exam_no` ASC) USING BTREE,
  INDEX `idx_patient_id`(`patient_id` ASC) USING BTREE,
  INDEX `idx_exam_status`(`exam_status` ASC) USING BTREE,
  INDEX `idx_request_time`(`request_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13000 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '检查检验表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ch_examination
-- ----------------------------

-- ----------------------------
-- Table structure for ch_medical_record
-- ----------------------------
DROP TABLE IF EXISTS `ch_medical_record`;
CREATE TABLE `ch_medical_record`  (
  `record_id` bigint NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `record_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '病历号',
  `patient_id` bigint NOT NULL COMMENT '患者ID → 关联ch_patient.patient_id',
  `staff_id` bigint NOT NULL COMMENT '医生ID → 关联ch_staff.staff_id',
  `appointment_id` bigint NULL DEFAULT NULL COMMENT '关联预约ID → 关联ch_appointment.appointment_id',
  `prescription_id` bigint NULL DEFAULT NULL COMMENT '关联处方ID → 关联ch_prescription.prescription_id',
  `exam_id` bigint NULL DEFAULT NULL COMMENT '关联检查ID → 关联ch_examination.exam_id',
  `charge_id` bigint NULL DEFAULT NULL COMMENT '关联收费ID → 关联ch_charge_record.charge_id',
  `visit_date` date NOT NULL COMMENT '就诊日期',
  `visit_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'outpatient' COMMENT '就诊类型（outpatient门诊 inpatient住院）',
  `chief_complaint` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主诉',
  `present_illness` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '现病史',
  `past_history` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '既往史',
  `allergy_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '过敏信息',
  `physical_exam` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '体格检查',
  `auxiliary_exam` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '辅助检查',
  `preliminary_diagnosis` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '初步诊断',
  `final_diagnosis` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '最终诊断',
  `treatment_plan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '治疗方案',
  `medical_advice` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '医嘱',
  `revisit_date` date NULL DEFAULT NULL COMMENT '复诊日期',
  `record_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'draft' COMMENT '状态（draft草稿 completed完成）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`record_id`) USING BTREE,
  UNIQUE INDEX `idx_record_no`(`record_no` ASC) USING BTREE,
  INDEX `fk_medical_record_appointment`(`appointment_id` ASC) USING BTREE,
  INDEX `fk_medical_record_prescription`(`prescription_id` ASC) USING BTREE,
  INDEX `fk_medical_record_exam`(`exam_id` ASC) USING BTREE,
  INDEX `fk_medical_record_charge`(`charge_id` ASC) USING BTREE,
  INDEX `idx_medical_record_patient`(`patient_id` ASC, `visit_date` ASC) USING BTREE,
  INDEX `idx_medical_record_staff`(`staff_id` ASC, `visit_date` ASC) USING BTREE,
  INDEX `idx_medical_record_status`(`record_status` ASC) USING BTREE,
  CONSTRAINT `fk_medical_record_appointment` FOREIGN KEY (`appointment_id`) REFERENCES `ch_appointment` (`appointment_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_medical_record_charge` FOREIGN KEY (`charge_id`) REFERENCES `ch_charge_record` (`charge_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_medical_record_exam` FOREIGN KEY (`exam_id`) REFERENCES `ch_examination` (`exam_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_medical_record_patient` FOREIGN KEY (`patient_id`) REFERENCES `ch_patient` (`patient_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_medical_record_prescription` FOREIGN KEY (`prescription_id`) REFERENCES `ch_prescription` (`prescription_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_medical_record_staff` FOREIGN KEY (`staff_id`) REFERENCES `ch_staff` (`staff_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 5000 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '就诊记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ch_medical_record
-- ----------------------------

-- ----------------------------
-- Table structure for ch_medicine
-- ----------------------------
DROP TABLE IF EXISTS `ch_medicine`;
CREATE TABLE `ch_medicine`  (
  `medicine_id` bigint NOT NULL AUTO_INCREMENT COMMENT '药品ID',
  `medicine_code` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '药品编码',
  `medicine_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '药品名称',
  `specification` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '规格',
  `category_id` bigint NULL DEFAULT NULL COMMENT '分类ID',
  `manufacturer` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生产厂家',
  `approval_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '批准文号',
  `is_prescription` tinyint(1) NULL DEFAULT 1 COMMENT '是否处方药（0否 1是）',
  `purchase_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '采购价',
  `sale_price` decimal(10, 2) NOT NULL COMMENT '销售价',
  `stock_warning` int NULL DEFAULT 10 COMMENT '库存预警',
  `validity_period` int NULL DEFAULT NULL COMMENT '有效期（月）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`medicine_id`, `status`) USING BTREE,
  UNIQUE INDEX `idx_medicine_code`(`medicine_code` ASC) USING BTREE,
  INDEX `idx_medicine_name`(`medicine_name` ASC) USING BTREE,
  INDEX `idx_category_id`(`category_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE,
  INDEX `idx_medicine_composite`(`medicine_name` ASC, `category_id` ASC, `status` ASC) USING BTREE,
  INDEX `idx_medicine_price`(`sale_price` ASC) USING BTREE,
  INDEX `medicine_id`(`medicine_id` ASC) USING BTREE,
  CONSTRAINT `ch-medicine_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `ch_medicine_category` (`category_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6005 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '药品信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ch_medicine
-- ----------------------------
INSERT INTO `ch_medicine` VALUES (6000, 'MED001', '阿莫西林胶囊', '0.25g*24粒/盒', 1, '华北制药股份有限公司', '国药准字H13021234', 1, 8.50, 15.80, 20, 24, '0', 'admin', '2026-01-27 20:49:17', 'admin', '2026-01-27 20:49:17', '广谱抗生素，用于敏感菌所致感染');
INSERT INTO `ch_medicine` VALUES (6001, 'MED002', '布洛芬缓释胶囊', '0.3g*20粒/盒', 2, '中美天津史克制药有限公司', '国药准字H10900089', 1, 12.30, 25.60, 30, 36, '0', 'admin', '2026-01-27 20:49:17', 'admin', '2026-01-27 20:49:17', '非甾体抗炎药，用于缓解轻至中度疼痛');
INSERT INTO `ch_medicine` VALUES (6002, 'MED003', '复方甘草片', '100片/瓶', 3, '北京同仁堂科技发展有限公司', '国药准字Z11020356', 0, 6.80, 12.50, 50, 24, '0', 'admin', '2026-01-27 20:49:17', 'admin', '2026-01-27 20:49:17', '镇咳祛痰药，用于咳嗽多痰');
INSERT INTO `ch_medicine` VALUES (6003, 'MED004', '奥美拉唑肠溶胶囊', '20mg*14粒/盒', 4, '阿斯利康制药有限公司', '国药准字J20171098', 1, 25.40, 48.90, 15, 36, '0', 'admin', '2026-01-27 20:49:17', 'admin', '2026-01-28 10:39:18', '质子泵抑制剂，用于胃溃疡、反流性食管炎');
INSERT INTO `ch_medicine` VALUES (6004, 'MED005', '云南白药创可贴', '100片/盒', 5, '云南白药集团股份有限公司', '国药准字Z53020799', 0, 19.90, 35.00, 100, 36, '0', 'admin', '2026-01-27 20:49:17', 'admin', '2026-01-28 10:29:46', '止血镇痛，用于小面积开放性外科创伤');

-- ----------------------------
-- Table structure for ch_medicine_category
-- ----------------------------
DROP TABLE IF EXISTS `ch_medicine_category`;
CREATE TABLE `ch_medicine_category`  (
  `category_id` bigint NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `category_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类编码',
  `category_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类名称',
  `parent_id` bigint NULL DEFAULT NULL COMMENT '父分类ID',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`category_id`) USING BTREE,
  UNIQUE INDEX `idx_category_code`(`category_code` ASC) USING BTREE,
  INDEX `medicine_category_ibfk_1`(`parent_id` ASC) USING BTREE,
  CONSTRAINT `medicine_category_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `ch_medicine_category` (`category_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '药品分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ch_medicine_category
-- ----------------------------
INSERT INTO `ch_medicine_category` VALUES (1, 'ANTIBIOTIC', '抗生素类', NULL, '0', '', '2026-01-27 19:13:33', '', '2026-01-28 10:48:03');
INSERT INTO `ch_medicine_category` VALUES (2, 'ANALGESIC', '镇痛药', NULL, '0', '', '2026-01-27 19:13:33', '', NULL);
INSERT INTO `ch_medicine_category` VALUES (3, 'CARDIOVASCULAR', '心血管类', NULL, '0', '', '2026-01-27 19:13:33', '', NULL);
INSERT INTO `ch_medicine_category` VALUES (4, 'RESPIRATORY', '呼吸系统类', NULL, '0', '', '2026-01-27 19:13:33', '', NULL);
INSERT INTO `ch_medicine_category` VALUES (5, 'DIGESTIVE', '消化系统类', NULL, '0', '', '2026-01-27 19:13:33', '', NULL);
INSERT INTO `ch_medicine_category` VALUES (6, 'EXTERNAL', '外用药', NULL, '0', '', '2026-01-27 19:13:33', '', NULL);

-- ----------------------------
-- Table structure for ch_medicine_stock
-- ----------------------------
DROP TABLE IF EXISTS `ch_medicine_stock`;
CREATE TABLE `ch_medicine_stock`  (
  `stock_id` bigint NOT NULL AUTO_INCREMENT COMMENT '库存ID',
  `medicine_id` bigint NOT NULL COMMENT '药品ID',
  `batch_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '批次号',
  `production_date` date NULL DEFAULT NULL COMMENT '生产日期',
  `expiry_date` date NOT NULL COMMENT '有效期至',
  `quantity` int NOT NULL DEFAULT 0 COMMENT '库存数量',
  `available_quantity` int NULL DEFAULT 0 COMMENT '可用数量',
  `purchase_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '采购单价',
  `supplier` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '供应商',
  `storage_location` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '存放位置',
  `stock_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'normal' COMMENT '状态（normal正常 expiring临期 expired过期）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`stock_id`) USING BTREE,
  UNIQUE INDEX `idx_batch`(`medicine_id` ASC, `batch_no` ASC) USING BTREE,
  INDEX `idx_medicine_id`(`medicine_id` ASC) USING BTREE,
  INDEX `idx_expiry_date`(`expiry_date` ASC) USING BTREE,
  INDEX `idx_stock_status`(`stock_status` ASC) USING BTREE,
  INDEX `idx_stock_expiry`(`expiry_date` ASC, `stock_status` ASC) USING BTREE,
  CONSTRAINT `medicine_ibfk_1` FOREIGN KEY (`medicine_id`) REFERENCES `ch_medicine` (`medicine_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7001 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '药品库存表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ch_medicine_stock
-- ----------------------------
INSERT INTO `ch_medicine_stock` VALUES (7000, 6000, '2312', '2026-01-05', '2026-01-07', 1090, 1090, 122.00, '无', '无', 'normal', '', '2026-01-28 09:44:50', '', NULL);

-- ----------------------------
-- Table structure for ch_notification
-- ----------------------------
DROP TABLE IF EXISTS `ch_notification`;
CREATE TABLE `ch_notification`  (
  `notify_id` bigint NOT NULL AUTO_INCREMENT COMMENT '通知ID',
  `user_id` bigint NOT NULL COMMENT '接收用户ID',
  `notify_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '通知类型（appointment预约 remind提醒 system系统）',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '内容',
  `related_id` bigint NULL DEFAULT NULL COMMENT '关联业务ID',
  `is_read` tinyint(1) NULL DEFAULT 0 COMMENT '是否已读（0未读 1已读）',
  `send_time` datetime NULL DEFAULT NULL COMMENT '发送时间',
  `read_time` datetime NULL DEFAULT NULL COMMENT '读取时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`notify_id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_notify_type`(`notify_type` ASC) USING BTREE,
  INDEX `idx_is_read`(`is_read` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14000 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '消息通知表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ch_notification
-- ----------------------------

-- ----------------------------
-- Table structure for ch_patient
-- ----------------------------
DROP TABLE IF EXISTS `ch_patient`;
CREATE TABLE `ch_patient`  (
  `patient_id` bigint NOT NULL AUTO_INCREMENT COMMENT '患者ID',
  `user_id` bigint NOT NULL COMMENT '关联用户ID',
  `patient_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '患者编号',
  `id_card` varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '身份证号',
  `gender` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '性别（0男 1女 2未知）',
  `birth_date` date NULL DEFAULT NULL COMMENT '出生日期',
  `age` int NULL DEFAULT NULL COMMENT '年龄',
  `blood_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '血型',
  `marriage_status` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '婚姻状况',
  `occupation` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '职业',
  `nation` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '民族',
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '现住址',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `allergy_history` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '过敏史',
  `chronic_disease` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '慢性病史',
  `family_history` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '家族病史',
  `insurance_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '医保卡号',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '患者状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`patient_id`) USING BTREE,
  UNIQUE INDEX `idx_patient_no`(`patient_no` ASC) USING BTREE,
  UNIQUE INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  UNIQUE INDEX `idx_id_card`(`id_card` ASC) USING BTREE,
  INDEX `idx_phone`(`phone` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE,
  INDEX `idx_patient_name`(`patient_no` ASC, `patient_id` ASC) USING BTREE,
  INDEX `idx_patient_birth`(`birth_date` ASC) USING BTREE,
  INDEX `idx_patient_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1000 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '患者信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ch_patient
-- ----------------------------

-- ----------------------------
-- Table structure for ch_prescription
-- ----------------------------
DROP TABLE IF EXISTS `ch_prescription`;
CREATE TABLE `ch_prescription`  (
  `prescription_id` bigint NOT NULL AUTO_INCREMENT COMMENT '处方ID',
  `prescription_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '处方号',
  `patient_id` bigint NOT NULL COMMENT '患者ID',
  `staff_id` bigint NOT NULL COMMENT '开方医生ID',
  `record_id` bigint NULL DEFAULT NULL COMMENT '关联病历ID',
  `diagnosis` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '诊断',
  `usage_instructions` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '用法用量说明',
  `total_amount` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '总金额',
  `prescription_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'common' COMMENT '处方类型（common普通 emergency急诊）',
  `prescription_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'unfilled' COMMENT '状态（unfilled未取药 filled已取药 dispensed已发药 cancelled已退药）',
  `dispense_time` datetime NULL DEFAULT NULL COMMENT '发药时间',
  `dispenser_id` bigint NULL DEFAULT NULL COMMENT '发药人ID',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`prescription_id`) USING BTREE,
  UNIQUE INDEX `idx_prescription_no`(`prescription_no` ASC) USING BTREE,
  INDEX `idx_patient_id`(`patient_id` ASC) USING BTREE,
  INDEX `idx_staff_id`(`staff_id` ASC) USING BTREE,
  INDEX `idx_record_id`(`record_id` ASC) USING BTREE,
  INDEX `idx_prescription_status`(`prescription_status` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE,
  INDEX `idx_prescription_composite`(`patient_id` ASC, `prescription_status` ASC, `create_time` ASC) USING BTREE,
  INDEX `idx_prescription_doctor`(`staff_id` ASC, `create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8000 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '处方表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ch_prescription
-- ----------------------------

-- ----------------------------
-- Table structure for ch_prescription_detail
-- ----------------------------
DROP TABLE IF EXISTS `ch_prescription_detail`;
CREATE TABLE `ch_prescription_detail`  (
  `detail_id` bigint NOT NULL AUTO_INCREMENT COMMENT '明细ID',
  `prescription_id` bigint NOT NULL COMMENT '处方ID',
  `medicine_id` bigint NOT NULL COMMENT '药品ID',
  `quantity` int NOT NULL COMMENT '数量',
  `dosage` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '单次剂量',
  `frequency` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '频次',
  `days` int NULL DEFAULT NULL COMMENT '天数',
  `total_quantity` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '总用量',
  `usage_method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用法',
  `unit_price` decimal(10, 2) NOT NULL COMMENT '单价',
  `subtotal` decimal(10, 2) NOT NULL COMMENT '小计',
  `notes` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`detail_id`) USING BTREE,
  INDEX `idx_prescription_id`(`prescription_id` ASC) USING BTREE,
  INDEX `idx_medicine_id`(`medicine_id` ASC) USING BTREE,
  INDEX `idx_create_time`(`detail_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9000 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '处方明细表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ch_prescription_detail
-- ----------------------------

-- ----------------------------
-- Table structure for ch_schedule
-- ----------------------------
DROP TABLE IF EXISTS `ch_schedule`;
CREATE TABLE `ch_schedule`  (
  `schedule_id` bigint NOT NULL AUTO_INCREMENT COMMENT '排班ID',
  `staff_id` bigint NOT NULL COMMENT '医生ID',
  `schedule_date` date NOT NULL COMMENT '排班日期',
  `time_slot` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '时间段（morning上午 afternoon下午 night夜班）',
  `room_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '诊室号',
  `max_patients` int NULL DEFAULT 20 COMMENT '最大接诊人数',
  `current_patients` int NULL DEFAULT 0 COMMENT '当前预约人数',
  `schedule_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'normal' COMMENT '排班类型（normal普通 expert专家）',
  `fee` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '挂号费',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0可预约 1已满 2停诊）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`schedule_id`) USING BTREE,
  UNIQUE INDEX `idx_schedule_unique`(`staff_id` ASC, `schedule_date` ASC, `time_slot` ASC) USING BTREE,
  INDEX `idx_schedule_date`(`schedule_date` ASC) USING BTREE,
  INDEX `idx_staff_id`(`staff_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3001 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '医生排班表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ch_schedule
-- ----------------------------
INSERT INTO `ch_schedule` VALUES (3000, 1, '2026-02-04', '2323', '2323', 323, 323, 'normal', 32.00, '0', '', '2026-02-25 17:22:22', '', NULL);

-- ----------------------------
-- Table structure for ch_staff
-- ----------------------------
DROP TABLE IF EXISTS `ch_staff`;
CREATE TABLE `ch_staff`  (
  `staff_id` bigint NOT NULL AUTO_INCREMENT COMMENT '员工ID',
  `user_id` bigint NOT NULL COMMENT '关联用户ID',
  `staff_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '工号',
  `staff_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '姓名',
  `gender` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '性别（0男 1女）',
  `birth_date` date NULL DEFAULT NULL COMMENT '出生日期',
  `id_card` varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '身份证号',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '所属科室',
  `staff_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'doctor' COMMENT '员工类型（doctor医生 nurse护士 pharmacist药师 technician技师）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0在职 1休假 2离职）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`staff_id`) USING BTREE,
  UNIQUE INDEX `idx_staff_no`(`staff_no` ASC) USING BTREE,
  UNIQUE INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_dept_id`(`dept_id` ASC) USING BTREE,
  INDEX `idx_staff_type`(`staff_type` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2000 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '医护人员信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ch_staff
-- ----------------------------
INSERT INTO `ch_staff` VALUES (1001, 2001, 'DOC001', '张明', '0', '1985-03-15', '110101198503154512', '13800138001', 'zhangming@hospital.com', 101, 'doctor', '0', 'admin', NULL, '', NULL, '心血管科主任医师');
INSERT INTO `ch_staff` VALUES (1003, 2003, 'DOC003', '王强', '0', '1988-11-30', '110101198811305634', '13800138003', 'wangqiang@hospital.com', 103, 'doctor', '1', 'admin', NULL, '', NULL, '骨科医生，目前在休假');

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (4, 'ch_medicine', '药品信息表', '', '', 'ChMedicine', 'crud', 'element-ui', 'com.ruoyi.hospital', 'hospital', 'medicine', '药品信息', 'ruoyi', '0', '/', '{\"treeCode\":\"category_id\",\"parentMenuId\":2029}', 'admin', '2026-01-27 20:05:15', '', '2026-01-27 21:38:05', NULL);
INSERT INTO `gen_table` VALUES (5, 'ch_medicine_category', '药品分类表', NULL, NULL, 'ChMedicineCategory', 'crud', 'element-ui', 'com.ruoyi.hospital', 'hospital', 'category', '药品分类', 'ruoyi', '0', '/', '{\"parentMenuId\":2030}', 'admin', '2026-01-27 21:36:49', '', '2026-01-27 21:55:08', NULL);
INSERT INTO `gen_table` VALUES (6, 'ch_medicine_stock', '药品库存表', NULL, NULL, 'ChMedicineStock', 'crud', 'element-ui', 'com.ruoyi.hospital', 'hospital', 'stock', '药品库存', 'ruoyi', '0', '/', '{\"parentMenuId\":2031}', 'admin', '2026-01-27 21:52:47', '', '2026-01-28 09:37:40', NULL);
INSERT INTO `gen_table` VALUES (7, 'ch_staff', '医护人员信息表', NULL, NULL, 'ChStaff', 'crud', 'element-ui', 'com.ruoyi.hospital', 'doctor', 'info', '医护人员信息', 'ruoyi', '0', '/', '{\"parentMenuId\":2046}', 'admin', '2026-01-28 14:39:41', '', '2026-01-28 14:46:27', NULL);
INSERT INTO `gen_table` VALUES (8, 'ch_schedule', '医生排班表', NULL, NULL, 'ChSchedule', 'crud', 'element-ui', 'com.ruoyi.system', 'system', 'schedule', '医生排班', 'ruoyi', '0', '/', '{}', 'admin', '2026-01-28 15:16:42', '', '2026-01-28 15:17:18', NULL);
INSERT INTO `gen_table` VALUES (9, 'ch_medical_record', '就诊记录表', NULL, NULL, 'ChMedicalRecord', 'crud', 'element-ui', 'com.ruoyi.hospital', 'hospital', 'record', '就诊记录', 'ruoyi', '0', '/', '{\"parentMenuId\":2000}', 'admin', '2026-02-09 09:06:58', '', '2026-02-09 09:29:11', NULL);
INSERT INTO `gen_table` VALUES (10, 'ch_patient', '患者信息表', NULL, NULL, 'ChPatient', 'crud', 'element-ui', 'com.ruoyi.hospital', 'hospital', 'patient', '患者信息', 'ruoyi', '0', '/', '{\"parentMenuId\":2000}', 'admin', '2026-02-09 09:07:11', '', '2026-02-09 09:10:13', NULL);
INSERT INTO `gen_table` VALUES (11, 'ch_appointment', '预约挂号表', NULL, NULL, 'ChAppointment', 'crud', 'element-ui', 'com.ruoyi.hospital', 'diagnosis', 'appointment', '预约挂号', 'ruoyi', '0', '/', '{\"parentMenuId\":2048}', 'admin', '2026-02-09 10:26:17', '', '2026-02-09 10:30:36', NULL);
INSERT INTO `gen_table` VALUES (12, 'ch_prescription', '处方表', 'ch_prescription_detail', 'prescription_id', 'ChPrescription', 'sub', 'element-ui', 'com.ruoyi.hospital', 'diagnosis', 'prescription', '处方', 'ruoyi', '0', '/', '{\"parentMenuId\":2052}', 'admin', '2026-02-09 10:45:23', '', '2026-02-09 10:50:24', NULL);
INSERT INTO `gen_table` VALUES (13, 'ch_prescription_detail', '处方明细表', NULL, NULL, 'ChPrescriptionDetail', 'crud', '', 'com.ruoyi.system', 'system', 'detail', '处方明细', 'ruoyi', '0', '/', NULL, 'admin', '2026-02-09 10:45:23', '', NULL, NULL);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 253 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (88, 4, 'medicine_id', '药品ID', 'bigint', 'Long', 'medicineId', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-01-27 20:05:15', '', '2026-01-27 21:38:05');
INSERT INTO `gen_table_column` VALUES (89, 4, 'medicine_code', '药品编码', 'varchar(30)', 'String', 'medicineCode', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2026-01-27 20:05:15', '', '2026-01-27 21:38:05');
INSERT INTO `gen_table_column` VALUES (90, 4, 'medicine_name', '药品名称', 'varchar(100)', 'String', 'medicineName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 3, 'admin', '2026-01-27 20:05:15', '', '2026-01-27 21:38:05');
INSERT INTO `gen_table_column` VALUES (92, 4, 'specification', '规格', 'varchar(100)', 'String', 'specification', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 4, 'admin', '2026-01-27 20:05:15', '', '2026-01-27 21:38:05');
INSERT INTO `gen_table_column` VALUES (93, 4, 'category_id', '分类ID', 'bigint', 'Long', 'categoryId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2026-01-27 20:05:15', '', '2026-01-27 21:38:05');
INSERT INTO `gen_table_column` VALUES (94, 4, 'manufacturer', '生产厂家', 'varchar(200)', 'String', 'manufacturer', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 6, 'admin', '2026-01-27 20:05:15', '', '2026-01-27 21:38:05');
INSERT INTO `gen_table_column` VALUES (95, 4, 'approval_number', '批准文号', 'varchar(50)', 'String', 'approvalNumber', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 7, 'admin', '2026-01-27 20:05:15', '', '2026-01-27 21:38:05');
INSERT INTO `gen_table_column` VALUES (96, 4, 'is_prescription', '是否处方药（0否 1是）', 'tinyint(1)', 'Integer', 'isPrescription', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 8, 'admin', '2026-01-27 20:05:15', '', '2026-01-27 21:38:05');
INSERT INTO `gen_table_column` VALUES (97, 4, 'purchase_price', '采购价', 'decimal(10,2)', 'BigDecimal', 'purchasePrice', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 9, 'admin', '2026-01-27 20:05:15', '', '2026-01-27 21:38:05');
INSERT INTO `gen_table_column` VALUES (98, 4, 'sale_price', '销售价', 'decimal(10,2)', 'BigDecimal', 'salePrice', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'input', '', 10, 'admin', '2026-01-27 20:05:15', '', '2026-01-27 21:38:05');
INSERT INTO `gen_table_column` VALUES (99, 4, 'stock_warning', '库存预警', 'int', 'Long', 'stockWarning', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 11, 'admin', '2026-01-27 20:05:15', '', '2026-01-27 21:38:05');
INSERT INTO `gen_table_column` VALUES (100, 4, 'validity_period', '有效期（月）', 'int', 'Long', 'validityPeriod', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 12, 'admin', '2026-01-27 20:05:15', '', '2026-01-27 21:38:05');
INSERT INTO `gen_table_column` VALUES (101, 4, 'status', '状态（0正常 1停用）', 'char(1)', 'String', 'status', '1', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'radio', '', 13, 'admin', '2026-01-27 20:05:15', '', '2026-01-27 21:38:05');
INSERT INTO `gen_table_column` VALUES (102, 4, 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 14, 'admin', '2026-01-27 20:05:15', '', '2026-01-27 21:38:05');
INSERT INTO `gen_table_column` VALUES (103, 4, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 15, 'admin', '2026-01-27 20:05:15', '', '2026-01-27 21:38:05');
INSERT INTO `gen_table_column` VALUES (104, 4, 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'input', '', 16, 'admin', '2026-01-27 20:05:15', '', '2026-01-27 21:38:05');
INSERT INTO `gen_table_column` VALUES (105, 4, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 17, 'admin', '2026-01-27 20:05:15', '', '2026-01-27 21:38:05');
INSERT INTO `gen_table_column` VALUES (106, 4, 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', '0', '1', '1', '1', NULL, 'EQ', 'textarea', '', 18, 'admin', '2026-01-27 20:05:15', '', '2026-01-27 21:38:05');
INSERT INTO `gen_table_column` VALUES (107, 5, 'category_id', '分类ID', 'bigint', 'Long', 'categoryId', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-01-27 21:36:49', '', '2026-01-27 22:11:44');
INSERT INTO `gen_table_column` VALUES (108, 5, 'category_code', '分类编码', 'varchar(20)', 'String', 'categoryCode', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2026-01-27 21:36:49', '', '2026-01-27 22:11:44');
INSERT INTO `gen_table_column` VALUES (109, 5, 'category_name', '分类名称', 'varchar(50)', 'String', 'categoryName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 3, 'admin', '2026-01-27 21:36:49', '', '2026-01-27 22:11:44');
INSERT INTO `gen_table_column` VALUES (110, 5, 'parent_id', '父分类ID', 'bigint', 'Long', 'parentId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2026-01-27 21:36:49', '', '2026-01-27 22:11:44');
INSERT INTO `gen_table_column` VALUES (112, 5, 'status', '状态（0正常 1停用）', 'char(1)', 'String', 'status', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 5, 'admin', '2026-01-27 21:36:49', '', '2026-01-27 22:11:44');
INSERT INTO `gen_table_column` VALUES (113, 5, 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 6, 'admin', '2026-01-27 21:36:49', '', '2026-01-27 22:11:44');
INSERT INTO `gen_table_column` VALUES (114, 5, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 7, 'admin', '2026-01-27 21:36:49', '', '2026-01-27 22:11:44');
INSERT INTO `gen_table_column` VALUES (115, 5, 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'input', '', 8, 'admin', '2026-01-27 21:36:49', '', '2026-01-27 22:11:44');
INSERT INTO `gen_table_column` VALUES (116, 5, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 9, 'admin', '2026-01-27 21:36:49', '', '2026-01-27 22:11:44');
INSERT INTO `gen_table_column` VALUES (117, 6, 'stock_id', '库存ID', 'bigint', 'Long', 'stockId', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-01-27 21:52:47', '', '2026-01-28 09:37:40');
INSERT INTO `gen_table_column` VALUES (118, 6, 'medicine_id', '药品ID', 'bigint', 'Long', 'medicineId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2026-01-27 21:52:47', '', '2026-01-28 09:37:40');
INSERT INTO `gen_table_column` VALUES (119, 6, 'batch_no', '批次号', 'varchar(50)', 'String', 'batchNo', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'input', '', 3, 'admin', '2026-01-27 21:52:47', '', '2026-01-28 09:37:40');
INSERT INTO `gen_table_column` VALUES (120, 6, 'production_date', '生产日期', 'date', 'Date', 'productionDate', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'datetime', '', 4, 'admin', '2026-01-27 21:52:47', '', '2026-01-28 09:37:40');
INSERT INTO `gen_table_column` VALUES (121, 6, 'expiry_date', '有效期至', 'date', 'Date', 'expiryDate', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'datetime', '', 5, 'admin', '2026-01-27 21:52:47', '', '2026-01-28 09:37:40');
INSERT INTO `gen_table_column` VALUES (122, 6, 'quantity', '库存数量', 'int', 'Long', 'quantity', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'input', '', 6, 'admin', '2026-01-27 21:52:47', '', '2026-01-28 09:37:40');
INSERT INTO `gen_table_column` VALUES (123, 6, 'available_quantity', '可用数量', 'int', 'Long', 'availableQuantity', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 7, 'admin', '2026-01-27 21:52:47', '', '2026-01-28 09:37:40');
INSERT INTO `gen_table_column` VALUES (124, 6, 'purchase_price', '采购单价', 'decimal(10,2)', 'BigDecimal', 'purchasePrice', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 8, 'admin', '2026-01-27 21:52:47', '', '2026-01-28 09:37:40');
INSERT INTO `gen_table_column` VALUES (125, 6, 'supplier', '供应商', 'varchar(200)', 'String', 'supplier', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 9, 'admin', '2026-01-27 21:52:47', '', '2026-01-28 09:37:40');
INSERT INTO `gen_table_column` VALUES (126, 6, 'storage_location', '存放位置', 'varchar(100)', 'String', 'storageLocation', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 10, 'admin', '2026-01-27 21:52:47', '', '2026-01-28 09:37:40');
INSERT INTO `gen_table_column` VALUES (127, 6, 'stock_status', '状态（normal正常 expiring临期 expired过期）', 'varchar(20)', 'String', 'stockStatus', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 11, 'admin', '2026-01-27 21:52:47', '', '2026-01-28 09:37:40');
INSERT INTO `gen_table_column` VALUES (128, 6, 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 12, 'admin', '2026-01-27 21:52:47', '', '2026-01-28 09:37:40');
INSERT INTO `gen_table_column` VALUES (129, 6, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 13, 'admin', '2026-01-27 21:52:47', '', '2026-01-28 09:37:40');
INSERT INTO `gen_table_column` VALUES (130, 6, 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'input', '', 14, 'admin', '2026-01-27 21:52:47', '', '2026-01-28 09:37:40');
INSERT INTO `gen_table_column` VALUES (131, 6, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 15, 'admin', '2026-01-27 21:52:47', '', '2026-01-28 09:37:40');
INSERT INTO `gen_table_column` VALUES (132, 7, 'staff_id', '员工ID', 'bigint', 'Long', 'staffId', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-01-28 14:39:41', '', '2026-01-28 14:46:27');
INSERT INTO `gen_table_column` VALUES (133, 7, 'user_id', '关联用户ID', 'bigint', 'Long', 'userId', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'input', '', 2, 'admin', '2026-01-28 14:39:41', '', '2026-01-28 14:46:27');
INSERT INTO `gen_table_column` VALUES (134, 7, 'staff_no', '工号', 'varchar(20)', 'String', 'staffNo', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2026-01-28 14:39:41', '', '2026-01-28 14:46:27');
INSERT INTO `gen_table_column` VALUES (135, 7, 'staff_name', '姓名', 'varchar(50)', 'String', 'staffName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 4, 'admin', '2026-01-28 14:39:41', '', '2026-01-28 14:46:27');
INSERT INTO `gen_table_column` VALUES (136, 7, 'gender', '性别（0男 1女）', 'char(1)', 'String', 'gender', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 5, 'admin', '2026-01-28 14:39:41', '', '2026-01-28 14:46:27');
INSERT INTO `gen_table_column` VALUES (137, 7, 'birth_date', '出生日期', 'date', 'Date', 'birthDate', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'datetime', '', 6, 'admin', '2026-01-28 14:39:41', '', '2026-01-28 14:46:27');
INSERT INTO `gen_table_column` VALUES (138, 7, 'id_card', '身份证号', 'varchar(18)', 'String', 'idCard', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 7, 'admin', '2026-01-28 14:39:41', '', '2026-01-28 14:46:27');
INSERT INTO `gen_table_column` VALUES (139, 7, 'phone', '联系电话', 'varchar(20)', 'String', 'phone', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 8, 'admin', '2026-01-28 14:39:41', '', '2026-01-28 14:46:27');
INSERT INTO `gen_table_column` VALUES (140, 7, 'email', '邮箱', 'varchar(50)', 'String', 'email', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 9, 'admin', '2026-01-28 14:39:41', '', '2026-01-28 14:46:27');
INSERT INTO `gen_table_column` VALUES (141, 7, 'dept_id', '所属科室', 'bigint', 'Long', 'deptId', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 10, 'admin', '2026-01-28 14:39:41', '', '2026-01-28 14:46:27');
INSERT INTO `gen_table_column` VALUES (142, 7, 'staff_type', '员工类型（doctor医生 nurse护士 pharmacist药师 technician技师）', 'varchar(20)', 'String', 'staffType', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'select', '', 11, 'admin', '2026-01-28 14:39:41', '', '2026-01-28 14:46:27');
INSERT INTO `gen_table_column` VALUES (143, 7, 'status', '状态（0在职 1休假 2离职）', 'char(1)', 'String', 'status', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'radio', '', 12, 'admin', '2026-01-28 14:39:41', '', '2026-01-28 14:46:27');
INSERT INTO `gen_table_column` VALUES (144, 7, 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 13, 'admin', '2026-01-28 14:39:41', '', '2026-01-28 14:46:27');
INSERT INTO `gen_table_column` VALUES (145, 7, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 14, 'admin', '2026-01-28 14:39:41', '', '2026-01-28 14:46:27');
INSERT INTO `gen_table_column` VALUES (146, 7, 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'input', '', 15, 'admin', '2026-01-28 14:39:41', '', '2026-01-28 14:46:27');
INSERT INTO `gen_table_column` VALUES (147, 7, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 16, 'admin', '2026-01-28 14:39:41', '', '2026-01-28 14:46:27');
INSERT INTO `gen_table_column` VALUES (148, 7, 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', '0', '1', '1', '1', NULL, 'EQ', 'textarea', '', 17, 'admin', '2026-01-28 14:39:41', '', '2026-01-28 14:46:27');
INSERT INTO `gen_table_column` VALUES (149, 8, 'schedule_id', '排班ID', 'bigint', 'Long', 'scheduleId', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-01-28 15:16:43', '', '2026-01-28 15:17:23');
INSERT INTO `gen_table_column` VALUES (150, 8, 'staff_id', '医生ID', 'bigint', 'Long', 'staffId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2026-01-28 15:16:43', '', '2026-01-28 15:17:23');
INSERT INTO `gen_table_column` VALUES (151, 8, 'schedule_date', '排班日期', 'date', 'Date', 'scheduleDate', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'datetime', '', 3, 'admin', '2026-01-28 15:16:43', '', '2026-01-28 15:17:23');
INSERT INTO `gen_table_column` VALUES (152, 8, 'time_slot', '时间段（morning上午 afternoon下午 night夜班）', 'varchar(20)', 'String', 'timeSlot', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2026-01-28 15:16:43', '', '2026-01-28 15:17:23');
INSERT INTO `gen_table_column` VALUES (153, 8, 'room_no', '诊室号', 'varchar(20)', 'String', 'roomNo', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2026-01-28 15:16:43', '', '2026-01-28 15:17:23');
INSERT INTO `gen_table_column` VALUES (154, 8, 'max_patients', '最大接诊人数', 'int', 'Long', 'maxPatients', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2026-01-28 15:16:43', '', '2026-01-28 15:17:23');
INSERT INTO `gen_table_column` VALUES (155, 8, 'current_patients', '当前预约人数', 'int', 'Long', 'currentPatients', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2026-01-28 15:16:43', '', '2026-01-28 15:17:23');
INSERT INTO `gen_table_column` VALUES (156, 8, 'schedule_type', '排班类型（normal普通 expert专家）', 'varchar(20)', 'String', 'scheduleType', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', '', 8, 'admin', '2026-01-28 15:16:43', '', '2026-01-28 15:17:23');
INSERT INTO `gen_table_column` VALUES (157, 8, 'fee', '挂号费', 'decimal(10,2)', 'BigDecimal', 'fee', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 9, 'admin', '2026-01-28 15:16:43', '', '2026-01-28 15:17:23');
INSERT INTO `gen_table_column` VALUES (158, 8, 'status', '状态（0可预约 1已满 2停诊）', 'char(1)', 'String', 'status', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 10, 'admin', '2026-01-28 15:16:43', '', '2026-01-28 15:17:23');
INSERT INTO `gen_table_column` VALUES (159, 8, 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 11, 'admin', '2026-01-28 15:16:43', '', '2026-01-28 15:17:23');
INSERT INTO `gen_table_column` VALUES (160, 8, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 12, 'admin', '2026-01-28 15:16:43', '', '2026-01-28 15:17:23');
INSERT INTO `gen_table_column` VALUES (161, 8, 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'input', '', 13, 'admin', '2026-01-28 15:16:43', '', '2026-01-28 15:17:23');
INSERT INTO `gen_table_column` VALUES (162, 8, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 14, 'admin', '2026-01-28 15:16:43', '', '2026-01-28 15:17:23');
INSERT INTO `gen_table_column` VALUES (163, 9, 'record_id', '记录ID', 'bigint', 'Long', 'recordId', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-02-09 09:06:58', '', '2026-02-09 09:29:17');
INSERT INTO `gen_table_column` VALUES (164, 9, 'record_no', '病历号', 'varchar(30)', 'String', 'recordNo', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2026-02-09 09:06:58', '', '2026-02-09 09:29:17');
INSERT INTO `gen_table_column` VALUES (165, 9, 'patient_id', '患者ID', 'bigint', 'Long', 'patientId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2026-02-09 09:06:58', '', '2026-02-09 09:29:17');
INSERT INTO `gen_table_column` VALUES (166, 9, 'staff_id', '医生ID', 'bigint', 'Long', 'staffId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2026-02-09 09:06:58', '', '2026-02-09 09:29:17');
INSERT INTO `gen_table_column` VALUES (167, 9, 'appointment_id', '关联预约ID', 'bigint', 'Long', 'appointmentId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2026-02-09 09:06:58', '', '2026-02-09 09:29:17');
INSERT INTO `gen_table_column` VALUES (168, 9, 'visit_date', '就诊日期', 'date', 'Date', 'visitDate', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'datetime', '', 6, 'admin', '2026-02-09 09:06:58', '', '2026-02-09 09:29:17');
INSERT INTO `gen_table_column` VALUES (169, 9, 'chief_complaint', '主诉', 'text', 'String', 'chiefComplaint', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 7, 'admin', '2026-02-09 09:06:58', '', '2026-02-09 09:29:17');
INSERT INTO `gen_table_column` VALUES (170, 9, 'present_illness', '现病史', 'text', 'String', 'presentIllness', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 8, 'admin', '2026-02-09 09:06:58', '', '2026-02-09 09:29:17');
INSERT INTO `gen_table_column` VALUES (171, 9, 'past_history', '既往史', 'text', 'String', 'pastHistory', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 9, 'admin', '2026-02-09 09:06:58', '', '2026-02-09 09:29:17');
INSERT INTO `gen_table_column` VALUES (172, 9, 'allergy_info', '过敏信息', 'text', 'String', 'allergyInfo', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 10, 'admin', '2026-02-09 09:06:58', '', '2026-02-09 09:29:17');
INSERT INTO `gen_table_column` VALUES (173, 9, 'physical_exam', '体格检查', 'text', 'String', 'physicalExam', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 11, 'admin', '2026-02-09 09:06:58', '', '2026-02-09 09:29:17');
INSERT INTO `gen_table_column` VALUES (174, 9, 'auxiliary_exam', '辅助检查', 'text', 'String', 'auxiliaryExam', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 12, 'admin', '2026-02-09 09:06:58', '', '2026-02-09 09:29:17');
INSERT INTO `gen_table_column` VALUES (175, 9, 'preliminary_diagnosis', '初步诊断', 'text', 'String', 'preliminaryDiagnosis', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 13, 'admin', '2026-02-09 09:06:58', '', '2026-02-09 09:29:17');
INSERT INTO `gen_table_column` VALUES (176, 9, 'final_diagnosis', '最终诊断', 'text', 'String', 'finalDiagnosis', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 14, 'admin', '2026-02-09 09:06:58', '', '2026-02-09 09:29:17');
INSERT INTO `gen_table_column` VALUES (177, 9, 'treatment_plan', '治疗方案', 'text', 'String', 'treatmentPlan', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 15, 'admin', '2026-02-09 09:06:58', '', '2026-02-09 09:29:17');
INSERT INTO `gen_table_column` VALUES (178, 9, 'medical_advice', '医嘱', 'text', 'String', 'medicalAdvice', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 16, 'admin', '2026-02-09 09:06:58', '', '2026-02-09 09:29:17');
INSERT INTO `gen_table_column` VALUES (179, 9, 'revisit_date', '复诊日期', 'date', 'Date', 'revisitDate', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 17, 'admin', '2026-02-09 09:06:58', '', '2026-02-09 09:29:17');
INSERT INTO `gen_table_column` VALUES (180, 9, 'record_status', '状态（draft草稿 completed完成）', 'varchar(20)', 'String', 'recordStatus', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 18, 'admin', '2026-02-09 09:06:58', '', '2026-02-09 09:29:17');
INSERT INTO `gen_table_column` VALUES (181, 9, 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 19, 'admin', '2026-02-09 09:06:58', '', '2026-02-09 09:29:17');
INSERT INTO `gen_table_column` VALUES (182, 9, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 20, 'admin', '2026-02-09 09:06:58', '', '2026-02-09 09:29:17');
INSERT INTO `gen_table_column` VALUES (183, 9, 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'input', '', 21, 'admin', '2026-02-09 09:06:58', '', '2026-02-09 09:29:17');
INSERT INTO `gen_table_column` VALUES (184, 9, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 22, 'admin', '2026-02-09 09:06:58', '', '2026-02-09 09:29:17');
INSERT INTO `gen_table_column` VALUES (185, 10, 'patient_id', '患者ID', 'bigint', 'Long', 'patientId', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-02-09 09:07:11', '', '2026-02-09 09:10:36');
INSERT INTO `gen_table_column` VALUES (186, 10, 'user_id', '关联用户ID', 'bigint', 'Long', 'userId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2026-02-09 09:07:11', '', '2026-02-09 09:10:36');
INSERT INTO `gen_table_column` VALUES (187, 10, 'patient_no', '患者编号', 'varchar(30)', 'String', 'patientNo', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2026-02-09 09:07:11', '', '2026-02-09 09:10:36');
INSERT INTO `gen_table_column` VALUES (188, 10, 'id_card', '身份证号', 'varchar(18)', 'String', 'idCard', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2026-02-09 09:07:11', '', '2026-02-09 09:10:36');
INSERT INTO `gen_table_column` VALUES (189, 10, 'gender', '性别（0男 1女 2未知）', 'char(1)', 'String', 'gender', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2026-02-09 09:07:11', '', '2026-02-09 09:10:36');
INSERT INTO `gen_table_column` VALUES (190, 10, 'birth_date', '出生日期', 'date', 'Date', 'birthDate', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 6, 'admin', '2026-02-09 09:07:11', '', '2026-02-09 09:10:36');
INSERT INTO `gen_table_column` VALUES (191, 10, 'age', '年龄', 'int', 'Long', 'age', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2026-02-09 09:07:11', '', '2026-02-09 09:10:36');
INSERT INTO `gen_table_column` VALUES (192, 10, 'blood_type', '血型', 'varchar(10)', 'String', 'bloodType', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', '', 8, 'admin', '2026-02-09 09:07:11', '', '2026-02-09 09:10:36');
INSERT INTO `gen_table_column` VALUES (193, 10, 'marriage_status', '婚姻状况', 'varchar(10)', 'String', 'marriageStatus', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 9, 'admin', '2026-02-09 09:07:11', '', '2026-02-09 09:10:36');
INSERT INTO `gen_table_column` VALUES (194, 10, 'occupation', '职业', 'varchar(50)', 'String', 'occupation', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 10, 'admin', '2026-02-09 09:07:11', '', '2026-02-09 09:10:36');
INSERT INTO `gen_table_column` VALUES (195, 10, 'nation', '民族', 'varchar(20)', 'String', 'nation', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 11, 'admin', '2026-02-09 09:07:11', '', '2026-02-09 09:10:36');
INSERT INTO `gen_table_column` VALUES (196, 10, 'address', '现住址', 'varchar(200)', 'String', 'address', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 12, 'admin', '2026-02-09 09:07:11', '', '2026-02-09 09:10:36');
INSERT INTO `gen_table_column` VALUES (197, 10, 'phone', '联系电话', 'varchar(20)', 'String', 'phone', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 13, 'admin', '2026-02-09 09:07:11', '', '2026-02-09 09:10:36');
INSERT INTO `gen_table_column` VALUES (198, 10, 'allergy_history', '过敏史', 'text', 'String', 'allergyHistory', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 14, 'admin', '2026-02-09 09:07:11', '', '2026-02-09 09:10:36');
INSERT INTO `gen_table_column` VALUES (199, 10, 'chronic_disease', '慢性病史', 'text', 'String', 'chronicDisease', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 15, 'admin', '2026-02-09 09:07:11', '', '2026-02-09 09:10:36');
INSERT INTO `gen_table_column` VALUES (200, 10, 'family_history', '家族病史', 'text', 'String', 'familyHistory', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 16, 'admin', '2026-02-09 09:07:11', '', '2026-02-09 09:10:36');
INSERT INTO `gen_table_column` VALUES (201, 10, 'insurance_no', '医保卡号', 'varchar(50)', 'String', 'insuranceNo', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 17, 'admin', '2026-02-09 09:07:11', '', '2026-02-09 09:10:36');
INSERT INTO `gen_table_column` VALUES (202, 10, 'status', '患者状态（0正常 1停用）', 'char(1)', 'String', 'status', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 18, 'admin', '2026-02-09 09:07:11', '', '2026-02-09 09:10:36');
INSERT INTO `gen_table_column` VALUES (203, 10, 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 19, 'admin', '2026-02-09 09:07:11', '', '2026-02-09 09:10:36');
INSERT INTO `gen_table_column` VALUES (204, 10, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 20, 'admin', '2026-02-09 09:07:11', '', '2026-02-09 09:10:36');
INSERT INTO `gen_table_column` VALUES (205, 10, 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'input', '', 21, 'admin', '2026-02-09 09:07:11', '', '2026-02-09 09:10:36');
INSERT INTO `gen_table_column` VALUES (206, 10, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 22, 'admin', '2026-02-09 09:07:11', '', '2026-02-09 09:10:36');
INSERT INTO `gen_table_column` VALUES (207, 10, 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', '0', '1', '1', '1', NULL, 'EQ', 'textarea', '', 23, 'admin', '2026-02-09 09:07:11', '', '2026-02-09 09:10:36');
INSERT INTO `gen_table_column` VALUES (208, 11, 'appointment_id', '预约ID', 'bigint', 'Long', 'appointmentId', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-02-09 10:26:17', '', '2026-02-09 10:30:36');
INSERT INTO `gen_table_column` VALUES (209, 11, 'appointment_no', '预约号', 'varchar(30)', 'String', 'appointmentNo', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2026-02-09 10:26:17', '', '2026-02-09 10:30:36');
INSERT INTO `gen_table_column` VALUES (210, 11, 'patient_id', '患者ID', 'bigint', 'Long', 'patientId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2026-02-09 10:26:17', '', '2026-02-09 10:30:36');
INSERT INTO `gen_table_column` VALUES (211, 11, 'staff_id', '医生ID', 'bigint', 'Long', 'staffId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2026-02-09 10:26:17', '', '2026-02-09 10:30:36');
INSERT INTO `gen_table_column` VALUES (212, 11, 'schedule_id', '排班ID', 'bigint', 'Long', 'scheduleId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2026-02-09 10:26:17', '', '2026-02-09 10:30:36');
INSERT INTO `gen_table_column` VALUES (213, 11, 'dept_id', '科室ID', 'bigint', 'Long', 'deptId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2026-02-09 10:26:17', '', '2026-02-09 10:30:36');
INSERT INTO `gen_table_column` VALUES (214, 11, 'appointment_date', '预约日期', 'date', 'Date', 'appointmentDate', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'datetime', '', 7, 'admin', '2026-02-09 10:26:17', '', '2026-02-09 10:30:36');
INSERT INTO `gen_table_column` VALUES (215, 11, 'time_slot', '时间段', 'varchar(20)', 'String', 'timeSlot', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'input', '', 8, 'admin', '2026-02-09 10:26:17', '', '2026-02-09 10:30:36');
INSERT INTO `gen_table_column` VALUES (216, 11, 'appointment_time', '预约时间', 'datetime', 'Date', 'appointmentTime', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'datetime', '', 9, 'admin', '2026-02-09 10:26:17', '', '2026-02-09 10:30:36');
INSERT INTO `gen_table_column` VALUES (217, 11, 'queue_number', '排队号', 'int', 'Long', 'queueNumber', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 10, 'admin', '2026-02-09 10:26:17', '', '2026-02-09 10:30:36');
INSERT INTO `gen_table_column` VALUES (218, 11, 'symptoms', '症状描述', 'text', 'String', 'symptoms', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'textarea', '', 11, 'admin', '2026-02-09 10:26:17', '', '2026-02-09 10:30:36');
INSERT INTO `gen_table_column` VALUES (219, 11, 'source', '来源（online线上 offline线下）', 'varchar(20)', 'String', 'source', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 12, 'admin', '2026-02-09 10:26:17', '', '2026-02-09 10:30:36');
INSERT INTO `gen_table_column` VALUES (220, 11, 'fee', '挂号费', 'decimal(10,2)', 'BigDecimal', 'fee', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 13, 'admin', '2026-02-09 10:26:17', '', '2026-02-09 10:30:36');
INSERT INTO `gen_table_column` VALUES (221, 11, 'payment_status', '缴费状态（0未付 1已付）', 'char(1)', 'String', 'paymentStatus', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'radio', '', 14, 'admin', '2026-02-09 10:26:17', '', '2026-02-09 10:30:36');
INSERT INTO `gen_table_column` VALUES (222, 11, 'appointment_status', '预约状态（pending待确认 confirmed已确认 completed已完成 cancelled已取消 no_show未就诊）', 'varchar(20)', 'String', 'appointmentStatus', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 15, 'admin', '2026-02-09 10:26:17', '', '2026-02-09 10:30:36');
INSERT INTO `gen_table_column` VALUES (223, 11, 'cancel_reason', '取消原因', 'varchar(200)', 'String', 'cancelReason', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 16, 'admin', '2026-02-09 10:26:17', '', '2026-02-09 10:30:36');
INSERT INTO `gen_table_column` VALUES (224, 11, 'arrive_time', '到院时间', 'datetime', 'Date', 'arriveTime', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'datetime', '', 17, 'admin', '2026-02-09 10:26:17', '', '2026-02-09 10:30:36');
INSERT INTO `gen_table_column` VALUES (225, 11, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 18, 'admin', '2026-02-09 10:26:17', '', '2026-02-09 10:30:36');
INSERT INTO `gen_table_column` VALUES (226, 11, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 19, 'admin', '2026-02-09 10:26:17', '', '2026-02-09 10:30:36');
INSERT INTO `gen_table_column` VALUES (227, 12, 'prescription_id', '处方ID', 'bigint', 'Long', 'prescriptionId', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-02-09 10:45:23', '', '2026-02-09 10:50:24');
INSERT INTO `gen_table_column` VALUES (228, 12, 'prescription_no', '处方号', 'varchar(30)', 'String', 'prescriptionNo', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2026-02-09 10:45:23', '', '2026-02-09 10:50:24');
INSERT INTO `gen_table_column` VALUES (229, 12, 'patient_id', '患者ID', 'bigint', 'Long', 'patientId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2026-02-09 10:45:23', '', '2026-02-09 10:50:24');
INSERT INTO `gen_table_column` VALUES (230, 12, 'staff_id', '开方医生ID', 'bigint', 'Long', 'staffId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2026-02-09 10:45:23', '', '2026-02-09 10:50:24');
INSERT INTO `gen_table_column` VALUES (231, 12, 'record_id', '关联病历ID', 'bigint', 'Long', 'recordId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2026-02-09 10:45:23', '', '2026-02-09 10:50:24');
INSERT INTO `gen_table_column` VALUES (232, 12, 'diagnosis', '诊断', 'text', 'String', 'diagnosis', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 6, 'admin', '2026-02-09 10:45:23', '', '2026-02-09 10:50:24');
INSERT INTO `gen_table_column` VALUES (233, 12, 'usage_instructions', '用法用量说明', 'text', 'String', 'usageInstructions', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 7, 'admin', '2026-02-09 10:45:23', '', '2026-02-09 10:50:24');
INSERT INTO `gen_table_column` VALUES (234, 12, 'total_amount', '总金额', 'decimal(10,2)', 'BigDecimal', 'totalAmount', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2026-02-09 10:45:23', '', '2026-02-09 10:50:24');
INSERT INTO `gen_table_column` VALUES (235, 12, 'prescription_type', '处方类型（common普通 emergency急诊）', 'varchar(20)', 'String', 'prescriptionType', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', '', 9, 'admin', '2026-02-09 10:45:23', '', '2026-02-09 10:50:24');
INSERT INTO `gen_table_column` VALUES (236, 12, 'prescription_status', '状态（unfilled未取药 filled已取药 dispensed已发药 cancelled已退药）', 'varchar(20)', 'String', 'prescriptionStatus', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 10, 'admin', '2026-02-09 10:45:23', '', '2026-02-09 10:50:24');
INSERT INTO `gen_table_column` VALUES (237, 12, 'dispense_time', '发药时间', 'datetime', 'Date', 'dispenseTime', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 11, 'admin', '2026-02-09 10:45:23', '', '2026-02-09 10:50:24');
INSERT INTO `gen_table_column` VALUES (238, 12, 'dispenser_id', '发药人ID', 'bigint', 'Long', 'dispenserId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 12, 'admin', '2026-02-09 10:45:23', '', '2026-02-09 10:50:24');
INSERT INTO `gen_table_column` VALUES (239, 12, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 13, 'admin', '2026-02-09 10:45:23', '', '2026-02-09 10:50:24');
INSERT INTO `gen_table_column` VALUES (240, 12, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 14, 'admin', '2026-02-09 10:45:23', '', '2026-02-09 10:50:24');
INSERT INTO `gen_table_column` VALUES (241, 13, 'detail_id', '明细ID', 'bigint', 'Long', 'detailId', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-02-09 10:45:23', '', NULL);
INSERT INTO `gen_table_column` VALUES (242, 13, 'prescription_id', '处方ID', 'bigint', 'Long', 'prescriptionId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2026-02-09 10:45:23', '', NULL);
INSERT INTO `gen_table_column` VALUES (243, 13, 'medicine_id', '药品ID', 'bigint', 'Long', 'medicineId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2026-02-09 10:45:23', '', NULL);
INSERT INTO `gen_table_column` VALUES (244, 13, 'quantity', '数量', 'int', 'Long', 'quantity', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2026-02-09 10:45:23', '', NULL);
INSERT INTO `gen_table_column` VALUES (245, 13, 'dosage', '单次剂量', 'varchar(50)', 'String', 'dosage', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2026-02-09 10:45:23', '', NULL);
INSERT INTO `gen_table_column` VALUES (246, 13, 'frequency', '频次', 'varchar(50)', 'String', 'frequency', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2026-02-09 10:45:23', '', NULL);
INSERT INTO `gen_table_column` VALUES (247, 13, 'days', '天数', 'int', 'Long', 'days', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2026-02-09 10:45:23', '', NULL);
INSERT INTO `gen_table_column` VALUES (248, 13, 'total_quantity', '总用量', 'varchar(50)', 'String', 'totalQuantity', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2026-02-09 10:45:23', '', NULL);
INSERT INTO `gen_table_column` VALUES (249, 13, 'usage_method', '用法', 'varchar(200)', 'String', 'usageMethod', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 9, 'admin', '2026-02-09 10:45:23', '', NULL);
INSERT INTO `gen_table_column` VALUES (250, 13, 'unit_price', '单价', 'decimal(10,2)', 'BigDecimal', 'unitPrice', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 10, 'admin', '2026-02-09 10:45:23', '', NULL);
INSERT INTO `gen_table_column` VALUES (251, 13, 'subtotal', '小计', 'decimal(10,2)', 'BigDecimal', 'subtotal', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 11, 'admin', '2026-02-09 10:45:23', '', NULL);
INSERT INTO `gen_table_column` VALUES (252, 13, 'notes', '备注', 'varchar(200)', 'String', 'notes', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 12, 'admin', '2026-02-09 10:45:23', '', NULL);

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob NULL COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'Blob类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '日历信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'Cron类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint NOT NULL COMMENT '触发的时间',
  `sched_time` bigint NOT NULL COMMENT '定时器制定的时间',
  `priority` int NOT NULL COMMENT '优先级',
  `state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '已触发的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务组名',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '任务详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '存储的悲观锁信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '暂停的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '调度器状态表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '简单触发器的信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '同步机制的行锁表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint NULL DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint NULL DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int NULL DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器的类型',
  `start_time` bigint NOT NULL COMMENT '开始时间',
  `end_time` bigint NULL DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint NULL DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name` ASC, `job_name` ASC, `job_group` ASC) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '触发器详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2026-01-27 17:20:10', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2026-01-27 17:20:10', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2026-01-27 17:20:10', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2026-01-27 17:20:10', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2026-01-27 17:20:10', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2026-01-27 17:20:10', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');
INSERT INTO `sys_config` VALUES (7, '用户管理-初始密码修改策略', 'sys.account.initPasswordModify', '1', 'Y', 'admin', '2026-01-27 17:20:10', '', NULL, '0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框');
INSERT INTO `sys_config` VALUES (8, '用户管理-账号密码更新周期', 'sys.account.passwordValidateDays', '0', 'Y', 'admin', '2026-01-27 17:20:10', '', NULL, '密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '科室ID',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父科室ID',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '祖级列表(不知)',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '科室名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '科室负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '科室状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '若依科技', 0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-01-27 17:20:09', '', NULL);
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-01-27 17:20:09', '', NULL);
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-01-27 17:20:09', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-01-27 17:20:09', '', NULL);
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-01-27 17:20:09', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-01-27 17:20:09', '', NULL);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-01-27 17:20:09', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-01-27 17:20:09', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-01-27 17:20:09', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-01-27 17:20:09', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2026-01-27 17:20:10', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2026-01-27 17:20:10', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2026-01-27 17:20:10', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2026-01-27 17:20:10', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2026-01-27 17:20:10', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2026-01-27 17:20:10', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2026-01-27 17:20:10', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2026-01-27 17:20:10', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2026-01-27 17:20:10', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2026-01-27 17:20:10', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2026-01-27 17:20:10', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2026-01-27 17:20:10', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2026-01-27 17:20:10', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2026-01-27 17:20:10', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2026-01-27 17:20:10', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2026-01-27 17:20:10', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2026-01-27 17:20:10', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-01-27 17:20:10', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-01-27 17:20:10', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-01-27 17:20:10', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-01-27 17:20:10', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2026-01-27 17:20:10', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-01-27 17:20:10', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-01-27 17:20:10', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-01-27 17:20:10', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-01-27 17:20:10', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-01-27 17:20:10', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2026-01-27 17:20:10', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2026-01-27 17:20:10', '', NULL, '停用状态');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2026-01-27 17:20:10', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2026-01-27 17:20:10', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2026-01-27 17:20:10', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2026-01-27 17:20:10', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2026-01-27 17:20:10', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2026-01-27 17:20:10', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2026-01-27 17:20:10', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2026-01-27 17:20:10', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2026-01-27 17:20:10', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2026-01-27 17:20:10', '', NULL, '登录状态列表');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2026-01-27 17:20:10', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2026-01-27 17:20:10', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2026-01-27 17:20:10', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 160 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'Edge 144', 'Windows >=10', '0', '登录成功', '2026-01-27 18:16:35');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Edge 144', 'Windows >=10', '0', '退出成功', '2026-01-27 18:52:12');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'Edge 144', 'Windows >=10', '0', '登录成功', '2026-01-27 19:14:32');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '内网IP', 'Edge 144', 'Windows >=10', '0', '登录成功', '2026-01-28 09:36:22');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '内网IP', 'Edge 144', 'Windows >=10', '0', '登录成功', '2026-01-28 11:13:30');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '内网IP', 'Edge 144', 'Windows >=10', '1', '验证码错误', '2026-01-28 12:44:06');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '127.0.0.1', '内网IP', 'Edge 144', 'Windows >=10', '0', '登录成功', '2026-01-28 12:44:11');
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '127.0.0.1', '内网IP', 'Edge 144', 'Windows >=10', '0', '登录成功', '2026-01-28 14:36:35');
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '127.0.0.1', '内网IP', 'Edge 144', 'Windows >=10', '0', '登录成功', '2026-01-28 17:35:42');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '127.0.0.1', '内网IP', 'Edge 144', 'Windows >=10', '0', '登录成功', '2026-02-09 09:01:15');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '内网IP', 'Edge 144', 'Windows >=10', '0', '退出成功', '2026-02-09 10:59:49');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '127.0.0.1', '内网IP', 'Edge 144', 'Windows >=10', '0', '登录成功', '2026-02-09 11:01:28');
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '127.0.0.1', '内网IP', 'Edge 144', 'Windows >=10', '0', '退出成功', '2026-02-09 11:17:47');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '127.0.0.1', '内网IP', 'Edge 144', 'Windows >=10', '1', '验证码已失效', '2026-02-09 11:19:52');
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '127.0.0.1', '内网IP', 'Edge 144', 'Windows >=10', '1', '验证码错误', '2026-02-09 11:19:55');
INSERT INTO `sys_logininfor` VALUES (115, 'admin', '127.0.0.1', '内网IP', 'Edge 144', 'Windows >=10', '0', '登录成功', '2026-02-09 11:20:01');
INSERT INTO `sys_logininfor` VALUES (116, 'admin', '127.0.0.1', '内网IP', 'Edge 144', 'Windows >=10', '0', '退出成功', '2026-02-09 11:21:31');
INSERT INTO `sys_logininfor` VALUES (117, 'admin', '127.0.0.1', '内网IP', 'Edge 144', 'Windows >=10', '1', '验证码已失效', '2026-02-09 11:30:21');
INSERT INTO `sys_logininfor` VALUES (118, 'admin', '127.0.0.1', '内网IP', 'Edge 144', 'Windows >=10', '0', '登录成功', '2026-02-09 11:30:28');
INSERT INTO `sys_logininfor` VALUES (119, 'admin', '127.0.0.1', '内网IP', 'Edge 144', 'Windows >=10', '0', '退出成功', '2026-02-09 11:58:57');
INSERT INTO `sys_logininfor` VALUES (120, 'admin', '127.0.0.1', '内网IP', 'Edge 144', 'Windows >=10', '0', '登录成功', '2026-02-09 11:59:01');
INSERT INTO `sys_logininfor` VALUES (121, 'admin', '127.0.0.1', '内网IP', 'Edge 144', 'Windows >=10', '0', '退出成功', '2026-02-09 12:01:01');
INSERT INTO `sys_logininfor` VALUES (122, 'admin', '127.0.0.1', '内网IP', 'Edge 144', 'Windows >=10', '0', '登录成功', '2026-02-09 12:02:03');
INSERT INTO `sys_logininfor` VALUES (123, 'admin', '127.0.0.1', '内网IP', 'Edge 144', 'Windows >=10', '0', '退出成功', '2026-02-09 12:04:32');
INSERT INTO `sys_logininfor` VALUES (124, 'admin', '127.0.0.1', '内网IP', 'Edge 144', 'Windows >=10', '0', '登录成功', '2026-02-09 12:05:29');
INSERT INTO `sys_logininfor` VALUES (125, 'admin', '127.0.0.1', '内网IP', 'Edge 144', 'Windows >=10', '0', '登录成功', '2026-02-09 15:24:23');
INSERT INTO `sys_logininfor` VALUES (126, 'admin', '192.168.0.103', '内网IP', 'Edge 144', 'Windows >=10', '0', '登录成功', '2026-02-09 16:38:49');
INSERT INTO `sys_logininfor` VALUES (127, 'admin', '127.0.0.1', '内网IP', 'Edge 144', 'Windows >=10', '0', '登录成功', '2026-02-09 17:06:15');
INSERT INTO `sys_logininfor` VALUES (128, 'admin', '127.0.0.1', '内网IP', 'Edge 144', 'Windows >=10', '1', '验证码错误', '2026-02-09 17:16:07');
INSERT INTO `sys_logininfor` VALUES (129, 'admin', '127.0.0.1', '内网IP', 'Edge 144', 'Windows >=10', '0', '登录成功', '2026-02-09 17:16:11');
INSERT INTO `sys_logininfor` VALUES (130, 'admin', '127.0.0.1', '内网IP', 'Edge 144', 'Windows >=10', '0', '登录成功', '2026-02-10 10:55:03');
INSERT INTO `sys_logininfor` VALUES (131, 'admin', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '1', '验证码错误', '2026-02-25 14:05:16');
INSERT INTO `sys_logininfor` VALUES (132, 'admin', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '1', '验证码错误', '2026-02-25 14:05:17');
INSERT INTO `sys_logininfor` VALUES (133, 'admin', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-02-25 14:05:23');
INSERT INTO `sys_logininfor` VALUES (134, 'admin', '192.168.1.43', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-02-25 14:57:52');
INSERT INTO `sys_logininfor` VALUES (135, 'admin', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-02-25 15:31:55');
INSERT INTO `sys_logininfor` VALUES (136, 'admin', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-02-25 15:34:38');
INSERT INTO `sys_logininfor` VALUES (137, 'admin', '192.168.1.43', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-02-25 15:44:25');
INSERT INTO `sys_logininfor` VALUES (138, 'admin', '192.168.1.43', '内网IP', 'Edge 145', 'Windows >=10', '0', '退出成功', '2026-02-25 15:44:29');
INSERT INTO `sys_logininfor` VALUES (139, 'admin', '192.168.1.43', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-02-25 15:53:14');
INSERT INTO `sys_logininfor` VALUES (140, 'admin', '192.168.1.43', '内网IP', 'Edge 145', 'Windows >=10', '0', '退出成功', '2026-02-25 16:02:32');
INSERT INTO `sys_logininfor` VALUES (141, 'admin', '192.168.1.43', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-02-25 16:06:25');
INSERT INTO `sys_logininfor` VALUES (142, 'admin', '192.168.1.43', '内网IP', 'Edge 145', 'Windows >=10', '0', '退出成功', '2026-02-25 16:19:19');
INSERT INTO `sys_logininfor` VALUES (143, 'admin', '192.168.1.43', '内网IP', 'Edge 145', 'Windows >=10', '1', '验证码错误', '2026-02-25 16:43:44');
INSERT INTO `sys_logininfor` VALUES (144, 'admin', '192.168.1.43', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-02-25 16:43:48');
INSERT INTO `sys_logininfor` VALUES (145, 'admin', '192.168.1.43', '内网IP', 'Edge 145', 'Windows >=10', '0', '退出成功', '2026-02-25 16:45:00');
INSERT INTO `sys_logininfor` VALUES (146, 'admin', '192.168.1.43', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-02-25 16:46:12');
INSERT INTO `sys_logininfor` VALUES (147, 'admin', '192.168.1.43', '内网IP', 'Edge 145', 'Windows >=10', '0', '退出成功', '2026-02-25 16:48:42');
INSERT INTO `sys_logininfor` VALUES (148, 'admin', '192.168.1.43', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-02-25 16:48:48');
INSERT INTO `sys_logininfor` VALUES (149, 'admin', '192.168.1.43', '内网IP', 'Edge 145', 'Windows >=10', '0', '退出成功', '2026-02-25 16:48:51');
INSERT INTO `sys_logininfor` VALUES (150, 'admin', '192.168.1.43', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-02-25 16:48:57');
INSERT INTO `sys_logininfor` VALUES (151, 'admin', '192.168.1.43', '内网IP', 'Edge 145', 'Windows >=10', '0', '退出成功', '2026-02-25 16:49:01');
INSERT INTO `sys_logininfor` VALUES (152, 'admin', '192.168.1.43', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-02-25 17:12:19');
INSERT INTO `sys_logininfor` VALUES (153, 'admin', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '1', '验证码错误', '2026-02-26 08:58:13');
INSERT INTO `sys_logininfor` VALUES (154, 'admin', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-02-26 08:58:17');
INSERT INTO `sys_logininfor` VALUES (155, 'admin', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '退出成功', '2026-02-26 08:59:11');
INSERT INTO `sys_logininfor` VALUES (156, 'admin', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-03-09 11:04:06');
INSERT INTO `sys_logininfor` VALUES (157, 'admin', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-03-09 14:36:05');
INSERT INTO `sys_logininfor` VALUES (158, 'admin', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-03-09 16:13:50');
INSERT INTO `sys_logininfor` VALUES (159, 'admin', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-03-10 08:47:40');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由名称',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2090 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 9, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2026-01-27 17:20:09', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 10, 'monitor', NULL, '', '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2026-01-27 17:20:09', '', NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 11, 'tool', NULL, '', '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2026-01-27 17:20:09', '', NULL, '系统工具目录');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2026-01-27 17:20:09', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2026-01-27 17:20:09', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2026-01-27 17:20:09', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2026-01-27 17:20:09', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2026-01-27 17:20:09', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2026-01-27 17:20:09', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2026-01-27 17:20:09', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2026-01-27 17:20:09', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2026-01-27 17:20:09', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2026-01-27 17:20:09', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2026-01-27 17:20:09', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2026-01-27 17:20:09', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2026-01-27 17:20:09', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2026-01-27 17:20:09', '', NULL, '缓存列表菜单');
INSERT INTO `sys_menu` VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2026-01-27 17:20:09', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2026-01-27 17:20:09', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2026-01-27 17:20:09', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2026-01-27 17:20:09', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2026-01-27 17:20:09', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2026-01-27 17:20:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2026-01-27 17:20:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2026-01-27 17:20:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2026-01-27 17:20:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2026-01-27 17:20:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2026-01-27 17:20:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2026-01-27 17:20:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2026-01-27 17:20:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2026-01-27 17:20:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2026-01-27 17:20:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2026-01-27 17:20:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2026-01-27 17:20:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2026-01-27 17:20:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2026-01-27 17:20:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2026-01-27 17:20:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2026-01-27 17:20:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2026-01-27 17:20:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2026-01-27 17:20:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2026-01-27 17:20:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2026-01-27 17:20:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2026-01-27 17:20:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2026-01-27 17:20:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2026-01-27 17:20:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2026-01-27 17:20:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2026-01-27 17:20:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2026-01-27 17:20:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2026-01-27 17:20:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2026-01-27 17:20:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2026-01-27 17:20:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2026-01-27 17:20:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2026-01-27 17:20:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2026-01-27 17:20:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2026-01-27 17:20:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2026-01-27 17:20:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2026-01-27 17:20:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2026-01-27 17:20:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2026-01-27 17:20:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2026-01-27 17:20:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2026-01-27 17:20:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2026-01-27 17:20:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2026-01-27 17:20:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2026-01-27 17:20:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2026-01-27 17:20:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2026-01-27 17:20:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2026-01-27 17:20:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2026-01-27 17:20:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2026-01-27 17:20:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2026-01-27 17:20:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2026-01-27 17:20:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2026-01-27 17:20:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2026-01-27 17:20:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2026-01-27 17:20:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2026-01-27 17:20:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2026-01-27 17:20:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2026-01-27 17:20:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 116, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2026-01-27 17:20:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 116, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2026-01-27 17:20:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 116, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2026-01-27 17:20:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 116, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2026-01-27 17:20:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 116, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2026-01-27 17:20:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 116, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2026-01-27 17:20:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, '患者管理', 0, 1, 'patient', '', NULL, '', 1, 0, 'M', '0', '0', '', 'table', 'admin', '2026-01-27 19:21:08', '', NULL, '患者管理');
INSERT INTO `sys_menu` VALUES (2001, '医生管理', 0, 2, 'doctor', '', NULL, '', 1, 0, 'M', '0', '0', '', 'table', 'admin', '2026-01-27 19:29:01', 'admin', '2026-01-27 19:31:09', '医护人员信息管理');
INSERT INTO `sys_menu` VALUES (2005, '药品管理', 0, 3, 'medicine', '', NULL, '', 1, 0, 'M', '0', '0', '', 'table', 'admin', '2026-01-27 19:29:01', 'admin', '2026-01-27 19:31:43', '药品信息管理');
INSERT INTO `sys_menu` VALUES (2022, '药品查询', 2029, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'hospital:medicine:query', '#', 'admin', '2026-01-27 19:34:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2023, '药品新增', 2029, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'hospital:medicine:add', '#', 'admin', '2026-01-27 19:34:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2024, '药品修改', 2029, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'hospital:medicine:edit', '#', 'admin', '2026-01-27 19:34:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2025, '药品删除', 2029, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'hospital:medicine:remove', '#', 'admin', '2026-01-27 19:34:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2026, '药品导出', 2029, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'hospital:medicine:export', '#', 'admin', '2026-01-27 19:34:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2027, '库存调整', 2029, 6, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'hospital:medicine:stock', '#', 'admin', '2026-01-27 19:34:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2029, '药品信息', 2005, 1, 'medicine/info', 'hospital/medicine/info/index', NULL, 'MedicineInfo', 1, 0, 'C', '0', '0', 'hospital:medicine:list', 'list', 'admin', '2026-01-27 21:23:46', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2030, '药品分类', 2005, 2, 'medicine/category', 'hospital/medicine/category/index', NULL, 'MedicineCategory', 1, 0, 'C', '0', '0', 'hospital:category:list', 'list', 'admin', '2026-01-27 21:48:45', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2031, '药品库存', 2005, 3, 'medicine/stock', 'hospital/medicine/stock/index', NULL, 'MedicineStock', 1, 0, 'C', '0', '0', 'hospital:stock:list', 'list', 'admin', '2026-01-27 21:51:36', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2033, '药品分类查询', 2032, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'hospital:category:query', '#', 'admin', '2026-01-27 21:58:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2034, '药品分类新增', 2030, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'hospital:category:add', '#', 'admin', '2026-01-27 21:58:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2035, '药品分类修改', 2030, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'hospital:category:edit', '#', 'admin', '2026-01-27 21:58:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2036, '药品分类删除', 2030, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'hospital:category:remove', '#', 'admin', '2026-01-27 21:58:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2037, '药品分类导出', 2030, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'hospital:category:export', '#', 'admin', '2026-01-27 21:58:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2039, '药品库存查询', 2031, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'hospital:stock:query', '#', 'admin', '2026-01-28 09:41:25', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2040, '药品库存新增', 2031, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'hospital:stock:add', '#', 'admin', '2026-01-28 09:41:25', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2041, '药品库存修改', 2031, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'hospital:stock:edit', '#', 'admin', '2026-01-28 09:41:25', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2042, '药品库存删除', 2031, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'hospital:stock:remove', '#', 'admin', '2026-01-28 09:41:25', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2043, '药品库存导出', 2031, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'hospital:stock:export', '#', 'admin', '2026-01-28 09:41:25', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2044, '患者档案', 2000, 0, 'patient/profile', 'hospital/patient/profile/index', NULL, '', 1, 0, 'C', '0', '0', 'hospital:patient:list', 'education', 'admin', '2026-01-28 11:34:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2045, '就诊记录', 2000, 0, 'patient/record', 'hospital/patient/record/index', NULL, '', 1, 0, 'C', '0', '0', 'hospital:medical:list', 'dict', 'admin', '2026-01-28 11:35:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2046, '医生信息', 2001, 0, 'doctor/info', 'hospital/doctor/info/index', NULL, '', 1, 0, 'C', '0', '0', 'hospital:doctor:list', 'list', 'admin', '2026-01-28 11:40:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2047, '医生排班', 2001, 0, 'doctor/schedule', 'hospital/doctor/schedule/index', NULL, 'DoctorSchedule', 1, 0, 'C', '0', '0', 'hospital:schedule:list', 'date', 'admin', '2026-01-28 12:46:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2048, '诊疗管理', 0, 4, 'diagnosis', NULL, NULL, '', 1, 0, 'M', '0', '0', '', 'documentation', 'admin', '2026-01-28 12:49:09', 'admin', '2026-01-28 12:49:27', '');
INSERT INTO `sys_menu` VALUES (2049, '预约挂号', 2048, 0, 'diagnosis/appointment', 'hospital/diagnosis/appointment/index', NULL, 'DiagnosisAppointment', 1, 0, 'C', '0', '0', 'hospital:appointment:list', 'list', 'admin', '2026-01-28 12:53:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2050, '门诊就诊', 2048, 0, 'diagnosis/record', 'hospital/diagnosis/record/index', NULL, 'DiagnosisOutpatient', 1, 0, 'C', '0', '0', 'hospital:outpatient:list', 'list', 'admin', '2026-01-28 12:56:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2051, '检查检验', 2048, 0, 'diagnosis/examination', 'hospital/diagnosis/examination/index', NULL, 'DiagnosisExamination', 1, 0, 'C', '0', '0', 'hospital:examination:list', 'list', 'admin', '2026-01-28 12:57:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2052, '处方管理', 2048, 0, 'diagnosis/prescription', 'hospital/diagnosis/prescription/index', NULL, 'DiagnosisPrescription', 1, 0, 'C', '0', '0', 'hospital:prescription:list', 'list', 'admin', '2026-01-28 12:58:50', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2053, '医护人员信息查询', 2046, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'doctor:info:query', '#', 'admin', '2026-01-28 14:49:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2054, '医护人员信息新增', 2046, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'doctor:info:add', '#', 'admin', '2026-01-28 14:49:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2055, '医护人员信息修改', 2046, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'doctor:info:edit', '#', 'admin', '2026-01-28 14:49:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2056, '医护人员信息删除', 2046, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'doctor:info:remove', '#', 'admin', '2026-01-28 14:49:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2057, '医护人员信息导出', 2046, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'doctor:info:export', '#', 'admin', '2026-01-28 14:49:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2058, '医生排班查询', 2047, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'hospital:schedule:query', '#', 'admin', '2026-01-28 15:20:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2059, '医生排班新增', 2047, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'hospital:schedule:add', '#', 'admin', '2026-01-28 15:20:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2060, '医生排班修改', 2047, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'hospital:schedule:edit', '#', 'admin', '2026-01-28 15:20:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2061, '医生排班删除', 2047, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'hospital:schedule:remove', '#', 'admin', '2026-01-28 15:20:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2062, '医生排班导出', 2047, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'hospital:schedule:export', '#', 'admin', '2026-01-28 15:20:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2063, '患者信息查询', 2044, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'hospital:patient:query', '#', 'admin', '2026-02-09 09:24:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2064, '患者信息新增', 2044, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'hospital:patient:add', '#', 'admin', '2026-02-09 09:24:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2065, '患者信息修改', 2044, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'hospital:patient:edit', '#', 'admin', '2026-02-09 09:24:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2066, '患者信息删除', 2044, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'hospital:patient:remove', '#', 'admin', '2026-02-09 09:24:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2067, '患者信息导出', 2044, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'hospital:patient:export', '#', 'admin', '2026-02-09 09:24:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2068, '就诊记录查询', 2049, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'hospital:record:query', '#', 'admin', '2026-02-09 09:31:33', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2069, '就诊记录新增', 2049, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'hospital:record:add', '#', 'admin', '2026-02-09 09:31:33', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2070, '就诊记录修改', 2049, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'hospital:record:edit', '#', 'admin', '2026-02-09 09:31:33', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2071, '就诊记录删除', 2049, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'hospital:record:remove', '#', 'admin', '2026-02-09 09:31:33', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2072, '就诊记录导出', 2049, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'hospital:record:export', '#', 'admin', '2026-02-09 09:31:33', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2073, '预约挂号查询', 2049, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'diagnosis:appointment:query', '#', 'admin', '2026-02-09 10:33:25', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2074, '预约挂号新增', 2049, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'diagnosis:appointment:add', '#', 'admin', '2026-02-09 10:33:25', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2075, '预约挂号修改', 2049, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'diagnosis:appointment:edit', '#', 'admin', '2026-02-09 10:33:25', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2076, '预约挂号删除', 2049, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'diagnosis:appointment:remove', '#', 'admin', '2026-02-09 10:33:25', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2077, '预约挂号导出', 2049, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'diagnosis:appointment:export', '#', 'admin', '2026-02-09 10:33:25', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2078, '处方查询', 2052, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'diagnosis:prescription:query', '#', 'admin', '2026-02-09 10:52:43', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2079, '处方新增', 2052, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'diagnosis:prescription:add', '#', 'admin', '2026-02-09 10:52:43', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2080, '处方修改', 2052, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'diagnosis:prescription:edit', '#', 'admin', '2026-02-09 10:52:43', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2081, '处方删除', 2052, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'diagnosis:prescription:remove', '#', 'admin', '2026-02-09 10:52:43', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2082, '处方导出', 2052, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'diagnosis:prescription:export', '#', 'admin', '2026-02-09 10:52:43', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2083, '处方查询', 2050, 1, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', NULL, '#', 'admin', '2026-02-09 16:49:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2084, '就诊记录新增', 2050, 2, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'hospital:record:add', '#', 'admin', '2026-02-09 16:51:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2085, '就诊记录修改', 2050, 0, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', NULL, '#', 'admin', '2026-02-09 16:51:56', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2086, '就诊记录删除', 2050, 0, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', NULL, '#', 'admin', '2026-02-09 16:52:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2087, '就诊记录导出', 2050, 0, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'hospital:record:export', '#', 'admin', '2026-02-09 16:52:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2088, '获取患者草稿处方', 2050, 0, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', '', '#', 'admin', '2026-02-09 16:53:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2089, '预约挂号查询', 2050, 0, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'diagnosis:appointment:query', '#', 'admin', '2026-03-09 16:28:46', '', NULL, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2026-01-27 17:20:11', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2026-01-27 17:20:11', '', NULL, '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 233 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"table\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"患者管理\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"communityhospital/patient/index\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 19:21:08', 26);
INSERT INTO `sys_oper_log` VALUES (101, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"hospital/doctor/index\",\"createTime\":\"2026-01-27 19:29:01\",\"icon\":\"table\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"医生管理\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"doctor\",\"perms\":\"hospital:doctor:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 19:31:09', 15);
INSERT INTO `sys_oper_log` VALUES (102, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"hospital/department/index\",\"createTime\":\"2026-01-27 19:29:01\",\"icon\":\"table\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"科室管理\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":0,\"path\":\"department\",\"perms\":\"hospital:department:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 19:31:17', 15);
INSERT INTO `sys_oper_log` VALUES (103, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"hospital/schedule/index\",\"createTime\":\"2026-01-27 19:29:01\",\"icon\":\"table\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2003,\"menuName\":\"排班管理\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"schedule\",\"perms\":\"hospital:schedule:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 19:31:24', 15);
INSERT INTO `sys_oper_log` VALUES (104, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"hospital/appointment/index\",\"createTime\":\"2026-01-27 19:29:01\",\"icon\":\"table\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2004,\"menuName\":\"预约管理\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":0,\"path\":\"appointment\",\"perms\":\"hospital:appointment:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 19:31:34', 14);
INSERT INTO `sys_oper_log` VALUES (105, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"hospital/medicine/index\",\"createTime\":\"2026-01-27 19:29:01\",\"icon\":\"table\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2005,\"menuName\":\"药品管理\",\"menuType\":\"C\",\"orderNum\":6,\"params\":{},\"parentId\":0,\"path\":\"medicine\",\"perms\":\"hospital:medicine:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 19:31:43', 16);
INSERT INTO `sys_oper_log` VALUES (106, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"hospital/prescription/index\",\"createTime\":\"2026-01-27 19:29:01\",\"icon\":\"table\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2006,\"menuName\":\"处方管理\",\"menuType\":\"C\",\"orderNum\":7,\"params\":{},\"parentId\":0,\"path\":\"prescription\",\"perms\":\"hospital:prescription:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 19:31:51', 15);
INSERT INTO `sys_oper_log` VALUES (107, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"hospital/statistics/index\",\"createTime\":\"2026-01-27 19:29:01\",\"icon\":\"table\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2007,\"menuName\":\"统计分析\",\"menuType\":\"C\",\"orderNum\":8,\"params\":{},\"parentId\":0,\"path\":\"statistics\",\"perms\":\"hospital:statistics:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 19:31:58', 15);
INSERT INTO `sys_oper_log` VALUES (108, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"ch_patient,ch_medicine\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 19:44:50', 212);
INSERT INTO `sys_oper_log` VALUES (109, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"ch_staff\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 19:45:12', 88);
INSERT INTO `sys_oper_log` VALUES (110, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"medicine\",\"className\":\"ChMedicine\",\"columns\":[{\"capJavaField\":\"MedicineId\",\"columnComment\":\"药品ID\",\"columnId\":1,\"columnName\":\"medicine_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 19:44:50\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"medicineId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"MedicineCode\",\"columnComment\":\"药品编码\",\"columnId\":2,\"columnName\":\"medicine_code\",\"columnType\":\"varchar(30)\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 19:44:50\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"medicineCode\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"MedicineName\",\"columnComment\":\"药品名称\",\"columnId\":3,\"columnName\":\"medicine_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 19:44:50\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"medicineName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"GenericName\",\"columnComment\":\"通用名\",\"columnId\":4,\"columnName\":\"generic_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 19:44:50\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 19:46:01', 69);
INSERT INTO `sys_oper_log` VALUES (111, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.synchDb()', 'GET', 1, 'admin', '研发部门', '/tool/gen/synchDb/ch_staff', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 20:01:54', 60);
INSERT INTO `sys_oper_log` VALUES (112, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.synchDb()', 'GET', 1, 'admin', '研发部门', '/tool/gen/synchDb/ch_medicine', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 20:01:56', 62);
INSERT INTO `sys_oper_log` VALUES (113, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.synchDb()', 'GET', 1, 'admin', '研发部门', '/tool/gen/synchDb/ch_patient', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 20:01:58', 65);
INSERT INTO `sys_oper_log` VALUES (114, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.synchDb()', 'GET', 1, 'admin', '研发部门', '/tool/gen/synchDb/ch_medicine', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 20:02:53', 51);
INSERT INTO `sys_oper_log` VALUES (115, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"ch_medicine\"}', NULL, 0, NULL, '2026-01-27 20:03:03', 26);
INSERT INTO `sys_oper_log` VALUES (116, '代码生成', 3, 'com.ruoyi.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '研发部门', '/tool/gen/3', '127.0.0.1', '内网IP', '[3] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 20:05:03', 10);
INSERT INTO `sys_oper_log` VALUES (117, '代码生成', 3, 'com.ruoyi.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '研发部门', '/tool/gen/1', '127.0.0.1', '内网IP', '[1] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 20:05:05', 10);
INSERT INTO `sys_oper_log` VALUES (118, '代码生成', 3, 'com.ruoyi.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '研发部门', '/tool/gen/2', '127.0.0.1', '内网IP', '[2] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 20:05:07', 9);
INSERT INTO `sys_oper_log` VALUES (119, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"ch_medicine\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 20:05:15', 58);
INSERT INTO `sys_oper_log` VALUES (120, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"medicine\",\"className\":\"ChMedicine\",\"columns\":[{\"capJavaField\":\"MedicineId\",\"columnComment\":\"药品ID\",\"columnId\":88,\"columnName\":\"medicine_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 20:05:15\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"medicineId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"MedicineCode\",\"columnComment\":\"药品编码\",\"columnId\":89,\"columnName\":\"medicine_code\",\"columnType\":\"varchar(30)\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 20:05:15\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"medicineCode\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"MedicineName\",\"columnComment\":\"药品名称\",\"columnId\":90,\"columnName\":\"medicine_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 20:05:15\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"medicineName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"GenericName\",\"columnComment\":\"通用名\",\"columnId\":91,\"columnName\":\"generic_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 20:05:15\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"is', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 20:31:33', 92);
INSERT INTO `sys_oper_log` VALUES (121, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"ch_medicine\"}', NULL, 0, NULL, '2026-01-27 20:31:37', 36);
INSERT INTO `sys_oper_log` VALUES (122, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"medicine\",\"className\":\"ChMedicine\",\"columns\":[{\"capJavaField\":\"MedicineId\",\"columnComment\":\"药品ID\",\"columnId\":88,\"columnName\":\"medicine_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 20:05:15\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"medicineId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"updateTime\":\"2026-01-27 20:31:33\",\"usableColumn\":false},{\"capJavaField\":\"MedicineCode\",\"columnComment\":\"药品编码\",\"columnId\":89,\"columnName\":\"medicine_code\",\"columnType\":\"varchar(30)\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 20:05:15\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"medicineCode\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"updateTime\":\"2026-01-27 20:31:33\",\"usableColumn\":false},{\"capJavaField\":\"MedicineName\",\"columnComment\":\"药品名称\",\"columnId\":90,\"columnName\":\"medicine_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 20:05:15\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"medicineName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"updateTime\":\"2026-01-27 20:31:33\",\"usableColumn\":false},{\"capJavaField\":\"GenericName\",\"columnComment\":\"通用名\",\"columnId\":91,\"columnName\":\"generic_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 20:05:15\",\"dictType\":\"\",\"edit\":', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 20:38:48', 43);
INSERT INTO `sys_oper_log` VALUES (123, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"ch_medicine\"}', NULL, 0, NULL, '2026-01-27 20:38:52', 24);
INSERT INTO `sys_oper_log` VALUES (124, '药品信息', 1, 'com.ruoyi.hospital.controller.ChMedicineController.add()', 'POST', 1, 'admin', '研发部门', '/hospital/medicine', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-01-27 20:45:25\",\"genericName\":\"31\",\"medicineCode\":\"12312\",\"medicineName\":\"312312\",\"params\":{},\"salePrice\":23123} ', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'generic_name\' in \'field list\'\r\n### The error may exist in file [C:\\Users\\ASUSAAAA\\Desktop\\system\\community-hospital\\ruoyi-admin\\target\\classes\\mapper\\hospital\\ChMedicineMapper.xml]\r\n### The error may involve com.ruoyi.hospital.mapper.ChMedicineMapper.insertChMedicine-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into ch_medicine          ( medicine_code,             medicine_name,             generic_name,                                                                                           sale_price,                                                                 create_time )           values ( ?,             ?,             ?,                                                                                           ?,                                                                 ? )\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'generic_name\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'generic_name\' in \'field list\'', '2026-01-27 20:45:25', 42);
INSERT INTO `sys_oper_log` VALUES (125, '药品信息', 1, 'com.ruoyi.hospital.controller.ChMedicineController.add()', 'POST', 1, 'admin', '研发部门', '/hospital/medicine', '127.0.0.1', '内网IP', '{\"approvalNumber\":\"232\",\"categoryId\":23,\"createTime\":\"2026-01-27 20:46:45\",\"genericName\":\"323\",\"isPrescription\":1,\"manufacturer\":\"323\",\"medicineCode\":\"medicine1\",\"medicineName\":\"测试药品1\",\"params\":{},\"purchasePrice\":323,\"remark\":\"323\",\"salePrice\":23123,\"specification\":\"323\",\"stockWarning\":323,\"validityPeriod\":323} ', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'generic_name\' in \'field list\'\r\n### The error may exist in file [C:\\Users\\ASUSAAAA\\Desktop\\system\\community-hospital\\ruoyi-admin\\target\\classes\\mapper\\hospital\\ChMedicineMapper.xml]\r\n### The error may involve com.ruoyi.hospital.mapper.ChMedicineMapper.insertChMedicine-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into ch_medicine          ( medicine_code,             medicine_name,             generic_name,             specification,             category_id,             manufacturer,             approval_number,             is_prescription,             purchase_price,             sale_price,             stock_warning,             validity_period,                                       create_time,                                       remark )           values ( ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,                                       ?,                                       ? )\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'generic_name\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'generic_name\' in \'field list\'', '2026-01-27 20:46:45', 7);
INSERT INTO `sys_oper_log` VALUES (126, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.synchDb()', 'GET', 1, 'admin', '研发部门', '/tool/gen/synchDb/ch_medicine', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 21:00:21', 89);
INSERT INTO `sys_oper_log` VALUES (127, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"ch_medicine\"}', NULL, 0, NULL, '2026-01-27 21:00:24', 98);
INSERT INTO `sys_oper_log` VALUES (128, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"ch_medicine\"}', NULL, 0, NULL, '2026-01-27 21:01:30', 24);
INSERT INTO `sys_oper_log` VALUES (129, '药品信息', 5, 'com.ruoyi.hospital.controller.ChMedicineController.export()', 'POST', 1, 'admin', '研发部门', '/hospital/medicine/export', '127.0.0.1', '内网IP', '{\"pageSize\":\"10\",\"pageNum\":\"1\"}', NULL, 0, NULL, '2026-01-27 21:03:34', 392);
INSERT INTO `sys_oper_log` VALUES (130, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"hospital/medicine/index\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"药品信息\",\"menuType\":\"C\",\"orderNum\":7,\"params\":{},\"parentId\":2005,\"path\":\"medicine\",\"perms\":\"hospital:medicine:view\",\"routeName\":\"Medicine\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"新增菜单\'药品信息\'失败，路由名称或地址已存在\",\"code\":500}', 0, NULL, '2026-01-27 21:13:54', 12);
INSERT INTO `sys_oper_log` VALUES (131, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"hospital/medicine/index\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"药品信息\",\"menuType\":\"C\",\"orderNum\":7,\"params\":{},\"parentId\":2005,\"path\":\"medicine\",\"perms\":\"hospital:medicine:view\",\"routeName\":\"Medicine\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"新增菜单\'药品信息\'失败，路由名称或地址已存在\",\"code\":500}', 0, NULL, '2026-01-27 21:13:59', 7);
INSERT INTO `sys_oper_log` VALUES (132, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"hospital/medicine/index\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"药品信息\",\"menuType\":\"C\",\"orderNum\":7,\"params\":{},\"parentId\":2005,\"path\":\"medicine\",\"perms\":\"hospital:medicine:view\",\"routeName\":\"Medicine\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"新增菜单\'药品信息\'失败，路由名称或地址已存在\",\"code\":500}', 0, NULL, '2026-01-27 21:18:19', 8);
INSERT INTO `sys_oper_log` VALUES (133, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"hospital/medicine/index\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"药品信息\",\"menuType\":\"C\",\"orderNum\":7,\"params\":{},\"parentId\":2005,\"path\":\"info\",\"perms\":\"hospital:medicine:view\",\"routeName\":\"Medicine\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"新增菜单\'药品信息\'失败，路由名称或地址已存在\",\"code\":500}', 0, NULL, '2026-01-27 21:23:29', 9);
INSERT INTO `sys_oper_log` VALUES (134, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"hospital/medicine/index\",\"createBy\":\"admin\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"药品信息\",\"menuType\":\"C\",\"orderNum\":7,\"params\":{},\"parentId\":2005,\"path\":\"info\",\"perms\":\"hospital:medicine:view\",\"routeName\":\"info\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 21:23:46', 20);
INSERT INTO `sys_oper_log` VALUES (135, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"medicine\",\"className\":\"ChMedicine\",\"columns\":[{\"capJavaField\":\"MedicineId\",\"columnComment\":\"药品ID\",\"columnId\":88,\"columnName\":\"medicine_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 20:05:15\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"medicineId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"updateTime\":\"2026-01-27 21:00:21\",\"usableColumn\":false},{\"capJavaField\":\"MedicineCode\",\"columnComment\":\"药品编码\",\"columnId\":89,\"columnName\":\"medicine_code\",\"columnType\":\"varchar(30)\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 20:05:15\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"medicineCode\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"updateTime\":\"2026-01-27 21:00:21\",\"usableColumn\":false},{\"capJavaField\":\"MedicineName\",\"columnComment\":\"药品名称\",\"columnId\":90,\"columnName\":\"medicine_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 20:05:15\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"medicineName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"updateTime\":\"2026-01-27 21:00:21\",\"usableColumn\":false},{\"capJavaField\":\"Specification\",\"columnComment\":\"规格\",\"columnId\":92,\"columnName\":\"specification\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 20:05:15\",\"dictType\":\"\",\"edit', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 21:31:38', 54);
INSERT INTO `sys_oper_log` VALUES (136, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"ch_medicine\"}', NULL, 0, NULL, '2026-01-27 21:31:42', 27);
INSERT INTO `sys_oper_log` VALUES (137, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"ch_medicine\"}', NULL, 0, NULL, '2026-01-27 21:32:14', 31);
INSERT INTO `sys_oper_log` VALUES (138, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"ch_medicine_category\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 21:36:49', 51);
INSERT INTO `sys_oper_log` VALUES (139, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"medicine\",\"className\":\"ChMedicine\",\"columns\":[{\"capJavaField\":\"MedicineId\",\"columnComment\":\"药品ID\",\"columnId\":88,\"columnName\":\"medicine_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 20:05:15\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"medicineId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"updateTime\":\"2026-01-27 21:31:38\",\"usableColumn\":false},{\"capJavaField\":\"MedicineCode\",\"columnComment\":\"药品编码\",\"columnId\":89,\"columnName\":\"medicine_code\",\"columnType\":\"varchar(30)\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 20:05:15\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"medicineCode\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"updateTime\":\"2026-01-27 21:31:38\",\"usableColumn\":false},{\"capJavaField\":\"MedicineName\",\"columnComment\":\"药品名称\",\"columnId\":90,\"columnName\":\"medicine_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 20:05:15\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"medicineName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"updateTime\":\"2026-01-27 21:31:38\",\"usableColumn\":false},{\"capJavaField\":\"Specification\",\"columnComment\":\"规格\",\"columnId\":92,\"columnName\":\"specification\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 20:05:15\",\"dictType\":\"\",\"edit', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 21:38:05', 55);
INSERT INTO `sys_oper_log` VALUES (140, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"category\",\"className\":\"ChMedicineCategory\",\"columns\":[{\"capJavaField\":\"CategoryId\",\"columnComment\":\"分类ID\",\"columnId\":107,\"columnName\":\"category_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 21:36:49\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"categoryId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CategoryCode\",\"columnComment\":\"分类编码\",\"columnId\":108,\"columnName\":\"category_code\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 21:36:49\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"categoryCode\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CategoryName\",\"columnComment\":\"分类名称\",\"columnId\":109,\"columnName\":\"category_name\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 21:36:49\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"categoryName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ParentId\",\"columnComment\":\"父分类ID\",\"columnId\":110,\"columnName\":\"parent_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 21:36:49\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"i', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 21:39:51', 30);
INSERT INTO `sys_oper_log` VALUES (141, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"hospital/category/index\",\"createBy\":\"admin\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"药品分类\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2005,\"path\":\"category\",\"perms\":\"hospital:category:list\",\"routeName\":\"MedicineCategory\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 21:48:45', 16);
INSERT INTO `sys_oper_log` VALUES (142, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"hospital/stock/index\",\"createBy\":\"admin\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"药品库存\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2005,\"path\":\"stock\",\"perms\":\"hospital:stock:list\",\"routeName\":\"MedicineStock\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 21:51:36', 15);
INSERT INTO `sys_oper_log` VALUES (143, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"ch_medicine_stock\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 21:52:47', 52);
INSERT INTO `sys_oper_log` VALUES (144, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"stock\",\"className\":\"ChMedicineStock\",\"columns\":[{\"capJavaField\":\"StockId\",\"columnComment\":\"库存ID\",\"columnId\":117,\"columnName\":\"stock_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 21:52:47\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"stockId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"MedicineId\",\"columnComment\":\"药品ID\",\"columnId\":118,\"columnName\":\"medicine_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 21:52:47\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"medicineId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"BatchNo\",\"columnComment\":\"批次号\",\"columnId\":119,\"columnName\":\"batch_no\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 21:52:47\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"1\",\"javaField\":\"batchNo\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ProductionDate\",\"columnComment\":\"生产日期\",\"columnId\":120,\"columnName\":\"production_date\",\"columnType\":\"date\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 21:52:47\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"datetime\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 21:53:47', 38);
INSERT INTO `sys_oper_log` VALUES (145, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"stock\",\"className\":\"ChMedicineStock\",\"columns\":[{\"capJavaField\":\"StockId\",\"columnComment\":\"库存ID\",\"columnId\":117,\"columnName\":\"stock_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 21:52:47\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"stockId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"updateTime\":\"2026-01-27 21:53:47\",\"usableColumn\":false},{\"capJavaField\":\"MedicineId\",\"columnComment\":\"药品ID\",\"columnId\":118,\"columnName\":\"medicine_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 21:52:47\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"medicineId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"updateTime\":\"2026-01-27 21:53:47\",\"usableColumn\":false},{\"capJavaField\":\"BatchNo\",\"columnComment\":\"批次号\",\"columnId\":119,\"columnName\":\"batch_no\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 21:52:47\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"1\",\"javaField\":\"batchNo\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"updateTime\":\"2026-01-27 21:53:47\",\"usableColumn\":false},{\"capJavaField\":\"ProductionDate\",\"columnComment\":\"生产日期\",\"columnId\":120,\"columnName\":\"production_date\",\"columnType\":\"date\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 21:52:47\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"datetime\",\"increme', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 21:54:52', 36);
INSERT INTO `sys_oper_log` VALUES (146, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"category\",\"className\":\"ChMedicineCategory\",\"columns\":[{\"capJavaField\":\"CategoryId\",\"columnComment\":\"分类ID\",\"columnId\":107,\"columnName\":\"category_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 21:36:49\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"categoryId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"updateTime\":\"2026-01-27 21:39:51\",\"usableColumn\":false},{\"capJavaField\":\"CategoryCode\",\"columnComment\":\"分类编码\",\"columnId\":108,\"columnName\":\"category_code\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 21:36:49\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"categoryCode\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"updateTime\":\"2026-01-27 21:39:51\",\"usableColumn\":false},{\"capJavaField\":\"CategoryName\",\"columnComment\":\"分类名称\",\"columnId\":109,\"columnName\":\"category_name\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 21:36:49\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"categoryName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"updateTime\":\"2026-01-27 21:39:51\",\"usableColumn\":false},{\"capJavaField\":\"ParentId\",\"columnComment\":\"父分类ID\",\"columnId\":110,\"columnName\":\"parent_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 21:36:49\",\"dictType\":\"\",\"edit\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 21:55:08', 25);
INSERT INTO `sys_oper_log` VALUES (147, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"ch_medicine_category\"}', NULL, 0, NULL, '2026-01-27 21:55:26', 20);
INSERT INTO `sys_oper_log` VALUES (148, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.synchDb()', 'GET', 1, 'admin', '研发部门', '/tool/gen/synchDb/ch_medicine_category', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 22:03:43', 39);
INSERT INTO `sys_oper_log` VALUES (149, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.synchDb()', 'GET', 1, 'admin', '研发部门', '/tool/gen/synchDb/ch_medicine_category', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 22:11:44', 62);
INSERT INTO `sys_oper_log` VALUES (150, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"ch_medicine_category\"}', NULL, 0, NULL, '2026-01-27 22:12:03', 96);
INSERT INTO `sys_oper_log` VALUES (151, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"stock\",\"className\":\"ChMedicineStock\",\"columns\":[{\"capJavaField\":\"StockId\",\"columnComment\":\"库存ID\",\"columnId\":117,\"columnName\":\"stock_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 21:52:47\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"stockId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"updateTime\":\"2026-01-27 21:54:52\",\"usableColumn\":false},{\"capJavaField\":\"MedicineId\",\"columnComment\":\"药品ID\",\"columnId\":118,\"columnName\":\"medicine_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 21:52:47\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"medicineId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"updateTime\":\"2026-01-27 21:54:52\",\"usableColumn\":false},{\"capJavaField\":\"BatchNo\",\"columnComment\":\"批次号\",\"columnId\":119,\"columnName\":\"batch_no\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 21:52:47\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"1\",\"javaField\":\"batchNo\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"updateTime\":\"2026-01-27 21:54:52\",\"usableColumn\":false},{\"capJavaField\":\"ProductionDate\",\"columnComment\":\"生产日期\",\"columnId\":120,\"columnName\":\"production_date\",\"columnType\":\"date\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 21:52:47\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"datetime\",\"increme', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 09:37:40', 65);
INSERT INTO `sys_oper_log` VALUES (152, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"ch_medicine_stock\"}', NULL, 0, NULL, '2026-01-28 09:37:43', 27);
INSERT INTO `sys_oper_log` VALUES (153, '药品库存', 1, 'com.ruoyi.hospital.controller.ChMedicineStockController.add()', 'POST', 1, 'admin', '研发部门', '/hospital/stock', '127.0.0.1', '内网IP', '{\"availableQuantity\":1090,\"batchNo\":\"2312\",\"createTime\":\"2026-01-28 09:44:50\",\"expiryDate\":\"2026-01-07\",\"medicineId\":1,\"params\":{},\"productionDate\":\"2026-01-05\",\"purchasePrice\":122,\"quantity\":1090,\"stockId\":7000,\"storageLocation\":\"无\",\"supplier\":\"无\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 09:44:50', 20);
INSERT INTO `sys_oper_log` VALUES (154, '药品信息', 2, 'com.ruoyi.hospital.controller.ChMedicineController.edit()', 'PUT', 1, 'admin', '研发部门', '/hospital/medicine', '127.0.0.1', '内网IP', '{\"approvalNumber\":\"国药准字Z53020799\",\"categoryId\":5,\"categoryName\":\"消化系统类\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 20:49:17\",\"isPrescription\":0,\"manufacturer\":\"云南白药集团股份有限公司\",\"medicineCode\":\"MED005\",\"medicineId\":6004,\"medicineName\":\"云南白药创可贴\",\"params\":{},\"purchasePrice\":19.9,\"remark\":\"止血镇痛，用于小面积开放性外科创伤\",\"salePrice\":35,\"specification\":\"100片/盒\",\"status\":\"0\",\"stockWarning\":100,\"updateBy\":\"admin\",\"updateTime\":\"2026-01-28 10:29:45\",\"validityPeriod\":36} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 10:29:45', 17);
INSERT INTO `sys_oper_log` VALUES (155, '药品信息', 2, 'com.ruoyi.hospital.controller.ChMedicineController.edit()', 'PUT', 1, 'admin', '研发部门', '/hospital/medicine', '127.0.0.1', '内网IP', '{\"approvalNumber\":\"国药准字J20171098\",\"categoryId\":4,\"categoryName\":\"呼吸系统类\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 20:49:17\",\"isPrescription\":1,\"manufacturer\":\"阿斯利康制药有限公司\",\"medicineCode\":\"MED004\",\"medicineId\":6003,\"medicineName\":\"奥美拉唑肠溶胶囊\",\"params\":{},\"purchasePrice\":25.4,\"remark\":\"质子泵抑制剂，用于胃溃疡、反流性食管炎\",\"salePrice\":48.9,\"specification\":\"20mg*14粒/盒\",\"status\":\"1\",\"stockWarning\":15,\"updateBy\":\"admin\",\"updateTime\":\"2026-01-28 10:39:13\",\"validityPeriod\":36} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 10:39:13', 9);
INSERT INTO `sys_oper_log` VALUES (156, '药品信息', 2, 'com.ruoyi.hospital.controller.ChMedicineController.edit()', 'PUT', 1, 'admin', '研发部门', '/hospital/medicine', '127.0.0.1', '内网IP', '{\"approvalNumber\":\"国药准字J20171098\",\"categoryId\":4,\"categoryName\":\"呼吸系统类\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 20:49:17\",\"isPrescription\":1,\"manufacturer\":\"阿斯利康制药有限公司\",\"medicineCode\":\"MED004\",\"medicineId\":6003,\"medicineName\":\"奥美拉唑肠溶胶囊\",\"params\":{},\"purchasePrice\":25.4,\"remark\":\"质子泵抑制剂，用于胃溃疡、反流性食管炎\",\"salePrice\":48.9,\"specification\":\"20mg*14粒/盒\",\"status\":\"0\",\"stockWarning\":15,\"updateBy\":\"admin\",\"updateTime\":\"2026-01-28 10:39:18\",\"validityPeriod\":36} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 10:39:18', 10);
INSERT INTO `sys_oper_log` VALUES (157, '药品分类', 2, 'com.ruoyi.hospital.controller.ChMedicineCategoryController.edit()', 'PUT', 1, 'admin', '研发部门', '/hospital/category', '127.0.0.1', '内网IP', '{\"categoryCode\":\"ANTIBIOTIC\",\"categoryId\":1,\"categoryName\":\"抗生素类1\",\"createBy\":\"\",\"createTime\":\"2026-01-27 19:13:33\",\"params\":{},\"status\":\"0\",\"updateBy\":\"\",\"updateTime\":\"2026-01-28 10:47:53\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 10:47:53', 12);
INSERT INTO `sys_oper_log` VALUES (158, '药品分类', 2, 'com.ruoyi.hospital.controller.ChMedicineCategoryController.edit()', 'PUT', 1, 'admin', '研发部门', '/hospital/category', '127.0.0.1', '内网IP', '{\"categoryCode\":\"ANTIBIOTIC\",\"categoryId\":1,\"categoryName\":\"抗生素类\",\"createBy\":\"\",\"createTime\":\"2026-01-27 19:13:33\",\"params\":{},\"status\":\"0\",\"updateBy\":\"\",\"updateTime\":\"2026-01-28 10:48:03\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 10:48:03', 8);
INSERT INTO `sys_oper_log` VALUES (159, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2008', '127.0.0.1', '内网IP', '2008 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 11:26:44', 15);
INSERT INTO `sys_oper_log` VALUES (160, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2009', '127.0.0.1', '内网IP', '2009 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 11:26:46', 11);
INSERT INTO `sys_oper_log` VALUES (161, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2010', '127.0.0.1', '内网IP', '2010 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 11:26:48', 13);
INSERT INTO `sys_oper_log` VALUES (162, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2011', '127.0.0.1', '内网IP', '2011 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 11:26:50', 12);
INSERT INTO `sys_oper_log` VALUES (163, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2012', '127.0.0.1', '内网IP', '2012 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 11:26:53', 12);
INSERT INTO `sys_oper_log` VALUES (164, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2015', '127.0.0.1', '内网IP', '2015 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 11:26:58', 12);
INSERT INTO `sys_oper_log` VALUES (165, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2016', '127.0.0.1', '内网IP', '2016 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 11:27:00', 12);
INSERT INTO `sys_oper_log` VALUES (166, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2017', '127.0.0.1', '内网IP', '2017 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 11:27:02', 12);
INSERT INTO `sys_oper_log` VALUES (167, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2018', '127.0.0.1', '内网IP', '2018 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 11:27:05', 12);
INSERT INTO `sys_oper_log` VALUES (168, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2019', '127.0.0.1', '内网IP', '2019 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 11:27:08', 10);
INSERT INTO `sys_oper_log` VALUES (169, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"hospital/patient/index\",\"createBy\":\"admin\",\"icon\":\"education\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"患者档案\",\"menuType\":\"C\",\"params\":{},\"parentId\":2000,\"path\":\"profile\",\"perms\":\"hospital:patient:list\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 11:34:51', 19);
INSERT INTO `sys_oper_log` VALUES (170, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"hospital/medical/index\",\"createBy\":\"admin\",\"icon\":\"dict\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"就诊记录\",\"menuType\":\"C\",\"params\":{},\"parentId\":2000,\"path\":\"record\",\"perms\":\"hospital:medical:list\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 11:35:58', 14);
INSERT INTO `sys_oper_log` VALUES (171, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"hospital/doctor/index\\t\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"医生信息\",\"menuType\":\"C\",\"params\":{},\"parentId\":2001,\"path\":\"info\",\"perms\":\"hospital:doctor:list\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"新增菜单\'医生信息\'失败，路由名称或地址已存在\",\"code\":500}', 0, NULL, '2026-01-28 11:37:13', 7);
INSERT INTO `sys_oper_log` VALUES (172, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"hospital/doctor/index\\t\",\"createBy\":\"admin\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"医生信息\",\"menuType\":\"C\",\"params\":{},\"parentId\":2001,\"path\":\"doctor/info\",\"perms\":\"hospital:doctor:list\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 11:40:29', 14);
INSERT INTO `sys_oper_log` VALUES (173, '在线用户', 7, 'com.ruoyi.web.controller.monitor.SysUserOnlineController.forceLogout()', 'DELETE', 1, 'admin', '研发部门', '/monitor/online/e6418226-edb3-4bc0-911b-6e4afb739a2a', '127.0.0.1', '内网IP', '\"e6418226-edb3-4bc0-911b-6e4afb739a2a\" ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 12:43:59', 6);
INSERT INTO `sys_oper_log` VALUES (174, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"hospital/doctor/schedule/index\",\"createBy\":\"admin\",\"icon\":\"date\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"医生排班\",\"menuType\":\"C\",\"params\":{},\"parentId\":2001,\"path\":\"doctor/schedule\",\"perms\":\"hospital:schedule:list\",\"routeName\":\"DoctorSchedule\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 12:46:54', 15);
INSERT INTO `sys_oper_log` VALUES (175, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"icon\":\"documentation\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuName\":\"诊疗管理\",\"menuType\":\"M\",\"params\":{},\"parentId\":0,\"path\":\"diagnosis\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"新增菜单\'诊疗管理\'失败，地址必须以http(s)://开头\",\"code\":500}', 0, NULL, '2026-01-28 12:48:54', 4);
INSERT INTO `sys_oper_log` VALUES (176, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"documentation\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"诊疗管理\",\"menuType\":\"M\",\"params\":{},\"parentId\":0,\"path\":\"diagnosis\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 12:49:09', 14);
INSERT INTO `sys_oper_log` VALUES (177, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-01-28 12:49:09\",\"icon\":\"documentation\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2048,\"menuName\":\"诊疗管理\",\"menuType\":\"M\",\"params\":{},\"parentId\":0,\"path\":\"diagnosis\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 12:49:27', 14);
INSERT INTO `sys_oper_log` VALUES (178, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"hospital/diagnosis/appointment/index\",\"createBy\":\"admin\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"预约挂号\",\"menuType\":\"C\",\"params\":{},\"parentId\":2048,\"path\":\"diagnosis/appointment\",\"perms\":\"hospital:appointment:list\",\"routeName\":\"DiagnosisAppointment\\t\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 12:53:44', 14);
INSERT INTO `sys_oper_log` VALUES (179, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"hospital/diagnosis/outpatient/index\",\"createBy\":\"admin\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"门诊就诊\",\"menuType\":\"C\",\"params\":{},\"parentId\":2048,\"path\":\"diagnosis/outpatient\",\"perms\":\"hospital:outpatient:list\",\"routeName\":\"DiagnosisOutpatient\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 12:56:06', 15);
INSERT INTO `sys_oper_log` VALUES (180, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"hospital/diagnosis/examination/index\",\"createBy\":\"admin\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"检查检验\",\"menuType\":\"C\",\"params\":{},\"parentId\":2048,\"path\":\"diagnosis/examination\",\"perms\":\"hospital:examination:list\",\"routeName\":\"DiagnosisExamination\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 12:57:32', 14);
INSERT INTO `sys_oper_log` VALUES (181, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"hospital/diagnosis/prescription/index\",\"createBy\":\"admin\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"处方管理\",\"menuType\":\"C\",\"params\":{},\"parentId\":2048,\"path\":\"diagnosis/prescription\",\"perms\":\"hospital:prescription:list\",\"routeName\":\"DiagnosisPrescription\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 12:58:50', 16);
INSERT INTO `sys_oper_log` VALUES (182, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"ch_staff\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 14:39:41', 132);
INSERT INTO `sys_oper_log` VALUES (183, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"info\",\"className\":\"ChStaff\",\"columns\":[{\"capJavaField\":\"StaffId\",\"columnComment\":\"员工ID\",\"columnId\":132,\"columnName\":\"staff_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-01-28 14:39:41\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"staffId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"关联用户ID\",\"columnId\":133,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-01-28 14:39:41\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"StaffNo\",\"columnComment\":\"工号\",\"columnId\":134,\"columnName\":\"staff_no\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2026-01-28 14:39:41\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"staffNo\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"StaffName\",\"columnComment\":\"姓名\",\"columnId\":135,\"columnName\":\"staff_name\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-01-28 14:39:41\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaFie', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 14:46:27', 56);
INSERT INTO `sys_oper_log` VALUES (184, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"ch_staff\"}', NULL, 0, NULL, '2026-01-28 14:46:31', 106);
INSERT INTO `sys_oper_log` VALUES (185, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"ch_schedule\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 15:16:43', 58);
INSERT INTO `sys_oper_log` VALUES (186, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"schedule\",\"className\":\"ChSchedule\",\"columns\":[{\"capJavaField\":\"ScheduleId\",\"columnComment\":\"排班ID\",\"columnId\":149,\"columnName\":\"schedule_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-01-28 15:16:43\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"scheduleId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"StaffId\",\"columnComment\":\"医生ID\",\"columnId\":150,\"columnName\":\"staff_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-01-28 15:16:43\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"staffId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ScheduleDate\",\"columnComment\":\"排班日期\",\"columnId\":151,\"columnName\":\"schedule_date\",\"columnType\":\"date\",\"createBy\":\"admin\",\"createTime\":\"2026-01-28 15:16:43\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"datetime\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"scheduleDate\",\"javaType\":\"Date\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"TimeSlot\",\"columnComment\":\"时间段（morning上午 afternoon下午 night夜班）\",\"columnId\":152,\"columnName\":\"time_slot\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2026-01-28 15:16:43\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isLis', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 15:17:18', 41);
INSERT INTO `sys_oper_log` VALUES (187, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.synchDb()', 'GET', 1, 'admin', '研发部门', '/tool/gen/synchDb/ch_schedule', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 15:17:23', 42);
INSERT INTO `sys_oper_log` VALUES (188, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"ch_schedule\"}', NULL, 0, NULL, '2026-01-28 15:17:25', 33);
INSERT INTO `sys_oper_log` VALUES (189, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"ch_medical_record\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-09 09:06:58', 110);
INSERT INTO `sys_oper_log` VALUES (190, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"ch_patient\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-09 09:07:11', 83);
INSERT INTO `sys_oper_log` VALUES (191, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.synchDb()', 'GET', 1, 'admin', '研发部门', '/tool/gen/synchDb/ch_patient', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-09 09:07:16', 88);
INSERT INTO `sys_oper_log` VALUES (192, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.synchDb()', 'GET', 1, 'admin', '研发部门', '/tool/gen/synchDb/ch_medical_record', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-09 09:07:18', 70);
INSERT INTO `sys_oper_log` VALUES (193, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"ch_patient\"}', NULL, 0, NULL, '2026-02-09 09:07:23', 158);
INSERT INTO `sys_oper_log` VALUES (194, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"patient\",\"className\":\"ChPatient\",\"columns\":[{\"capJavaField\":\"PatientId\",\"columnComment\":\"患者ID\",\"columnId\":185,\"columnName\":\"patient_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-02-09 09:07:11\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"patientId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":10,\"updateBy\":\"\",\"updateTime\":\"2026-02-09 09:07:16\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"关联用户ID\",\"columnId\":186,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-02-09 09:07:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":10,\"updateBy\":\"\",\"updateTime\":\"2026-02-09 09:07:16\",\"usableColumn\":false},{\"capJavaField\":\"PatientNo\",\"columnComment\":\"患者编号\",\"columnId\":187,\"columnName\":\"patient_no\",\"columnType\":\"varchar(30)\",\"createBy\":\"admin\",\"createTime\":\"2026-02-09 09:07:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"patientNo\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":10,\"updateBy\":\"\",\"updateTime\":\"2026-02-09 09:07:16\",\"usableColumn\":false},{\"capJavaField\":\"IdCard\",\"columnComment\":\"身份证号\",\"columnId\":188,\"columnName\":\"id_card\",\"columnType\":\"varchar(18)\",\"createBy\":\"admin\",\"createTime\":\"2026-02-09 09:07:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-09 09:10:13', 62);
INSERT INTO `sys_oper_log` VALUES (195, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"record\",\"className\":\"ChMedicalRecord\",\"columns\":[{\"capJavaField\":\"RecordId\",\"columnComment\":\"记录ID\",\"columnId\":163,\"columnName\":\"record_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-02-09 09:06:58\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"recordId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":9,\"updateBy\":\"\",\"updateTime\":\"2026-02-09 09:07:18\",\"usableColumn\":false},{\"capJavaField\":\"RecordNo\",\"columnComment\":\"病历号\",\"columnId\":164,\"columnName\":\"record_no\",\"columnType\":\"varchar(30)\",\"createBy\":\"admin\",\"createTime\":\"2026-02-09 09:06:58\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"recordNo\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":9,\"updateBy\":\"\",\"updateTime\":\"2026-02-09 09:07:18\",\"usableColumn\":false},{\"capJavaField\":\"PatientId\",\"columnComment\":\"患者ID\",\"columnId\":165,\"columnName\":\"patient_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-02-09 09:06:58\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"patientId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":9,\"updateBy\":\"\",\"updateTime\":\"2026-02-09 09:07:18\",\"usableColumn\":false},{\"capJavaField\":\"StaffId\",\"columnComment\":\"医生ID\",\"columnId\":166,\"columnName\":\"staff_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-02-09 09:06:58\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"i', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-09 09:10:27', 51);
INSERT INTO `sys_oper_log` VALUES (196, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.synchDb()', 'GET', 1, 'admin', '研发部门', '/tool/gen/synchDb/ch_medical_record', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-09 09:10:34', 69);
INSERT INTO `sys_oper_log` VALUES (197, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.synchDb()', 'GET', 1, 'admin', '研发部门', '/tool/gen/synchDb/ch_patient', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-09 09:10:36', 65);
INSERT INTO `sys_oper_log` VALUES (198, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"ch_patient\"}', NULL, 0, NULL, '2026-02-09 09:10:37', 34);
INSERT INTO `sys_oper_log` VALUES (199, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"record\",\"className\":\"ChMedicalRecord\",\"columns\":[{\"capJavaField\":\"RecordId\",\"columnComment\":\"记录ID\",\"columnId\":163,\"columnName\":\"record_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-02-09 09:06:58\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"recordId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":9,\"updateBy\":\"\",\"updateTime\":\"2026-02-09 09:10:34\",\"usableColumn\":false},{\"capJavaField\":\"RecordNo\",\"columnComment\":\"病历号\",\"columnId\":164,\"columnName\":\"record_no\",\"columnType\":\"varchar(30)\",\"createBy\":\"admin\",\"createTime\":\"2026-02-09 09:06:58\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"recordNo\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":9,\"updateBy\":\"\",\"updateTime\":\"2026-02-09 09:10:34\",\"usableColumn\":false},{\"capJavaField\":\"PatientId\",\"columnComment\":\"患者ID\",\"columnId\":165,\"columnName\":\"patient_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-02-09 09:06:58\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"patientId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":9,\"updateBy\":\"\",\"updateTime\":\"2026-02-09 09:10:34\",\"usableColumn\":false},{\"capJavaField\":\"StaffId\",\"columnComment\":\"医生ID\",\"columnId\":166,\"columnName\":\"staff_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-02-09 09:06:58\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"i', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-09 09:29:11', 86);
INSERT INTO `sys_oper_log` VALUES (200, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.synchDb()', 'GET', 1, 'admin', '研发部门', '/tool/gen/synchDb/ch_medical_record', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-09 09:29:17', 99);
INSERT INTO `sys_oper_log` VALUES (201, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"ch_medical_record\"}', NULL, 0, NULL, '2026-02-09 09:29:31', 108);
INSERT INTO `sys_oper_log` VALUES (202, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"ch_appointment\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-09 10:26:17', 106);
INSERT INTO `sys_oper_log` VALUES (203, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"appointment\",\"className\":\"ChAppointment\",\"columns\":[{\"capJavaField\":\"AppointmentId\",\"columnComment\":\"预约ID\",\"columnId\":208,\"columnName\":\"appointment_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-02-09 10:26:17\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"appointmentId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":11,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"AppointmentNo\",\"columnComment\":\"预约号\",\"columnId\":209,\"columnName\":\"appointment_no\",\"columnType\":\"varchar(30)\",\"createBy\":\"admin\",\"createTime\":\"2026-02-09 10:26:17\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"appointmentNo\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":11,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"PatientId\",\"columnComment\":\"患者ID\",\"columnId\":210,\"columnName\":\"patient_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-02-09 10:26:17\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"patientId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":11,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"StaffId\",\"columnComment\":\"医生ID\",\"columnId\":211,\"columnName\":\"staff_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-02-09 10:26:17\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-09 10:27:13', 92);
INSERT INTO `sys_oper_log` VALUES (204, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"appointment\",\"className\":\"ChAppointment\",\"columns\":[{\"capJavaField\":\"AppointmentId\",\"columnComment\":\"预约ID\",\"columnId\":208,\"columnName\":\"appointment_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-02-09 10:26:17\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"appointmentId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":11,\"updateBy\":\"\",\"updateTime\":\"2026-02-09 10:27:13\",\"usableColumn\":false},{\"capJavaField\":\"AppointmentNo\",\"columnComment\":\"预约号\",\"columnId\":209,\"columnName\":\"appointment_no\",\"columnType\":\"varchar(30)\",\"createBy\":\"admin\",\"createTime\":\"2026-02-09 10:26:17\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"appointmentNo\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":11,\"updateBy\":\"\",\"updateTime\":\"2026-02-09 10:27:13\",\"usableColumn\":false},{\"capJavaField\":\"PatientId\",\"columnComment\":\"患者ID\",\"columnId\":210,\"columnName\":\"patient_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-02-09 10:26:17\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"patientId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":11,\"updateBy\":\"\",\"updateTime\":\"2026-02-09 10:27:13\",\"usableColumn\":false},{\"capJavaField\":\"StaffId\",\"columnComment\":\"医生ID\",\"columnId\":211,\"columnName\":\"staff_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-02-09 10:26:17\",\"dictType\":\"\",\"edit\":true,\"ht', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-09 10:30:36', 48);
INSERT INTO `sys_oper_log` VALUES (205, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"ch_appointment\"}', NULL, 0, NULL, '2026-02-09 10:30:46', 200);
INSERT INTO `sys_oper_log` VALUES (206, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"ch_prescription_detail,ch_prescription\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-09 10:45:23', 88);
INSERT INTO `sys_oper_log` VALUES (207, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"ch_prescription\"}', NULL, 0, NULL, '2026-02-09 10:45:39', 43);
INSERT INTO `sys_oper_log` VALUES (208, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"prescription\",\"className\":\"ChPrescription\",\"columns\":[{\"capJavaField\":\"PrescriptionId\",\"columnComment\":\"处方ID\",\"columnId\":227,\"columnName\":\"prescription_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-02-09 10:45:23\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"prescriptionId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":12,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"PrescriptionNo\",\"columnComment\":\"处方号\",\"columnId\":228,\"columnName\":\"prescription_no\",\"columnType\":\"varchar(30)\",\"createBy\":\"admin\",\"createTime\":\"2026-02-09 10:45:23\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"prescriptionNo\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":12,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"PatientId\",\"columnComment\":\"患者ID\",\"columnId\":229,\"columnName\":\"patient_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-02-09 10:45:23\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"patientId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":12,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"StaffId\",\"columnComment\":\"开方医生ID\",\"columnId\":230,\"columnName\":\"staff_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-02-09 10:45:23\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-09 10:50:24', 75);
INSERT INTO `sys_oper_log` VALUES (209, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"ch_prescription\"}', NULL, 0, NULL, '2026-02-09 10:50:49', 49);
INSERT INTO `sys_oper_log` VALUES (210, '用户头像', 2, 'com.ruoyi.web.controller.system.SysProfileController.avatar()', 'POST', 1, 'admin', '研发部门', '/system/user/profile/avatar', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2026/02/09/ebc36e15110c4db8972ff48a9f4372df.jpg\",\"code\":200}', 0, NULL, '2026-02-09 11:58:32', 68);
INSERT INTO `sys_oper_log` VALUES (211, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'admin', '研发部门', '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"ry@163.com\",\"nickName\":\"耄耋\",\"params\":{},\"phonenumber\":\"15888888888\",\"sex\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-09 11:58:51', 23);
INSERT INTO `sys_oper_log` VALUES (212, '医护人员信息', 5, 'com.ruoyi.hospital.controller.ChStaffController.export()', 'POST', 1, 'admin', '研发部门', '/doctor/info/export', '127.0.0.1', '内网IP', '{\"pageSize\":\"10\",\"pageNum\":\"1\"}', NULL, 0, NULL, '2026-02-09 12:05:40', 521);
INSERT INTO `sys_oper_log` VALUES (213, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '192.168.0.103', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"处方查询\",\"menuType\":\"F\",\"params\":{},\"parentId\":2050,\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-09 16:49:57', 29);
INSERT INTO `sys_oper_log` VALUES (214, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '192.168.0.103', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"就诊记录新增\",\"menuType\":\"F\",\"params\":{},\"parentId\":2050,\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-09 16:51:19', 18);
INSERT INTO `sys_oper_log` VALUES (215, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '192.168.0.103', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"就诊记录修改\",\"menuType\":\"F\",\"params\":{},\"parentId\":2050,\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-09 16:51:56', 19);
INSERT INTO `sys_oper_log` VALUES (216, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '192.168.0.103', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"就诊记录删除\",\"menuType\":\"F\",\"params\":{},\"parentId\":2050,\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-09 16:52:34', 17);
INSERT INTO `sys_oper_log` VALUES (217, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '192.168.0.103', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"就诊记录导出\",\"menuType\":\"F\",\"params\":{},\"parentId\":2050,\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-09 16:52:49', 13);
INSERT INTO `sys_oper_log` VALUES (218, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '192.168.0.103', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"获取患者草稿处方\",\"menuType\":\"F\",\"params\":{},\"parentId\":2050,\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-09 16:53:07', 16);
INSERT INTO `sys_oper_log` VALUES (219, '预约挂号', 5, 'com.ruoyi.hospital.controller.ChAppointmentController.export()', 'POST', 1, 'admin', '研发部门', '/diagnosis/appointment/export', '192.168.0.103', '内网IP', '{\"pageSize\":\"10\",\"pageNum\":\"1\"}', NULL, 0, NULL, '2026-02-09 16:59:12', 471);
INSERT INTO `sys_oper_log` VALUES (220, '预约挂号', 5, 'com.ruoyi.hospital.controller.ChAppointmentController.export()', 'POST', 1, 'admin', '研发部门', '/diagnosis/appointment/export', '127.0.0.1', '内网IP', '{\"pageSize\":\"10\",\"pageNum\":\"1\"}', NULL, 0, NULL, '2026-02-09 17:07:14', 25);
INSERT INTO `sys_oper_log` VALUES (221, '医护人员信息', 3, 'com.ruoyi.hospital.controller.ChStaffController.remove()', 'DELETE', 1, 'admin', '研发部门', '/doctor/info/1002', '127.0.0.1', '内网IP', '[1002] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-09 17:16:48', 20);
INSERT INTO `sys_oper_log` VALUES (222, '用户管理', 4, 'com.ruoyi.web.controller.system.SysUserController.insertAuthRole()', 'PUT', 1, 'admin', '研发部门', '/system/user/authRole', '192.168.1.43', '内网IP', '{\"roleIds\":\"2\",\"userId\":\"2\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-25 15:54:23', 65);
INSERT INTO `sys_oper_log` VALUES (223, '医生排班', 1, 'com.ruoyi.hospital.controller.ChScheduleController.add()', 'POST', 1, 'admin', '研发部门', '/hospital/schedule', '192.168.1.43', '内网IP', '{\"createTime\":\"2026-02-25 17:22:21\",\"currentPatients\":323,\"fee\":32,\"maxPatients\":323,\"params\":{},\"roomNo\":\"2323\",\"scheduleDate\":\"2026-02-04\",\"scheduleId\":3000,\"staffId\":1,\"timeSlot\":\"2323\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-25 17:22:21', 20);
INSERT INTO `sys_oper_log` VALUES (224, '预约挂号', 1, 'com.ruoyi.hospital.controller.ChAppointmentController.add()', 'POST', 1, 'admin', '研发部门', '/diagnosis/appointment', '127.0.0.1', '内网IP', '{\"appointmentDate\":\"2026-03-03\",\"appointmentId\":4000,\"appointmentNo\":\"1\",\"appointmentTime\":\"2026-03-03\",\"createTime\":\"2026-03-09 11:41:01\",\"deptId\":1,\"fee\":1,\"params\":{},\"patientId\":1,\"queueNumber\":1,\"scheduleId\":1,\"source\":\"1\",\"staffId\":1,\"symptoms\":\"1\",\"timeSlot\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-09 11:41:01', 22);
INSERT INTO `sys_oper_log` VALUES (225, '预约挂号', 2, 'com.ruoyi.hospital.controller.ChAppointmentController.edit()', 'PUT', 1, 'admin', '研发部门', '/diagnosis/appointment', '127.0.0.1', '内网IP', '{\"appointmentDate\":\"2026-03-03\",\"appointmentId\":4000,\"appointmentNo\":\"1\",\"appointmentStatus\":\"pending\",\"appointmentTime\":\"2026-03-03\",\"arriveTime\":\"2026-03-10\",\"createTime\":\"2026-03-09 11:41:02\",\"deptId\":1,\"fee\":1,\"params\":{},\"patientId\":1,\"paymentStatus\":\"0\",\"queueNumber\":1,\"scheduleId\":1,\"source\":\"1\",\"staffId\":1,\"symptoms\":\"1\",\"timeSlot\":\"1\",\"updateTime\":\"2026-03-09 11:41:39\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-09 11:41:39', 10);
INSERT INTO `sys_oper_log` VALUES (226, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"预约挂号查询\",\"menuType\":\"F\",\"params\":{},\"parentId\":2050,\"perms\":\"diagnosis:appointment:query\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-09 16:28:46', 29);
INSERT INTO `sys_oper_log` VALUES (227, '预约挂号', 2, 'com.ruoyi.hospital.controller.ChAppointmentController.edit()', 'PUT', 1, 'admin', '研发部门', '/diagnosis/appointment', '127.0.0.1', '内网IP', '{\"appointmentDate\":\"2026-03-03\",\"appointmentId\":4000,\"appointmentNo\":\"1\",\"appointmentStatus\":\"confirmed\",\"appointmentTime\":\"2026-03-03\",\"arriveTime\":\"2026-03-10\",\"createTime\":\"2026-03-09 11:41:02\",\"deptId\":1,\"fee\":1,\"params\":{},\"patientId\":1,\"paymentStatus\":\"0\",\"queueNumber\":1,\"scheduleId\":1,\"source\":\"1\",\"staffId\":1,\"symptoms\":\"1\",\"timeSlot\":\"1\",\"updateTime\":\"2026-03-09 17:04:04\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-09 17:04:04', 21);
INSERT INTO `sys_oper_log` VALUES (228, '预约挂号', 2, 'com.ruoyi.hospital.controller.ChAppointmentController.edit()', 'PUT', 1, 'admin', '研发部门', '/diagnosis/appointment', '127.0.0.1', '内网IP', '{\"appointmentDate\":\"2026-03-09\",\"appointmentId\":4000,\"appointmentNo\":\"1\",\"appointmentStatus\":\"confirmed\",\"appointmentTime\":\"2026-03-09\",\"arriveTime\":\"2026-03-10\",\"createTime\":\"2026-03-09 11:41:02\",\"deptId\":1,\"fee\":1,\"params\":{},\"patientId\":1,\"paymentStatus\":\"0\",\"queueNumber\":1,\"scheduleId\":1,\"source\":\"1\",\"staffId\":1,\"symptoms\":\"1\",\"timeSlot\":\"1\",\"updateTime\":\"2026-03-09 17:11:15\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-09 17:11:15', 11);
INSERT INTO `sys_oper_log` VALUES (229, '处方', 1, 'com.ruoyi.hospital.controller.ChPrescriptionController.add()', 'POST', 1, 'admin', '研发部门', '/diagnosis/prescription', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-03-09 17:16:15\",\"diagnosis\":\"\",\"params\":{},\"patientId\":1,\"prescriptionStatus\":\"confirmed\",\"staffId\":1} ', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'prescription_no\' doesn\'t have a default value\r\n### The error may exist in file [C:\\Users\\ASUSAAAA\\Desktop\\system\\community-hospital\\ruoyi-admin\\target\\classes\\mapper\\hospital\\ChPrescriptionMapper.xml]\r\n### The error may involve com.ruoyi.hospital.mapper.ChPrescriptionMapper.insertChPrescription-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into ch_prescription          ( patient_id,             staff_id,                          diagnosis,                                                    prescription_status,                                       create_time )           values ( ?,             ?,                          ?,                                                    ?,                                       ? )\r\n### Cause: java.sql.SQLException: Field \'prescription_no\' doesn\'t have a default value\n; Field \'prescription_no\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'prescription_no\' doesn\'t have a default value', '2026-03-09 17:16:15', 44);
INSERT INTO `sys_oper_log` VALUES (230, '处方', 1, 'com.ruoyi.hospital.controller.ChPrescriptionController.add()', 'POST', 1, 'admin', '研发部门', '/diagnosis/prescription', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-03-09 17:16:28\",\"diagnosis\":\"\",\"params\":{},\"patientId\":1,\"prescriptionStatus\":\"confirmed\",\"staffId\":1} ', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'prescription_no\' doesn\'t have a default value\r\n### The error may exist in file [C:\\Users\\ASUSAAAA\\Desktop\\system\\community-hospital\\ruoyi-admin\\target\\classes\\mapper\\hospital\\ChPrescriptionMapper.xml]\r\n### The error may involve com.ruoyi.hospital.mapper.ChPrescriptionMapper.insertChPrescription-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into ch_prescription          ( patient_id,             staff_id,                          diagnosis,                                                    prescription_status,                                       create_time )           values ( ?,             ?,                          ?,                                                    ?,                                       ? )\r\n### Cause: java.sql.SQLException: Field \'prescription_no\' doesn\'t have a default value\n; Field \'prescription_no\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'prescription_no\' doesn\'t have a default value', '2026-03-09 17:16:28', 5);
INSERT INTO `sys_oper_log` VALUES (231, '预约挂号', 2, 'com.ruoyi.hospital.controller.ChAppointmentController.edit()', 'PUT', 1, 'admin', '研发部门', '/diagnosis/appointment', '127.0.0.1', '内网IP', '{\"appointmentDate\":\"2026-03-10\",\"appointmentId\":4000,\"appointmentNo\":\"1\",\"appointmentStatus\":\"confirmed\",\"appointmentTime\":\"2026-03-09\",\"arriveTime\":\"2026-03-10\",\"createTime\":\"2026-03-09 11:41:02\",\"deptId\":1,\"fee\":1,\"params\":{},\"patientId\":1,\"paymentStatus\":\"0\",\"queueNumber\":1,\"scheduleId\":1,\"source\":\"1\",\"staffId\":1,\"symptoms\":\"1\",\"timeSlot\":\"1\",\"updateTime\":\"2026-03-10 08:50:44\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-10 08:50:44', 19);
INSERT INTO `sys_oper_log` VALUES (232, '预约挂号', 2, 'com.ruoyi.hospital.controller.ChAppointmentController.edit()', 'PUT', 1, 'admin', '研发部门', '/diagnosis/appointment', '127.0.0.1', '内网IP', '{\"appointmentDate\":\"2026-03-10\",\"appointmentId\":4000,\"appointmentNo\":\"1\",\"appointmentStatus\":\"confirmed\",\"appointmentTime\":\"2026-03-10\",\"arriveTime\":\"2026-03-10\",\"createTime\":\"2026-03-09 11:41:02\",\"deptId\":1,\"fee\":1,\"params\":{},\"patientId\":1,\"paymentStatus\":\"0\",\"queueNumber\":1,\"scheduleId\":1,\"source\":\"1\",\"staffId\":1,\"symptoms\":\"1\",\"timeSlot\":\"1\",\"updateTime\":\"2026-03-10 08:50:51\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-10 08:50:51', 9);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2026-01-27 17:20:09', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2026-01-27 17:20:09', '', NULL, '普通角色');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 114);
INSERT INTO `sys_role_menu` VALUES (2, 115);
INSERT INTO `sys_role_menu` VALUES (2, 116);
INSERT INTO `sys_role_menu` VALUES (2, 117);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1046);
INSERT INTO `sys_role_menu` VALUES (2, 1047);
INSERT INTO `sys_role_menu` VALUES (2, 1048);
INSERT INTO `sys_role_menu` VALUES (2, 1049);
INSERT INTO `sys_role_menu` VALUES (2, 1050);
INSERT INTO `sys_role_menu` VALUES (2, 1051);
INSERT INTO `sys_role_menu` VALUES (2, 1052);
INSERT INTO `sys_role_menu` VALUES (2, 1053);
INSERT INTO `sys_role_menu` VALUES (2, 1054);
INSERT INTO `sys_role_menu` VALUES (2, 1055);
INSERT INTO `sys_role_menu` VALUES (2, 1056);
INSERT INTO `sys_role_menu` VALUES (2, 1057);
INSERT INTO `sys_role_menu` VALUES (2, 1058);
INSERT INTO `sys_role_menu` VALUES (2, 1059);
INSERT INTO `sys_role_menu` VALUES (2, 1060);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `pwd_update_date` datetime NULL DEFAULT NULL COMMENT '密码最后更新时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '耄耋', '00', 'ry@163.com', '15888888888', '1', '/profile/avatar/2026/02/09/ebc36e15110c4db8972ff48a9f4372df.jpg', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-03-10 08:47:39', '2026-01-27 17:20:09', 'admin', '2026-01-27 17:20:09', '', '2026-02-09 11:58:51', '管理员');
INSERT INTO `sys_user` VALUES (2, 105, 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-01-27 17:20:09', '2026-01-27 17:20:09', 'admin', '2026-01-27 17:20:09', '', NULL, '测试员');

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);

-- ----------------------------
-- Procedure structure for generate_patient_no
-- ----------------------------
DROP PROCEDURE IF EXISTS `generate_patient_no`;
delimiter ;;
CREATE PROCEDURE `generate_patient_no`(OUT patient_no VARCHAR(30))
BEGIN
    DECLARE seq INT;
    SET @date_str = DATE_FORMAT(NOW(), '%Y%m%d');
    
    -- 获取当天的序列号
    SELECT COALESCE(MAX(SUBSTRING(patient_no, 11)), 0) + 1 INTO seq
    FROM ch_patient 
    WHERE patient_no LIKE CONCAT('PT', @date_str, '%');
    
    SET patient_no = CONCAT('PT', @date_str, LPAD(seq, 6, '0'));
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
