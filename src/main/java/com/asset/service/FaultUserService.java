package com.asset.service;


import com.asset.beans.PageQuery;
import com.asset.beans.PageResult;
import com.asset.common.Const;
import com.asset.dao.FaultTypeMapper;
import com.asset.dao.FaultUserMapper;
import com.asset.model.FaultType;
import com.asset.model.FaultUser;
import com.asset.util.BeanValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FaultUserService {


    @Autowired
    private FaultUserMapper faultUserMapper;

    @Autowired
    private FaultTypeMapper faultTypeMapper;

    public PageResult<FaultUser> faultRoleUserAll(PageQuery page){
        int  count = faultUserMapper.count(Const.roleUser.faultAdministrator);
        if(count > 0){
            List<FaultUser> faultUsers = faultUserMapper.listByUserRoleAll(page, Const.roleUser.faultAdministrator);
            return PageResult.<FaultUser>builder().data(faultUsers).total(count).build();
        }
        return PageResult.<FaultUser>builder().build();
    }

    public PageResult<FaultUser> faultRoleUserCondi(PageQuery page, FaultType faultType){
        BeanValidator.check(faultType);
        int count =0;
        if(("").equals(faultType.getFaultTypeId())){
            count = faultUserMapper.count(Const.roleUser.faultAdministrator);
        }else{
            count = faultUserMapper.countTypeId(Const.roleUser.faultAdministrator,faultType.getFaultTypeId());
        }
        if(count > 0){
            List<FaultUser> faultUsers = faultUserMapper.listByUserRoleCondition(page, Const.roleUser.faultAdministrator,faultType.getFaultTypeId(),faultType.getUserId());
            return PageResult.<FaultUser>builder().data(faultUsers).total(count).build();
        }
        return PageResult.<FaultUser>builder().build();
    }



    //分页查询所有结果
    public PageResult<FaultUser> faultRoleUser(PageQuery page, int  faultTypeId){
        BeanValidator.check(faultTypeId);
        int count =0;
        if(("").equals(faultTypeId)){
            count = faultUserMapper.count(Const.roleUser.faultAdministrator);
        }else{
            count = faultUserMapper.countTypeId(Const.roleUser.faultAdministrator,faultTypeId);
        }
        if(count > 0){
            List<FaultUser> faultUsers = faultUserMapper.listByUserRole(page, Const.roleUser.faultAdministrator,faultTypeId);
            return PageResult.<FaultUser>builder().data(faultUsers).total(count).build();
        }
        return PageResult.<FaultUser>builder().build();
    }




    //分页查询所有结果
    public List<FaultUser> roleUser(){
        int count = faultUserMapper.count(Const.roleUser.faultAdministrator);
        if(count > 0){
            List<FaultUser> faultUsers = faultUserMapper.userRole(Const.roleUser.faultAdministrator);
            return faultUsers;
        }
        return null;
    }


    public  int saveRoleUser(FaultType faultType){
        faultTypeMapper.delete(faultType.getFaultTypeId(), faultType.getUserId());
        return faultTypeMapper.insertSelective(faultType);
    }


    public  int update (FaultType faultType){
        return faultTypeMapper.updateByPrimaryKeySelective(faultType);
    }

    public  int delete(int faultTypeId){
        return faultTypeMapper.deleteByPrimaryKey(faultTypeId);
    }



    public List<FaultUser> selectionRequestType(FaultUser faultUser){
        List<FaultUser> faults = faultUserMapper.selectionRequestType(faultUser.getFaultTypeId());
        if(faults !=null){
            return faults;
        }
        return  null;
    }






}
