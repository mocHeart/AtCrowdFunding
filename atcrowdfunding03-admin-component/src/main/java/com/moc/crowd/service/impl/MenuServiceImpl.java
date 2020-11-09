package com.moc.crowd.service.impl;

import com.moc.crowd.mapper.MenuMapper;
import com.moc.crowd.service.api.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MenuServiceImpl implements MenuService {

    @Autowired
    private MenuMapper menuMapper;

}
