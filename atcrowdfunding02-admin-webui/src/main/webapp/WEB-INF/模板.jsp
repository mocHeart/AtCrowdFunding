<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<%@include file="/WEB-INF/include-head.jsp"%>
<%-- 模板jSP: 主体框架的抽离 --%>
<body>
<%@include file="/WEB-INF/include-nav.jsp"%>
<div class="container-fluid">
  <div class="row">
    <%@include file="/WEB-INF/include-siderbar.jsp"%>
    <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
      <%-- 主体内容 --%>
    </div>
  </div>
</div>
</body>

</html>
