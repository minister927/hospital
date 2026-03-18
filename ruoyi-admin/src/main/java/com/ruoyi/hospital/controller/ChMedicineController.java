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
import com.ruoyi.hospital.domain.ChMedicine;
import com.ruoyi.hospital.service.IChMedicineService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 药品信息Controller
 * 
 * @author ruoyi
 * @date 2026-01-27
 */
@RestController
@RequestMapping("/hospital/medicine")
public class ChMedicineController extends BaseController
{
    @Autowired
    private IChMedicineService chMedicineService;

    /**
     * 查询药品信息列表
     */
    @PreAuthorize("@ss.hasPermi('hospital:medicine:list')")
    @GetMapping("/list")
    public TableDataInfo list(ChMedicine chMedicine)
    {
        startPage();
        List<ChMedicine> list = chMedicineService.selectChMedicineList(chMedicine);
        return getDataTable(list);
    }

    /**
     * 导出药品信息列表
     */
    @PreAuthorize("@ss.hasPermi('hospital:medicine:export')")
    @Log(title = "药品信息", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, ChMedicine chMedicine)
    {
        List<ChMedicine> list = chMedicineService.selectChMedicineList(chMedicine);
        ExcelUtil<ChMedicine> util = new ExcelUtil<ChMedicine>(ChMedicine.class);
        util.exportExcel(response, list, "药品信息数据");
    }

    /**
     * 获取药品信息详细信息
     */
    @PreAuthorize("@ss.hasPermi('hospital:medicine:query')")
    @GetMapping(value = "/{medicineId}")
    public AjaxResult getInfo(@PathVariable("medicineId") Long medicineId)
    {
        return success(chMedicineService.selectChMedicineByMedicineId(medicineId));
    }

    /**
     * 新增药品信息
     */
    @PreAuthorize("@ss.hasPermi('hospital:medicine:add')")
    @Log(title = "药品信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ChMedicine chMedicine)
    {
        return toAjax(chMedicineService.insertChMedicine(chMedicine));
    }

    /**
     * 修改药品信息
     */
    @PreAuthorize("@ss.hasPermi('hospital:medicine:edit')")
    @Log(title = "药品信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ChMedicine chMedicine)
    {
        return toAjax(chMedicineService.updateChMedicine(chMedicine));
    }

    /**
     * 删除药品信息
     */
    @PreAuthorize("@ss.hasPermi('hospital:medicine:remove')")
    @Log(title = "药品信息", businessType = BusinessType.DELETE)
	@DeleteMapping("/{medicineIds}")
    public AjaxResult remove(@PathVariable Long[] medicineIds)
    {
        return toAjax(chMedicineService.deleteChMedicineByMedicineIds(medicineIds));
    }
}
