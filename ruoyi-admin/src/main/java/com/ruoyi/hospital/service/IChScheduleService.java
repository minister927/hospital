package com.ruoyi.hospital.service;

import com.ruoyi.hospital.domain.ChSchedule;

import java.util.List;

/**
 * 医生排班Service接口
 * 
 * @author ruoyi
 * @date 2026-01-28
 */
public interface IChScheduleService 
{
    /**
     * 查询医生排班
     * 
     * @param scheduleId 医生排班主键
     * @return 医生排班
     */
    public ChSchedule selectChScheduleByScheduleId(Long scheduleId);

    /**
     * 查询医生排班列表
     * 
     * @param chSchedule 医生排班
     * @return 医生排班集合
     */
    public List<ChSchedule> selectChScheduleList(ChSchedule chSchedule);

    /**
     * 新增医生排班
     * 
     * @param chSchedule 医生排班
     * @return 结果
     */
    public int insertChSchedule(ChSchedule chSchedule);

    /**
     * 修改医生排班
     * 
     * @param chSchedule 医生排班
     * @return 结果
     */
    public int updateChSchedule(ChSchedule chSchedule);

    /**
     * 批量删除医生排班
     * 
     * @param scheduleIds 需要删除的医生排班主键集合
     * @return 结果
     */
    public int deleteChScheduleByScheduleIds(Long[] scheduleIds);

    /**
     * 删除医生排班信息
     * 
     * @param scheduleId 医生排班主键
     * @return 结果
     */
    public int deleteChScheduleByScheduleId(Long scheduleId);
}
