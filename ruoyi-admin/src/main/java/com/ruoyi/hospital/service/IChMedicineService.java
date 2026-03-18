package com.ruoyi.hospital.service;

import java.util.List;
import com.ruoyi.hospital.domain.ChMedicine;

/**
 * 药品信息Service接口
 * 
 * @author ruoyi
 * @date 2026-01-27
 */
public interface IChMedicineService 
{
    /**
     * 查询药品信息
     * 
     * @param medicineId 药品信息主键
     * @return 药品信息
     */
    public ChMedicine selectChMedicineByMedicineId(Long medicineId);

    /**
     * 查询药品信息列表
     * 
     * @param chMedicine 药品信息
     * @return 药品信息集合
     */
    public List<ChMedicine> selectChMedicineList(ChMedicine chMedicine);

    /**
     * 新增药品信息
     * 
     * @param chMedicine 药品信息
     * @return 结果
     */
    public int insertChMedicine(ChMedicine chMedicine);

    /**
     * 修改药品信息
     * 
     * @param chMedicine 药品信息
     * @return 结果
     */
    public int updateChMedicine(ChMedicine chMedicine);

    /**
     * 批量删除药品信息
     * 
     * @param medicineIds 需要删除的药品信息主键集合
     * @return 结果
     */
    public int deleteChMedicineByMedicineIds(Long[] medicineIds);

    /**
     * 删除药品信息信息
     * 
     * @param medicineId 药品信息主键
     * @return 结果
     */
    public int deleteChMedicineByMedicineId(Long medicineId);
}
