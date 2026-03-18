package com.ruoyi.hospital.domain;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 药品库存对象 ch_medicine_stock
 * 
 * @author ruoyi
 * @date 2026-01-28
 */
public class ChMedicineStock extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 库存ID */
    private Long stockId;

    /** 药品ID */
    @Excel(name = "药品ID")
    private Long medicineId;

    /** 批次号 */
    @Excel(name = "批次号")
    private String batchNo;

    /** 生产日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "生产日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date productionDate;

    /** 有效期至 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "有效期至", width = 30, dateFormat = "yyyy-MM-dd")
    private Date expiryDate;

    /** 库存数量 */
    @Excel(name = "库存数量")
    private Long quantity;

    /** 可用数量 */
    @Excel(name = "可用数量")
    private Long availableQuantity;

    /** 采购单价 */
    @Excel(name = "采购单价")
    private BigDecimal purchasePrice;

    /** 供应商 */
    @Excel(name = "供应商")
    private String supplier;

    /** 存放位置 */
    @Excel(name = "存放位置")
    private String storageLocation;

    /** 状态（normal正常 expiring临期 expired过期） */
    @Excel(name = "状态", readConverterExp = "n=ormal正常,e=xpiring临期,e=xpired过期")
    private String stockStatus;

    public void setStockId(Long stockId) 
    {
        this.stockId = stockId;
    }

    public Long getStockId() 
    {
        return stockId;
    }

    public void setMedicineId(Long medicineId) 
    {
        this.medicineId = medicineId;
    }

    public Long getMedicineId() 
    {
        return medicineId;
    }

    public void setBatchNo(String batchNo) 
    {
        this.batchNo = batchNo;
    }

    public String getBatchNo() 
    {
        return batchNo;
    }

    public void setProductionDate(Date productionDate) 
    {
        this.productionDate = productionDate;
    }

    public Date getProductionDate() 
    {
        return productionDate;
    }

    public void setExpiryDate(Date expiryDate) 
    {
        this.expiryDate = expiryDate;
    }

    public Date getExpiryDate() 
    {
        return expiryDate;
    }

    public void setQuantity(Long quantity) 
    {
        this.quantity = quantity;
    }

    public Long getQuantity() 
    {
        return quantity;
    }

    public void setAvailableQuantity(Long availableQuantity) 
    {
        this.availableQuantity = availableQuantity;
    }

    public Long getAvailableQuantity() 
    {
        return availableQuantity;
    }

    public void setPurchasePrice(BigDecimal purchasePrice) 
    {
        this.purchasePrice = purchasePrice;
    }

    public BigDecimal getPurchasePrice() 
    {
        return purchasePrice;
    }

    public void setSupplier(String supplier) 
    {
        this.supplier = supplier;
    }

    public String getSupplier() 
    {
        return supplier;
    }

    public void setStorageLocation(String storageLocation) 
    {
        this.storageLocation = storageLocation;
    }

    public String getStorageLocation() 
    {
        return storageLocation;
    }

    public void setStockStatus(String stockStatus) 
    {
        this.stockStatus = stockStatus;
    }

    public String getStockStatus() 
    {
        return stockStatus;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("stockId", getStockId())
            .append("medicineId", getMedicineId())
            .append("batchNo", getBatchNo())
            .append("productionDate", getProductionDate())
            .append("expiryDate", getExpiryDate())
            .append("quantity", getQuantity())
            .append("availableQuantity", getAvailableQuantity())
            .append("purchasePrice", getPurchasePrice())
            .append("supplier", getSupplier())
            .append("storageLocation", getStorageLocation())
            .append("stockStatus", getStockStatus())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
