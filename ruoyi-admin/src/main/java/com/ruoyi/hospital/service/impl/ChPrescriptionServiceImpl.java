package com.ruoyi.hospital.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import com.ruoyi.common.utils.StringUtils;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.hospital.domain.ChPrescriptionDetail;
import com.ruoyi.hospital.mapper.ChPrescriptionMapper;
import com.ruoyi.hospital.domain.ChPrescription;
import com.ruoyi.hospital.service.IChPrescriptionService;

/**
 * 处方Service业务层处理
 *
 * @author ruoyi
 * @date 2026-02-09
 */
@Service
public class ChPrescriptionServiceImpl implements IChPrescriptionService
{
    @Autowired
    private ChPrescriptionMapper chPrescriptionMapper;

    /**
     * 查询处方
     *
     * @param prescriptionId 处方主键
     * @return 处方
     */
    @Override
    public ChPrescription selectChPrescriptionByPrescriptionId(Long prescriptionId)
    {
        return chPrescriptionMapper.selectChPrescriptionByPrescriptionId(prescriptionId);
    }

    @Override
    public List<ChPrescription> selectDraftPrescriptionByPatientId(Long patientId) {
        return null;
    }

    /**
     * 查询处方列表
     *
     * @param chPrescription 处方
     * @return 处方
     */
    @Override
    public List<ChPrescription> selectChPrescriptionList(ChPrescription chPrescription)
    {
        return chPrescriptionMapper.selectChPrescriptionList(chPrescription);
    }

    /**
     * 新增处方
     *
     * @param chPrescription 处方
     * @return 结果
     */
    @Transactional
    @Override
    public int insertChPrescription(ChPrescription chPrescription)
    {
        // 如果前端没有传递处方编号，则自动生成一个唯一的处方编号，后续优化代码生成逻辑
        if (chPrescription.getPrescriptionNo() == null || chPrescription.getPrescriptionNo().trim().isEmpty()) {
            // generate a simple unique prescription number: PR + yyyyMMddHHmmss + 3 random digits
            String gen = "PR" + DateUtils.dateTimeNow() + (int)(Math.random() * 900 + 100);
            chPrescription.setPrescriptionNo(gen);
        }
        chPrescription.setCreateTime(DateUtils.getNowDate());
        int rows = chPrescriptionMapper.insertChPrescription(chPrescription);
        insertChPrescriptionDetail(chPrescription);
        return rows;
    }

    /**
     * 修改处方
     *
     * @param chPrescription 处方
     * @return 结果
     */
    @Transactional
    @Override
    public int updateChPrescription(ChPrescription chPrescription)
    {
        chPrescription.setUpdateTime(DateUtils.getNowDate());
        chPrescriptionMapper.deleteChPrescriptionDetailByPrescriptionId(chPrescription.getPrescriptionId());
        insertChPrescriptionDetail(chPrescription);
        return chPrescriptionMapper.updateChPrescription(chPrescription);
    }

    /**
     * 实现接口中的确认处方方法,接口的方法再类里面都要实现
     */
    @Override
    public int confirmPrescription(Long prescriptionId, Long recordId) {
        // 这里编写业务逻辑，比如调用Mapper关联就诊记录
        // 示例：return chPrescriptionMapper.confirmPrescription(prescriptionId, recordId);
        // 若暂时无实际逻辑，可先返回默认值（后续补充）
        return 0;
    }

    /**
     * 批量删除处方
     *
     * @param prescriptionIds 需要删除的处方主键
     * @return 结果
     */
    @Transactional
    @Override
    public int deleteChPrescriptionByPrescriptionIds(Long[] prescriptionIds)
    {
        chPrescriptionMapper.deleteChPrescriptionDetailByPrescriptionIds(prescriptionIds);
        return chPrescriptionMapper.deleteChPrescriptionByPrescriptionIds(prescriptionIds);
    }

    /**
     * 删除处方信息
     *
     * @param prescriptionId 处方主键
     * @return 结果
     */
    @Transactional
    @Override
    public int deleteChPrescriptionByPrescriptionId(Long prescriptionId)
    {
        chPrescriptionMapper.deleteChPrescriptionDetailByPrescriptionId(prescriptionId);
        return chPrescriptionMapper.deleteChPrescriptionByPrescriptionId(prescriptionId);
    }

    /**
     * 新增处方明细信息
     *
     * @param chPrescription 处方对象
     */
    public void insertChPrescriptionDetail(ChPrescription chPrescription)
    {
        List<ChPrescriptionDetail> chPrescriptionDetailList = chPrescription.getChPrescriptionDetailList();
        Long prescriptionId = chPrescription.getPrescriptionId();
        if (StringUtils.isNotNull(chPrescriptionDetailList))
        {
            List<ChPrescriptionDetail> list = new ArrayList<ChPrescriptionDetail>();
            for (ChPrescriptionDetail chPrescriptionDetail : chPrescriptionDetailList)
            {
                chPrescriptionDetail.setPrescriptionId(prescriptionId);
                list.add(chPrescriptionDetail);
            }
            if (list.size() > 0)
            {
                chPrescriptionMapper.batchChPrescriptionDetail(list);
            }
        }
    }
}
