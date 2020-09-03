<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Insert title here</title>
  <!--                服务器地址                           服务器端口                         项目路径     最后的/不要忘记   -->
  <base href="http://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/"/>
  <%-- base标签注意点：
         1. :不能省略
         2. contextPath前面没有/
         3. contextPath后面必须有/
         4. 放在参照base标签的标签之前，title里
         5. 所有参照base标签的标签的路径都不能以/开头
   --%>
</head>
<body>
  <!--  参照base标签替代该行 <a href="${pageContext.request.contextPath}/test/ssm.html">测试SSM整合环境</a>  -->
  <a href="test/ssm.html">测试SSM整合环境</a>
</body>
</html>
