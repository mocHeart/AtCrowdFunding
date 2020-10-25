package com.moc.crowd.mvc.handler;

import com.moc.crowd.constant.CrowdConstant;
import com.moc.crowd.entity.Admin;
import com.moc.crowd.service.api.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller
public class AdminHandler {

    @Autowired
    private AdminService adminService;

    @RequestMapping("/admin/do/login.html")
    public String doLogin(@RequestParam("loginAcct") String loginAcct,
                          @RequestParam("userPswd") String userPswd,
                          HttpSession session) {
        // 调用Service方法执行登录检查
        // 该方法如果能返回admin则登录成功，账号密码不正确会抛出异常
        Admin admin = adminService.getAdminByLoginAcct(loginAcct, userPswd);

        // 将登录返回的admin对象存入session域中
        session.setAttribute(CrowdConstant.ATTR_NAME_LOGIN_ADMIN, admin);

        // 请求后台主页面：避免刷新浏览器导致表单重复提交，重定向到目标页面
        return "redirect:/admin/to/main/page.html";
    }

    @RequestMapping("/admin/do/logout.html")
    public String doLogout(HttpSession session) {

        // session强制失效
        session.invalidate();

        return "redirect:/admin/to/login/page.html";
    }

}
