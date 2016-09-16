$(function() {
    var params = "id,type,categoryId,descrition,content,costIntegral,amount,goodsName,url,thumbnailUrl,count,startTime,endTime,sort,lastChangedTime";
    $("#dg").datagrid({
        url: '../service/getLogs?params=' + params + '&TABLENAME=exchangedGoods&compareName1=goodsName',
        fit: true,
        columns: [[
            {
                field: 'id',
                hidden: true
            },
            {
                title: '商品名称',
                field: 'goodsName',
                width: 100,
                sortable: true
            },
            {
                title: '商品缩略图',
                field: 'thumbnailUrl',
                width: 100,
                formatter:function(value,row,index){return '<a title="点击查看原图" href="..'+ row.url +'" target="_blank"><img height="60px" src="..'+row.thumbnailUrl+'" /></a>';},
                sortable: true
            },
            {
                title: '兑换类型',
                field: 'type',
                width: 80,
                formatter:function(value,row,index){return value == 1?"积分" :value == 2 ? "现金" :value == 3 ?"积分+现金" : "其他"},
                sortable: true
            },
            {
                title: '商品类型',
                field: 'categoryId',
                width: 80,
                formatter : function(value,row,index){
                    var jsonData = $.ajax({
                       type : "post",
                       url : "../service/getLogClear",
                       dataType : "JSON",
                       data : {
                           params : "name",
                           TABLENAME : "category",
                           PRIMARYKEY : "id",
                           contentId : value
                       },
                       async : false
                    }).responseText;
                    var json = eval('(' + jsonData + ')');
                    return json.name;
                },
                sortable: true
            },
            {
                title: '兑换所需积分',
                field: 'costIntegral',
                width: 80,
                sortable: true
            },
            {
                title: '兑换所需金额',
                field: 'amount',
                width: 100,
                sortable: true
            },
            {
                title: '库存数量',
                field: 'count',
                width: 80,
                sortable: true
            },
            {
                title: '开始时间',
                field: 'startTime',
                width: 120,
                formatter : function(value,row,index){return value.substring(0,value.length-2)},
                sortable: true
            },
            {
                title: '结束时间',
                field: 'endTime',
                width: 120,
                formatter : function(value,row,index){return value.substring(0,value.length-2)},
                sortable: true
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
        emptyMsg: '没有查询到商品信息！'
    });
});

function searchData(isvalid){
    $('#dg').datagrid('load',{
        param2 : $('#searchtitle').textbox("getValue")
    });
}
/**
 * 添加信息
 */

function newImage(){
    $("#operationType").val("add");
    $("#showImages").hide();
    $('#dlg').dialog('open').dialog('setTitle','新增商品');
    $('#fm').form('clear');
    $("#categoryId").combotree({
        url:'../service/getCategoryTreeByName?module=goods',
        required : true
    });
    $("#type").combobox("setValue",1);
    $("input[name=url]").attr("accept","image/*");

    url = '../service/fileUpload';
}

/**
 * 更新信息
 */

function editImage(){
    var row = $('#dg').datagrid('getSelected');
    $("#operationType").val("update");
    if (row){
            $('#dlg').dialog('open').dialog('setTitle','修改商品');
            $("#categoryId").combotree({
               url:'../service/getCategoryTreeByName?module=goods',
               required : true
            });
            $("#showImages").html('<label>缩略图:</label>&nbsp;&nbsp;<a title="点击查看原图" href="..'+ row.url +'" target="_blank"><img width="160px" src="..'+row.thumbnailUrl+'" /></a>');
            $("#showImages").show();
            //$('#fm').form('load',row);
            $("#categoryId").combotree("setValue",row['categoryId']);
            $("#goodsName").textbox("setValue",row['goodsName']);
            $("#content").val(row['content']);
            $("#type").combobox("setValue",row['type']);
            $("#costIntegral").numberbox("setValue",row['costIntegral']);
            $("#amount").numberbox("setValue",row['amount']);
            $("#count").numberbox("setValue",row['count']);
            $("#startTime").datetimebox("setValue",row['startTime']);
            $("#endTime").datetimebox("setValue",row['endTime']);
            $("#sort").numberbox("setValue",row['sort']);
            $("#goodsImage").filebox({required:false});
            $("input[name=url]").attr("accept","image/*");
            url = '../service/fileUpload';
    }else{
        $.messager.alert('提示','请选择一行操作数据');
    }
}

/**
 * 保存信息
 */

function saveImage(){
    var costIntegral = $("#costIntegral").numberbox("getValue");
    var amount = $("#amount").numberbox("getValue");
    if(costIntegral == ""){
        $("#costIntegral").numberbox("setValue",0);
    }
    if(amount == ""){
        $("#amount").numberbox("setValue",0);
    }
    if(url.indexOf("?") > -1) {
        url = url.substring(0,url.indexOf("?"));
    }
    url = url + "?TABLENAME=exchangedGoods&PRIMARYKEY=id";
    var operationType = $("#operationType").val();
    if(operationType == "update"){
        var row = $('#dg').datagrid('getSelected');
        if(row){
            var imgHideId = row['id'];
            if(imgHideId){
                url = url + '&contentId=' + imgHideId;
                var fileVal = $("#goodsImage").filebox("getValue");
                if(!fileVal){
                    url = url + "&url=" + row['url'] + "&thumbnailUrl=" + row['thumbnailUrl'];
                }
            }
        }
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
            $.messager.confirm('提示', '确定要删除此商品信息?', function (r) {
                if (r) {
                    $.messager.progress({
                        title: '请稍后',
                        msg: '正在删除商品信息...'
                    });
                    $.ajax({
                        url: "../service/delete",
                        data: {
                            TABLENAME: "exchangedGoods",
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
    }else{
        $.messager.alert('提示','请选择一行操作数据');
    }
}