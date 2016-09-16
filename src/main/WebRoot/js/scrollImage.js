$(function() {
    var params = "id,title,url,thumbnailUrl,sort,isvalid,lastChangedTime";
    $("#dg").datagrid({
        url: '../service/getLogs?params=' + params + '&TABLENAME=scrollPicture&compareName=isvalid&compareName1=title',
        fit: true,
        columns: [[
            {
                field: 'id',
                hidden: true
            },
            {
                title: '名称',
                field: 'title',
                width: 100,
                sortable: true
            },
            {
                title: '排序',
                field: 'sort',
                width: 100,
                sortable: true
            },
            {
                title: '缩略图',
                field: 'thumbnailUrl',
                width: 120,
                formatter:function(value,row,index){return '<a title="点击查看原图" href="..'+ row.url +'" target="_blank"><img height="60px" src="..'+row.thumbnailUrl+'" /></a>';},
                sortable: true
            },
            {
                title: '上传时间',
                field: 'lastChangedTime',
                width: 100,
                formatter : function(value,row,index){return value.substring(0,value.length-2)},
                sortable: true
            }
        ]],
        pagination: true,
        rownumbers: true,
        fitColumns: true,
        pageSize: 10,
        pageList: [10, 20, 30],
        toolbar: '#toolbar',
        scrollbarSize: 0,
        singleSelect: true,
        emptyMsg: '没有查询到图片信息！'
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
    $("#operationType").val("add");
    $("#showImages").hide();
    $('#dlg').dialog('open').dialog('setTitle','新增图片');
    $('#fm').form('clear');
    $("input[name=url]").attr("accept","image/*");
    url = '../service/fileUpload';
}

/**
 * 更新信息
 */

function editImage(){
    $("#operationType").val("update");
    var row = $('#dg').datagrid('getSelected');
    if (row){
        $('#dlg').dialog('open').dialog('setTitle','修改图片');
        $("#showImages").html('<label>缩略图:</label>&nbsp;&nbsp;<a title="点击查看原图" href="..'+ row.url +'" target="_blank"><img width="160px" src="..'+row.thumbnailUrl+'" /></a>');
        $("#showImages").show();
        //$('#fm').form('load',row);
        $("#title").textbox("setValue",row.title);
        $("#sort").numberbox("setValue",row.sort);
        $("#imageUrl").filebox({required:false});
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
    if(url.indexOf("?") > -1) {
        url = url.substring(0,url.indexOf("?"));
    }
    url = url + "?TABLENAME=scrollPicture&PRIMARYKEY=id";
    //url = url + "?title=" + encodeURI($("#title").textbox('getValue')) + "&sort=" + $("#sort").numberbox("getValue") + "&TABLENAME=scrollPicture&PRIMARYKEY=id";
    var operationType = $("#operationType").val();
    if(operationType == "update"){
        var row = $('#dg').datagrid('getSelected');
        if(row){
            var imgHideId = row['id'];
            if(imgHideId){
                url = url + '&contentId=' + imgHideId;
                var fileVal = $("#imageUrl").filebox("getValue");
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
        $.messager.confirm('提示','确定要删除此图片信息?',function(r){
            if (r){
                $.messager.progress({
                    title:'请稍后',
                    msg:'正在删除图片信息...'
                });
                $.ajax({
                    url:"../service/delete",
                    data : {
                        TABLENAME : "scrollPicture",
                        PRIMARYKEY : "id",
                        contentId : row['id']
                    },
                    dataType:"text",
                    success:function(data){
                        $.messager.progress('close');
                        if (data > 0){
                            $('#dg').datagrid('reload');
                        }else {
                            $.messager.alert('提示','删除信息失败','error');
                        }
                    },
                    error:function(request,msg){
                        $.messager.progress('close');
                        $.messager.alert('提示','删除信息失败:'+msg,'error');
                    }
                });
            }
        });
    }else{
        $.messager.alert('提示','请选择一行操作数据');
    }
}