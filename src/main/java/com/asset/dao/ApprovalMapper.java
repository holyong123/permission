package com.asset.dao;

import com.asset.beans.PageQuery;
import com.asset.model.Approval;
import com.asset.model.Goods;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ApprovalMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Approval record);

    int insertSelective(Approval record);

    Approval selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Approval record);

    int updateByPrimaryKey(Approval record);

    List<Approval> selectListAll(@Param("page") PageQuery page);

    List<Approval>  listById(@Param("page") PageQuery page,@Param("id") int  userId);

    int  count();

    //条件查询
    List<Approval>   selectLikeByCondition(@Param("page") PageQuery page, @Param("name")String name, @Param("status")Integer status, @Param("count")Integer count, @Param("operateTime")String operateTime);

    List<Approval>  getStatus(@Param("name") String name );

    List<Approval> selectStatus(@Param("status")Integer status);
    //查看审批状态
    List<Approval> selectByStatus(@Param("page") PageQuery page,@Param("status")Integer status);
    //查看未入库状态  已购买的状态
    List<Approval> selectWarehousing(@Param("page") PageQuery page,@Param("status")Integer status);

    //根据日期删除记录
    int deleteByDate( @Param("operateTime")String operateTime, @Param("status")Integer status);



}