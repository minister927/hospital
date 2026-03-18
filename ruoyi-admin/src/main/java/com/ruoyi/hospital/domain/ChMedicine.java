package com.ruoyi.hospital.domain;

import java.math.BigDecimal;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 药品信息对象 ch_medicine
 * 
 * @author ruoyi
 * @date 2026-01-27
 */
public class ChMedicine extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 药品ID */
    private Long medicineId;

    /** 药品编码 */
    @Excel(name = "药品编码")
    private String medicineCode;

    /** 药品名称 */
    @Excel(name = "药品名称")
    private String medicineName;

    /** 规格 */
    @Excel(name = "规格")
    private String specification;

    /** 分类ID */
    @Excel(name = "分类ID")
    private Long categoryId;

    /** 分类名称 ,关联用法*/
    @Excel(name = "药品分类")
    private String categoryName;

    /** 生产厂家 */
    @Excel(name = "生产厂家")
    private String manufacturer;

    /** 批准文号 */
    @Excel(name = "批准文号")
    private String approvalNumber;

    /** 是否处方药（0否 1是） */
    @Excel(name = "是否处方药", readConverterExp = "0=否,1=是")
    private Integer isPrescription;

    /** 采购价 */
    @Excel(name = "采购价")
    private BigDecimal purchasePrice;

    /** 销售价 */
    @Excel(name = "销售价")
    private BigDecimal salePrice;

    /** 库存预警 */
    @Excel(name = "库存预警")
    private Long stockWarning;

    /** 有效期（月） */
    @Excel(name = "有效期", readConverterExp = "月=")
    private Long validityPeriod;

    /** 状态（0正常 1停用） */
    private String status;

    public void setMedicineId(Long medicineId) 
    {
        this.medicineId = medicineId;
    }

    public Long getMedicineId() 
    {
        return medicineId;
    }

    public void setMedicineCode(String medicineCode) 
    {
        this.medicineCode = medicineCode;
    }

    public String getMedicineCode() 
    {
        return medicineCode;
    }

    public void setMedicineName(String medicineName) 
    {
        this.medicineName = medicineName;
    }

    public String getMedicineName() 
    {
        return medicineName;
    }

    public void setSpecification(String specification) 
    {
        this.specification = specification;
    }

    public String getSpecification() 
    {
        return specification;
    }

    public void setCategoryId(Long categoryId) 
    {
        this.categoryId = categoryId;
    }

    public Long getCategoryId() 
    {
        return categoryId;
    }

    public void setCategoryName(String categoryName)//关联用法
    {
        this.categoryName = categoryName;
    }

    public String getCategoryName()
    {
        return categoryName;
    }

    public void setManufacturer(String manufacturer) 
    {
        this.manufacturer = manufacturer;
    }

    public String getManufacturer() 
    {
        return manufacturer;
    }

    public void setApprovalNumber(String approvalNumber) 
    {
        this.approvalNumber = approvalNumber;
    }

    public String getApprovalNumber() 
    {
        return approvalNumber;
    }

    public void setIsPrescription(Integer isPrescription) 
    {
        this.isPrescription = isPrescription;
    }

    public Integer getIsPrescription() 
    {
        return isPrescription;
    }

    public void setPurchasePrice(BigDecimal purchasePrice) 
    {
        this.purchasePrice = purchasePrice;
    }

    public BigDecimal getPurchasePrice() 
    {
        return purchasePrice;
    }

    public void setSalePrice(BigDecimal salePrice) 
    {
        this.salePrice = salePrice;
    }

    public BigDecimal getSalePrice() 
    {
        return salePrice;
    }

    public void setStockWarning(Long stockWarning) 
    {
        this.stockWarning = stockWarning;
    }

    public Long getStockWarning() 
    {
        return stockWarning;
    }

    public void setValidityPeriod(Long validityPeriod) 
    {
        this.validityPeriod = validityPeriod;
    }

    public Long getValidityPeriod() 
    {
        return validityPeriod;
    }

    public void setStatus(String status) 
    {
        this.status = status;
    }

    public String getStatus() 
    {
        return status;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("medicineId", getMedicineId())
            .append("medicineCode", getMedicineCode())
            .append("medicineName", getMedicineName())
            .append("specification", getSpecification())
            .append("categoryId", getCategoryId())
            .append("categoryName", getCategoryName())//关联用法
            .append("manufacturer", getManufacturer())
            .append("approvalNumber", getApprovalNumber())
            .append("isPrescription", getIsPrescription())
            .append("purchasePrice", getPurchasePrice())
            .append("salePrice", getSalePrice())
            .append("stockWarning", getStockWarning())
            .append("validityPeriod", getValidityPeriod())
            .append("status", getStatus())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
