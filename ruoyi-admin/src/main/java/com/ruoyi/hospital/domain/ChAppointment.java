package com.ruoyi.hospital.domain;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import com.ruoyi.hospital.domain.ChPatient;
import com.ruoyi.hospital.domain.ChStaff;

/**
 * 预约挂号对象 ch_appointment
 * 
 * @author ruoyi
 * @date 2026-02-09
 */
public class ChAppointment extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 预约ID */
    private Long appointmentId;

    /** 预约号 */
    @Excel(name = "预约号")
    private String appointmentNo;

    /** 患者ID */
    @Excel(name = "患者ID")
    private Long patientId;

    /** 医生ID */
    @Excel(name = "医生ID")
    private Long staffId;

    /** 排班ID */
    @Excel(name = "排班ID")
    private Long scheduleId;

    /** 科室ID */
    @Excel(name = "科室ID")
    private Long deptId;

    /** 预约日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "预约日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date appointmentDate;

    /** 时间段 */
    @Excel(name = "时间段")
    private String timeSlot;

    /** 预约时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "预约时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date appointmentTime;

    /** 排队号 */
    @Excel(name = "排队号")
    private Long queueNumber;

    /** 症状描述 */
    @Excel(name = "症状描述")
    private String symptoms;

    /** 来源（online线上 offline线下） */
    @Excel(name = "来源", readConverterExp = "o=nline线上,o=ffline线下")
    private String source;

    /** 挂号费 */
    @Excel(name = "挂号费")
    private BigDecimal fee;

    /** 缴费状态（0未付 1已付） */
    @Excel(name = "缴费状态", readConverterExp = "0=未付,1=已付")
    private String paymentStatus;

    /** 预约状态（pending待确认 confirmed已确认 completed已完成 cancelled已取消 no_show未就诊） */
    @Excel(name = "预约状态", readConverterExp = "p=ending待确认,c=onfirmed已确认,c=ompleted已完成,c=ancelled已取消,n=o_show未就诊")
    private String appointmentStatus;

    /** 取消原因 */
    @Excel(name = "取消原因")
    private String cancelReason;

    /** 到院时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "到院时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date arriveTime;

    /** 关联患者对象 */
    private ChPatient patient;

    /** 关联医生对象 */
    private ChStaff staff;

    public void setAppointmentId(Long appointmentId) 
    {
        this.appointmentId = appointmentId;
    }

    public Long getAppointmentId() 
    {
        return appointmentId;
    }

    public void setAppointmentNo(String appointmentNo) 
    {
        this.appointmentNo = appointmentNo;
    }

    public String getAppointmentNo() 
    {
        return appointmentNo;
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

    public void setScheduleId(Long scheduleId) 
    {
        this.scheduleId = scheduleId;
    }

    public Long getScheduleId() 
    {
        return scheduleId;
    }

    public void setDeptId(Long deptId) 
    {
        this.deptId = deptId;
    }

    public Long getDeptId() 
    {
        return deptId;
    }

    public void setAppointmentDate(Date appointmentDate) 
    {
        this.appointmentDate = appointmentDate;
    }

    public Date getAppointmentDate() 
    {
        return appointmentDate;
    }

    public void setTimeSlot(String timeSlot) 
    {
        this.timeSlot = timeSlot;
    }

    public String getTimeSlot() 
    {
        return timeSlot;
    }

    public void setAppointmentTime(Date appointmentTime) 
    {
        this.appointmentTime = appointmentTime;
    }

    public Date getAppointmentTime() 
    {
        return appointmentTime;
    }

    public void setQueueNumber(Long queueNumber) 
    {
        this.queueNumber = queueNumber;
    }

    public Long getQueueNumber() 
    {
        return queueNumber;
    }

    public void setSymptoms(String symptoms) 
    {
        this.symptoms = symptoms;
    }

    public String getSymptoms() 
    {
        return symptoms;
    }

    public void setSource(String source) 
    {
        this.source = source;
    }

    public String getSource() 
    {
        return source;
    }

    public void setFee(BigDecimal fee) 
    {
        this.fee = fee;
    }

    public BigDecimal getFee() 
    {
        return fee;
    }

    public void setPaymentStatus(String paymentStatus) 
    {
        this.paymentStatus = paymentStatus;
    }

    public String getPaymentStatus() 
    {
        return paymentStatus;
    }

    public void setAppointmentStatus(String appointmentStatus) 
    {
        this.appointmentStatus = appointmentStatus;
    }

    public String getAppointmentStatus() 
    {
        return appointmentStatus;
    }

    public void setCancelReason(String cancelReason) 
    {
        this.cancelReason = cancelReason;
    }

    public String getCancelReason() 
    {
        return cancelReason;
    }

    public void setArriveTime(Date arriveTime) 
    {
        this.arriveTime = arriveTime;
    }

    public Date getArriveTime() 
    {
        return arriveTime;
    }

    public ChPatient getPatient() {
        return patient;
    }

    public void setPatient(ChPatient patient) {
        this.patient = patient;
    }

    public ChStaff getStaff() {
        return staff;
    }

    public void setStaff(ChStaff staff) {
        this.staff = staff;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("appointmentId", getAppointmentId())
            .append("appointmentNo", getAppointmentNo())
            .append("patientId", getPatientId())
            .append("staffId", getStaffId())
            .append("scheduleId", getScheduleId())
            .append("deptId", getDeptId())
            .append("appointmentDate", getAppointmentDate())
            .append("timeSlot", getTimeSlot())
            .append("appointmentTime", getAppointmentTime())
            .append("queueNumber", getQueueNumber())
            .append("symptoms", getSymptoms())
            .append("source", getSource())
            .append("fee", getFee())
            .append("paymentStatus", getPaymentStatus())
            .append("appointmentStatus", getAppointmentStatus())
            .append("cancelReason", getCancelReason())
            .append("arriveTime", getArriveTime())
            .append("createTime", getCreateTime())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
