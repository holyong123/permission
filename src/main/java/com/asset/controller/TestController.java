package com.asset.controller;

import com.asset.beans.PageQuery;
import com.asset.common.ApplicationContextHelper;
import com.asset.common.JsonData;
import com.asset.dao.GoodsMapper;
import com.asset.dao.SysAclModuleMapper;
import com.asset.exception.ParamException;
import com.asset.exception.PermissionException;
import com.asset.model.Goods;
import com.asset.model.SysAclModule;
import com.asset.param.TestVo;
import com.asset.service.ApprovalService;
import com.asset.service.GoodsService;
import com.asset.util.BeanValidator;
import com.asset.util.ExportExcelUtil;
import com.asset.util.ExportExcelWrapper;
import com.asset.util.JsonMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

@Controller
@RequestMapping("/test")
@Slf4j
public class TestController {

    @Autowired
    private GoodsService goodsService;

    @Autowired
    private GoodsMapper goodsMapper;
    @Autowired
    private ApprovalService approvalService;

    @RequestMapping("/hello.json")
    @ResponseBody
    public JsonData hello() {
        log.info("hello");
        throw new PermissionException("test exception");
//         return JsonData.success("hello, permission");
    }



    @RequestMapping("/list.json")
    @ResponseBody
    public JsonData list(PageQuery pageQuery){
        System.out.println(JsonData.success(goodsService.selectListAll(pageQuery)));
        throw new PermissionException("test exception");
    }

    @RequestMapping("/validate.json")
    @ResponseBody
    public JsonData validate(TestVo vo) throws ParamException {
        log.info("validate");
        SysAclModuleMapper moduleMapper = ApplicationContextHelper.popBean(SysAclModuleMapper.class);
        SysAclModule module = moduleMapper.selectByPrimaryKey(1);
        log.info(JsonMapper.obj2String(module));
        BeanValidator.check(vo);
        return JsonData.success("test validate");
    }


    @RequestMapping("/delete.json")
    @ResponseBody
    public JsonData delete() throws ParamException {
        log.info("delete");
        approvalService.delete();
        return JsonData.success("test success");
    }



    @RequestMapping(value = "/export.json",
            produces = "application/json;charset=utf-8",
            method = RequestMethod.POST
    )
    @ResponseBody
    public JsonData  exportExcel(HttpSession session, HttpServletResponse response, HttpServletRequest request) throws Exception {

        try {
//            List<Goods> list = goodsMapper.selectList();
            List<Goods> list = goodsMapper.selectExcelData();

            // 准备数据
            String[] columnNames = {"ID", "名称","编号", " 申请人", "接收人", "状态"};
            String fileName = "仓库物品列表";
            String title = "资产配置清单";
            ExportExcelWrapper<Goods> util = new ExportExcelWrapper<Goods>();
            String path  =  "E:/test"+ new Date().getTime() +".xls";
//            util.exportExcel(title, columnNames, list, new FileOutputStream(path), ExportExcelUtil.EXCEL_FILE_2003);
            util.exportExcel(fileName, title, columnNames, list, response, ExportExcelUtil.EXCEL_FILE_2003);

            return  JsonData.success();
        } catch (Exception e) {

        }
        return  JsonData.fail("shibai");
    }


    public static void main(String[] args) {

        List list =new ArrayList();

        List listLinked =new LinkedList();






    }


}
