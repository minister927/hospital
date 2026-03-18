package com.ruoyi.hospital.mapper;

import java.util.List;
import com.ruoyi.hospital.domain.ChMedicineCategory;
import org.apache.ibatis.annotations.Mapper;

/**
 * 药品分类Mapper接口
 * 
 * @author ruoyi
 * @date 2026-01-27
 */
@Mapper//新增
public interface ChMedicineCategoryMapper 
{
    /**
     * 查询药品分类
     * 
     * @param categoryId 药品分类主键
     * @return 药品分类
     */
    public ChMedicineCategory selectChMedicineCategoryByCategoryId(Long categoryId);

    /**
     * 查询药品分类列表
     * 
     * @param chMedicineCategory 药品分类
     * @return 药品分类集合
     */
    public List<ChMedicineCategory> selectChMedicineCategoryList(ChMedicineCategory chMedicineCategory);

    /**
     * 新增药品分类
     * 
     * @param chMedicineCategory 药品分类
     * @return 结果
     */
    public int insertChMedicineCategory(ChMedicineCategory chMedicineCategory);

    /**
     * 修改药品分类
     * 
     * @param chMedicineCategory 药品分类
     * @return 结果
     */
    public int updateChMedicineCategory(ChMedicineCategory chMedicineCategory);

    /**
     * 删除药品分类
     * 
     * @param categoryId 药品分类主键
     * @return 结果
     */
    public int deleteChMedicineCategoryByCategoryId(Long categoryId);

    /**
     * 批量删除药品分类
     * 
     * @param categoryIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteChMedicineCategoryByCategoryIds(Long[] categoryIds);
}
