package com.ruoyi.hospital.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 医生排班对象 ch_schedule
 * 
 * @author ruoyi
 * @date 2026-01-28
 */
public class ChSchedule extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 排班ID */
    private Long scheduleId;

    /** 医生ID */
    @Excel(name = "医生ID")
    private Long staffId;

    /** 排班日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "排班日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date scheduleDate;

    /** 时间段（morning上午 afternoon下午 night夜班） */
    @Excel(name = "时间段", readConverterExp = "m=orning上午,a=fternoon下午,n=ight夜班")
    private String timeSlot;

    /** 诊室号 */
    @Excel(name = "诊室号")
    private String roomNo;

    /** 最大接诊人数 */
    @Excel(name = "最大接诊人数")
    private Long maxPatients;

    /** 当前预约人数 */
    @Excel(name = "当前预约人数")
    private Long currentPatients;

    /** 排班类型（normal普通 expert专家） */
    @Excel(name = "排班类型", readConverterExp = "n=ormal普通,e=xpert专家")
    private String scheduleType;

    /** 挂号费 */
    @Excel(name = "挂号费")
    private BigDecimal fee;

    /** 状态（0可预约 1已满 2停诊） */
    @Excel(name = "状态", readConverterExp = "0=可预约,1=已满,2=停诊")
    private String status;

    public void setScheduleId(Long scheduleId) 
    {
        this.scheduleId = scheduleId;
    }

    public Long getScheduleId() 
    {
        return scheduleId;
    }

    public void setStaffId(Long staffId) 
    {
        this.staffId = staffId;
    }

    public Long getStaffId() 
    {
        return staffId;
    }

    public void setScheduleDate(Date scheduleDate) 
    {
        this.scheduleDate = scheduleDate;
    }

    public Date getScheduleDate() 
    {
        return scheduleDate;
    }

    public void setTimeSlot(String timeSlot) 
    {
        this.timeSlot = timeSlot;
    }

    public String getTimeSlot() 
    {
        return timeSlot;
    }

    public void setRoomNo(String roomNo) 
    {
        this.roomNo = roomNo;
    }

    public String getRoomNo() 
    {
        return roomNo;
    }

    public void setMaxPatients(Long maxPatients) 
    {
        this.maxPatients = maxPatients;
    }

    public Long getMaxPatients() 
    {
        return maxPatients;
    }

    public void setCurrentPatients(Long currentPatients) 
    {
        this.currentPatients = currentPatients;
    }

    public Long getCurrentPatients() 
    {
        return currentPatients;
    }

    public void setScheduleType(String scheduleType) 
    {
        this.scheduleType = scheduleType;
    }

    public String getScheduleType() 
    {
        return scheduleType;
    }

    public void setFee(BigDecimal fee) 
    {
        this.fee = fee;
    }

    public BigDecimal getFee() 
    {
        return fee;
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
            .append("scheduleId", getScheduleId())
            .append("staffId", getStaffId())
            .append("scheduleDate", getScheduleDate())
            .append("timeSlot", getTimeSlot())
            .append("roomNo", getRoomNo())
            .append("maxPatients", getMaxPatients())
            .append("currentPatients", getCurrentPatients())
            .append("scheduleType", getScheduleType())
            .append("fee", getFee())
            .append("status", getStatus())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
