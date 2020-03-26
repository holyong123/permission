package com.asset.service;

import com.asset.beans.PageQuery;
import com.asset.beans.PageResult;
import com.asset.common.Const;
import com.asset.dao.ApprovalMapper;
import com.asset.dao.SysAclMapper;
import com.asset.model.Approval;
import com.asset.util.BeanValidator;
import com.asset.util.GetDateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class ApprovalService {

    @Autowired
    private ApprovalMapper approvalMapper;
    @Autowired
    private SysAclMapper sysAclMapper;




    public PageResult<Approval> list(PageQuery page){
        BeanValidator.check(page);
        int count = approvalMapper.count();
        if(count >0) {
            List<Approval> approvals = approvalMapper.selectListAll(page);
            return PageResult.<Approval>builder().data(approvals).total(count).build();
        }
        return PageResult.<Approval>builder().build();
    }

//    public PageResult<Approval> list(PageQuery page,int userId){
//        BeanValidator.check(page);
//        int count = approvalMapper.count();
//        if(count >0) {
//            List<Approval> approvals = approvalMapper.listById(page,userId);
//            return PageResult.<Approval>builder().data(approvals).total(count).build();
//        }
//        return PageResult.<Approval>builder().build();
//    }

    public PageResult<Approval> list(PageQuery page,int status){
        BeanValidator.check(page);
        int count = approvalMapper.count();
        if(count >0) {
            List<Approval> approvals = approvalMapper.selectByStatus(page,status);
            return PageResult.<Approval>builder().data(approvals).total(count).build();
        }
        return PageResult.<Approval>builder().build();
    }


    public int update(Approval approval){
        BeanValidator.check(approval);
        return approvalMapper.updateByPrimaryKeySelective(approval);

    }




    public  int  save(Approval approval){
        BeanValidator.check(approval);
        return approvalMapper.insertSelective(approval);
    }



    public  int delete(int id){
        BeanValidator.check(id);
        return approvalMapper.deleteByPrimaryKey(id);
    }


    //根据条件删除  不同意-状态和日期
    public  int delete(){
        String pastDate = GetDateTime.getPastDate(7);
        return approvalMapper.deleteByDate(pastDate, Const.approvalStatus.Disagreement);
    }


    //审批状态
    public  List<Approval> selectByStatus(PageQuery page, Integer status){
        List<Approval> approvals = approvalMapper.selectByStatus(page,status);
        if(approvals !=null){
            return approvals;
        }
        return null;
    }


    //根据状态查看
    public PageResult<Approval> listBystatus(PageQuery page,int status){
        BeanValidator.check(page);
        int count = approvalMapper.count();
        if(count >0) {
            List<Approval> approvals = approvalMapper.selectByStatus(page,status);
            return PageResult.<Approval>builder().data(approvals).total(count).build();
        }
        return PageResult.<Approval>builder().build();
    }


    //根据状态查看
    public PageResult<Approval> selectWarehousing(PageQuery page,int status){
        BeanValidator.check(page);
        int count = approvalMapper.count();
        if(count >0) {
            List<Approval> approvals = approvalMapper.selectWarehousing(page,status);
            return PageResult.<Approval>builder().data(approvals).total(count).build();
        }
        return PageResult.<Approval>builder().build();
    }



    //根据条件查询列表
    public PageResult<Approval> selectLikeByCondition(PageQuery page,Approval approval){
        BeanValidator.check(page);
        int sum = approvalMapper.count();
        if(sum >0) {
            List<Approval> approvals = approvalMapper.selectLikeByCondition(page,approval.getName(),approval.getStatus(),approval.getCount(),approval.getOperateTime());
            return PageResult.<Approval>builder().data(approvals).total(sum).build();
        }
        return PageResult.<Approval>builder().build();

    }





}