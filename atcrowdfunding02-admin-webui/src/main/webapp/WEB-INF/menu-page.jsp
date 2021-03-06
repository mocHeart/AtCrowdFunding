<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<%@include file="/WEB-INF/include-head.jsp"%>
<link rel="stylesheet" href="ztree/zTreeStyle.css">
<%-- 模板jSP: 主体框架的抽离 --%>
<body>
<%@include file="/WEB-INF/include-nav.jsp"%>
<div class="container-fluid">
  <div class="row">
    <%@include file="/WEB-INF/include-siderbar.jsp"%>
    <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

      <div class="panel panel-default">
        <div class="panel-heading">
          <i class="glyphicon glyphicon-th-list"></i> 权限菜单列表
          <div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal">
            <i class="glyphicon glyphicon-question-sign"></i>
          </div>
        </div>
        <div class="panel-body">
          <%-- 这个ul标签是zTree动态生成的节点所依附的静态节点  --%>
          <ul id="treeDemo" class="ztree"></ul>
        </div>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript" src="ztree/jquery.ztree.all-3.5.min.js"></script>
<script type="text/javascript" src="crowd/menu-page.js"></script>
<script type="text/javascript">
    $(function () {
        // 1. 创建JSON对象用于存储对zTree对象的设置
        var setting = {
            view: {
                addDiyDom: myAddDiyDom,           // 自定义树节点前的icon
                addHoverDom: myAddHoverDom,       // 鼠标移入节点范围添加按钮组
                removeHoverDom: myRemoveHoverDom  // 鼠标移出节点范围删除按钮组
            },
            data: {
                key: {
                    url: "#"     // 点击树节点不跳转
                }
            }
        };

        // 2. 准备生成树形结构的JSON数据 (Ajax请求)
        $.ajax({
            url: "/menu/get/whole/tree.json",
            type: "post",
            dataType: "json",
            success: function (response) {
                var result = response.result;
                if (result == "SUCCESS") {
                    var zNodes = response.data;
                    // 3. 初始化树形结构
                    $.fn.zTree.init($("#treeDemo"), setting, zNodes);
                    //console.log(zNodes);
                }
                if (result == "FAILED") {
                    layer.msg(response.message);
                }
            }
        });

    });
</script>
</body>

</html>
