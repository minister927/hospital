package com.ruoyi.hospital.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.hospital.mapper.ChPatientMapper;
import com.ruoyi.hospital.domain.ChPatient;
import com.ruoyi.hospital.service.IChPatientService;

/**
 * 患者信息Service业务层处理
 * 
 * @author ruoyi
 * @date 2026-02-09
 */
@Service
public class ChPatientServiceImpl implements IChPatientService 
{
    @Autowired
    private ChPatientMapper chPatientMapper;

    /**
     * 查询患者信息
     * 
     * @param patientId 患者信息主键
     * @return 患者信息
     */
    @Override
    public ChPatient selectChPatientByPatientId(Long patientId)
    {
        return chPatientMapper.selectChPatientByPatientId(patientId);
    }

    /**
     * 查询患者信息列表
     * 
     * @param chPatient 患者信息
     * @return 患者信息
     */
    @Override
    public List<ChPatient> selectChPatientList(ChPatient chPatient)
    {
        return chPatientMapper.selectChPatientList(chPatient);
    }

    /**
     * 新增患者信息
     * 
     * @param chPatient 患者信息
     * @return 结果
     */
    @Override
    public int insertChPatient(ChPatient chPatient)
    {
        chPatient.setCreateTime(DateUtils.getNowDate());
        return chPatientMapper.insertChPatient(chPatient);
    }

    /**
     * 修改患者信息
     * 
     * @param chPatient 患者信息
     * @return 结果
     */
    @Override
    public int updateChPatient(ChPatient chPatient)
    {
        chPatient.setUpdateTime(DateUtils.getNowDate());
        return chPatientMapper.updateChPatient(chPatient);
    }

    /**
     * 批量删除患者信息
     * 
     * @param patientIds 需要删除的患者信息主键
     * @return 结果
     */
    @Override
    public int deleteChPatientByPatientIds(Long[] patientIds)
    {
        return chPatientMapper.deleteChPatientByPatientIds(patientIds);
    }

    /**
     * 删除患者信息信息
     * 
     * @param patientId 患者信息主键
     * @return 结果
     */
    @Override
    public int deleteChPatientByPatientId(Long patientId)
    {
        return chPatientMapper.deleteChPatientByPatientId(patientId);
    }
}
