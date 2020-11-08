// ִ�з�ҳ������ҳ��Ч�����κ�ʱ����ö������¼���ҳ��
function generatePage() {

    // 1. ��ȡ��ҳ����
    var pageInfo = getPageInfoRomote();

    // 2. �����
    fillTableBody(pageInfo);
}

// Զ�̷��ʷ�������ȡpageInfo����
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

    // �����Ӧ״̬�벻��200��������������ʾ�����õ�ǰ����ֹͣ
    if (statusCode != 200) {
        layer.msg("ʧ�ܣ�״̬�룺" + statusCode + "��˵����Ϣ��" + ajaxResult.statusText);
        return null;
    }

    // 200 ����ɹ�����ȡpageInfo
    var resultEntity = ajaxResult.responseJSON;
    var result = resultEntity.result;

    if (result == "FAILED") {
        layer.msg(resultEntity.message);
        return null;
    }

    var pageInfo = resultEntity.data;
    return pageInfo;

}

// �����
function fillTableBody(pageInfo) {

    // ���֮ǰɾ���ɵ�����
    $("#rolePageBody").empty();
    $("#Pagination").empty();

    if (pageInfo == null || pageInfo == undefined || pageInfo.list == null || pageInfo.list.length == 0) {
        $("#rolePageBody").append("<tr><td colspan='4'>��Ǹ��û�в�ѯ�������������ݣ�</td> </tr>");
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

// ���ɷ�ҳ������
function generateNavigator(pageInfo) {
    // ��ȡ�ܼ�¼��
    var totalRecord = pageInfo.total
    ;
    // ������ص�����
    var properties = {
        num_edge_entries: 3,                               // ��Եҳ��
        num_display_entries: 5,                            // ����ҳ��
        callback: paginationCallBack,                      // ����ҳ��ʱ�Ļص�����
        items_per_page: pageInfo.pageSize,                 // ÿҳ��ʾ������
        current_page: pageInfo.pageNum - 1,                // ��ǰҳ�루0��ʼ������
        prev_text: "��һҳ",                                // ��һҳ��ť���ı�
        next_text: "��һҳ"                                 // ��һҳ��ť���ı�
    };

    // ����ҳ�뵼����
    $("#Pagination").pagination(totalRecord, properties);
}

// ��ҳ�ص�����
function paginationCallBack(pageIndex, jQuery) {
    // �޸�ҳ��
    window.pageNum = pageIndex + 1;
    // ���µ��÷�ҳ����
    generatePage();
    // ȡ��������Ĭ����Ϊ
    return false;
}

