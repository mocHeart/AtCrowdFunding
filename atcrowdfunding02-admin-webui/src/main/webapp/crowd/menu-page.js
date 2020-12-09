// �޸����ڵ�ǰ��ͼ��
function myAddDiyDom(treeId, treeNode) {
    // treeId ���������νṹ���ŵ�ul��ǩ��id
    console.log("treeId: " + treeId);

    // ��ǰ���νڵ�ȫ�������ݣ������Ӻ�˲�ѯ����Menu�����ȫ������
    console.log("treeNode: ");
    console.log(treeNode)

    // zTree����id�Ĺ���
    // eg: treeDemo_8_ico    treeDemo_8_a
    // ����: ul��ǩ��id_��ǰ�ڵ�����_����
    // ��ʾ��"ul��ǩ��id_��ǰ�ڵ�����" �ⲿ�ֿ���ͨ������treeNode��tId���Եõ�
    // ����id�����ɹ���ƴ�ӳ���span�ı�ǩ��id
    var spanId = treeNode.tId + "_ico";

    // ���ݿ���ͼ���span��ǩ�ҵ����span��ǩ
    // ɾ���ɵ�class
    // ����µ�class
    $("#" + spanId)
        .removeClass()
        .addClass(treeNode.icon);
}

// �������ڵ㷶Χ��Ӱ�ť��
function myAddHoverDom(treeId, treeNode) {
    // ��ť��ı�ǩ�ṹ�� <span> <a><i></i></a> <a><i></i></a> </span>
    // ��ť����ֵ�λ�ã��ڵ���treeDemo_n_a�����ӵĺ���

    // Ϊ�����Ƴ���ť��ʱ�ܶ�λ�����ڵ�span,��Ҫ��span�����й��ɵ�Id
    var btnGroupId = treeNode.tId + "_btnGroup";

    // �ж�֮ǰ�Ƿ��Ѿ���ӹ���ť��  ����0˵�������
    if ($("#" + btnGroupId).length > 0) {
        return;
    }

    // ׼��������ť��HTML��ǩ
    var addBtn = "<a id='"+treeNode.id+"' class='addBtn btn btn-info dropdown-toggle btn-xs' style='margin-left:10px;padding-top:0px;' href='#' title='����ӽڵ�'>&nbsp;&nbsp;<i class='fa fa-fw fa-plus rbg '></i></a>";
    var removeBtn = "<a id='"+treeNode.id+"' class='removeBtn btn btn-info dropdown-toggle btn-xs' style='margin-left:10px;padding-top:0px;' href='#' title='ɾ���ڵ�'>&nbsp;&nbsp;<i class='fa fa-fw fa-times rbg '></i></a>";
    var editBtn = "<a id='"+treeNode.id+"' class='editBtn btn btn-info dropdown-toggle btn-xs' style='margin-left:10px;padding-top:0px;' href='#' title='�޸Ľڵ�'>&nbsp;&nbsp;<i class='fa fa-fw fa-edit rbg '></i></a>";

    // ��ȡ��ǰ�ڵ�ļ�������
    var level = treeNode.level;

    // ���������洢ƴװ�õİ�ť����
    var btnHTML = "";

    // �жϵ�ǰ�ڵ�ļ���
    if(level == 0) {
        // ����Ϊ0ʱ�Ǹ��ڵ㣬ֻ������ӽڵ�
        btnHTML = addBtn;
    }

    if(level == 1) {
        // ����Ϊ1ʱ�Ƿ�֧�ڵ㣬��������ӽڵ㡢�޸�
        btnHTML = addBtn + " " + editBtn;

        // ��ȡ��ǰ�ڵ���ӽڵ�����
        var length = treeNode.children.length;

        // ���û���ӽڵ㣬����ɾ��
        if(length == 0) {
            btnHTML = btnHTML + " " + removeBtn;
        }

    }

    if(level == 2) {
        // ����Ϊ2ʱ��Ҷ�ӽڵ㣬�����޸ġ�ɾ��
        btnHTML = editBtn + " " + removeBtn;
    }


    // ��ť��ǰ��ĳ����ӵ�id
    var anchorId = treeNode.tId + "_a";

    // ���Ԫ��
    $("#" + anchorId).after("<span id='" + btnGroupId + "'>" + btnHTML + "</span>");


}


// ����Ƴ��ڵ㷶Χɾ����ť��
function myRemoveHoverDom(treeId, treeNode) {
    // ƴ�Ӱ�ť���id
    var btnGroupId = treeNode.tId + "_btnGroup";

    // �Ƴ���ӦԪ��
    $("#" + btnGroupId).remove();
}
