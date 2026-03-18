package com.ruoyi.hospital.mapper;

import java.util.List;
import com.ruoyi.hospital.domain.ChPrescription;
import com.ruoyi.hospital.domain.ChPrescriptionDetail;
import org.apache.ibatis.annotations.Mapper;

/**
 * 处方Mapper接口
 * 
 * @author ruoyi
 * @date 2026-02-09
 */
@Mapper//新增
public interface ChPrescriptionMapper 
{
    /**
     * 查询处方
     * 
     * @param prescriptionId 处方主键
     * @return 处方
     */
    public ChPrescription selectChPrescriptionByPrescriptionId(Long prescriptionId);

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

    /**
     * 删除处方
     * 
     * @param prescriptionId 处方主键
     * @return 结果
     */
    public int deleteChPrescriptionByPrescriptionId(Long prescriptionId);

    /**
     * 批量删除处方
     * 
     * @param prescriptionIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteChPrescriptionByPrescriptionIds(Long[] prescriptionIds);

    /**
     * 批量删除处方明细
     * 
     * @param prescriptionIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteChPrescriptionDetailByPrescriptionIds(Long[] prescriptionIds);
    
    /**
     * 批量新增处方明细
     * 
     * @param chPrescriptionDetailList 处方明细列表
     * @return 结果
     */
    public int batchChPrescriptionDetail(List<ChPrescriptionDetail> chPrescriptionDetailList);
    

    /**
     * 通过处方主键删除处方明细信息
     * 
     * @param prescriptionId 处方ID
     * @return 结果
     */
    public int deleteChPrescriptionDetailByPrescriptionId(Long prescriptionId);
}
