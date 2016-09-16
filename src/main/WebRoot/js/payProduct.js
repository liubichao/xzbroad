$(function() {
    var params = "id,title,content,payProgramId,amount,unit,discountType,rate,disamount,ispredefine,sort,lastChangedTime";
    $("#dg").datagrid({
        url: '../service/getLogs?params=' + params + '&TABLENAME=payProduct&compareName=ispredefine&compareName1=title',
        fit: true,
        columns: [[
            {
                field: 'id',
                hidden: true
            },
            {
                title: '节目名称',
                field: 'title',
                width: 160,
                sortable: true
            },
            {
                title: '节目内容',
                field: 'content',
                width: 200,
                nowrap: false,
                sortable: true
            },
            {
                title: '节目编号',
                field: 'payProgramId',
                width: 80,
                sortable: true
            },
            {
                title: '金额',
                field: 'amount',
                width: 50,
                sortable: true
            },
            {
                title: '单位',
                field: 'unit',
                width: 80,
                sortable: true
            },
            {
                title: '折扣类型',
                field: 'discountType',
                width: 80,
                sortable: true,
                formatter:function(value,row,index){return row.discountType == '0' ? '无折扣' : row.discountType == '1' ? '按比例' : row.discountType == '2' ? '减金额' : '其他';}
            },
            {
                title: '折扣比例（%）',
                field: 'rate',
                width: 100,
                sortable: true
            },
            {
                title: '折扣金额',
                field: 'disamount',
                width: 80,
                sortable: true
            },
            {
                title: '是否预定义',
                field: 'ispredefine',
                width: 80,
                sortable: true,
                formatter:function(value,row,index){return row.ispredefine == '1' ? '预定义' : '自定义';}
            },
            {
                title: '排序',
                field: 'sort',
                width: 50,
                sortable: true
            },
            {
                title: '更新时间',
                field: 'lastChangedTime',
                width: 120,
                formatter : function(value,row,index){return value.substring(0,value.length-2)},
                sortable: true
            }
        ]],
        pagination: true,
        rownumbers: true,
        fitColumns: true,
        pageSize: 20,
        pageList: [20, 30, 40],
        toolbar: '#toolbar',
        scrollbarSize: 0,
        singleSelect: true,
        emptyMsg: '没有查询到付费节目信息！'
    });
});

function searchData(isvalid){
    $('#dg').datagrid('load',{
        param2 : $('#searchtitle').textbox("getValue"),
        param1 : isvalid
    });
}
/**
 * 添加信息
 */

function newImage(){
    $('#dlg').dialog('open').dialog('setTitle','新增节目');
    $('#fm').form('clear');
    $("#sort").numberbox("setValue",0);
    $("#discountType").combobox("setValue",0);
    $("#ispredefine").combobox("setValue",0);
    $("#rate").numberbox("setValue",100);
    $("#disamount").numberbox("setValue",0);

    url = '../service/save?TABLENAME=payProduct&PRIMARYKEY=id';
}

/**
 * 更新信息
 */

function editImage(){
    var row = $('#dg').datagrid('getSelected');

    if (row){
        if(row.ispredefine == '1'){
            $.messager.alert('提示','本条数据为预定义数据，无法修改');
        }else{
            $('#dlg').dialog('open').dialog('setTitle','修改节目');
            $('#fm').form('load',row);
            url = '../service/update?TABLENAME=payProduct&PRIMARYKEY=id&contentId='+row['id'];
        }
    }else{
        $.messager.alert('提示','请选择一行操作数据');
    }
}

/**
 * 保存信息
 */

function saveImage(){
    var rate = $("#rate").numberbox("getValue");
    var disamount = $("#disamount").numberbox("getValue");
    var sort = $("#sort").numberbox("getValue");
    if(rate == ""){
        $("#rate").numberbox("setValue",0);
    }
    if(disamount == ""){
        $("#disamount").numberbox("setValue",0);
    }
    if(sort == ""){
        $("#sort").numberbox("setValue",0);
    }
    $('#fm').form('submit',{
        url: url,
        onSubmit: function(){
            var isValid = $(this).form('validate');
            if(isValid){
                $.messager.progress({
                    title:'请稍后',
                    msg:'数据保存中...'
                });
            }
            return isValid;
        },
        success: function(result){
            $.messager.progress('close');
            if (result > 0){
                $('#dlg').dialog('close');
                $('#dg').datagrid('reload');
            }else{
                $.messager.alert('提示',result,'error');
            }
        }
    });
}


function delImage(){
    var row = $('#dg').datagrid('getSelected');
    if (row){
        if(row.ispredefine == '1'){
            $.messager.alert('提示','本条数据为预定义数据，不能删除');
        }else {
            $.messager.confirm('提示', '确定要删除此节目信息?', function (r) {
                if (r) {
                    $.messager.progress({
                        title: '请稍后',
                        msg: '正在删除节目信息...'
                    });
                    $.ajax({
                        url: "../service/delete",
                        data: {
                            TABLENAME: "payProduct",
                            PRIMARYKEY: "id",
                            contentId: row['id']
                        },
                        dataType: "text",
                        success: function (data) {
                            $.messager.progress('close');
                            if (data > 0) {
                                $('#dg').datagrid('reload');
                            } else {
                                $.messager.alert('提示', '删除信息失败', 'error');
                            }
                        },
                        error: function (request, msg) {
                            $.messager.progress('close');
                            $.messager.alert('提示', '删除信息失败:' + msg, 'error');
                        }
                    });
                }
            });
        }
    }else{
        $.messager.alert('提示','请选择一行操作数据');
    }
}