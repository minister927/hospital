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
import com.ruoyi.hospital.domain.ChMedicineStock;
import com.ruoyi.hospital.service.IChMedicineStockService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 药品库存Controller
 * 
 * @author ruoyi
 * @date 2026-01-28
 */
@RestController
@RequestMapping("/hospital/stock")
public class ChMedicineStockController extends BaseController
{
    @Autowired
    private IChMedicineStockService chMedicineStockService;

    /**
     * 查询药品库存列表
     */
    @PreAuthorize("@ss.hasPermi('hospital:stock:list')")
    @GetMapping("/list")
    public TableDataInfo list(ChMedicineStock chMedicineStock)
    {
        startPage();
        List<ChMedicineStock> list = chMedicineStockService.selectChMedicineStockList(chMedicineStock);
        return getDataTable(list);
    }

    /**
     * 导出药品库存列表
     */
    @PreAuthorize("@ss.hasPermi('hospital:stock:export')")
    @Log(title = "药品库存", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, ChMedicineStock chMedicineStock)
    {
        List<ChMedicineStock> list = chMedicineStockService.selectChMedicineStockList(chMedicineStock);
        ExcelUtil<ChMedicineStock> util = new ExcelUtil<ChMedicineStock>(ChMedicineStock.class);
        util.exportExcel(response, list, "药品库存数据");
    }

    /**
     * 获取药品库存详细信息
     */
    @PreAuthorize("@ss.hasPermi('hospital:stock:query')")
    @GetMapping(value = "/{stockId}")
    public AjaxResult getInfo(@PathVariable("stockId") Long stockId)
    {
        return success(chMedicineStockService.selectChMedicineStockByStockId(stockId));
    }

    /**
     * 新增药品库存
     */
    @PreAuthorize("@ss.hasPermi('hospital:stock:add')")
    @Log(title = "药品库存", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ChMedicineStock chMedicineStock)
    {
        return toAjax(chMedicineStockService.insertChMedicineStock(chMedicineStock));
    }

    /**
     * 修改药品库存
     */
    @PreAuthorize("@ss.hasPermi('hospital:stock:edit')")
    @Log(title = "药品库存", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ChMedicineStock chMedicineStock)
    {
        return toAjax(chMedicineStockService.updateChMedicineStock(chMedicineStock));
    }

    /**
     * 删除药品库存
     */
    @PreAuthorize("@ss.hasPermi('hospital:stock:remove')")
    @Log(title = "药品库存", businessType = BusinessType.DELETE)
	@DeleteMapping("/{stockIds}")
    public AjaxResult remove(@PathVariable Long[] stockIds)
    {
        return toAjax(chMedicineStockService.deleteChMedicineStockByStockIds(stockIds));
    }
}
