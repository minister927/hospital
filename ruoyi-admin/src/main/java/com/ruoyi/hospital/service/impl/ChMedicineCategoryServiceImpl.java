package com.ruoyi.hospital.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.hospital.mapper.ChMedicineCategoryMapper;
import com.ruoyi.hospital.domain.ChMedicineCategory;
import com.ruoyi.hospital.service.IChMedicineCategoryService;

/**
 * 药品分类Service业务层处理
 * 
 * @author ruoyi
 * @date 2026-01-27
 */
@Service
public class ChMedicineCategoryServiceImpl implements IChMedicineCategoryService 
{
    @Autowired
    private ChMedicineCategoryMapper chMedicineCategoryMapper;

    /**
     * 查询药品分类
     * 
     * @param categoryId 药品分类主键
     * @return 药品分类
     */
    @Override
    public ChMedicineCategory selectChMedicineCategoryByCategoryId(Long categoryId)
    {
        return chMedicineCategoryMapper.selectChMedicineCategoryByCategoryId(categoryId);
    }

    /**
     * 查询药品分类列表
     * 
     * @param chMedicineCategory 药品分类
     * @return 药品分类
     */
    @Override
    public List<ChMedicineCategory> selectChMedicineCategoryList(ChMedicineCategory chMedicineCategory)
    {
        return chMedicineCategoryMapper.selectChMedicineCategoryList(chMedicineCategory);
    }

    /**
     * 新增药品分类
     * 
     * @param chMedicineCategory 药品分类
     * @return 结果
     */
    @Override
    public int insertChMedicineCategory(ChMedicineCategory chMedicineCategory)
    {
        chMedicineCategory.setCreateTime(DateUtils.getNowDate());
        return chMedicineCategoryMapper.insertChMedicineCategory(chMedicineCategory);
    }

    /**
     * 修改药品分类
     * 
     * @param chMedicineCategory 药品分类
     * @return 结果
     */
    @Override
    public int updateChMedicineCategory(ChMedicineCategory chMedicineCategory)
    {
        chMedicineCategory.setUpdateTime(DateUtils.getNowDate());
        return chMedicineCategoryMapper.updateChMedicineCategory(chMedicineCategory);
    }

    /**
     * 批量删除药品分类
     * 
     * @param categoryIds 需要删除的药品分类主键
     * @return 结果
     */
    @Override
    public int deleteChMedicineCategoryByCategoryIds(Long[] categoryIds)
    {
        return chMedicineCategoryMapper.deleteChMedicineCategoryByCategoryIds(categoryIds);
    }

    /**
     * 删除药品分类信息
     * 
     * @param categoryId 药品分类主键
     * @return 结果
     */
    @Override
    public int deleteChMedicineCategoryByCategoryId(Long categoryId)
    {
        return chMedicineCategoryMapper.deleteChMedicineCategoryByCategoryId(categoryId);
    }
}
