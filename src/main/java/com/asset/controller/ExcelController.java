package com.asset.controller;

import com.asset.common.JsonData;
import com.asset.dao.GoodsMapper;
import com.asset.model.Goods;
import com.asset.param.GoodsParam;
import com.asset.service.GoodsService;
import com.asset.util.ExportExcelUtil;
import com.asset.util.ExportExcelWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/excel")
public class ExcelController {


    @Autowired
    private GoodsService goodsService;
    @Autowired
    private GoodsMapper goodsMapper;


    @RequestMapping(value = "/export.json",
            produces = "application/json;charset=utf-8",
            method = RequestMethod.POST
    )
    @ResponseBody
    public JsonData  exportExcel(HttpSession session, HttpServletResponse response) throws Exception {
        List<GoodsParam> listParam = new ArrayList<>();
        try {
            List<Goods> list = goodsMapper.selectExcelData();
            for (Goods goods:list){
                GoodsParam param =new GoodsParam();
                param.setName(goods.getName());
                param.setAssetId(goods.getAssetId());
                param.setApplicant(goods.getApplicant());
                param.setOperateTime(goods.getOperateTime());
                param.setStatus(goods.getStatus());
                param.setUsePlace(goods.getUsePlace());
                param.setRemark(goods.getRemark());
                listParam.add(param);
            }

            // 准备数据
            String[] columnNames = {"名称","编号", " 申请人", "最后一次更新时间", "状态","使用地点","备注"};
            String fileName = "仓库物品列表";
            String title = "资产配置清单";
            ExportExcelWrapper<GoodsParam> util = new ExportExcelWrapper<>();
            util.exportExcel(fileName, title, columnNames, listParam, response, ExportExcelUtil.EXCEL_FILE_2003);
            return JsonData.success();

        } catch (Exception e) {

        }
        return JsonData.fail("失败");
    }



}
