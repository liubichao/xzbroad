$(function() {
	var params = "id,smartCardId,wechatId,state,username,mobilephone,remark,lastChangedTime";
	$("#dg").datagrid({
		url: '../service/getLogs?params=' + params + '&TABLENAME=userBindWechat&compareName1=smartCardId&compareName=state',
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
				title: '智能卡号',
				field: 'smartCardId',
				width: 100,
				sortable: true
			},
			{
				title: '用户名',
				field: 'username',
				width: 100,
				sortable: true
			},
			{
				title: '手机号',
				field: 'mobilephone',
				width: 100,
				sortable: true
			},
			{
				title: '状态',
				field: 'state',
				width: 70,
				formatter : function(value,row,index){return value == 1 ? "已绑定" : "<b style='text-decoration: underline;text-decoration-color: red;'>未绑定</b>"},
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
		view: detailview,
		detailFormatter:function(index,row){
			return '<div class="ddv" style="padding:5px 0"></div>';
		},
		onExpandRow: function(index,row){
			var ddv = $(this).datagrid('getRowDetail',index).find('div.ddv');
			var bindHtml='该微信号绑定的智能卡号有：';
			var rUrl = "../service/getLogs";
			var rData = {
				params : "smartCardId",
				TABLENAME : "userBindWechat",
				compareName : 'state',
				compareName1 : 'wechatId',
				param1 : 1,
				param2 :row.wechatId
			};
			var jsonData = getAjaxText(rUrl,rData,'json');
			var json = eval('(' + jsonData + ')');
			if(json != null){
				json = json.rows;
			}
			if(json != null && json.length > 0){
				bindHtml += "<b style='color:red;'>" + json.length + "</b>个，分别是：";
				for(var k = 0; k < json.length ;k++){
					bindHtml += '<b style="text-decoration:underline;text-decoration-color: #00ee00;">' + json[k].smartCardId + '</b>';
					if(k < json.length - 1){
						bindHtml += "、";
					}
				}
			}
			ddv.panel({
				height:30,
				border:true,
				cache:false,
				content:bindHtml
			});
			$('#dg').datagrid('fixDetailRowHeight',index);
		},
		pageSize: 20,
		pageList: [20, 30, 40],
		toolbar: '#toolbar',
		scrollbarSize: 0,
		singleSelect: true,
		emptyMsg: '没有查询到绑定信息！'
	});
});

function searchData(isvalid){
	$('#dg').datagrid('load',{
		param2 : $('#searchtitle').textbox("getValue"),
		param1 : isvalid
	});
}
/**
 * 更新信息
 */

function editImage(){
	var row = $('#dg').datagrid('getSelected');

	if (row){
			$('#dlg').dialog('open').dialog('setTitle','修改绑定信息');
			$('#fm').form('load',row);
		    /*$('#wechatId').textbox('textbox').attr('readonly',true);
		    $('#name').textbox('textbox').attr('readonly',true);
		    $('#telphone').textbox('textbox').attr('readonly',true);
		    $('#address').textbox('textbox').attr('readonly',true);
		    $('#email').textbox('textbox').attr('readonly',true);
		    $('#lastChangedTime').textbox('textbox').attr('readonly',true);*/
		    //$('#type').combobox({disabled: true});
			url = '../service/update?TABLENAME=userBindWechat&PRIMARYKEY=id&contentId='+row['id'];
	}else{
		$.messager.alert('提示','请选择一行操作数据');
	}
}

/**
 * 保存信息
 */

function saveImage(){
	var row = $('#dg').datagrid('getSelected');
	if (row){
		var state = row.state;
		var s = $("#state").combobox("getValue");
		if(s != state){
			if(s == "1"){
				var rUrl = "../service/getCount";
				var rData = { state : 1, smartCardId : row.smartCardId };
				var flag = getAjaxText(rUrl,rData,'text');
				if(flag > 0){
					$.messager.alert('提示','该智能卡已经绑定','error');
				}else{
					rUrl = "../service/getCount";
					rData = { wechatId : row.wechatId, state : 1 };
					var count = getAjaxText(rUrl,rData,'text');
					if(count < 4){
						modify();
					}else{
						$.messager.alert('提示','该微信号绑定的智能卡已经达到四个','error');
					}
				}
			}else{
				modify();
			}
		}else{
			$('#dlg').dialog('close');
			$('#dg').datagrid('reload');
		}
	}
}

function modify(){
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
			$.messager.confirm('提示', '确定要删除此绑定信息?', function (r) {
				if (r) {
					$.messager.progress({
						title: '请稍后',
						msg: '正在删除绑定信息...'
					});
					$.ajax({
						url: "../service/delete",
						data: {
							TABLENAME: "userBindWechat",
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