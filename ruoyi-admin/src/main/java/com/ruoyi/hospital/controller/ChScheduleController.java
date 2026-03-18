package com.ruoyi.hospital.controller;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.hospital.domain.ChSchedule;
import com.ruoyi.hospital.service.IChScheduleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 医生排班Controller
 * 
 * @author ruoyi
 * @date 2026-01-28
 */
@RestController
@RequestMapping("/hospital/schedule")
public class ChScheduleController extends BaseController
{
    @Autowired
    private IChScheduleService chScheduleService;

    /**
     * 查询医生排班列表
     */
    @PreAuthorize("@ss.hasPermi('hospital:schedule:list')")
    @GetMapping("/list")
    public TableDataInfo list(ChSchedule chSchedule)
    {
        startPage();
        List<ChSchedule> list = chScheduleService.selectChScheduleList(chSchedule);
        return getDataTable(list);
    }

    /**
     * 导出医生排班列表
     */
    @PreAuthorize("@ss.hasPermi('hospital:schedule:export')")
    @Log(title = "医生排班", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, ChSchedule chSchedule)
    {
        List<ChSchedule> list = chScheduleService.selectChScheduleList(chSchedule);
        ExcelUtil<ChSchedule> util = new ExcelUtil<ChSchedule>(ChSchedule.class);
        util.exportExcel(response, list, "医生排班数据");
    }

    /**
     * 获取医生排班详细信息
     */
    @PreAuthorize("@ss.hasPermi('hospital:schedule:query')")
    @GetMapping(value = "/{scheduleId}")
    public AjaxResult getInfo(@PathVariable("scheduleId") Long scheduleId)
    {
        return success(chScheduleService.selectChScheduleByScheduleId(scheduleId));
    }

    /**
     * 新增医生排班
     */
    @PreAuthorize("@ss.hasPermi('hospital:schedule:add')")
    @Log(title = "医生排班", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ChSchedule chSchedule)
    {
        return toAjax(chScheduleService.insertChSchedule(chSchedule));
    }

    /**
     * 修改医生排班
     */
    @PreAuthorize("@ss.hasPermi('hospital:schedule:edit')")
    @Log(title = "医生排班", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ChSchedule chSchedule)
    {
        return toAjax(chScheduleService.updateChSchedule(chSchedule));
    }

    /**
     * 删除医生排班
     */
    @PreAuthorize("@ss.hasPermi('hospital:schedule:remove')")
    @Log(title = "医生排班", businessType = BusinessType.DELETE)
	@DeleteMapping("/{scheduleIds}")
    public AjaxResult remove(@PathVariable Long[] scheduleIds)
    {
        return toAjax(chScheduleService.deleteChScheduleByScheduleIds(scheduleIds));
    }
}
