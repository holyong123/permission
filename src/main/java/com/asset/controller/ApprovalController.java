package com.asset.controller;


import com.asset.beans.PageQuery;
import com.asset.beans.PageResult;
import com.asset.common.Const;
import com.asset.common.JsonData;
import com.asset.dao.SysAclMapper;
import com.asset.model.*;
import com.asset.service.ApprovalService;
import com.asset.service.GoodsService;
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
import java.util.List;

@Controller
@RequestMapping("/approval")
public class ApprovalController {

    @Autowired
    private ApprovalService approvalService;
    @Autowired
    private SysRoleService sysRoleService;
    @Autowired
    private SysAclMapper sysAclMapper;
    @Resource
    private SysUserService sysUserService;
    @Resource
    private GoodsService goodsService;


    @RequestMapping("approval.page")
    public ModelAndView config() {
        return new ModelAndView("approval");
    }


    @RequestMapping("applicant.page")
    public ModelAndView applicant() {
        return new ModelAndView("applicant");
    }


    @RequestMapping("warehousing.page")
    public ModelAndView warehousing() {
        return new ModelAndView("warehousing");
    }


    @RequestMapping(value = "/list.json",
            produces = "application/json;charset=utf-8",
            method = RequestMethod.GET
    )
    @ResponseBody
    public JsonData list(PageQuery page,HttpSession session){
        int userId = (int) session.getAttribute("userId");
        String username = (String) session.getAttribute("username");
        List<SysRole> sysRoles = sysRoleService.permissionUser(username);
        if(sysRoles.size() >0){
            for(SysRole listRole:sysRoles){
                if(listRole.getName().equals(Const.roleUser.RightsAdministrator)){
                    PageResult<Approval> list = approvalService.list(page,Const.approvalStatus.approvale);
                    return  JsonData.success(list);
                }
            }
        }
        PageResult<Approval> list = approvalService.list(page);
        return  JsonData.success(list);
    }


    @RequestMapping(value = "/update.json",
            produces = "application/json;charset=utf-8",
            method = RequestMethod.POST
    )
    @ResponseBody
    public JsonData update(Approval approval, HttpSession session){
        String  uri ="/approval/update.json";
        int   userId  = (int) session.getAttribute("userId");
        List<SysAcl> url = sysAclMapper.getUrl(userId);
        for(SysAcl sysAcl: url){
            if (sysAcl.getUrl().equals(uri)) {
                approvalService.update(approval);
                return JsonData.success();
            }
        }
        return JsonData.fail("您没有相关权限");
    }



    @RequestMapping(value = "/save.json",
            produces = "application/json;charset=utf-8",
            method = RequestMethod.POST
    )
    @ResponseBody
    public JsonData save(Approval approval, HttpSession session){
        String  uri ="/approval/save.json";
        int   userId  = (int) session.getAttribute("userId");
        List<SysAcl> url = sysAclMapper.getUrl(userId);
        for(SysAcl sysAcl: url){
            if (sysAcl.getUrl().equals(uri)) {
                approvalService.save(approval);
                return JsonData.success();
            }
        }
        return JsonData.fail("您没有相关权限");
    }


    @RequestMapping("/delete.json")
    @ResponseBody
    public JsonData delete(@RequestParam("id") int id, HttpSession session){
        String uri = "/approval/delete.json";
        int   userId  = (int) session.getAttribute("userId");
        List<SysAcl> url = sysAclMapper.getUrl(userId);
        for(SysAcl sysAcl: url){
            if (sysAcl.getUrl().equals(uri)) {
                approvalService.delete(id);
                return JsonData.success();
            }
        }
        return JsonData.fail("您没有相关权限");


    }


    //根据角色查询列表
    @RequestMapping(value = "/listByCondition.json",
            produces = "application/json;charset=utf-8",
            method = RequestMethod.GET
    )
    @ResponseBody
    public JsonData listByCondition(PageQuery page,HttpSession session){
        int userId = (int) session.getAttribute("userId");
        approvalService.delete();
        List<SysRole> sysRoles = sysRoleService.selectRole(userId);
        //已入库的物品新增进物品表
        List<Approval> approvals = approvalService.selectByStatus(page,Const.approvalStatus.warehousing);
        for (Approval apps :approvals){
            Goods goods =new Goods();
            goods.setName(apps.getName());
            goods.setCount(apps.getCount());
            goods.setWareHouse("");
            goodsService.save(goods);
        }
        if(sysRoles !=null){
            for (SysRole role : sysRoles){
                if(role.getName().equals(Const.roleUser.godownKeeper)){
                    return JsonData.success(approvalService.selectWarehousing(page,Const.approvalStatus.alreadyurchased));
                }else if (role.getName().equals(Const.roleUser.ApprovalAdministrator)){
                    return  JsonData.success(approvalService.list(page));
                }else if (role.getName().equals(Const.roleUser.RightsAdministrator)){
                    return  JsonData.success(approvalService.list(page));
                }else if(role.getName().equals(Const.roleUser.Buyer)){
                    return  JsonData.success(approvalService.listBystatus(page,Const.approvalStatus.buy));
                }else if(role.getName().equals(Const.roleUser.User)){
                    return  JsonData.success(approvalService.list(page));
                }else{
                    return  JsonData.success(approvalService.list(page));
                }

            }
        }
        PageResult<Approval> list = approvalService.list(page);
        return  JsonData.success(list);
    }


    //根据多条件查询列表
    @RequestMapping(value = "/listLikeByCondition.json",
            produces = "application/json;charset=utf-8",
            method = RequestMethod.GET
    )
    @ResponseBody
    public  JsonData listLikeByCondition(PageQuery page,Approval approval){
        PageResult<Approval> approvalPageResult = approvalService.selectLikeByCondition(page,approval);
        return JsonData.success(approvalPageResult);

    }





}
