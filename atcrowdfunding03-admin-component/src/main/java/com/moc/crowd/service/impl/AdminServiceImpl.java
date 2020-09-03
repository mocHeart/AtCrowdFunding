package com.moc.crowd.service.impl;

import com.moc.crowd.entity.Admin;
import com.moc.crowd.entity.AdminExample;
import com.moc.crowd.mapper.AdminMapper;
import com.moc.crowd.service.api.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    private AdminMapper adminMapper;

    @Override
    public void saveAdmin(Admin admin) {
        adminMapper.insert(admin);
    }

    @Override
    public List<Admin> getAll() {
        return adminMapper.selectByExample(new AdminExample());
    }

}
