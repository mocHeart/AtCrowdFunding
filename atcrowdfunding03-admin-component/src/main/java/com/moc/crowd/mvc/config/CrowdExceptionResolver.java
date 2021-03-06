package com.moc.crowd.mvc.config;

import com.google.gson.Gson;
import com.moc.crowd.constant.CrowdConstant;
import com.moc.crowd.exception.CommonException;
import com.moc.crowd.exception.LoginAcctAlreadyInUseException;
import com.moc.crowd.exception.LoginFailedException;
import com.moc.crowd.util.CrowdUtil;
import com.moc.crowd.util.ResultEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

// @ControllerAdvice 表示当前类是一个基于注解的异常处理器类
@ControllerAdvice
public class CrowdExceptionResolver {

    // @ExceptionHandler 将一个具体的异常类型和一个方法关联起来
    @ExceptionHandler(value = NullPointerException.class)
    public ModelAndView resolveNullPointerException(NullPointerException exception,
                                                    HttpServletRequest request,
                                                    HttpServletResponse response) throws IOException {
        String viewName = "system-error";
        return commonResolve(viewName, exception, request, response);
    }

    @ExceptionHandler(value = CommonException.class)
    public ModelAndView resolveCommonException(CommonException exception,
                                                    HttpServletRequest request,
                                                    HttpServletResponse response) throws IOException {
        String viewName = "system-error";
        return commonResolve(viewName, exception, request, response);
    }

    @ExceptionHandler(value = LoginFailedException.class)
    public ModelAndView resolveLoginFailedException(LoginFailedException exception,
                                                    HttpServletRequest request,
                                                    HttpServletResponse response) throws IOException {
        String viewName = "admin-login";
        return commonResolve(viewName, exception, request, response);
    }

    @ExceptionHandler(value = LoginAcctAlreadyInUseException.class)
    public ModelAndView resolveLoginAcctAlreadyInUseException(LoginAcctAlreadyInUseException exception,
                                                    HttpServletRequest request,
                                                    HttpServletResponse response) throws IOException {
        String viewName = "admin-add";
        return commonResolve(viewName, exception, request, response);
    }


    /**
     * 具体的异常类型和一个方法关联起来的公共方法
     * @param exception  实际捕获到的异常类型
     * @param request    当前请求对象
     * @param response    当前响应对象
     * @return  处理结果
     */
    private ModelAndView commonResolve(String viewName, Exception exception,
                                       HttpServletRequest request,
                                       HttpServletResponse response) throws IOException {
        // 1. 判断请求的类型
        boolean judgeResult = CrowdUtil.judgeRequestType(request);
        // 2. 如果是Ajax请求
        if (judgeResult) {
            // 3. 创建ResultEntity对象
            ResultEntity<Object> resultEntity = ResultEntity.failed(exception.getMessage());
            // 4. 创建Gson对象
            Gson gson = new Gson();
            // 5. 将ResultEntity对象转换为JSON字符串
            String json = gson.toJson(resultEntity);
            // 6. 将JSON字符串作为响应体返回给浏览器
            response.getWriter().write(json);
            // 7. 由于已经通过原生response对象返回了响应，所有不在提供ModelAndView对象
            return null;
        }
        // 8. 不是Ajax请求，创建ModelAndView对象
        ModelAndView modelAndView = new ModelAndView();
        // 9. 将Exception对象存入模型
        modelAndView.addObject(CrowdConstant.ATTR_NAME_EXCEPTION, exception);
        // 10. 设置对应的视图名称
        modelAndView.setViewName(viewName);
        // 11. 返回ModelANdView对象
        return modelAndView;
    }



}
