package com.ruoyi.hospital.service;

import java.util.List;
import com.ruoyi.hospital.domain.ChPrescription;

/**
 * 处方Service接口
 *
 * @author ruoyi
 * @date 2026-02-09
 */
public interface IChPrescriptionService
{
    /**
     * 查询处方
     *
     * @param prescriptionId 处方主键
     * @return 处方
     */
    public ChPrescription selectChPrescriptionByPrescriptionId(Long prescriptionId);

    /** 查询患者草稿处方 */
    public List<ChPrescription> selectDraftPrescriptionByPatientId(Long patientId);///public使用有何效果？

    /**
     * 查询处方列表
     *
     * @param chPrescription 处方
     * @return 处方集合
     */
    public List<ChPrescription> selectChPrescriptionList(ChPrescription chPrescription);

    /**
     * 新增处方
     *
     * @param chPrescription 处方
     * @return 结果
     */
    public int insertChPrescription(ChPrescription chPrescription);

    /**
     * 修改处方
     *
     * @param chPrescription 处方
     * @return 结果
     */
    public int updateChPrescription(ChPrescription chPrescription);

    /** 确认处方（关联就诊记录） */
    public int confirmPrescription(Long prescriptionId, Long recordId);//

    /**
     * 批量删除处方
     *
     * @param prescriptionIds 需要删除的处方主键集合
     * @return 结果
     */
    public int deleteChPrescriptionByPrescriptionIds(Long[] prescriptionIds);

    /**
     * 删除处方信息
     *
     * @param prescriptionId 处方主键
     * @return 结果
     */
    public int deleteChPrescriptionByPrescriptionId(Long prescriptionId);
}
