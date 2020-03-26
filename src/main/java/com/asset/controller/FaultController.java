package com.asset.controller;


import com.alibaba.fastjson.JSONObject;
import com.asset.beans.PageQuery;
import com.asset.beans.PageResult;
import com.asset.common.Const;
import com.asset.common.JsonData;
import com.asset.dao.SysAclMapper;
import com.asset.model.Fault;
import com.asset.model.SysAcl;
import com.asset.model.SysUser;
import com.asset.service.FaultService;
import com.asset.service.SysRoleService;
import com.asset.service.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("fault")
public class FaultController {

    @Autowired
    private FaultService faultService;
    @Autowired
    private SysRoleService sysRoleService;
    @Autowired
    private SysAclMapper sysAclMapper;

    @Resource
    private SysUserService sysUserService;


    @RequestMapping("display.page")
    public ModelAndView display() {
        return new ModelAndView("display");
    }

    @RequestMapping("handing.page")
    public ModelAndView handling() {
        return new ModelAndView("handing");
    }

    @RequestMapping("faultwrite.page")
    public ModelAndView applicant() {
        return new ModelAndView("faultwrite");
    }


    //故障列表  模糊查询
    @RequestMapping(value = "/faultDisplayParam.json",
            produces = "application/json;charset=utf-8",
            method = RequestMethod.GET
    )
    @ResponseBody
    public JsonData faultDisplayParam(PageQuery page, Fault fault){
        PageResult<Fault> faultPageResult = faultService.faultDisplayParam(page, fault);
        if(faultPageResult !=null){
            return  JsonData.success(faultPageResult);
        }
        return  JsonData.fail("未查询到数据");
    }


    //查询 填写的故障信息
    @RequestMapping(value = "/faultWriteList.json",
            produces = "application/json;charset=utf-8",
            method = RequestMethod.GET
    )
    @ResponseBody
    public JsonData faultWriteList(PageQuery page, HttpSession session){
        int userId = (int) session.getAttribute("userId");
        String username = (String) session.getAttribute("username");

        PageResult<Fault> list = faultService.faultWriteList(page, Const.faultStatus.waitfault);
        return  JsonData.success(list);

    }


    @RequestMapping(value = "/save.json",
            produces = "application/json;charset=utf-8",
            method = RequestMethod.POST
    )
    @ResponseBody
    public JsonData save(Fault fault, HttpSession session){
        String  uri ="/fault/save.json";
        int   userId  = (int) session.getAttribute("userId");
        List<SysAcl> url = sysAclMapper.getUrl(userId);
        for(SysAcl sysAcl: url){
            if (sysAcl.getUrl().equals(uri)) {
                faultService.faultSave(fault);
                return JsonData.success();
            }
        }
        return JsonData.fail("您没有相关权限");
    }

    @RequestMapping(value = "/saved.json",
            produces = "application/json;charset=utf-8",
            method = RequestMethod.POST
    )
    @ResponseBody
    public JsonData saved(Fault fault, HttpSession session){
        String  uri ="/fault/save.json";
        int   userId  = (int) session.getAttribute("userId");
        List<SysAcl> url = sysAclMapper.getUrl(userId);
        for(SysAcl sysAcl: url){
            if (sysAcl.getUrl().equals(uri)) {
                faultService.save(fault);
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
    public JsonData update(Fault fault, HttpSession session){
        String  uri ="/fault/update.json";
        int   userId  = (int) session.getAttribute("userId");
        List<SysAcl> url = sysAclMapper.getUrl(userId);
        for(SysAcl sysAcl: url){
            if (sysAcl.getUrl().equals(uri)) {
                faultService.faultUpdate(fault);
                return JsonData.success();
            }
        }
        return JsonData.fail("您没有相关权限");
    }


    @RequestMapping(value = "/updated.json",
            produces = "application/json;charset=utf-8",
            method = RequestMethod.POST
    )
    @ResponseBody
    public JsonData updated(Fault fault, HttpSession session){
        String  uri ="/fault/update.json";
        int   userId  = (int) session.getAttribute("userId");
        List<SysAcl> url = sysAclMapper.getUrl(userId);
        for(SysAcl sysAcl: url){
            if (sysAcl.getUrl().equals(uri)) {
                faultService.update(fault);
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
    public JsonData delete(@RequestParam(value="id") int id, HttpSession session){
        String  uri ="/fault/delete.json";
        int   userId  = (int) session.getAttribute("userId");
        List<SysAcl> url = sysAclMapper.getUrl(userId);
        for(SysAcl sysAcl: url){
            if (sysAcl.getUrl().equals(uri)) {
                faultService.delete(id);
                return JsonData.success();
            }
        }
        return JsonData.fail("您没有相关权限");
    }


    //查询 查找处理中的故障信息
    @RequestMapping(value = "/handingList.json",
            produces = "application/json;charset=utf-8",
            method = RequestMethod.GET
    )
    @ResponseBody
    public JsonData faultHandingList(PageQuery page){
        PageResult<Fault> list = faultService.faultHanding(page, Const.faultStatus.infault);
        return  JsonData.success(list);

    }


    //查询 查找处理中的故障信息
    @RequestMapping(value = "/faultDisplayList.json",
            produces = "application/json;charset=utf-8",
            method = RequestMethod.GET
    )
    @ResponseBody
    public JsonData faultDisplayList(PageQuery page, HttpSession session){
        int userId = (int) session.getAttribute("userId");
        String username = (String) session.getAttribute("username");
        PageResult<Fault> list = faultService.faultHanding(page, Const.faultStatus.faulted);
        return  JsonData.success(list);

    }


    @RequestMapping(value = "/user.json",
            produces = "application/json;charset=utf-8",
            method = RequestMethod.GET
    )
    @ResponseBody
    public JsonData user(){
        List<SysUser> sysUsers = sysUserService.getAll();
        List<JSONObject> userList = new ArrayList<JSONObject>();
        for (SysUser auditList : sysUsers) {
            JSONObject objCode = new JSONObject();
            objCode.put("id", auditList.getId());
            objCode.put("username", auditList.getUsername());
            userList.add(objCode);
        }
        JSONObject dataJson = new JSONObject();
        dataJson.put("userList", userList);

        return JsonData.success(userList);
    }




    //查询处理人  根据id 和  faultType
    @RequestMapping(value = "/dealing.json",
            produces = "application/json;charset=utf-8",
            method = RequestMethod.GET
    )
    @ResponseBody
    public JsonData dealing(@RequestParam("id") Integer id, @RequestParam("faultType") int faultType){
        String dealing = faultService.dealing(id, faultType);
        return  JsonData.success(dealing);
    }





}
