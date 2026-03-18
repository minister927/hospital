package com.ruoyi.hospital.service;

import java.util.List;
import com.ruoyi.hospital.domain.ChStaff;

/**
 * 医护人员信息Service接口
 * 
 * @author ruoyi
 * @date 2026-01-28
 */
public interface IChStaffService 
{
    /**
     * 查询医护人员信息
     * 
     * @param staffId 医护人员信息主键
     * @return 医护人员信息
     */
    public ChStaff selectChStaffByStaffId(Long staffId);

    /**
     * 查询医护人员信息列表
     * 
     * @param chStaff 医护人员信息
     * @return 医护人员信息集合
     */
    public List<ChStaff> selectChStaffList(ChStaff chStaff);

    /**
     * 新增医护人员信息
     * 
     * @param chStaff 医护人员信息
     * @return 结果
     */
    public int insertChStaff(ChStaff chStaff);

    /**
     * 修改医护人员信息
     * 
     * @param chStaff 医护人员信息
     * @return 结果
     */
    public int updateChStaff(ChStaff chStaff);

    /**
     * 批量删除医护人员信息
     * 
     * @param staffIds 需要删除的医护人员信息主键集合
     * @return 结果
     */
    public int deleteChStaffByStaffIds(Long[] staffIds);

    /**
     * 删除医护人员信息信息
     * 
     * @param staffId 医护人员信息主键
     * @return 结果
     */
    public int deleteChStaffByStaffId(Long staffId);
}
