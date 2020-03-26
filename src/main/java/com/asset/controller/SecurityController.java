package com.asset.controller;


import com.asset.beans.PageQuery;
import com.asset.common.JsonData;
import com.asset.service.JurisdictionService;
import com.asset.service.SysUserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;

@Controller
@RequestMapping("/security")
public class SecurityController {

    @Resource
    private SysUserService sysUserService;

    @Resource
    private JurisdictionService jurisdictionService;


    @RequestMapping("security.page")
    public ModelAndView security() {
        return new ModelAndView("security");
    }


    @RequestMapping(value = "/list.json",
            produces = "application/json;charset=utf-8",
            method = RequestMethod.GET
    )
    @ResponseBody
    public JsonData  list(PageQuery pageQuery){
        return  JsonData.success(jurisdictionService.list(pageQuery));
    }






}
