package com.ruoyi.hospital.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.hospital.mapper.ChMedicineMapper;
import com.ruoyi.hospital.domain.ChMedicine;
import com.ruoyi.hospital.service.IChMedicineService;

/**
 * 药品信息Service业务层处理
 * 
 * @author ruoyi
 * @date 2026-01-27
 */
@Service
public class ChMedicineServiceImpl implements IChMedicineService 
{
    @Autowired
    private ChMedicineMapper chMedicineMapper;

    /**
     * 查询药品信息
     * 
     * @param medicineId 药品信息主键
     * @return 药品信息
     */
    @Override
    public ChMedicine selectChMedicineByMedicineId(Long medicineId)
    {
        return chMedicineMapper.selectChMedicineByMedicineId(medicineId);
    }

    /**
     * 查询药品信息列表
     * 
     * @param chMedicine 药品信息
     * @return 药品信息
     */
    @Override
    public List<ChMedicine> selectChMedicineList(ChMedicine chMedicine)
    {
        return chMedicineMapper.selectChMedicineList(chMedicine);
    }

    /**
     * 新增药品信息
     * 
     * @param chMedicine 药品信息
     * @return 结果
     */
    @Override
    public int insertChMedicine(ChMedicine chMedicine)
    {
        chMedicine.setCreateTime(DateUtils.getNowDate());
        return chMedicineMapper.insertChMedicine(chMedicine);
    }

    /**
     * 修改药品信息
     * 
     * @param chMedicine 药品信息
     * @return 结果
     */
    @Override
    public int updateChMedicine(ChMedicine chMedicine)
    {
        chMedicine.setUpdateTime(DateUtils.getNowDate());
        return chMedicineMapper.updateChMedicine(chMedicine);
    }

    /**
     * 批量删除药品信息
     * 
     * @param medicineIds 需要删除的药品信息主键
     * @return 结果
     */
    @Override
    public int deleteChMedicineByMedicineIds(Long[] medicineIds)
    {
        return chMedicineMapper.deleteChMedicineByMedicineIds(medicineIds);
    }

    /**
     * 删除药品信息信息
     * 
     * @param medicineId 药品信息主键
     * @return 结果
     */
    @Override
    public int deleteChMedicineByMedicineId(Long medicineId)
    {
        return chMedicineMapper.deleteChMedicineByMedicineId(medicineId);
    }
}
