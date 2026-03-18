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
import com.ruoyi.hospital.domain.ChMedicalRecord;
import com.ruoyi.hospital.service.IMedicalRecordService;
import com.ruoyi.hospital.service.IChPrescriptionService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

@RestController
@RequestMapping("/hospital/record")
public class ChMedicalRecordController extends BaseController
{
    @Autowired
    private IMedicalRecordService medicalRecordService;

    @Autowired
    private IChPrescriptionService prescriptionService;

    @PreAuthorize("@ss.hasPermi('hospital:record:list')")
    @GetMapping("/list")
    public TableDataInfo list(ChMedicalRecord chMedicalRecord)
    {
        startPage();
        List<ChMedicalRecord> list = medicalRecordService.selectChMedicalRecordList(chMedicalRecord);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('hospital:record:export')")
    @Log(title = "就诊记录", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, ChMedicalRecord chMedicalRecord)
    {
        List<ChMedicalRecord> list = medicalRecordService.selectChMedicalRecordList(chMedicalRecord);
        ExcelUtil<ChMedicalRecord> util = new ExcelUtil<>(ChMedicalRecord.class);
        util.exportExcel(response, list, "就诊记录数据");
    }

    @PreAuthorize("@ss.hasPermi('hospital:record:query')")
    @GetMapping(value = "/{recordId}")
    public AjaxResult getInfo(@PathVariable("recordId") Long recordId)
    {
        return success(medicalRecordService.selectChMedicalRecordById(recordId));
    }

    @PreAuthorize("@ss.hasPermi('hospital:record:add')")
    @Log(title = "就诊记录", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ChMedicalRecord chMedicalRecord)
    {
        return toAjax(medicalRecordService.insertChMedicalRecord(chMedicalRecord));
    }

    @PreAuthorize("@ss.hasPermi('hospital:record:edit')")
    @Log(title = "就诊记录", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ChMedicalRecord chMedicalRecord)
    {
        return toAjax(medicalRecordService.updateChMedicalRecord(chMedicalRecord));
    }

    @PreAuthorize("@ss.hasPermi('hospital:record:remove')")
    @Log(title = "就诊记录", businessType = BusinessType.DELETE)
    @DeleteMapping("/{recordIds}")
    public AjaxResult remove(@PathVariable Long[] recordIds)
    {
        return toAjax(medicalRecordService.deleteChMedicalRecordByIds(recordIds));
    }

    /**
     * 获取患者的草稿处方（新增就诊记录时选择）
     */
    @PreAuthorize("@ss.hasPermi('hospital:record:query')")
    @GetMapping("/draftPrescription/{patientId}")
    public AjaxResult draftPrescription(@PathVariable Long patientId)
    {
        return success(prescriptionService.selectDraftPrescriptionByPatientId(patientId));
    }
}