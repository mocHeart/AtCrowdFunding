package com.moc.crowd.service.api;

import com.moc.crowd.entity.Menu;

import java.util.List;

public interface MenuService {
    List<Menu> getAll();

    void saveMenu(Menu menu);

}
