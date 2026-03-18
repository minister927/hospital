package com.ruoyi.hospital.service;

import java.util.List;
import com.ruoyi.hospital.domain.ChAppointment;

/**
 * 预约挂号Service接口
 * 
 * @author ruoyi
 * @date 2026-02-09
 */
public interface IChAppointmentService 
{
    /**
     * 查询预约挂号
     * 
     * @param appointmentId 预约挂号主键
     * @return 预约挂号
     */
    public ChAppointment selectChAppointmentByAppointmentId(Long appointmentId);

    /**
     * 查询预约挂号列表
     * 
     * @param chAppointment 预约挂号
     * @return 预约挂号集合
     */
    public List<ChAppointment> selectChAppointmentList(ChAppointment chAppointment);

    /**
     * 新增预约挂号
     * 
     * @param chAppointment 预约挂号
     * @return 结果
     */
    public int insertChAppointment(ChAppointment chAppointment);

    /**
     * 修改预约挂号
     * 
     * @param chAppointment 预约挂号
     * @return 结果
     */
    public int updateChAppointment(ChAppointment chAppointment);

    /**
     * 批量删除预约挂号
     * 
     * @param appointmentIds 需要删除的预约挂号主键集合
     * @return 结果
     */
    public int deleteChAppointmentByAppointmentIds(Long[] appointmentIds);

    /**
     * 删除预约挂号信息
     * 
     * @param appointmentId 预约挂号主键
     * @return 结果
     */
    public int deleteChAppointmentByAppointmentId(Long appointmentId);
}
