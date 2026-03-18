package com.ruoyi.hospital.domain;

import java.math.BigDecimal;
import java.util.List;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 处方对象 ch_prescription
 * 
 * @author ruoyi
 * @date 2026-02-09
 */
public class ChPrescription extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 处方ID */
    private Long prescriptionId;

    /** 处方号 */
    @Excel(name = "处方号")
    private String prescriptionNo;

    /** 患者ID */
    @Excel(name = "患者ID")
    private Long patientId;

    /** 开方医生ID */
    @Excel(name = "开方医生ID")
    private Long staffId;

    /** 关联病历ID */
    @Excel(name = "关联病历ID")
    private Long recordId;

    /** 诊断 */
    @Excel(name = "诊断")
    private String diagnosis;

    /** 用法用量说明 */
    @Excel(name = "用法用量说明")
    private String usageInstructions;

    /** 总金额 */
    @Excel(name = "总金额")
    private BigDecimal totalAmount;

    /** 处方类型（common普通 emergency急诊） */
    @Excel(name = "处方类型", readConverterExp = "c=ommon普通,e=mergency急诊")
    private String prescriptionType;

    /** 状态（unfilled未取药 filled已取药 dispensed已发药 cancelled已退药） */
    @Excel(name = "状态", readConverterExp = "u=nfilled未取药,f=illed已取药,d=ispensed已发药,c=ancelled已退药")
    private String prescriptionStatus;

    /** 发药时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "发药时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date dispenseTime;

    /** 发药人ID */
    @Excel(name = "发药人ID")
    private Long dispenserId;

    /** 处方明细信息 */
    private List<ChPrescriptionDetail> chPrescriptionDetailList;

    public void setPrescriptionId(Long prescriptionId) 
    {
        this.prescriptionId = prescriptionId;
    }

    public Long getPrescriptionId() 
    {
        return prescriptionId;
    }

    public void setPrescriptionNo(String prescriptionNo) 
    {
        this.prescriptionNo = prescriptionNo;
    }

    public String getPrescriptionNo() 
    {
        return prescriptionNo;
    }

    public void setPatientId(Long patientId) 
    {
        this.patientId = patientId;
    }

    public Long getPatientId() 
    {
        return patientId;
    }

    public void setStaffId(Long staffId) 
    {
        this.staffId = staffId;
    }

    public Long getStaffId() 
    {
        return staffId;
    }

    public void setRecordId(Long recordId) 
    {
        this.recordId = recordId;
    }

    public Long getRecordId() 
    {
        return recordId;
    }

    public void setDiagnosis(String diagnosis) 
    {
        this.diagnosis = diagnosis;
    }

    public String getDiagnosis() 
    {
        return diagnosis;
    }

    public void setUsageInstructions(String usageInstructions) 
    {
        this.usageInstructions = usageInstructions;
    }

    public String getUsageInstructions() 
    {
        return usageInstructions;
    }

    public void setTotalAmount(BigDecimal totalAmount) 
    {
        this.totalAmount = totalAmount;
    }

    public BigDecimal getTotalAmount() 
    {
        return totalAmount;
    }

    public void setPrescriptionType(String prescriptionType) 
    {
        this.prescriptionType = prescriptionType;
    }

    public String getPrescriptionType() 
    {
        return prescriptionType;
    }

    public void setPrescriptionStatus(String prescriptionStatus) 
    {
        this.prescriptionStatus = prescriptionStatus;
    }

    public String getPrescriptionStatus() 
    {
        return prescriptionStatus;
    }

    public void setDispenseTime(Date dispenseTime) 
    {
        this.dispenseTime = dispenseTime;
    }

    public Date getDispenseTime() 
    {
        return dispenseTime;
    }

    public void setDispenserId(Long dispenserId) 
    {
        this.dispenserId = dispenserId;
    }

    public Long getDispenserId() 
    {
        return dispenserId;
    }

    public List<ChPrescriptionDetail> getChPrescriptionDetailList()
    {
        return chPrescriptionDetailList;
    }

    public void setChPrescriptionDetailList(List<ChPrescriptionDetail> chPrescriptionDetailList)
    {
        this.chPrescriptionDetailList = chPrescriptionDetailList;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("prescriptionId", getPrescriptionId())
            .append("prescriptionNo", getPrescriptionNo())
            .append("patientId", getPatientId())
            .append("staffId", getStaffId())
            .append("recordId", getRecordId())
            .append("diagnosis", getDiagnosis())
            .append("usageInstructions", getUsageInstructions())
            .append("totalAmount", getTotalAmount())
            .append("prescriptionType", getPrescriptionType())
            .append("prescriptionStatus", getPrescriptionStatus())
            .append("dispenseTime", getDispenseTime())
            .append("dispenserId", getDispenserId())
            .append("createTime", getCreateTime())
            .append("updateTime", getUpdateTime())
            .append("chPrescriptionDetailList", getChPrescriptionDetailList())
            .toString();
    }
}
