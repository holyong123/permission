package com.asset.dao;

import com.asset.beans.PageQuery;
import com.asset.model.FaultUser;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface FaultUserMapper {

    int count(@Param("name") String roleName);

    int countTypeId(@Param("name") String roleName, @Param("faultTypeId") int faultTypeId);


    //条件查询
    List<FaultUser> listByUserRole(@Param("page") PageQuery page, @Param("name") String roleName, @Param("typeId") int faultTypeId);

    List<FaultUser> listByUserRoleAll(@Param("page") PageQuery page, @Param("name") String roleName);

    List<FaultUser> listByUserRoleCondition(@Param("page") PageQuery page, @Param("name") String roleName, @Param("faultTypeId") int faultTypeId, @Param("userId") int userId);

    List<FaultUser> userRole(@Param("name") String roleName);

    int saveRoleUser(FaultUser faultUser);

    List<FaultUser> selectionRequestType(@Param("faultTypeId") int faultTypeId);

}
