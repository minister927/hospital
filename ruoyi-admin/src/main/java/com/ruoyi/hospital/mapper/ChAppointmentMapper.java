package com.ruoyi.hospital.mapper;

import java.util.List;
import com.ruoyi.hospital.domain.ChAppointment;
import org.apache.ibatis.annotations.Mapper;

/**
 * 预约挂号Mapper接口
 * 
 * @author ruoyi
 * @date 2026-02-09
 */
@Mapper//新增
public interface ChAppointmentMapper 
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
     * 删除预约挂号
     * 
     * @param appointmentId 预约挂号主键
     * @return 结果
     */
    public int deleteChAppointmentByAppointmentId(Long appointmentId);

    /**
     * 批量删除预约挂号
     * 
     * @param appointmentIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteChAppointmentByAppointmentIds(Long[] appointmentIds);
}
