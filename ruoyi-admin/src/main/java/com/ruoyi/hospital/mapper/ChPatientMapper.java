package com.ruoyi.hospital.mapper;

import java.util.List;
import com.ruoyi.hospital.domain.ChPatient;
import org.apache.ibatis.annotations.Mapper;

/**
 * 患者信息Mapper接口
 * 
 * @author ruoyi
 * @date 2026-02-09
 */
@Mapper//新增
public interface ChPatientMapper 
{
    /**
     * 查询患者信息
     * 
     * @param patientId 患者信息主键
     * @return 患者信息
     */
    public ChPatient selectChPatientByPatientId(Long patientId);

    /**
     * 查询患者信息列表
     * 
     * @param chPatient 患者信息
     * @return 患者信息集合
     */
    public List<ChPatient> selectChPatientList(ChPatient chPatient);

    /**
     * 新增患者信息
     * 
     * @param chPatient 患者信息
     * @return 结果
     */
    public int insertChPatient(ChPatient chPatient);

    /**
     * 修改患者信息
     * 
     * @param chPatient 患者信息
     * @return 结果
     */
    public int updateChPatient(ChPatient chPatient);

    /**
     * 删除患者信息
     * 
     * @param patientId 患者信息主键
     * @return 结果
     */
    public int deleteChPatientByPatientId(Long patientId);

    /**
     * 批量删除患者信息
     * 
     * @param patientIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteChPatientByPatientIds(Long[] patientIds);
}
