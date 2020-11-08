package com.moc.crowd.mvc.handler;

import com.github.pagehelper.PageInfo;
import com.moc.crowd.entity.Role;
import com.moc.crowd.service.api.RoleService;
import com.moc.crowd.util.ResultEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class RoleHandler {

    @Autowired
    private RoleService roleService;

    @RequestMapping("/role/get/page/info.json")
    @ResponseBody
    public ResultEntity<PageInfo<Role>> getPageInfo(
            @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum,
            @RequestParam(value = "pageSize", defaultValue = "5") Integer pageSize,
            @RequestParam(value = "keyword", defaultValue = "") String keyword) {

        // 获取分页数据
        PageInfo<Role> pageInfo = roleService.getPageInfo(pageNum, pageSize, keyword);

        // 封装返回数据
        return ResultEntity.successWithData(pageInfo);
    }

    @RequestMapping("/role/save.json")
    @ResponseBody
    public ResultEntity<String> saveRole(Role role) {
        roleService.saveRole(role);
        return ResultEntity.successWithOutData();
    }

    @RequestMapping("/role/update.json")
    @ResponseBody
    public ResultEntity<String> updateRole(Role role) {
        roleService.updateRole(role);
        return ResultEntity.successWithOutData();
    }



}
