package com.asset.dao;

import com.asset.beans.PageQuery;
import com.asset.model.Fault;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface FaultMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Fault record);

    int insertSelective(Fault record);

    Fault selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Fault record);

    int updateByPrimaryKey(Fault record);

    int  count();

    List<Fault> faultWriteList(@Param("page") PageQuery page, @Param("status") int status);

    //status =  2 已处理  status =1 处理中
    List<Fault> faultAllList(@Param("page") PageQuery page, @Param("status") int status);


//    List<Fault> faultAllList(@Param("page")PageQuery page,@Param("requestType")int requestType,@Param("faultType")int faultType,@Param("status")int status,@Param("dealingPeople")String dealingPeople,@Param("operateTime")String operateTime);

    //status =  2 已处理  status =1 处理中
    List<Fault> faultHanding(@Param("page") PageQuery page, @Param("status") int status);


    List<Fault>  faultDisplayParam(@Param("page") PageQuery page, @Param("requestType") int requestType, @Param("faultType") int faultType, @Param("dealingPeople") String dealingPeople, @Param("status") int status);


    List<Fault> selectStatus(@Param("status") int status);

    String dealing(@Param("id") Integer id, @Param("faultType") int faultType);

}