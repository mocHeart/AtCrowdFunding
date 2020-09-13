package com.moc.crowd.mvc.handler;

import com.moc.crowd.entity.Admin;
import com.moc.crowd.service.api.AdminService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class TestHandler {

    @Autowired
    private AdminService adminService;

    @RequestMapping("/test/ssm.html")
    public String testSsm(ModelMap modelMap) {
        List<Admin> adminList = adminService.getAll();
        modelMap.addAttribute("adminList", adminList);
        return "target";
    }


    // 接受Ajax数据  第一种方式
    @RequestMapping("send/array/one.html")
    @ResponseBody
    public String testReceiveArrayOne(@RequestParam("array[]") List<Integer> array) {
        for (Integer number : array) {
            System.out.println("number: " + number);
        }
        return "scucess";
    }

    // 接受Ajax数据  第二种方式
    @RequestMapping("send/array/two.html")
    @ResponseBody
    public String testReceiveArrayTwo(ParamData paramData) {
        List<Integer> array = paramData.getArray();
        for (Integer number : array) {
            System.out.println("number: " + number);
        }
        return "scucess";
    }

    // 接受Ajax数据  第三种方式
    @RequestMapping("send/array/three.html")
    @ResponseBody
    public String testReceiveArrayTree(@RequestBody List<Integer> array) {
        Logger logger = LoggerFactory.getLogger(TestHandler.class);
        for (Integer number : array) {
            logger.info("number: " + number);
        }
        return "scucess";
    }

}
