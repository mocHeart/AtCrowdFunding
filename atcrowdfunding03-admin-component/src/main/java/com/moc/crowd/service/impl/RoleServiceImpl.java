package com.moc.crowd.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.moc.crowd.entity.Role;
import com.moc.crowd.mapper.RoleMapper;
import com.moc.crowd.service.api.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleServiceImpl implements RoleService {

    @Autowired
    private RoleMapper roleMapper;

    @Override
    public PageInfo<Role> getPageInfo(Integer pageNum, Integer pageSize, String keyword) {

        // 1. 开启分页功能
        PageHelper.startPage(pageNum, pageSize);

        // 2. 执行查找
        List<Role> roleList = roleMapper.selectRoleByKeyword(keyword);

        // 3. 封装为RageInfo对象返回
        return new PageInfo<>(roleList);
    }
}