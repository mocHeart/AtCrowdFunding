package com.moc.crowd.service.api;

import com.github.pagehelper.PageInfo;
import com.moc.crowd.entity.Role;

public interface RoleService {

    public PageInfo<Role> getPageInfo(Integer pageNum, Integer pageSize, String keyword);

}
