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
import com.ruoyi.hospital.domain.ChPrescription;
import com.ruoyi.hospital.service.IChPrescriptionService;
import com.ruoyi.hospital.domain.ChAppointment;
import com.ruoyi.hospital.service.IChAppointmentService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 处方Controller
 * 
 * @author ruoyi
 * @date 2026-02-09
 */
@RestController
@RequestMapping("/diagnosis/prescription")
public class ChPrescriptionController extends BaseController
{
    @Autowired
    private IChPrescriptionService chPrescriptionService;
    @Autowired
    private IChAppointmentService chAppointmentService;

    /**
     * 查询处方列表
     */
    @PreAuthorize("@ss.hasPermi('diagnosis:prescription:list')")
    @GetMapping("/list")
    public TableDataInfo list(ChPrescription chPrescription)
    {
        startPage();
        List<ChPrescription> list = chPrescriptionService.selectChPrescriptionList(chPrescription);
        return getDataTable(list);
    }

    /**
     * 导出处方列表
     */
    @PreAuthorize("@ss.hasPermi('diagnosis:prescription:export')")
    @Log(title = "处方", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, ChPrescription chPrescription)
    {
        List<ChPrescription> list = chPrescriptionService.selectChPrescriptionList(chPrescription);
        ExcelUtil<ChPrescription> util = new ExcelUtil<ChPrescription>(ChPrescription.class);
        util.exportExcel(response, list, "处方数据");
    }

    /**
     * 获取处方详细信息
     */
    @PreAuthorize("@ss.hasPermi('diagnosis:prescription:query')")
    @GetMapping(value = "/{prescriptionId}")
    public AjaxResult getInfo(@PathVariable("prescriptionId") Long prescriptionId)
    {
        return success(chPrescriptionService.selectChPrescriptionByPrescriptionId(prescriptionId));
    }

    /**
     * 新增处方
     */
    @PreAuthorize("@ss.hasPermi('diagnosis:prescription:add')")
    @Log(title = "处方", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ChPrescription chPrescription)
    {
        int rows = chPrescriptionService.insertChPrescription(chPrescription);
        // 提交处方后，自动将该患者的就诊（若有待接诊/就诊中记录）标记为已完成
        try {
            if (rows > 0 && chPrescription.getPatientId() != null) {
                ChAppointment criteria = new ChAppointment();
                criteria.setPatientId(chPrescription.getPatientId());
                List<ChAppointment> list = chAppointmentService.selectChAppointmentList(criteria);
                if (list != null) {
                    for (ChAppointment ap : list) {
                        String status = ap.getAppointmentStatus();
                        if ("pending".equals(status) || "confirmed".equals(status)) {
                            ap.setAppointmentStatus("completed");
                            chAppointmentService.updateChAppointment(ap);
                        }
                    }
                }
            }
        } catch (Exception ex) {
            // 记录异常但不要阻断处方新增
        }
        return toAjax(rows);
    }

    /**
     * 修改处方
     */
    @PreAuthorize("@ss.hasPermi('diagnosis:prescription:edit')")
    @Log(title = "处方", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ChPrescription chPrescription)
    {
        return toAjax(chPrescriptionService.updateChPrescription(chPrescription));
    }

    /**
     * 删除处方
     */
    @PreAuthorize("@ss.hasPermi('diagnosis:prescription:remove')")
    @Log(title = "处方", businessType = BusinessType.DELETE)
	@DeleteMapping("/{prescriptionIds}")
    public AjaxResult remove(@PathVariable Long[] prescriptionIds)
    {
        return toAjax(chPrescriptionService.deleteChPrescriptionByPrescriptionIds(prescriptionIds));
    }
}
