package com.asset.controller;


import com.alibaba.fastjson.JSONObject;
import com.asset.beans.PageQuery;
import com.asset.beans.PageResult;
import com.asset.common.JsonData;
import com.asset.dao.SysAclMapper;
import com.asset.model.*;
import com.asset.service.ApprovalService;
import com.asset.service.GoodsService;
import com.asset.service.SysRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/goods")
public class GoodsController {

    @Autowired
    private GoodsService goodsService;

    @Autowired
    private ApprovalService approvalService;

    @Autowired
    private SysAclMapper sysAclMapper;

    @Autowired
    private SysRoleService sysRoleService;


    @RequestMapping("config.page")
    public ModelAndView config() {
        return new ModelAndView("config");
    }

    @RequestMapping("newConfig.page")
    public ModelAndView newConfig() {
        return new ModelAndView("newConfig");
    }

    @RequestMapping("collarUse.page")
    public ModelAndView collarUse() {
        return new ModelAndView("collarUse");
    }



    @RequestMapping(value = "/list.json",
            produces = "application/json;charset=utf-8",
            method = RequestMethod.GET
    )
    @ResponseBody
    public JsonData list(PageQuery pageQuery,HttpSession session){
        int userId = (int) session.getAttribute("userId");

        return  JsonData.success(goodsService.selectListAll(pageQuery));
    }


    @RequestMapping(value = "/page.json",
            produces = "application/json;charset=utf-8",
            method = RequestMethod.GET
    )
    @ResponseBody
    public JsonData page(HttpSession session){
        if(goodsService.selectList(session) ==null ){
            return  JsonData.fail("您没有相关权限");
        }
        return  JsonData.success(goodsService.selectList(session));
    }

    @RequestMapping(value = "/update.json",
            produces = "application/json;charset=utf-8",
            method =RequestMethod.POST
    )
    @ResponseBody
    public JsonData update(Goods goods, HttpSession session){
        String  uri ="/goods/update.json";
        int   userId  = (int) session.getAttribute("userId");
        List<SysAcl> url = sysAclMapper.getUrl(userId);
        for(SysAcl sysAcl: url){
            if (sysAcl.getUrl().equals(uri)) {
                int update = goodsService.update(goods);
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
    public JsonData save(Goods goods, HttpSession session){
        String  uri ="/goods/save.json";
        int   userId  = (int) session.getAttribute("userId");
        List<SysAcl> url = sysAclMapper.getUrl(userId);
        for(SysAcl sysAcl: url){
            if (sysAcl.getUrl().equals(uri)) {
                int save = goodsService.save(goods);
                if(save > 0){
                    return JsonData.success();
                }else{
                    return JsonData.fail("请先去提出申请，然后再来添加");
                }
            }
        }
        return JsonData.fail("您没有相关权限");
    }


    @RequestMapping("/delete.json")
    @ResponseBody
    public JsonData delete(@RequestParam("id") int id, HttpSession session){
        int   userId  = (int) session.getAttribute("userId");
        String  uri ="/goods/delete.json";
        List<SysAcl> url = sysAclMapper.getUrl(userId);
        for(SysAcl sysAcl: url){
            if (sysAcl.getUrl().equals(uri)) {
                goodsService.delete(id);
                return JsonData.success();
            }
        }
        return JsonData.fail("您没有相关权限");
    }



    public JsonData url(HttpSession session, int  data, String uri){
        int  userId =(int)session.getAttribute("userId");
        List<SysAcl> url = sysAclMapper.getUrl(userId);
        for(SysAcl sysAcl: url){
            if (sysAcl.getUrl().equals(uri)) {
                if(data > 0){
                    return JsonData.success();
                }else{
                    return JsonData.fail("操作失败");
                }
            }
        }

        return JsonData.fail("您没有相关权限");

    }



    @RequestMapping(value = "/user.json",
            produces = "application/json;charset=utf-8",
            method = RequestMethod.GET
    )
    @ResponseBody
    public  JsonData user(){
        List<SysUser> sysUsers = goodsService.allUserList();
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



    //根据多条件查询列表
    @RequestMapping(value = "/listLikeByCondition.json",
            produces = "application/json;charset=utf-8",
            method = RequestMethod.GET
    )
    @ResponseBody
    public JsonData selectLikeByCondition(PageQuery page, Goods goods){
        PageResult<Goods> goodsPageResult = goodsService.selectLikeByCondition(page, goods);
        return JsonData.success(goodsPageResult);
    }







}
