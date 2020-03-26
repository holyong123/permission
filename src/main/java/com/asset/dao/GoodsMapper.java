package com.asset.dao;

import com.asset.beans.PageQuery;
import com.asset.model.Goods;
import com.asset.param.GoodsParam;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface GoodsMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Goods record);

    int insertSelective(Goods record);

    Goods selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Goods record);

    int updateByPrimaryKey(Goods record);


    List<Goods> selectListAll(@Param("page")PageQuery page);

    List<Goods> selectList();

    int selectCount();

    List<Goods> selectByIdName( @Param("name")String name,@Param("approxId")int  approxId);

    //根据条件查询
    List<Goods> selectLikeByCondition(@Param("page")PageQuery page,@Param("name")String name,@Param("applicant")String  applicant, @Param("status")Integer status, @Param("operateTime")String operateTime);


    List<Goods> selectExcelData();



}