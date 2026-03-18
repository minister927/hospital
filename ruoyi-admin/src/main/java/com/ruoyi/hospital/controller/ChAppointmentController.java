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
import com.ruoyi.hospital.domain.ChAppointment;
import com.ruoyi.hospital.service.IChAppointmentService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 预约挂号Controller
 * 
 * @author ruoyi
 * @date 2026-02-09
 */
@RestController
@RequestMapping("/diagnosis/appointment")
public class ChAppointmentController extends BaseController
{
    @Autowired
    private IChAppointmentService chAppointmentService;

    /**
     * 查询预约挂号列表
     */
    @PreAuthorize("@ss.hasPermi('diagnosis:appointment:list')")
    @GetMapping("/list")
    public TableDataInfo list(ChAppointment chAppointment)
    {
        startPage();
        List<ChAppointment> list = chAppointmentService.selectChAppointmentList(chAppointment);
        return getDataTable(list);
    }

    /**
     * 导出预约挂号列表
     */
    @PreAuthorize("@ss.hasPermi('diagnosis:appointment:export')")
    @Log(title = "预约挂号", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, ChAppointment chAppointment)
    {
        List<ChAppointment> list = chAppointmentService.selectChAppointmentList(chAppointment);
        ExcelUtil<ChAppointment> util = new ExcelUtil<ChAppointment>(ChAppointment.class);
        util.exportExcel(response, list, "预约挂号数据");
    }

    /**
     * 获取预约挂号详细信息
     */
    @PreAuthorize("@ss.hasPermi('diagnosis:appointment:query')")
    @GetMapping(value = "/{appointmentId}")
    public AjaxResult getInfo(@PathVariable("appointmentId") Long appointmentId)
    {
        return success(chAppointmentService.selectChAppointmentByAppointmentId(appointmentId));
    }

    /**
     * 新增预约挂号
     */
    @PreAuthorize("@ss.hasPermi('diagnosis:appointment:add')")
    @Log(title = "预约挂号", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ChAppointment chAppointment)
    {
        return toAjax(chAppointmentService.insertChAppointment(chAppointment));
    }

    /**
     * 修改预约挂号
     */
    @PreAuthorize("@ss.hasPermi('diagnosis:appointment:edit')")
    @Log(title = "预约挂号", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ChAppointment chAppointment)
    {
        return toAjax(chAppointmentService.updateChAppointment(chAppointment));
    }

    /**
     * 删除预约挂号
     */
    @PreAuthorize("@ss.hasPermi('diagnosis:appointment:remove')")
    @Log(title = "预约挂号", businessType = BusinessType.DELETE)
	@DeleteMapping("/{appointmentIds}")
    public AjaxResult remove(@PathVariable Long[] appointmentIds)
    {
        return toAjax(chAppointmentService.deleteChAppointmentByAppointmentIds(appointmentIds));
    }
}
