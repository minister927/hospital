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
import com.ruoyi.hospital.domain.ChStaff;
import com.ruoyi.hospital.service.IChStaffService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 医护人员信息Controller
 * 
 * @author ruoyi
 * @date 2026-01-28
 */
@RestController
@RequestMapping("/doctor/info")
public class ChStaffController extends BaseController
{
    @Autowired
    private IChStaffService chStaffService;

    /**
     * 查询医护人员信息列表
     */
    @PreAuthorize("@ss.hasPermi('doctor:info:list')")
    @GetMapping("/list")
    public TableDataInfo list(ChStaff chStaff)
    {
        startPage();
        List<ChStaff> list = chStaffService.selectChStaffList(chStaff);
        return getDataTable(list);
    }

    /**
     * 导出医护人员信息列表
     */
    @PreAuthorize("@ss.hasPermi('doctor:info:export')")
    @Log(title = "医护人员信息", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, ChStaff chStaff)
    {
        List<ChStaff> list = chStaffService.selectChStaffList(chStaff);
        ExcelUtil<ChStaff> util = new ExcelUtil<ChStaff>(ChStaff.class);
        util.exportExcel(response, list, "医护人员信息数据");
    }

    /**
     * 获取医护人员信息详细信息
     */
    @PreAuthorize("@ss.hasPermi('doctor:info:query')")
    @GetMapping(value = "/{staffId}")
    public AjaxResult getInfo(@PathVariable("staffId") Long staffId)
    {
        return success(chStaffService.selectChStaffByStaffId(staffId));
    }

    /**
     * 新增医护人员信息
     */
    @PreAuthorize("@ss.hasPermi('doctor:info:add')")
    @Log(title = "医护人员信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ChStaff chStaff)
    {
        return toAjax(chStaffService.insertChStaff(chStaff));
    }

    /**
     * 修改医护人员信息
     */
    @PreAuthorize("@ss.hasPermi('doctor:info:edit')")
    @Log(title = "医护人员信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ChStaff chStaff)
    {
        return toAjax(chStaffService.updateChStaff(chStaff));
    }

    /**
     * 删除医护人员信息
     */
    @PreAuthorize("@ss.hasPermi('doctor:info:remove')")
    @Log(title = "医护人员信息", businessType = BusinessType.DELETE)
	@DeleteMapping("/{staffIds}")
    public AjaxResult remove(@PathVariable Long[] staffIds)
    {
        return toAjax(chStaffService.deleteChStaffByStaffIds(staffIds));
    }
}
