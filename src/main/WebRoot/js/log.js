$(function(){
	var params = "id,username,useraction,lastChangedTime,userip";
	$("#dg").datagrid({
		url:'../service/getLogs?params='+ params +'&TABLENAME=loginfo&compareName=lastChangedTime',
		fit:true,
		columns:[[
			{
				field : 'ID',
				hidden : true
			},
			{
				title:'操作人',
				field:'USERNAME',
				width:100,
				sortable: true
			},
			{
				title:'操作内容',
				field:'USERACTION',
				width:100,
				formatter : function(value,row,index){return value == 'login' ? '登录系统' : value == 'update' ? '修改数据' : value == 'delete' ? '删除数据' : value == 'save' ? '添加数据' : value},
				sortable: true
			},
			{
				title:'操作日期',
				field:'LASTCHANGEDTIME',
				width:100,
				formatter : function(value,row,index){return value.substring(0,value.length-2)},
				sortable: true
			},
			{
				title:'IP',
				field:'USERIP',
				width:100,
				sortable: true
			}
		]],
		pagination:true,
		rownumbers:true,
		fitColumns:true,
		pageSize:20,
		pageList:[20,30,40],
		toolbar:'#btns',
		scrollbarSize :0 ,
		singleSelect: true,
		emptyMsg:'没有查询到日志信息！'
	});	
	
	
	
	//清除日志方式
	$("#clearLogType").combobox({
		valueField:'value',
		textField:'text',
		data:[
			{
				value:'0',
				text:'手动清除'
			},
			{
				value:'1',
				text:'自动清除'
			}
		],
		onLoadSuccess:function(data){
				$.ajax({
					url:'../service/getLogClear',
					data : {
						params : "id,type,remainDay",
						TABLENAME : "logClear",
						contentId : '1',
						PRIMARYKEY : "id"
					},
					type:'post',
					dataType:'json',
					success:function(data){
						if(data.type=='0'){
							$("#clearLogType").combobox('setValue',0);
							$("#manual").show();
							$("#auto").hide();
						}else{
							$("#clearLogType").combobox('setValue',1);
							$("#auto").show();
							$("#manual").hide();
						}
						$("#logRemainDay").combobox('setValue',data.remainDay);
					}
				});
		},
		onChange:function(newValue, oldValue){
			$.ajax({
					url:'../service/getLogClear',
				    data : {
						params : "id,type,remainDay",
						TABLENAME : "logClear",
						contentId : '1',
						PRIMARYKEY : "id"
					},
					type:'post',
					dataType:'json',
					success:function(data){
						$("#logRemainDay").combobox('setValue',data.remainDay);
					}
			});
			if(newValue=='0'){
							$("#manual").show();
							$("#auto").hide();
			}else{
							$("#auto").show();
							$("#manual").hide();
			}
		}
		
	});
	
	
});

function del(){
	//var rows = $('#dg').datagrid('getSelections');	//获取所有选中行的数据，得到数组 取值为rows[0]等
	var rows = $('#dg').datagrid('getSelected');//获取选中行，单值
	if(rows){
		$.messager.confirm('提示','确定要删除此信息?',function(r){
			if (r){
				$.messager.progress({
					title:'请稍后',
					msg:'正在删除日志信息...'
				});
				$.ajax({
					url:"../service/delete",
					data : {
						TABLENAME : "loginfo",
						PRIMARYKEY : "ID",
						contentId : rows['ID']
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

//保存日志清除时间的配置
function saveLogDay(){
	var day=$("#logRemainDay").combobox('getValue');
	var type=$("#clearLogType").combobox('getValue');
	$.ajax({
					url:'../service/update',
					data:{remainDay:day,type:type,TABLENAME:"logClear",PRIMARYKEY:"id",contentId:"1"},
					type:'post',
					success:function(data){
						if(data > 0){
							$("#dg").datagrid('load',{});
							$("#start").datetimebox('setValue',"");
							$("#end").datetimebox('setValue',"");
							$.messager.alert("提示","保存成功",'info');
						}else{
							$.messager.alert("提示","保存失败，请重试！",'info');
						}
						
					},
					error:function(data){
						$.messager.alert("提示","请求失败，请重试！",'info');
					}
	});
}
 



//2.查询
function searchLog(){
	var start=$("#start").datetimebox('getValue');
	var end=$("#end").datetimebox('getValue');
	if(start!=''&&end!=''&&start>=end){
		$.messager.alert("提示","起始时间应小于结束时间!",'info');
		return ;
	}
	
	$("#dg").datagrid('load',{
		 start:start,
		 end:end
	});
}


//3.重置
function clearIt(){
	$("#start").datetimebox('setValue',"");
	$("#end").datetimebox('setValue',"");
}

//4.清除
function clearLog(){
	var theEndTime=$("#theEndTime").datetimebox('getValue');
	if(theEndTime==''){
		$.messager.alert("提示","请指定要清除的日志截止时间!",'info');
		return ;
	}
	$.messager.confirm("提示","确认要清除吗？",function(r){
		if(r){		
				
				$.messager.progress({
								title : '请稍候',
								msg : '清除日志中...' 		
 					});
			
				$.ajax({
					url:'../service/delete',
					data:{contentId:theEndTime,TABLENAME:"loginfo",PRIMARYKEY:"lastChangedTime"},
					type:'post',
					success:function(data){
						if(data >= 0){
							$("#dg").datagrid('load',{
								start:$("#start").datetimebox('getValue'),
							 	end:$("#end").datetimebox('getValue')
							});
							$.messager.progress('close');
							$.messager.alert("提示","清除成功",'info');
						}else{
							$.messager.progress('close');
							$.messager.alert("提示","清除失败，请重试！",'info');
						}
						
					},
					error:function(data){
						$.messager.progress('close');
						$.messager.alert("提示","操作失败，请重试！",'info');
					}
				});
		}
	});
	
	
}


