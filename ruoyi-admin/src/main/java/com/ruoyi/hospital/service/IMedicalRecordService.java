package com.ruoyi.hospital.service;

import java.util.List;
import com.ruoyi.hospital.domain.ChMedicalRecord;

public interface IMedicalRecordService {
    /** 查询就诊记录 */
    ChMedicalRecord selectChMedicalRecordById(Long recordId);

    /** 查询就诊记录列表 */
    List<ChMedicalRecord> selectChMedicalRecordList(ChMedicalRecord chMedicalRecord);

    /** 新增就诊记录（关联处方） */
    int insertChMedicalRecord(ChMedicalRecord chMedicalRecord);

    /** 修改就诊记录 */
    int updateChMedicalRecord(ChMedicalRecord chMedicalRecord);

    /** 删除就诊记录 */
    int deleteChMedicalRecordById(Long recordId);

    /** 批量删除就诊记录 */
    int deleteChMedicalRecordByIds(Long[] recordIds);
}