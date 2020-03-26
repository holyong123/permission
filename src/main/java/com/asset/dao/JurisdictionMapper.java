package com.asset.dao;

import com.asset.beans.PageQuery;
import com.asset.model.Jurisdiction;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface JurisdictionMapper {

    List<Jurisdiction> securityList(@Param("page") PageQuery page);

    int selectCount();


}
