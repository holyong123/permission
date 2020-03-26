package com.asset.controller;

import com.asset.common.Const;
import com.asset.common.RequestHolder;
import com.asset.model.SysRole;
import com.asset.model.SysUser;
import com.asset.service.SysRoleService;
import com.asset.service.SysUserService;
import com.asset.util.MD5Util;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@Controller
public class UserController {

    @Resource
    private SysUserService sysUserService;
    @Resource
    private SysRoleService sysRoleService;

    @RequestMapping("/logout.page")
    public void logout(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getSession().invalidate();
        String path = "signin.jsp";
        response.sendRedirect(path);
    }

    @RequestMapping("/login.page")
    public void login(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        SysUser sysUser = sysUserService.findByKeyword(username);
        String errorMsg = "";
        String ret = request.getParameter("ret");

        if (StringUtils.isBlank(username)) {
            errorMsg = "用户名不可以为空";
        } else if (StringUtils.isBlank(password)) {
            errorMsg = "密码不可以为空";
        } else if (sysUser == null) {
            errorMsg = "查询不到指定的用户";
        } else if (!sysUser.getPassword().equals(MD5Util.encrypt(password))) {
            errorMsg = "用户名或密码错误";
        } else if (sysUser.getStatus() != 1) {
            errorMsg = "用户已被冻结，请联系管理员";
        } else {
            // login success
            request.getSession().setAttribute("user", sysUser);
            RequestHolder.add(sysUser);
            request.getSession().setAttribute("username", sysUser.getUsername());
            request.getSession().setAttribute("userId", sysUser.getId());

            List<SysRole> sysRoles = sysRoleService.permissionUser(sysUser.getUsername());
            if(sysRoles.size() > 0){
                for(SysRole listRole:sysRoles){
                    if(listRole.getName().equals(Const.roleUser.RightsAdministrator)){
                        request.getSession().setAttribute("permissionName", listRole.getName());
                    }else if (listRole.getName().equals(Const.roleUser.ApprovalAdministrator)){
                        request.getSession().setAttribute("ApprovalAdministrator", listRole.getName());
                    }else if(listRole.getName().equals(Const.roleUser.godownKeeper)){
                        request.getSession().setAttribute("godownKeeper", listRole.getName());
                    }else if(listRole.getName().equals(Const.roleUser.Buyer)){
                        request.getSession().setAttribute("Buyer", listRole.getName());
                    }else if(listRole.getName().equals(Const.roleUser.faultAdministrator)){
                        request.getSession().setAttribute("faultAdministrator", listRole.getName());
                    }else{
                        continue;
                    }

                }
            }else{
                request.getSession().setAttribute("permissionName", null);
            }

            if (StringUtils.isNotBlank(ret)) {
                response.sendRedirect(ret);
            } else {
                response.sendRedirect("/admin/index.page"); //TODO
                return;
            }
        }

        request.setAttribute("error", errorMsg);
        request.setAttribute("username", username);
        if (StringUtils.isNotBlank(ret)) {
            request.setAttribute("ret", ret);
        }
        String path = "signin.jsp";
        request.getRequestDispatcher(path).forward(request, response);


    }
}
