package com.moc.crowd.mvc.handler;

import com.moc.crowd.entity.Menu;
import com.moc.crowd.service.api.MenuService;
import com.moc.crowd.util.ResultEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class MenuHandler {

    @Autowired
    private MenuService menuService;

    @ResponseBody
    @RequestMapping("/menu/get/whole/tree.json")
    public ResultEntity<Menu> getWholeTree() {

        // 1. 查询全部的Menu对象
        List<Menu> menuList = menuService.getAll();

        // 2. 声明根节点
        Menu root = null;

        // 3. 创建Map对象存储id和menu的对应关系，便于查找父节点
        Map<Integer, Menu> menuMap = new HashMap<>();

        // 4. 遍历menuList，填充menuMap
        for (Menu menu : menuList) {
            Integer id = menu.getId();
            menuMap.put(id, menu);
        }

        // 5. 遍历menuList，查找根节点，关联父子关系
        for (Menu menu : menuList) {
            Integer pid = menu.getPid();
            if (pid == null) {
                root = menu;
                continue;
            }
            menuMap.get(pid).getChildren().add(menu);
        }

        // 6. 返回树的根节点
        return ResultEntity.successWithData(root);
    }

}
