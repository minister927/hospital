package com.ruoyi.hospital.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import java.util.Date;

public class ChMedicalRecord extends BaseEntity {
    private static final long serialVersionUID = 1L;

    private Long recordId;           // 记录ID
    @Excel(name = "病历号")
    private String recordNo;         // 病历号
    @Excel(name = "患者ID")
    private Long patientId;          // 患者ID
    @Excel(name = "医生ID")
    private Long staffId;            // 医生ID
    @Excel(name = "关联处方ID")
    private Long prescriptionId;     // 关联处方ID
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "就诊日期", dateFormat = "yyyy-MM-dd")
    private Date visitDate;          // 就诊日期
    @Excel(name = "就诊类型")
    private String visitType;        // 就诊类型
    @Excel(name = "主诉")
    private String chiefComplaint;   // 主诉
    @Excel(name = "现病史")
    private String presentIllness;   // 现病史
    @Excel(name = "初步诊断")
    private String preliminaryDiagnosis; // 初步诊断
    @Excel(name = "最终诊断")
    private String finalDiagnosis;   // 最终诊断
    @Excel(name = "医嘱")
    private String medicalAdvice;    // 医嘱
    @Excel(name = "状态")
    private String recordStatus;     // 状态

    // 关联查询用
    private ChPatient patient;       // 患者信息
    private ChStaff staff;           // 医生信息
    private ChPrescription prescription; // 处方信息

    // Getter & Setter
    public Long getRecordId() { return recordId; }
    public void setRecordId(Long recordId) { this.recordId = recordId; }
    public String getRecordNo() { return recordNo; }
    public void setRecordNo(String recordNo) { this.recordNo = recordNo; }
    public Long getPatientId() { return patientId; }
    public void setPatientId(Long patientId) { this.patientId = patientId; }
    public Long getStaffId() { return staffId; }
    public void setStaffId(Long staffId) { this.staffId = staffId; }
    public Long getPrescriptionId() { return prescriptionId; }
    public void setPrescriptionId(Long prescriptionId) { this.prescriptionId = prescriptionId; }
    public Date getVisitDate() { return visitDate; }
    public void setVisitDate(Date visitDate) { this.visitDate = visitDate; }
    public String getVisitType() { return visitType; }
    public void setVisitType(String visitType) { this.visitType = visitType; }
    public String getChiefComplaint() { return chiefComplaint; }
    public void setChiefComplaint(String chiefComplaint) { this.chiefComplaint = chiefComplaint; }
    public String getPresentIllness() { return presentIllness; }
    public void setPresentIllness(String presentIllness) { this.presentIllness = presentIllness; }
    public String getPreliminaryDiagnosis() { return preliminaryDiagnosis; }
    public void setPreliminaryDiagnosis(String preliminaryDiagnosis) { this.preliminaryDiagnosis = preliminaryDiagnosis; }
    public String getFinalDiagnosis() { return finalDiagnosis; }
    public void setFinalDiagnosis(String finalDiagnosis) { this.finalDiagnosis = finalDiagnosis; }
    public String getMedicalAdvice() { return medicalAdvice; }
    public void setMedicalAdvice(String medicalAdvice) { this.medicalAdvice = medicalAdvice; }
    public String getRecordStatus() { return recordStatus; }
    public void setRecordStatus(String recordStatus) { this.recordStatus = recordStatus; }
    public ChPatient getPatient() { return patient; }
    public void setPatient(ChPatient patient) { this.patient = patient; }
    public ChStaff getStaff() { return staff; }
    public void setStaff(ChStaff staff) { this.staff = staff; }
    public ChPrescription getPrescription() { return prescription; }
    public void setPrescription(ChPrescription prescription) { this.prescription = prescription; }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("recordId", getRecordId())
                .append("recordNo", getRecordNo())
                .append("patientId", getPatientId())
                .append("staffId", getStaffId())
                .append("prescriptionId", getPrescriptionId())
                .append("visitDate", getVisitDate())
                .append("visitType", getVisitType())
                .append("chiefComplaint", getChiefComplaint())
                .append("presentIllness", getPresentIllness())
                .append("preliminaryDiagnosis", getPreliminaryDiagnosis())
                .append("finalDiagnosis", getFinalDiagnosis())
                .append("medicalAdvice", getMedicalAdvice())
                .append("recordStatus", getRecordStatus())
                .toString();
    }
}