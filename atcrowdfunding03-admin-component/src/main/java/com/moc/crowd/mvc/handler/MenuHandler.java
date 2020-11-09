package com.moc.crowd.mvc.handler;

import com.moc.crowd.service.api.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller
public class MenuHandler {

    @Autowired
    private MenuService menuService;

}
