package com.moc.crowd.service.impl;

import com.moc.crowd.constant.CrowdConstant;
import com.moc.crowd.entity.Admin;
import com.moc.crowd.entity.AdminExample;
import com.moc.crowd.exception.LoginFailedException;
import com.moc.crowd.mapper.AdminMapper;
import com.moc.crowd.service.api.AdminService;
import com.moc.crowd.util.CrowdUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;

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

    @Override
    public Admin getAdminByLoginAcct(String loginAcct, String userPswd) {

        // 1. 根据登录账号查询Admin对象
        AdminExample adminExample = new AdminExample();
        AdminExample.Criteria criteria = adminExample.createCriteria();
        criteria.andLoginAcctEqualTo(loginAcct);
        List<Admin> list = adminMapper.selectByExample(adminExample);

        // 2. 判断Admin对象是否为null
        if (list == null || list.size() == 0) {
            throw new LoginFailedException(CrowdConstant.MESSAGE_LOGIN_FAILED);
        }
        if (list.size() > 1) {
            throw new RuntimeException(CrowdConstant.MESSAGE_SYSTEM_ERROR_LOGIN_NOT_UNIQUE);
        }

        Admin admin = list.get(0);

        // 3. 如果Admin对象为null,则抛出异常
        if (admin == null) {
            throw new LoginFailedException(CrowdConstant.MESSAGE_LOGIN_FAILED);
        }

        // 4. 如果Admin对象不为null,则将从数据库取出Admin对象
        String userPswdDB = admin.getUserPswd();

        // 5. 将表单提交的明文密码进行加密
        String userPswdForm = CrowdUtil.md5(userPswd);

        // 6. 对比密码
        if (!Objects.equals(userPswdDB, userPswdForm)) {
            // 7. 如果结果不一致则抛出异常
            throw new LoginFailedException(CrowdConstant.MESSAGE_LOGIN_FAILED);
        }

        // 8. 如果一致则返回Admin对象
        return admin;

    }
}
