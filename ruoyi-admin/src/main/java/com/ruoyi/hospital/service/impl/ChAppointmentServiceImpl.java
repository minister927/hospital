package com.ruoyi.hospital.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.hospital.mapper.ChAppointmentMapper;
import com.ruoyi.hospital.domain.ChAppointment;
import com.ruoyi.hospital.service.IChAppointmentService;

/**
 * 预约挂号Service业务层处理
 * 
 * @author ruoyi
 * @date 2026-02-09
 */
@Service
public class ChAppointmentServiceImpl implements IChAppointmentService 
{
    @Autowired
    private ChAppointmentMapper chAppointmentMapper;

    /**
     * 查询预约挂号
     * 
     * @param appointmentId 预约挂号主键
     * @return 预约挂号
     */
    @Override
    public ChAppointment selectChAppointmentByAppointmentId(Long appointmentId)
    {
        return chAppointmentMapper.selectChAppointmentByAppointmentId(appointmentId);
    }

    /**
     * 查询预约挂号列表
     * 
     * @param chAppointment 预约挂号
     * @return 预约挂号
     */
    @Override
    public List<ChAppointment> selectChAppointmentList(ChAppointment chAppointment)
    {
        return chAppointmentMapper.selectChAppointmentList(chAppointment);
    }

    /**
     * 新增预约挂号
     * 
     * @param chAppointment 预约挂号
     * @return 结果
     */
    @Override
    public int insertChAppointment(ChAppointment chAppointment)
    {
        chAppointment.setCreateTime(DateUtils.getNowDate());
        return chAppointmentMapper.insertChAppointment(chAppointment);
    }

    /**
     * 修改预约挂号
     * 
     * @param chAppointment 预约挂号
     * @return 结果
     */
    @Override
    public int updateChAppointment(ChAppointment chAppointment)
    {
        chAppointment.setUpdateTime(DateUtils.getNowDate());
        return chAppointmentMapper.updateChAppointment(chAppointment);
    }

    /**
     * 批量删除预约挂号
     * 
     * @param appointmentIds 需要删除的预约挂号主键
     * @return 结果
     */
    @Override
    public int deleteChAppointmentByAppointmentIds(Long[] appointmentIds)
    {
        return chAppointmentMapper.deleteChAppointmentByAppointmentIds(appointmentIds);
    }

    /**
     * 删除预约挂号信息
     * 
     * @param appointmentId 预约挂号主键
     * @return 结果
     */
    @Override
    public int deleteChAppointmentByAppointmentId(Long appointmentId)
    {
        return chAppointmentMapper.deleteChAppointmentByAppointmentId(appointmentId);
    }
}
