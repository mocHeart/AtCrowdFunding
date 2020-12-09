// 修改树节点前的图标
function myAddDiyDom(treeId, treeNode) {
    // treeId 是整个树形结构附着的ul标签的id
    console.log("treeId: " + treeId);

    // 当前树形节点全部的数据，包括从后端查询到的Menu对象的全部属性
    console.log("treeNode: ");
    console.log(treeNode)

    // zTree生成id的规则
    // eg: treeDemo_8_ico    treeDemo_8_a
    // 解释: ul标签的id_当前节点的序号_功能
    // 提示："ul标签的id_当前节点的序号" 这部分可以通过访问treeNode的tId属性得到
    // 根据id的生成规则拼接出来span的标签的id
    var spanId = treeNode.tId + "_ico";

    // 根据控制图标的span标签找到这个span标签
    // 删除旧的class
    // 添加新的class
    $("#" + spanId)
        .removeClass()
        .addClass(treeNode.icon);
}

// 鼠标移入节点范围添加按钮组
function myAddHoverDom(treeId, treeNode) {
    // 按钮组的标签结构： <span> <a><i></i></a> <a><i></i></a> </span>
    // 按钮组出现的位置：节点中treeDemo_n_a超链接的后面

    // 为了在移除按钮组时能定位到所在的span,需要给span设置有规律的Id
    var btnGroupId = treeNode.tId + "_btnGroup";

    // 判断之前是否已经添加过按钮组  大于0说明已添加
    if ($("#" + btnGroupId).length > 0) {
        return;
    }

    // 准备各个按钮的HTML标签
    var addBtn = "<a id='"+treeNode.id+"' class='addBtn btn btn-info dropdown-toggle btn-xs' style='margin-left:10px;padding-top:0px;' href='#' title='添加子节点'>&nbsp;&nbsp;<i class='fa fa-fw fa-plus rbg '></i></a>";
    var removeBtn = "<a id='"+treeNode.id+"' class='removeBtn btn btn-info dropdown-toggle btn-xs' style='margin-left:10px;padding-top:0px;' href='#' title='删除节点'>&nbsp;&nbsp;<i class='fa fa-fw fa-times rbg '></i></a>";
    var editBtn = "<a id='"+treeNode.id+"' class='editBtn btn btn-info dropdown-toggle btn-xs' style='margin-left:10px;padding-top:0px;' href='#' title='修改节点'>&nbsp;&nbsp;<i class='fa fa-fw fa-edit rbg '></i></a>";

    // 获取当前节点的级别数据
    var level = treeNode.level;

    // 声明变量存储拼装好的按钮代码
    var btnHTML = "";

    // 判断当前节点的级别
    if(level == 0) {
        // 级别为0时是根节点，只能添加子节点
        btnHTML = addBtn;
    }

    if(level == 1) {
        // 级别为1时是分支节点，可以添加子节点、修改
        btnHTML = addBtn + " " + editBtn;

        // 获取当前节点的子节点数量
        var length = treeNode.children.length;

        // 如果没有子节点，可以删除
        if(length == 0) {
            btnHTML = btnHTML + " " + removeBtn;
        }

    }

    if(level == 2) {
        // 级别为2时是叶子节点，可以修改、删除
        btnHTML = editBtn + " " + removeBtn;
    }


    // 按钮组前面的超链接的id
    var anchorId = treeNode.tId + "_a";

    // 添加元素
    $("#" + anchorId).after("<span id='" + btnGroupId + "'>" + btnHTML + "</span>");


}


// 鼠标移出节点范围删除按钮组
function myRemoveHoverDom(treeId, treeNode) {
    // 拼接按钮组的id
    var btnGroupId = treeNode.tId + "_btnGroup";

    // 移除对应元素
    $("#" + btnGroupId).remove();
}
