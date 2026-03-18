package com.ruoyi.hospital.domain;

import java.math.BigDecimal;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 处方明细对象 ch_prescription_detail
 * 
 * @author ruoyi
 * @date 2026-02-09
 */
public class ChPrescriptionDetail extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 明细ID */
    private Long detailId;

    /** 处方ID */
    @Excel(name = "处方ID")
    private Long prescriptionId;

    /** 药品ID */
    @Excel(name = "药品ID")
    private Long medicineId;

    /** 数量 */
    @Excel(name = "数量")
    private Long quantity;

    /** 单次剂量 */
    @Excel(name = "单次剂量")
    private String dosage;

    /** 频次 */
    @Excel(name = "频次")
    private String frequency;

    /** 天数 */
    @Excel(name = "天数")
    private Long days;

    /** 总用量 */
    @Excel(name = "总用量")
    private String totalQuantity;

    /** 用法 */
    @Excel(name = "用法")
    private String usageMethod;

    /** 单价 */
    @Excel(name = "单价")
    private BigDecimal unitPrice;

    /** 小计 */
    @Excel(name = "小计")
    private BigDecimal subtotal;

    /** 备注 */
    @Excel(name = "备注")
    private String notes;

    public void setDetailId(Long detailId) 
    {
        this.detailId = detailId;
    }

    public Long getDetailId() 
    {
        return detailId;
    }
    public void setPrescriptionId(Long prescriptionId) 
    {
        this.prescriptionId = prescriptionId;
    }

    public Long getPrescriptionId() 
    {
        return prescriptionId;
    }
    public void setMedicineId(Long medicineId) 
    {
        this.medicineId = medicineId;
    }

    public Long getMedicineId() 
    {
        return medicineId;
    }
    public void setQuantity(Long quantity) 
    {
        this.quantity = quantity;
    }

    public Long getQuantity() 
    {
        return quantity;
    }
    public void setDosage(String dosage) 
    {
        this.dosage = dosage;
    }

    public String getDosage() 
    {
        return dosage;
    }
    public void setFrequency(String frequency) 
    {
        this.frequency = frequency;
    }

    public String getFrequency() 
    {
        return frequency;
    }
    public void setDays(Long days) 
    {
        this.days = days;
    }

    public Long getDays() 
    {
        return days;
    }
    public void setTotalQuantity(String totalQuantity) 
    {
        this.totalQuantity = totalQuantity;
    }

    public String getTotalQuantity() 
    {
        return totalQuantity;
    }
    public void setUsageMethod(String usageMethod) 
    {
        this.usageMethod = usageMethod;
    }

    public String getUsageMethod() 
    {
        return usageMethod;
    }
    public void setUnitPrice(BigDecimal unitPrice) 
    {
        this.unitPrice = unitPrice;
    }

    public BigDecimal getUnitPrice() 
    {
        return unitPrice;
    }
    public void setSubtotal(BigDecimal subtotal) 
    {
        this.subtotal = subtotal;
    }

    public BigDecimal getSubtotal() 
    {
        return subtotal;
    }
    public void setNotes(String notes) 
    {
        this.notes = notes;
    }

    public String getNotes() 
    {
        return notes;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("detailId", getDetailId())
            .append("prescriptionId", getPrescriptionId())
            .append("medicineId", getMedicineId())
            .append("quantity", getQuantity())
            .append("dosage", getDosage())
            .append("frequency", getFrequency())
            .append("days", getDays())
            .append("totalQuantity", getTotalQuantity())
            .append("usageMethod", getUsageMethod())
            .append("unitPrice", getUnitPrice())
            .append("subtotal", getSubtotal())
            .append("notes", getNotes())
            .toString();
    }
}
