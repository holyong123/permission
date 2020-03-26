package com.asset.service;


import com.asset.beans.PageQuery;
import com.asset.beans.PageResult;
import com.asset.common.Const;
import com.asset.dao.*;
import com.asset.model.Approval;
import com.asset.model.Goods;
import com.asset.model.SysAcl;
import com.asset.model.SysUser;
import com.asset.param.GoodsParam;
import com.asset.util.BeanValidator;
import com.asset.util.RandomUUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Random;

@Service
public class GoodsService {

    @Autowired
    private GoodsMapper goodsMapper;

    @Autowired
    private SysRoleMapper sysRoleMapper;
    @Autowired
    private SysAclMapper sysAclMapper;
    @Autowired
    private ApprovalMapper approvalMapper;
    @Resource
    private SysUserMapper sysUserMapper;




    public PageResult<Goods> selectListAll(PageQuery page){
        BeanValidator.check(page);
        int count = goodsMapper.selectCount();
        if(count >0){
            List<Goods> goods = goodsMapper.selectListAll(page);
            return PageResult.<Goods>builder().data(goods).total(count).build();
        }
        return PageResult.<Goods>builder().build();

    }


    public  int update(Goods goods){
        BeanValidator.check(goods);
        if(goods.getOperateTime().equals("")){
            goods.setOperateTime("无归还时间");
        }
        return  goodsMapper.updateByPrimaryKey(goods);

    }


    public  int save(Goods goods){
        BeanValidator.check(goods);
        List<Approval> list = approvalMapper.getStatus(goods.getName());
        if(list.size() > 0){
            for(Approval approval : list){
                int i = approval.getId();
                String name = approval.getName();
                List<Goods> goodsList = goodsMapper.selectByIdName(name,i);
                if( approval.getStatus().equals(0)){
                    int sum = 0;
                    if(goodsList.size() >0 ){
                        for (Goods goodsValue:goodsList){
                            if(goodsValue.getApproxId() != null &&  goodsValue.getName() != null){
                                continue;
                            }else{
                                goods.setApproxId(approval.getId());
                                goods.setCount(1);
                                for(int j =0; j<=goods.getCount();j++){
                                    goods.setAssetId(RandomUUID.getUUID(10));
                                    sum = goodsMapper.insertSelective(goods);
                                    sum++;
                                }
                                return  sum;
                            }
                        }
                    }else{
                        goods.setApproxId(approval.getId());
                        goods.setCount(1);
                        for(int j =0; j<=goods.getCount();j++){
                            goods.setAssetId(RandomUUID.getUUID(10));
                            sum = goodsMapper.insertSelective(goods);
                            sum++;
                        }
                        return  sum;
                    }
                }
                else if (approval.getStatus().equals(Const.approvalStatus.warehousing)){
                    int sum = 0;
                    if (goodsList.size() > 0) {
                        for (Goods goodsValue : goodsList) {
                            if (goodsValue.getApproxId() != null && goodsValue.getName() != null) {
                                continue;
                            } else {
                                goods.setApproxId(approval.getId());
                                goods.setCount(1);
                                for (int j = 0; j <= goods.getCount(); j++) {
                                    goods.setAssetId(RandomUUID.getUUID(10));
                                    sum = goodsMapper.insertSelective(goods);
                                    sum++;
                                }
                                return sum;
                            }
                        }
                    } else {
                        goods.setApproxId(approval.getId());
                        goods.setCount(1);
                        for (int j = 0; j <= goods.getCount(); j++) {
                            goods.setAssetId(RandomUUID.getUUID(10));
                            sum = goodsMapper.insertSelective(goods);
                            sum++;
                        }
                        return sum;
                    }

                }
            }
        }

        return 0;
    }



    public  int delete(int  id){
        BeanValidator.check(id);
        return   goodsMapper.deleteByPrimaryKey(id);
    }


    public  List<Goods> selectList(HttpSession session){
        int   userId   =(int)session.getAttribute("userId");
        List<SysAcl> url = sysAclMapper.getUrl(userId);
        for (SysAcl urls : url){
            if(urls.getUrl().equals("/goods/page.json")){
                return  goodsMapper.selectList();
            }
        }
        return  null;
    }


    public List<SysUser> allUserList(){
        List<SysUser> all = sysUserMapper.getAll();
        return all;

    }



    public PageResult<Goods> selectLikeByCondition(PageQuery page, Goods goods){
        BeanValidator.check(page);
        int count = goodsMapper.selectCount();
        if(count >0){
            List<Goods> good = goodsMapper.selectLikeByCondition(page,goods.getName(),goods.getApplicant(),goods.getStatus(),goods.getOperateTime());
            return PageResult.<Goods>builder().data(good).total(count).build();
        }
        return PageResult.<Goods>builder().build();



    }




    public  List<Goods> selectExcelData(){
        return  goodsMapper.selectExcelData();
    }


}
