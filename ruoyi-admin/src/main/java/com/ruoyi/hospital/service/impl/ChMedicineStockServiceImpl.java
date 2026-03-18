package com.ruoyi.hospital.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.hospital.mapper.ChMedicineStockMapper;
import com.ruoyi.hospital.domain.ChMedicineStock;
import com.ruoyi.hospital.service.IChMedicineStockService;

/**
 * 药品库存Service业务层处理
 * 
 * @author ruoyi
 * @date 2026-01-28
 */
@Service
public class ChMedicineStockServiceImpl implements IChMedicineStockService 
{
    @Autowired
    private ChMedicineStockMapper chMedicineStockMapper;

    /**
     * 查询药品库存
     * 
     * @param stockId 药品库存主键
     * @return 药品库存
     */
    @Override
    public ChMedicineStock selectChMedicineStockByStockId(Long stockId)
    {
        return chMedicineStockMapper.selectChMedicineStockByStockId(stockId);
    }

    /**
     * 查询药品库存列表
     * 
     * @param chMedicineStock 药品库存
     * @return 药品库存
     */
    @Override
    public List<ChMedicineStock> selectChMedicineStockList(ChMedicineStock chMedicineStock)
    {
        return chMedicineStockMapper.selectChMedicineStockList(chMedicineStock);
    }

    /**
     * 新增药品库存
     * 
     * @param chMedicineStock 药品库存
     * @return 结果
     */
    @Override
    public int insertChMedicineStock(ChMedicineStock chMedicineStock)
    {
        chMedicineStock.setCreateTime(DateUtils.getNowDate());
        return chMedicineStockMapper.insertChMedicineStock(chMedicineStock);
    }

    /**
     * 修改药品库存
     * 
     * @param chMedicineStock 药品库存
     * @return 结果
     */
    @Override
    public int updateChMedicineStock(ChMedicineStock chMedicineStock)
    {
        chMedicineStock.setUpdateTime(DateUtils.getNowDate());
        return chMedicineStockMapper.updateChMedicineStock(chMedicineStock);
    }

    /**
     * 批量删除药品库存
     * 
     * @param stockIds 需要删除的药品库存主键
     * @return 结果
     */
    @Override
    public int deleteChMedicineStockByStockIds(Long[] stockIds)
    {
        return chMedicineStockMapper.deleteChMedicineStockByStockIds(stockIds);
    }

    /**
     * 删除药品库存信息
     * 
     * @param stockId 药品库存主键
     * @return 结果
     */
    @Override
    public int deleteChMedicineStockByStockId(Long stockId)
    {
        return chMedicineStockMapper.deleteChMedicineStockByStockId(stockId);
    }
}
