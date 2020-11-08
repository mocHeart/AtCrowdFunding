// 执行分页，生成页面效果，任何时候调用都会重新加载页面
function generatePage() {

    // 1. 获取分页数据
    var pageInfo = getPageInfoRomote();

    // 2. 填充表格
    fillTableBody(pageInfo);
}

// 远程访问服务器获取pageInfo数据
function getPageInfoRomote() {
    var ajaxResult = $.ajax({
        url: "/role/get/page/info.json",
        type: "post",
        data: {
            "pageNum": window.pageNum,
            "pageSize": window.pageSize,
            "keyword": window.keyword
        },
        async: false,
        dataType: "json",
    });
    console.log(ajaxResult);

    var statusCode = ajaxResult.status;

    // 如果响应状态码不是200，即发生错误显示错误，让当前函数停止
    if (statusCode != 200) {
        layer.msg("失败！状态码：" + statusCode + "，说明信息：" + ajaxResult.statusText);
        return null;
    }

    // 200 请求成功，获取pageInfo
    var resultEntity = ajaxResult.responseJSON;
    var result = resultEntity.result;

    if (result == "FAILED") {
        layer.msg(resultEntity.message);
        return null;
    }

    var pageInfo = resultEntity.data;
    return pageInfo;

}

// 填充表格
function fillTableBody(pageInfo) {

    // 添加之前删除旧的数据
    $("#rolePageBody").empty();
    $("#Pagination").empty();

    if (pageInfo == null || pageInfo == undefined || pageInfo.list == null || pageInfo.list.length == 0) {
        $("#rolePageBody").append("<tr><td colspan='4'>抱歉！没有查询到你搜索的数据！</td> </tr>");
        return;
    }

    for (var i = 0; i < pageInfo.list.length; i++) {
        var role = pageInfo.list[i];
        var roleId = role.id;
        var roleName = role.name;

        var numberTd = "<td>" + (i + 1) + "</td>";
        var checkboxTd = "<td><input type='checkbox'></td>";
        var roleNameTd = "<td>" + roleName + "</td>";

        var checkBtn = "<button type='button' class='btn btn-success btn-xs'><i class=' glyphicon glyphicon-check'></i></button>";
        var pencilBtn = "<button type='button' id='"+roleId+"' class='btn btn-primary btn-xs pencilBtn'><i class=' glyphicon glyphicon-pencil'></i></button>";
        var removeBtn = "<button type='button' class='btn btn-danger btn-xs'><i class=' glyphicon glyphicon-remove'></i></button>";

        var buttonTd = "<td>" + checkBtn + " " + pencilBtn + " " + removeBtn + "</td>";

        var tr = "<tr>" + numberTd + checkboxTd + roleNameTd + buttonTd + "</tr>";

        $("#rolePageBody").append(tr);
    }

    generateNavigator(pageInfo);

}

// 生成分页导航条
function generateNavigator(pageInfo) {
    // 获取总记录数
    var totalRecord = pageInfo.total
    ;
    // 声明相关的属性
    var properties = {
        num_edge_entries: 3,                               // 边缘页数
        num_display_entries: 5,                            // 主体页数
        callback: paginationCallBack,                      // “翻页”时的回调函数
        items_per_page: pageInfo.pageSize,                 // 每页显示的条数
        current_page: pageInfo.pageNum - 1,                // 当前页码（0开始计数）
        prev_text: "上一页",                                // 上一页按钮的文本
        next_text: "下一页"                                 // 下一页按钮的文本
    };

    // 生成页码导航条
    $("#Pagination").pagination(totalRecord, properties);
}

// 翻页回调函数
function paginationCallBack(pageIndex, jQuery) {
    // 修改页码
    window.pageNum = pageIndex + 1;
    // 重新调用分页函数
    generatePage();
    // 取消超链接默认行为
    return false;
}

