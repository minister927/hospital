package com.ruoyi.hospital.mapper;

import java.util.List;
import com.ruoyi.hospital.domain.ChMedicineStock;
import org.apache.ibatis.annotations.Mapper;

/**
 * 药品库存Mapper接口
 * 
 * @author ruoyi
 * @date 2026-01-28
 */
@Mapper//新增
public interface ChMedicineStockMapper 
{
    /**
     * 查询药品库存
     * 
     * @param stockId 药品库存主键
     * @return 药品库存
     */
    public ChMedicineStock selectChMedicineStockByStockId(Long stockId);

    /**
     * 查询药品库存列表
     * 
     * @param chMedicineStock 药品库存
     * @return 药品库存集合
     */
    public List<ChMedicineStock> selectChMedicineStockList(ChMedicineStock chMedicineStock);

    /**
     * 新增药品库存
     * 
     * @param chMedicineStock 药品库存
     * @return 结果
     */
    public int insertChMedicineStock(ChMedicineStock chMedicineStock);

    /**
     * 修改药品库存
     * 
     * @param chMedicineStock 药品库存
     * @return 结果
     */
    public int updateChMedicineStock(ChMedicineStock chMedicineStock);

    /**
     * 删除药品库存
     * 
     * @param stockId 药品库存主键
     * @return 结果
     */
    public int deleteChMedicineStockByStockId(Long stockId);

    /**
     * 批量删除药品库存
     * 
     * @param stockIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteChMedicineStockByStockIds(Long[] stockIds);
}
