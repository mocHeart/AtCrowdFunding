<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<%@include file="/WEB-INF/include-head.jsp"%>
<link rel="stylesheet" href="css/pagination.css">
<%-- 模板jSP: 主体框架的抽离 --%>
<body>
<%@include file="/WEB-INF/include-nav.jsp"%>
<div class="container-fluid">
  <div class="row">
    <%@include file="/WEB-INF/include-siderbar.jsp"%>
    <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
      <div class="panel panel-default">
        <div class="panel-heading">
          <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
        </div>
        <div class="panel-body">
          <form class="form-inline" role="form" style="float:left;">
            <div class="form-group has-feedback">
              <div class="input-group">
                <div class="input-group-addon">查询条件</div>
                <input id="keywordInput" class="form-control has-success" type="text" placeholder="请输入查询条件">
              </div>
            </div>
            <button id="searchBtn" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
          </form>
          <button type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
          <button id="showAddModalBtn" type="button" class="btn btn-primary" style="float:right;"><i class="glyphicon glyphicon-plus"></i> 新增</button>
          <br>
          <hr style="clear:both;">
          <div class="table-responsive">
            <table class="table  table-bordered">
              <thead>
              <tr>
                <th width="30">#</th>
                <th width="30"><input type="checkbox"></th>
                <th>名称</th>
                <th width="100">操作</th>
              </tr>
              </thead>
              <tbody id="rolePageBody">
                <%-- JS填充表格主体内容 --%>
              </tbody>
              <tfoot>
              <tr>
                <td colspan="6" align="center">
                  <div id="Pagination" class="pagination"><%--分页导航条--%></div>
                </td>
              </tr>

              </tfoot>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<%-- 引入模态框 --%>
<%@include file="/WEB-INF/modal-role-add.jsp"%>
<%@include file="/WEB-INF/modal-role-edit.jsp"%>

<script type="text/javascript">
    $(function () {
        // 1. 为分页准备初始化数据
        window.pageNum = 1;
        window.pageSize = 5;
        window.keyword = "";

        // 2. 调用执行分页函数，显示分页效果
        generatePage();

        // 3. 给查询按钮绑定单击响应函数
        $("#searchBtn").click(function () {
            window.keyword = $("#keywordInput").val();
            window.pageNum = 1;
            generatePage();
        });

        // 4. 新增按钮绑定弹窗
        $("#showAddModalBtn").click(function () {
            // 弹出模态框
            $("#roleAddModal").modal("show");

        });

        // 5. 新增模态框 - 保存按钮单击响应事件
        $("#saveRoleBtn").click(function () {
            var roleName = $.trim($("#roleAddModal [name=roleName]").val());
            $.ajax({
                url: "/role/save.json",
                type: "post",
                data: {
                    "name": roleName,
                },
                dataType: "json",
                success: function (response) {
                    var result = response.result;
                    if (result == "SUCCESS") {
                        layer.msg("操作成功！");
                        // 重新加载分页数据
                        window.pageNum = 9999999;
                        generatePage();
                    }
                    if (result == "FAILED") {
                        layer.msg("操作失败！" + response.statusText);
                    }
                },
                error: function (response) {
                    layer.msg(response.status + " " + response.statusText);
                }
            });
            // 关闭模态框
            $("#roleAddModal").modal("hide");
            // 清空模态框数据
            $("#roleAddModal [name=roleName]").val("");
        });

        // 6. 编辑按钮绑定按钮响应函数  （jQuery动态生成的按钮on函数绑定）
        // 给 【 #rolePageBody pencilBtn 】选择器所选的元素绑定事件
        $("#rolePageBody").on("click", ".pencilBtn", function () {
            $("#roleEditModal").modal("show");
            var roleName = $(this).parent().prev().text();
            // 保存时也能获取该数据
            window.roleId = this.id;
            $("#roleEditModal [name=roleName]").val(roleName);
        });

        console.log("hahahhhaha");

        // 7. 更新模态框 - 保存按钮单击响应事件
        $("#updateRoleBtn").click(function () {
            var roleName = $("#roleEditModal [name=roleName]").val();
            $.ajax({
                url: "/role/update.json",
                type: "post",
                data: {
                    "id": window.roleId,
                    "name": roleName
                },
                dataType: "json",
                success: function (response) {
                    var result = response.result;
                    if (result == "SUCCESS") {
                        layer.msg("操作成功！");
                        generatePage();
                    }
                    if (result == "FAILED") {
                        layer.msg("操作失败！" + response.statusText);
                    }
                },
                error: function (response) {
                    layer.msg(response.status + " " + response.statusText);
                }
            });
            // 关闭模态框
            $("#roleEditModal").modal("hide");
        });


    });
</script>
<script type="text/javascript" charset="utf-8" src="jquery/jquery.pagination.js"></script>
<script type="text/javascript" charset="utf-8" src="/crowd/role-page.js"></script>
</body>

</html>
