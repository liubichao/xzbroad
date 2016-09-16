<%@page
	language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>分类管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css"
	href="../easyUI/themes/metro-blue/easyui.css">
<link rel="stylesheet" type="text/css" href="../easyUI/themes/icon.css">
<link rel="stylesheet" type="text/css" href="../easyUI/themes/color.css">

<script type="text/javascript" src="../easyUI/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="../easyUI/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../easyUI/locale/easyui-lang-zh_CN.js"></script>
<style>
.treeDnd {background-image: url("../images/plugin.png");}
.tree-file{background:url('../images/house.png') no-repeat center center!important;}
</style>
</head>
<body>
	
	<div id="dlg" class="easyui-dialog" style="width:400px;height:220px;padding:10px 20px"
            closed="true" modal="true" buttons="#dlg-buttons">
    	<div class="ftitle">分类信息</div>
    	<input id="polId" type="hidden">
		<input id="parentId" type="hidden">
    	<form id="fm" method="post" novalidate>
    		<div class="fitem">
	            <label>分类名称:</label>
	           <input name="name" id="name" prompt="分类名称" class="easyui-textbox" data-options="validType:{length:[0,50],unique:['../service/checkNameExist','name','parentId']}"  required="true" missingMessage="请输入分类名称.">
		    </div>
            <div class="fitem">
                <label>分类排序:</label>
                <input name="sort" id="code" prompt="分类排序" class="easyui-numberbox" data-options="min:0,precision:0" required="true" missingMessage="请输入顺序号.">
            </div>
            <div class="fitem">
                <label>是否有效:</label>
                <select id="state" name="isvalid" editable="false" class="easyui-combobox" panelHeight="60" style="width: 164px;">
                	<option value="1" selected>是</option>
        			<option value="0">否</option>
                </select>
            </div>
        </form>
         <div id="dlg-buttons">
	        <a href="javascript:void(0);" class="easyui-linkbutton c8" iconCls="icon-ok" onclick="savepolitical()" style="width:90px">保存</a>
	        <a href="javascript:void(0);" class="easyui-linkbutton c8" iconCls="icon-cancel" onclick="$('#dlg').dialog('close');" style="width:90px">取消</a>
	    </div>
    </div>
    
	<table id="tg" class="easyui-treegrid" fit="true" toolbar="#tbar" autoRowHeight="false"
		rownumbers="true" idField="id" treeField="name" url="../service/getCategoryByPid" fitColumns="true" animate="true" >
		<thead>
            <tr>
           	    <th data-options="field:'name'" align="left" width="100">分类名称</th>
                <th data-options="field:'sort'" width="50">分类排序</th>
                <th data-options="field:'_operation'" align="center" width="150" formatter="formatOper">操作</th>
            </tr>
        </thead>
	</table>
	<!-- 显示权限树 -->
	
	<div id="dndTreeDlg" class="easyui-dialog" style="width:300px;height:300px;"
            closed="true" modal="true" buttons="#dndTreeDlg-buttons">
		<ul id="dndTree" dnd="true" animate="true" method="get"></ul>
		<div id="dndTreeDlg-buttons">
	        <a href="javascript:void(0);" class="easyui-linkbutton c8" iconCls="icon-ok" onclick="saveDndTree()" style="width:90px">保存</a>
	        <a href="javascript:void(0);" class="easyui-linkbutton c8" iconCls="icon-cancel" onclick="$('#dndTreeDlg').dialog('close');" style="width:90px">取消</a>
	    </div>
	</div>
	
</body>
<style type="text/css">
	#fm{
	    margin:0;
	    padding:10px 30px;
	}
	.ftitle{
	    font-size:14px;
	    font-weight:bold;
	    padding:5px 0;
	    margin-bottom:10px;
	    border-bottom:1px solid #ccc;
	}
	.fitem{
	    margin-bottom:5px;
	}
	.fitem label{
	    display:inline-block;
	    width:70px;
	    text-align: right;
	}
	.fitem input{
	    width:160px;
	}
</style>
<script type="text/javascript">
var uniqueCount = 0;
var url;
$(function(){
	$.extend($.fn.validatebox.defaults.rules, {
	    unique:{
	    	validator:function(value,param){
	    		if(uniqueCount<2){
	    			//uniqueCount++;
	    			return true;
	    		}else{
	    			var data = {};
	    			data[param[1]] = value;
	    			data['id'] = $('#'+param[2]).val();
	    			var isValidate=$.ajax({   
	                     url: param[0],   
	                     dataType: "text", 
	                     data: data,
	                     async: false,
	                     cache: false,   
	                     type: "post"
	            	}).responseText;
	    			if(isValidate=="error"){
	    				$.messager.alert('提示','分类名称验证失败,请稍后再试');
	    			}
		    		return isValidate=='true';
	    		}
	    	},
	    	message:'分类名称已存在'
	    }
	});
});
function formatOper(value,row,index){
	var oper=[];
	//添加子节点权限
	
	if(row['political.style']!='button'){
		oper.push('<a href="javascript:void(0);" onclick="newpolitical(\''+row.id+'\')">添加下级分类</a>');
	}
	
	//更新权限信息
	
	oper.push('<a href="javascript:void(0);" onclick="editpolitical(\''+row.id+'\',\''+ row.parentId +'\')">修改</a>');
	
	//删除权限信息
	if(row.id!=1){
		
	}
	
	var result='';
	for(var i=0,len=oper.length;i<len;i++){
		result+=oper[i]+' ';
	}
	return result;
}
/**
 * 新增权限
 */
function newpolitical(id){
	//新增时开启唯一性验证
	uniqueCount = 2;
	$('#polId').val('');
	$('#parentId').val(id);
	$('#dlg').dialog('open').dialog('setTitle','新增分类');
    $('#fm').form('clear');
	$("#code").numberbox("setValue",0);
    $('#state').combobox('setValue','1');
    url = '../service/save?TABLENAME=category&PRIMARYKEY=id&parentId='+id;
    
}

/**
 * 修改分类信息
 */
function editpolitical(id,pid){
	//修改时关闭前2次唯一性验证
	uniqueCount = 0;
	$('#dlg').dialog('open').dialog('setTitle','修改分类');
	$('#tg').treegrid('select',id);
	var row = $('#tg').treegrid('getSelected');
	$('#polId').val(id);
	$('#parentId').val(pid);
    $('#fm').form('load',row);
    $("#name").textbox("setValue",row['name']);
    $('#state').combobox('setValue',row['isvalid']);
    url = '../service/update?TABLENAME=category&PRIMARYKEY=id&contentId='+id;
}

/**
 * 保存权限
 */

function savepolitical(){
	$('#fm').form('submit',{
        url: url,
        onSubmit: function(param){
			 if($(this).form('validate')){
				 $.messager.progress({
		                title:'请稍后',
		                msg:'数据保存中...'
		            });
            	return true;
			 }
			 return false;
        },
        success: function(result){
       	 $.messager.progress('close');
            if (result > 0){
           	 	$('#dlg').dialog('close');
                $('#tg').treegrid('reload');
            }else {
           	 	$.messager.alert('提示','保存分类失败','error');
            }
        }
    });
}

/**
 * 删除权限
 */
 
</script>
</html>
