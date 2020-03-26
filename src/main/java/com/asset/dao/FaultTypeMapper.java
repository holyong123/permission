package com.asset.dao;

import com.asset.model.FaultType;
import org.apache.ibatis.annotations.Param;

public interface FaultTypeMapper {
    int deleteByPrimaryKey(Integer typeId);

    int insert(FaultType record);

    int insertSelective(FaultType record);

    FaultType selectByPrimaryKey(Integer typeId);

    int updateByPrimaryKeySelective(FaultType record);

    int updateByPrimaryKey(FaultType record);

    int delete(@Param("faultTypeId") Integer faultTypeId, @Param("userId") Integer userId);



}