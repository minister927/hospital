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
import com.ruoyi.hospital.domain.ChPatient;
import com.ruoyi.hospital.service.IChPatientService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 患者信息Controller
 * 
 * @author ruoyi
 * @date 2026-02-09
 */
@RestController
@RequestMapping("/hospital/patient")
public class ChPatientController extends BaseController
{
    @Autowired
    private IChPatientService chPatientService;

    /**
     * 查询患者信息列表
     */
    @PreAuthorize("@ss.hasPermi('hospital:patient:list')")
    @GetMapping("/list")
    public TableDataInfo list(ChPatient chPatient)
    {
        startPage();
        List<ChPatient> list = chPatientService.selectChPatientList(chPatient);
        return getDataTable(list);
    }

    /**
     * 导出患者信息列表
     */
    @PreAuthorize("@ss.hasPermi('hospital:patient:export')")
    @Log(title = "患者信息", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, ChPatient chPatient)
    {
        List<ChPatient> list = chPatientService.selectChPatientList(chPatient);
        ExcelUtil<ChPatient> util = new ExcelUtil<ChPatient>(ChPatient.class);
        util.exportExcel(response, list, "患者信息数据");
    }

    /**
     * 获取患者信息详细信息
     */
    @PreAuthorize("@ss.hasPermi('hospital:patient:query')")
    @GetMapping(value = "/{patientId}")
    public AjaxResult getInfo(@PathVariable("patientId") Long patientId)
    {
        return success(chPatientService.selectChPatientByPatientId(patientId));
    }

    /**
     * 新增患者信息
     */
    @PreAuthorize("@ss.hasPermi('hospital:patient:add')")
    @Log(title = "患者信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ChPatient chPatient)
    {
        return toAjax(chPatientService.insertChPatient(chPatient));
    }

    /**
     * 修改患者信息
     */
    @PreAuthorize("@ss.hasPermi('hospital:patient:edit')")
    @Log(title = "患者信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ChPatient chPatient)
    {
        return toAjax(chPatientService.updateChPatient(chPatient));
    }

    /**
     * 删除患者信息
     */
    @PreAuthorize("@ss.hasPermi('hospital:patient:remove')")
    @Log(title = "患者信息", businessType = BusinessType.DELETE)
	@DeleteMapping("/{patientIds}")
    public AjaxResult remove(@PathVariable Long[] patientIds)
    {
        return toAjax(chPatientService.deleteChPatientByPatientIds(patientIds));
    }
}
