package com.ruoyi.hospital.service.impl;

import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.hospital.domain.ChSchedule;
import com.ruoyi.hospital.mapper.ChScheduleMapper;
import com.ruoyi.hospital.service.IChScheduleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 医生排班Service业务层处理
 * 
 * @author ruoyi
 * @date 2026-01-28
 */
@Service
public class ChScheduleServiceImpl implements IChScheduleService
{
    @Autowired
    private ChScheduleMapper chScheduleMapper;

    /**
     * 查询医生排班
     * 
     * @param scheduleId 医生排班主键
     * @return 医生排班
     */
    @Override
    public ChSchedule selectChScheduleByScheduleId(Long scheduleId)
    {
        return chScheduleMapper.selectChScheduleByScheduleId(scheduleId);
    }

    /**
     * 查询医生排班列表
     * 
     * @param chSchedule 医生排班
     * @return 医生排班
     */
    @Override
    public List<ChSchedule> selectChScheduleList(ChSchedule chSchedule)
    {
        return chScheduleMapper.selectChScheduleList(chSchedule);
    }

    /**
     * 新增医生排班
     * 
     * @param chSchedule 医生排班
     * @return 结果
     */
    @Override
    public int insertChSchedule(ChSchedule chSchedule)
    {
        chSchedule.setCreateTime(DateUtils.getNowDate());
        return chScheduleMapper.insertChSchedule(chSchedule);
    }

    /**
     * 修改医生排班
     * 
     * @param chSchedule 医生排班
     * @return 结果
     */
    @Override
    public int updateChSchedule(ChSchedule chSchedule)
    {
        chSchedule.setUpdateTime(DateUtils.getNowDate());
        return chScheduleMapper.updateChSchedule(chSchedule);
    }

    /**
     * 批量删除医生排班
     * 
     * @param scheduleIds 需要删除的医生排班主键
     * @return 结果
     */
    @Override
    public int deleteChScheduleByScheduleIds(Long[] scheduleIds)
    {
        return chScheduleMapper.deleteChScheduleByScheduleIds(scheduleIds);
    }

    /**
     * 删除医生排班信息
     * 
     * @param scheduleId 医生排班主键
     * @return 结果
     */
    @Override
    public int deleteChScheduleByScheduleId(Long scheduleId)
    {
        return chScheduleMapper.deleteChScheduleByScheduleId(scheduleId);
    }
}
