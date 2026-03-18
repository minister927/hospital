package com.ruoyi.hospital.mapper;

import java.util.List;
import com.ruoyi.hospital.domain.ChMedicine;
import org.apache.ibatis.annotations.Mapper;

/**
 * 药品信息Mapper接口
 * 
 * @author ruoyi
 * @date 2026-01-27
 */
@Mapper//新增
public interface ChMedicineMapper 
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
     * 删除药品信息
     * 
     * @param medicineId 药品信息主键
     * @return 结果
     */
    public int deleteChMedicineByMedicineId(Long medicineId);

    /**
     * 批量删除药品信息
     * 
     * @param medicineIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteChMedicineByMedicineIds(Long[] medicineIds);
}
