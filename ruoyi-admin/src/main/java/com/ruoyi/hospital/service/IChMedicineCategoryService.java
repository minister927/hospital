package com.ruoyi.hospital.service;

import java.util.List;
import com.ruoyi.hospital.domain.ChMedicineCategory;

/**
 * 药品分类Service接口
 * 
 * @author ruoyi
 * @date 2026-01-27
 */
public interface IChMedicineCategoryService 
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
     * 批量删除药品分类
     * 
     * @param categoryIds 需要删除的药品分类主键集合
     * @return 结果
     */
    public int deleteChMedicineCategoryByCategoryIds(Long[] categoryIds);

    /**
     * 删除药品分类信息
     * 
     * @param categoryId 药品分类主键
     * @return 结果
     */
    public int deleteChMedicineCategoryByCategoryId(Long categoryId);
}
