package com.ruoyi.hospital.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 医护人员信息对象 ch_staff
 * 
 * @author ruoyi
 * @date 2026-01-28
 */
public class ChStaff extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 员工ID */
    private Long staffId;

    /** 关联用户ID */
    @Excel(name = "关联用户ID")
    private Long userId;

    /** 工号 */
    @Excel(name = "工号")
    private String staffNo;

    /** 姓名 */
    @Excel(name = "姓名")
    private String staffName;

    /** 性别（0男 1女） */
    @Excel(name = "性别", readConverterExp = "0=男,1=女")
    private String gender;

    /** 出生日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "出生日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date birthDate;

    /** 身份证号 */
    @Excel(name = "身份证号")
    private String idCard;

    /** 联系电话 */
    @Excel(name = "联系电话")
    private String phone;

    /** 邮箱 */
    @Excel(name = "邮箱")
    private String email;

    /** 所属科室 */
    @Excel(name = "所属科室")
    private Long deptId;

    /** 员工类型（doctor医生 nurse护士 pharmacist药师 technician技师） */
    @Excel(name = "员工类型", readConverterExp = "d=octor医生,n=urse护士,p=harmacist药师,t=echnician技师")
    private String staffType;

    /** 状态（0在职 1休假 2离职） */
    @Excel(name = "状态", readConverterExp = "0=在职,1=休假,2=离职")
    private String status;

    public void setStaffId(Long staffId) 
    {
        this.staffId = staffId;
    }

    public Long getStaffId() 
    {
        return staffId;
    }

    public void setUserId(Long userId) 
    {
        this.userId = userId;
    }

    public Long getUserId() 
    {
        return userId;
    }

    public void setStaffNo(String staffNo) 
    {
        this.staffNo = staffNo;
    }

    public String getStaffNo() 
    {
        return staffNo;
    }

    public void setStaffName(String staffName) 
    {
        this.staffName = staffName;
    }

    public String getStaffName() 
    {
        return staffName;
    }

    public void setGender(String gender) 
    {
        this.gender = gender;
    }

    public String getGender() 
    {
        return gender;
    }

    public void setBirthDate(Date birthDate) 
    {
        this.birthDate = birthDate;
    }

    public Date getBirthDate() 
    {
        return birthDate;
    }

    public void setIdCard(String idCard) 
    {
        this.idCard = idCard;
    }

    public String getIdCard() 
    {
        return idCard;
    }

    public void setPhone(String phone) 
    {
        this.phone = phone;
    }

    public String getPhone() 
    {
        return phone;
    }

    public void setEmail(String email) 
    {
        this.email = email;
    }

    public String getEmail() 
    {
        return email;
    }

    public void setDeptId(Long deptId) 
    {
        this.deptId = deptId;
    }

    public Long getDeptId() 
    {
        return deptId;
    }

    public void setStaffType(String staffType) 
    {
        this.staffType = staffType;
    }

    public String getStaffType() 
    {
        return staffType;
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
            .append("staffId", getStaffId())
            .append("userId", getUserId())
            .append("staffNo", getStaffNo())
            .append("staffName", getStaffName())
            .append("gender", getGender())
            .append("birthDate", getBirthDate())
            .append("idCard", getIdCard())
            .append("phone", getPhone())
            .append("email", getEmail())
            .append("deptId", getDeptId())
            .append("staffType", getStaffType())
            .append("status", getStatus())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
