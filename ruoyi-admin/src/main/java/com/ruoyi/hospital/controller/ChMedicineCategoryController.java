package com.ruoyi.hospital.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.hospital.domain.ChMedicineCategory;
import com.ruoyi.hospital.service.IChMedicineCategoryService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 药品分类Controller
 * 
 * @author ruoyi
 * @date 2026-01-27
 */
@RestController
@RequestMapping("/hospital/category")
public class ChMedicineCategoryController extends BaseController
{
    @Autowired
    private IChMedicineCategoryService chMedicineCategoryService;

    /**
     * 查询药品分类列表
     */
    @PreAuthorize("@ss.hasPermi('hospital:category:list')")
    @GetMapping("/list")
    public TableDataInfo list(ChMedicineCategory chMedicineCategory)
    {
        startPage();
        List<ChMedicineCategory> list = chMedicineCategoryService.selectChMedicineCategoryList(chMedicineCategory);
        return getDataTable(list);
    }

    /**
     * 导出药品分类列表
     */
    @PreAuthorize("@ss.hasPermi('hospital:category:export')")
    @Log(title = "药品分类", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, ChMedicineCategory chMedicineCategory)
    {
        List<ChMedicineCategory> list = chMedicineCategoryService.selectChMedicineCategoryList(chMedicineCategory);
        ExcelUtil<ChMedicineCategory> util = new ExcelUtil<ChMedicineCategory>(ChMedicineCategory.class);
        util.exportExcel(response, list, "药品分类数据");
    }

    /**
     * 获取药品分类详细信息
     */
    @PreAuthorize("@ss.hasPermi('hospital:category:query')")
    @GetMapping(value = "/{categoryId}")
    public AjaxResult getInfo(@PathVariable("categoryId") Long categoryId)
    {
        return success(chMedicineCategoryService.selectChMedicineCategoryByCategoryId(categoryId));
    }

    /**
     * 新增药品分类
     */
    @PreAuthorize("@ss.hasPermi('hospital:category:add')")
    @Log(title = "药品分类", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ChMedicineCategory chMedicineCategory)
    {
        return toAjax(chMedicineCategoryService.insertChMedicineCategory(chMedicineCategory));
    }

    /**
     * 修改药品分类
     */
    @PreAuthorize("@ss.hasPermi('hospital:category:edit')")
    @Log(title = "药品分类", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ChMedicineCategory chMedicineCategory)
    {
        return toAjax(chMedicineCategoryService.updateChMedicineCategory(chMedicineCategory));
    }

    /**
     * 删除药品分类
     */
    @PreAuthorize("@ss.hasPermi('hospital:category:remove')")
    @Log(title = "药品分类", businessType = BusinessType.DELETE)
	@DeleteMapping("/{categoryIds}")
    public AjaxResult remove(@PathVariable Long[] categoryIds)
    {
        return toAjax(chMedicineCategoryService.deleteChMedicineCategoryByCategoryIds(categoryIds));
    }
}
