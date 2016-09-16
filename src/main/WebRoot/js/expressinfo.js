$(function() {
	var params = "id,wechatId,name,mobilephone,telphone,address,zipcode,isdefault,remark,lastChangedTime";
	$("#dg").datagrid({
		url: '../service/getLogs?params=' + params + '&TABLENAME=expressinfo&compareName1=name',
		fit: true,
		columns: [[
			{
				field: 'id',
				hidden: true
			},
			{
				title: '微信openId',
				field: 'wechatId',
				width: 160,
				sortable: true
			},
			{
				title: '收货人姓名',
				field: 'name',
				width: 70,
				sortable: true
			},
			{
				title: '手机号码',
				field: 'mobilephone',
				width: 100,
				sortable: true
			},
			{
				title: '固定电话',
				field: 'telphone',
				width: 100,
				sortable: true
			},
			{
				title: '邮编',
				field: 'zipcode',
				width: 100,
				sortable: true
			},
			{
				title: '地址',
				field: 'address',
				width: 100,
				nowrap: false,
				sortable: true
			},
			{
				title: '默认地址',
				field: 'isdefault',
				width: 70,
				formatter : function(value,row,index){return value == 1 ? "是" : "否"},
				sortable: true
			},
			{
				title: '备注',
				field: 'remark',
				width: 100,
				nowrap: false,
				sortable: true
			},
			{
				title: '上报时间',
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
		emptyMsg: '没有查询到物流信息！'
	});
});

function searchData(isvalid){
	$('#dg').datagrid('load',{
		param2 : $('#searchtitle').textbox("getValue")
	});
}
/**
 * 更新信息
 */

function editImage(){
	var row = $('#dg').datagrid('getSelected');

	if (row){
			$('#dlg').dialog('open').dialog('setTitle','修改物流信息');
			$('#fm').form('load',row);
		    /*$('#wechatId').textbox('textbox').attr('readonly',true);
		    $('#name').textbox('textbox').attr('readonly',true);
		    $('#telphone').textbox('textbox').attr('readonly',true);
		    $('#address').textbox('textbox').attr('readonly',true);
		    $('#email').textbox('textbox').attr('readonly',true);
		    $('#lastChangedTime').textbox('textbox').attr('readonly',true);*/
		    //$('#type').combobox({disabled: true});
			url = '../service/update?TABLENAME=expressinfo&PRIMARYKEY=id&contentId='+row['id'];
	}else{
		$.messager.alert('提示','请选择一行操作数据');
	}
}

/**
 * 保存信息
 */

function saveImage(){
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
			$.messager.confirm('提示', '确定要删除此物流信息?', function (r) {
				if (r) {
					$.messager.progress({
						title: '请稍后',
						msg: '正在删除物流信息...'
					});
					$.ajax({
						url: "../service/delete",
						data: {
							TABLENAME: "expressinfo",
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