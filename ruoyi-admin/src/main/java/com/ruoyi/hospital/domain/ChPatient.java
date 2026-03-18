package com.ruoyi.hospital.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 患者信息对象 ch_patient
 * 
 * @author ruoyi
 * @date 2026-02-09
 */
public class ChPatient extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 患者ID */
    private Long patientId;

    /** 关联用户ID */
    @Excel(name = "关联用户ID")
    private Long userId;

    /** 患者编号 */
    @Excel(name = "患者编号")
    private String patientNo;

    /** 身份证号 */
    @Excel(name = "身份证号")
    private String idCard;

    /** 性别（0男 1女 2未知） */
    @Excel(name = "性别", readConverterExp = "0=男,1=女,2=未知")
    private String gender;

    /** 出生日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "出生日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date birthDate;

    /** 年龄 */
    @Excel(name = "年龄")
    private Long age;

    /** 血型 */
    @Excel(name = "血型")
    private String bloodType;

    /** 婚姻状况 */
    @Excel(name = "婚姻状况")
    private String marriageStatus;

    /** 职业 */
    @Excel(name = "职业")
    private String occupation;

    /** 民族 */
    @Excel(name = "民族")
    private String nation;

    /** 现住址 */
    @Excel(name = "现住址")
    private String address;

    /** 联系电话 */
    @Excel(name = "联系电话")
    private String phone;

    /** 患者姓名（来自关联用户表 nick_name） */
    private String patientName;

    /** 过敏史 */
    @Excel(name = "过敏史")
    private String allergyHistory;

    /** 慢性病史 */
    @Excel(name = "慢性病史")
    private String chronicDisease;

    /** 家族病史 */
    @Excel(name = "家族病史")
    private String familyHistory;

    /** 医保卡号 */
    @Excel(name = "医保卡号")
    private String insuranceNo;

    /** 患者状态（0正常 1停用） */
    @Excel(name = "患者状态", readConverterExp = "0=正常,1=停用")
    private String status;

    public void setPatientId(Long patientId) 
    {
        this.patientId = patientId;
    }

    public Long getPatientId() 
    {
        return patientId;
    }

    public void setUserId(Long userId) 
    {
        this.userId = userId;
    }

    public Long getUserId() 
    {
        return userId;
    }

    public void setPatientNo(String patientNo) 
    {
        this.patientNo = patientNo;
    }

    public String getPatientNo() 
    {
        return patientNo;
    }

    public void setIdCard(String idCard) 
    {
        this.idCard = idCard;
    }

    public String getIdCard() 
    {
        return idCard;
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

    public void setAge(Long age) 
    {
        this.age = age;
    }

    public Long getAge() 
    {
        return age;
    }

    public void setBloodType(String bloodType) 
    {
        this.bloodType = bloodType;
    }

    public String getBloodType() 
    {
        return bloodType;
    }

    public void setMarriageStatus(String marriageStatus) 
    {
        this.marriageStatus = marriageStatus;
    }

    public String getMarriageStatus() 
    {
        return marriageStatus;
    }

    public void setOccupation(String occupation) 
    {
        this.occupation = occupation;
    }

    public String getOccupation() 
    {
        return occupation;
    }

    public void setNation(String nation) 
    {
        this.nation = nation;
    }

    public String getNation() 
    {
        return nation;
    }

    public void setAddress(String address) 
    {
        this.address = address;
    }

    public String getAddress() 
    {
        return address;
    }

    public void setPhone(String phone) 
    {
        this.phone = phone;
    }

    public String getPhone() 
    {
        return phone;
    }

    public String getPatientName()
    {
        return patientName;
    }

    public void setPatientName(String patientName)
    {
        this.patientName = patientName;
    }

    public void setAllergyHistory(String allergyHistory) 
    {
        this.allergyHistory = allergyHistory;
    }

    public String getAllergyHistory() 
    {
        return allergyHistory;
    }

    public void setChronicDisease(String chronicDisease) 
    {
        this.chronicDisease = chronicDisease;
    }

    public String getChronicDisease() 
    {
        return chronicDisease;
    }

    public void setFamilyHistory(String familyHistory) 
    {
        this.familyHistory = familyHistory;
    }

    public String getFamilyHistory() 
    {
        return familyHistory;
    }

    public void setInsuranceNo(String insuranceNo) 
    {
        this.insuranceNo = insuranceNo;
    }

    public String getInsuranceNo() 
    {
        return insuranceNo;
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
            .append("patientId", getPatientId())
            .append("userId", getUserId())
            .append("patientNo", getPatientNo())
            .append("idCard", getIdCard())
            .append("gender", getGender())
            .append("birthDate", getBirthDate())
            .append("age", getAge())
            .append("bloodType", getBloodType())
            .append("marriageStatus", getMarriageStatus())
            .append("occupation", getOccupation())
            .append("nation", getNation())
            .append("address", getAddress())
            .append("phone", getPhone())
            .append("allergyHistory", getAllergyHistory())
            .append("chronicDisease", getChronicDisease())
            .append("familyHistory", getFamilyHistory())
            .append("insuranceNo", getInsuranceNo())
            .append("status", getStatus())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
