package com.asset.controller;


import com.alibaba.fastjson.JSONObject;
import com.asset.beans.PageQuery;
import com.asset.beans.PageResult;
import com.asset.common.Const;
import com.asset.common.JsonData;
import com.asset.dao.SysAclMapper;
import com.asset.model.Fault;
import com.asset.model.FaultType;
import com.asset.model.FaultUser;
import com.asset.model.SysAcl;
import com.asset.service.FaultService;
import com.asset.service.FaultUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("faultUser")
public class FaultUseController {
    @Autowired
    private FaultUserService faultUserService;
    @Autowired
    private FaultService faultService;

    @Autowired
    private SysAclMapper sysAclMapper;

    @RequestMapping("allotment.page")
    public ModelAndView allotment(){
        return new ModelAndView("allotment");
    }



    @RequestMapping(value = "/faultRoleUserAll.json",
            produces = "application/json;charset=utf-8",
            method = RequestMethod.GET
    )
    @ResponseBody
    public JsonData faultRoleUserAll(PageQuery page){
        PageResult<FaultUser> faultUserPageResult = faultUserService.faultRoleUserAll(page);
        return  JsonData.success(faultUserPageResult);
    }


/*    模糊查询*/
    @RequestMapping(value = "/faultRoleUserCondition.json",
            produces = "application/json;charset=utf-8",
            method = RequestMethod.GET
    )
    @ResponseBody
    public JsonData faultRoleUserCondition(PageQuery page, FaultType faultType){
        PageResult<FaultUser> faultUserPageResult = faultUserService.faultRoleUserCondi(page,faultType);
        return  JsonData.success(faultUserPageResult);
    }


    //关联匹配的
    @RequestMapping(value = "/faultRoleUser.json",
            produces = "application/json;charset=utf-8",
            method = RequestMethod.GET
    )
    @ResponseBody
    public JsonData faultRoleUser(PageQuery page, int  faultTypeId){
        PageResult<FaultUser> faultUserPageResult = faultUserService.faultRoleUser(page,faultTypeId);
        return  JsonData.success(faultUserPageResult);
    }


    //故障管理下面的人员
    @RequestMapping(value = "/roleUser.json",
            produces = "application/json;charset=utf-8",
            method = RequestMethod.GET
    )
    @ResponseBody
    public JsonData roleUser(){
        List<FaultUser> faultUsers = faultUserService.roleUser();
        if(faultUsers ==null){
            return  JsonData.success(null);
        }else{
            List<JSONObject> userList = new ArrayList<JSONObject>();
            for(FaultUser list :faultUsers){
                JSONObject objCode = new JSONObject();
                objCode.put("id", list.getUserId());
                objCode.put("username", list.getUsername());
                userList.add(objCode);
            }
            JSONObject dataJson = new JSONObject();
            dataJson.put("userList", userList);
            return  JsonData.success(userList);
        }

    }

    @RequestMapping(value = "/saveFaultType.json",
            produces = "application/json;charset=utf-8",
            method = RequestMethod.POST
    )
    @ResponseBody
    public JsonData saveFaultType(FaultType faultType, HttpSession session){
        String  uri ="/faultUser/saveFaultType.json";
        int   userId  = (int) session.getAttribute("userId");
        List<SysAcl> url = sysAclMapper.getUrl(userId);
        for(SysAcl sysAcl: url){
            if (sysAcl.getUrl().equals(uri)) {
                faultUserService.saveRoleUser(faultType);
                return JsonData.success();
            }
        }
        return JsonData.fail("您没有相关权限");
    }



    @RequestMapping(value = "/update.json",
            produces = "application/json;charset=utf-8",
            method = RequestMethod.POST
    )
    @ResponseBody
    public JsonData update(FaultType faultType, HttpSession session){
        String  uri ="/faultUser/update.json";
        int   userId  = (int) session.getAttribute("userId");
        List<SysAcl> url = sysAclMapper.getUrl(userId);
        for(SysAcl sysAcl: url){
            if (sysAcl.getUrl().equals(uri)) {
                faultUserService.update(faultType);
                return JsonData.success();
            }
        }
        return JsonData.fail("您没有相关权限");
    }


    @RequestMapping(value = "/delete.json",
            produces = "application/json;charset=utf-8",
            method = RequestMethod.POST
    )
    @ResponseBody
    public JsonData delete(@RequestParam(value="id")int id, HttpSession session){
        String  uri ="/faultUser/delete.json";
        int   userId  = (int) session.getAttribute("userId");
        List<SysAcl> url = sysAclMapper.getUrl(userId);
        for(SysAcl sysAcl: url){
            if (sysAcl.getUrl().equals(uri)) {
                faultUserService.delete(id);
                return JsonData.success();
            }
        }
        return JsonData.fail("您没有相关权限");
    }


    //查找系统业务对应的人员
    @RequestMapping(value = "/selectionRequestType.json",
            produces = "application/json;charset=utf-8",
            method = RequestMethod.GET
    )
    @ResponseBody
    public JsonData selectionRequestType(){
        Map paramHash = new HashMap<>();
        FaultUser faultUser =new FaultUser();
        List<FaultUser> faultUsers =null;
        List<Fault> faults = faultService.selectStatus(Const.faultStatus.infault);
        for(int i=1;i<3;i++){
            if(i ==1){
                faultUser.setFaultTypeId(1);
                List<String>  arr = new ArrayList<>();
                faultUsers = faultUserService.selectionRequestType(faultUser);
                for(FaultUser faultUser1 :faultUsers){
                    if(faults.size() >0){
                        for(Fault fault :faults){
                            if(faultUser1.getUsername().equals(fault.getDealingPeople())){
                                arr.add(faultUser1.getUsername() + " "+ "  *");
                            }else{
                                arr.add(faultUser1.getUsername() );
                            }

                        }
                    }else{
                        arr.add(faultUser1.getUsername() );
                    }
                }
                paramHash.put(1,arr);
            }else{
                List<String>  arr = new ArrayList<>();
                faultUser.setFaultTypeId(2);
                faultUsers = faultUserService.selectionRequestType(faultUser);
                for(FaultUser faultUser1 :faultUsers){
                    if(faults.size() >0){
                        for(Fault fault :faults){
                            if(faultUser1.getUsername().equals(fault.getDealingPeople())){
                                arr.add(faultUser1.getUsername() + " "+ "  *");
                            }else{
                                arr.add(faultUser1.getUsername() );
                            }

                        }
                    }else{
                        arr.add(faultUser1.getUsername() );
                    }
                }
                paramHash.put(2,arr);
            }

        }


        return  JsonData.success(paramHash);
    }





}
