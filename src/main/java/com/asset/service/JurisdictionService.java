package com.asset.service;


import com.asset.beans.PageQuery;
import com.asset.beans.PageResult;
import com.asset.dao.*;

import com.asset.model.*;
import com.asset.util.BeanValidator;
import com.google.common.collect.Lists;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Service
public class JurisdictionService {

    @Resource
    private JurisdictionMapper jurisdictionMapper;

    @Resource
    private SysUserMapper sysUserMapper;

    @Resource
    private SysRoleUserMapper sysRoleUserMapper;

    @Resource
    private SysRoleMapper sysRoleMapper;

    @Resource
    private SysRoleAclMapper sysRoleAclMapper;

    @Resource
    private SysAclMapper sysAclMapper;

    @Resource
    private SysAclModuleMapper sysAclModuleMapper;

    @Resource
    private SysDeptMapper sysDeptMapper;


    public PageResult<Jurisdiction> list(PageQuery pageQuery){
        BeanValidator.check(pageQuery);
        int count = jurisdictionMapper.selectCount();
        if(count > 0){
            List<Jurisdiction> jurisdictions = jurisdictionMapper.securityList(pageQuery);
            return PageResult.<Jurisdiction>builder().data(jurisdictions).total(count).build();
        }
        return PageResult.<Jurisdiction>builder().build();
    }


}
