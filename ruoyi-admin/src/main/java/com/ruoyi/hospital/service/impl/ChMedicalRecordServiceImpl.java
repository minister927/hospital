package com.ruoyi.hospital.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.hospital.domain.ChMedicalRecord;
import com.ruoyi.hospital.mapper.ChMedicalRecordMapper;
import com.ruoyi.hospital.service.IMedicalRecordService;
import com.ruoyi.hospital.service.IChPrescriptionService;

@Service
public class ChMedicalRecordServiceImpl implements IMedicalRecordService
{
    @Autowired
    private ChMedicalRecordMapper chMedicalRecordMapper;

    @Autowired
    private IChPrescriptionService prescriptionService;

    @Override
    public List<ChMedicalRecord> selectChMedicalRecordList(ChMedicalRecord chMedicalRecord)
    {
        return chMedicalRecordMapper.selectChMedicalRecordList(chMedicalRecord);
    }

    @Override
    public ChMedicalRecord selectChMedicalRecordById(Long recordId)
    {
        return chMedicalRecordMapper.selectChMedicalRecordById(recordId);
    }

    @Override
    @Transactional
    public int insertChMedicalRecord(ChMedicalRecord chMedicalRecord)
    {
        if (StringUtils.isBlank(chMedicalRecord.getRecordNo())) {
            chMedicalRecord.setRecordNo("REC" + System.currentTimeMillis());
        }
        if (StringUtils.isBlank(chMedicalRecord.getRecordStatus())) {
            chMedicalRecord.setRecordStatus("draft");
        }
        if (chMedicalRecord.getVisitDate() == null) {
            chMedicalRecord.setVisitDate(DateUtils.getNowDate());
        }
        chMedicalRecord.setCreateTime(DateUtils.getNowDate());

        int rows = chMedicalRecordMapper.insertChMedicalRecord(chMedicalRecord);

        // 关键：提交就诊记录时，自动关联处方并确认
        Long prescriptionId = chMedicalRecord.getPrescriptionId();
        if (prescriptionId != null) {
            prescriptionService.confirmPrescription(prescriptionId, chMedicalRecord.getRecordId());
        }
        return rows;
    }

    @Override
    public int updateChMedicalRecord(ChMedicalRecord chMedicalRecord)
    {
        chMedicalRecord.setUpdateTime(DateUtils.getNowDate());
        return chMedicalRecordMapper.updateChMedicalRecord(chMedicalRecord);
    }

    @Override
    public int deleteChMedicalRecordById(Long recordId)
    {
        return chMedicalRecordMapper.deleteChMedicalRecordById(recordId);
    }

    @Override
    public int deleteChMedicalRecordByIds(Long[] recordIds)
    {
        return chMedicalRecordMapper.deleteChMedicalRecordByIds(recordIds);
    }
}