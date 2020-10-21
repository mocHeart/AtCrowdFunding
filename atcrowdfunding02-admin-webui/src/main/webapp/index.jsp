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

  <%-- Jquery --%>
  <script type="text/javascript" src="jquery/jquery-2.1.1.min.js"></script>
  <script type="text/javascript" src="layer/layer.js"></script>

</head>
<body>
  <!--  参照base标签替代该行 <a href="${pageContext.request.contextPath}/test/ssm.html">测试SSM整合环境</a>  -->
  <a href="test/ssm.html">测试SSM整合环境</a>

  <br>
  <br>
  <button id="btn1">Send [5, 8, 12] One</button>

  <br>
  <br>
  <button id="btn2">Send [5, 8, 12] two</button>

  <br>
  <br>
  <button id="btn3">Send [5, 8, 12] three</button>

  <br>
  <br>
  <button id="btn4">点我弹框</button>


  <script type="text/javascript">
      // Ajax 发数组第一种方式
      //  @RequestParam("array[]")   带个[]不是很合理
      $(function () {
          $("#btn1").click(function () {
              $.ajax({
                  url: "send/array/one.html",         // 请求目标资源的地址
                  type: "post",                       // 请求方式
                  data: {"array": [5, 8, 12]},        // 要发送的请求参数
                  dataType: "text",                   // 如何对待服务器端返回的数据
                  success: function (response) {      // 服务器端成功处理请求后调用的回调函数
                                                      // response 响应体
                  },
                  error: function (response) {        // 服务器端处理请求失败后的调用回调函数
                  }
              })
          });
      });

      // Ajax 发数组第二种方式
      // 单个数据拼装，接受时需要使用对象（对应数组属性）
      $(function () {
          $("#btn2").click(function () {
              $.ajax({
                  url: "send/array/two.html",
                  type: "post",
                  data: {"array[0]": 5,
                         "array[1]": 8,
                         "array[2]": 12},
                  dataType: "text",
                  success: function (response) {
                  },
                  error: function (response) {
                  }
              })
          });
      });

      // Ajax 发数组第三种方式
      // 转化为JSON字符串发送
      $(function () {
          $("#btn3").click(function () {
              // 准备好要发送的数据
              var array = [5, 8, 12];
              // 将数据转化为JSON字符串
              var requestBody = JSON.stringify(array);  // "['5','8','12']"
              $.ajax({
                  url: "send/array/three.html",
                  type: "post",
                  data: requestBody,
                  contentType: "application/json;charset=UTF-8",
                  dataType: "text",
                  success: function (response) {
                  },
                  error: function (response) {
                  }
              })
          });
      });

      // layer演示
      $(function () {
          $("#btn4").click(function () {
              layer.msg("Layer的弹框！");
          });
      });



  </script>
</body>
</html>
