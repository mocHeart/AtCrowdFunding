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
          <button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='form.html'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
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

<script type="text/javascript">
    $(function () {
        // 1. 为分页准备初始化数据
        window.pageNum = 1;
        window.pageSize = 5;
        window.keyword = "";

        // 2. 调用执行分页函数，显示分页效果
        generatePage();
    });
</script>
<script type="text/javascript" charset="utf-8" src="jquery/jquery.pagination.js"></script>
<script type="text/javascript" charset="utf-8" src="/crowd/my-role.js"></script>
</body>

</html>
