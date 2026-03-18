package com.ruoyi.hospital.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.hospital.mapper.ChStaffMapper;
import com.ruoyi.hospital.domain.ChStaff;
import com.ruoyi.hospital.service.IChStaffService;

/**
 * 医护人员信息Service业务层处理
 * 
 * @author ruoyi
 * @date 2026-01-28
 */
@Service
public class ChStaffServiceImpl implements IChStaffService 
{
    @Autowired
    private ChStaffMapper chStaffMapper;

    /**
     * 查询医护人员信息
     * 
     * @param staffId 医护人员信息主键
     * @return 医护人员信息
     */
    @Override
    public ChStaff selectChStaffByStaffId(Long staffId)
    {
        return chStaffMapper.selectChStaffByStaffId(staffId);
    }

    /**
     * 查询医护人员信息列表
     * 
     * @param chStaff 医护人员信息
     * @return 医护人员信息
     */
    @Override
    public List<ChStaff> selectChStaffList(ChStaff chStaff)
    {
        return chStaffMapper.selectChStaffList(chStaff);
    }

    /**
     * 新增医护人员信息
     * 
     * @param chStaff 医护人员信息
     * @return 结果
     */
    @Override
    public int insertChStaff(ChStaff chStaff)
    {
        chStaff.setCreateTime(DateUtils.getNowDate());
        return chStaffMapper.insertChStaff(chStaff);
    }

    /**
     * 修改医护人员信息
     * 
     * @param chStaff 医护人员信息
     * @return 结果
     */
    @Override
    public int updateChStaff(ChStaff chStaff)
    {
        chStaff.setUpdateTime(DateUtils.getNowDate());
        return chStaffMapper.updateChStaff(chStaff);
    }

    /**
     * 批量删除医护人员信息
     * 
     * @param staffIds 需要删除的医护人员信息主键
     * @return 结果
     */
    @Override
    public int deleteChStaffByStaffIds(Long[] staffIds)
    {
        return chStaffMapper.deleteChStaffByStaffIds(staffIds);
    }

    /**
     * 删除医护人员信息信息
     * 
     * @param staffId 医护人员信息主键
     * @return 结果
     */
    @Override
    public int deleteChStaffByStaffId(Long staffId)
    {
        return chStaffMapper.deleteChStaffByStaffId(staffId);
    }
}
