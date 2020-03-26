package com.asset.dao;

import com.asset.model.SysAcl;
import com.asset.model.SysRole;
import com.asset.model.SysUser;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SysRoleMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(SysRole record);

    int insertSelective(SysRole record);

    SysRole selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SysRole record);

    int updateByPrimaryKey(SysRole record);

    List<SysRole> getAll();

    int countByName(@Param("name") String name, @Param("id") Integer id);

    List<SysRole> getByIdList(@Param("idList") List<Integer> idList);

    //判断用户权限
    List<SysRole>  permissionUser(@Param("username")String username);


    //查看用户角色
    List<SysRole>  selectRole(@Param("id") Integer id);

}