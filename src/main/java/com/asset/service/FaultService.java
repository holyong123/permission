package com.asset.service;


import com.asset.beans.PageQuery;
import com.asset.beans.PageResult;
import com.asset.common.Const;
import com.asset.dao.FaultMapper;
import com.asset.dao.FaultUserMapper;
import com.asset.model.Fault;
import com.asset.util.BeanValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
public class FaultService {
    @Autowired
    private FaultMapper faultMapper;
    @Autowired
    private FaultUserMapper faultUserMapper;




    //分页查询所有结果
    public PageResult<Fault> faultAll(PageQuery page, int status){
        BeanValidator.check(page);
        int count = faultMapper.count();
        if(count > 0){
            List<Fault> faultList = faultMapper.faultAllList(page,status);
            return PageResult.<Fault>builder().data(faultList).total(count).build();
        }
        return PageResult.<Fault>builder().build();
    }

    //模糊查询
    public PageResult<Fault> faultDisplayParam(PageQuery page, Fault fault){
        BeanValidator.check(fault);
        int count = faultMapper.count();
        if(count > 0){
//            if( fault.getRequestType() ==0 ||  fault.getFaultType()==0){
//                List<Fault> faultList = faultMapper.faultDisplayParam(page, fault.getDealingPeople(),Const.faultStatus.faulted);
//            }
            List<Fault> faultList = faultMapper.faultDisplayParam(page, fault.getRequestType(),fault.getFaultType(),fault.getDealingPeople(), Const.faultStatus.faulted);
            return PageResult.<Fault>builder().data(faultList).total(count).build();
        }
        return PageResult.<Fault>builder().build();

    }


    //分页  故障状态查询结果
    public PageResult<Fault> faultWriteList(PageQuery page, int status){
        BeanValidator.check(page);
        int count = faultMapper.count();
        if(count > 0){
            List<Fault> faultList = faultMapper.faultWriteList(page,status);
            return PageResult.<Fault>builder().data(faultList).total(count).build();
        }
        return PageResult.<Fault>builder().build();

    }

    //新增故障
    public int  faultSave(Fault record){
        BeanValidator.check(record);
        String formatDate= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
        String format = new SimpleDateFormat("HH:mm:ss").format(new Date());
        if(record.getFaultTime() != null && record.getFaultTime().length() > 8){
            record.setFaultTime(record.getFaultTime()+ " "+ format);
        }else{
            record.setFaultTime(formatDate);
        }

        if(record.getOperateTime() != null && record.getOperateTime().length() > 8 ){
            record.setOperateTime(record.getOperateTime()+" "+format);
        }else{
            record.setOperateTime(formatDate);
        }
        return faultMapper.insertSelective(record);

    }

    public int  save(Fault record){
        BeanValidator.check(record);
        return faultMapper.insertSelective(record);

    }
    //修改故障
    public int  faultUpdate(Fault record){
        BeanValidator.check(record);
        String formatDate= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
        String format = new SimpleDateFormat("HH:mm:ss").format(new Date());
        if(record.getFaultTime() != null && record.getFaultTime().length() > 8){
            record.setFaultTime(record.getFaultTime()+ " "+format);
        }else{
            record.setFaultTime(formatDate);
        }
        if(record.getOperateTime() != null && record.getOperateTime().length() > 8){
            record.setOperateTime(record.getOperateTime()+" "+format);
        }else{
            record.setOperateTime(formatDate);
        }
        return faultMapper.updateByPrimaryKeySelective(record);

    }


//    public  int updateHanding(Fault record){
//        BeanValidator.check(record);
//        String formatDate= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
//        String format = new SimpleDateFormat("HH:mm:ss").format(new Date());
//
//        if(record.getOperateTime() != null && record.getOperateTime().length() > 8){
//            record.setOperateTime(record.getOperateTime()+" "+ format);
//        }else{
//            record.setOperateTime(formatDate);
//        }
//        return faultMapper.updateByPrimaryKeySelective(record);
//
//    }


    //修改故障
    public int  update(Fault record){
        BeanValidator.check(record);
        return faultMapper.updateByPrimaryKeySelective(record);

    }



    //删除故障
    public  int delete(int id){
        BeanValidator.check(id);
        return faultMapper.deleteByPrimaryKey(id);
    }


    //分页  故障状态查询结果
    public PageResult<Fault> faultHanding(PageQuery page, int status){
        BeanValidator.check(page);
        int count = faultMapper.count();
        if(count > 0){
            List<Fault> faultList = faultMapper.faultHanding(page,status);
            return PageResult.<Fault>builder().data(faultList).total(count).build();
        }
        return PageResult.<Fault>builder().build();

    }


    public List<Fault> selectStatus(int status){
        List<Fault> faults = faultMapper.selectStatus(status);
        if(faults ==null){
            return  null;
        }
        return faults;
    }

    public  String dealing(Integer id, int faultType){
        BeanValidator.check(id);
        BeanValidator.check(faultType);
        return faultMapper.dealing(id,faultType);
    }

}
