<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
  <title>Title</title>
</head>
<body>

  <h1>出错啦！</h1>

  <!-- 从请求域取出Exception对象，在获取message属性便可得到错误消息 -->
  ${requestScope.exception.message}

</body>
</html>
