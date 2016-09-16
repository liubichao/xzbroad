<%@page
	language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link id="easyuiTheme" rel="stylesheet" type="text/css" href="../easyUI/themes/metro-blue/easyui.css">
<link rel="stylesheet" type="text/css" href="../easyUI/themes/icon.css">
<link rel="stylesheet" type="text/css" href="../easyUI/themes/color.css">
<script type="text/javascript" src="../easyUI/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="../js/ajaxInterceptor.js"></script>
<script type="text/javascript" src="../easyUI/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../easyUI/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="../js/jquery.cookie.js"></script>
<script type="text/javascript" src="../js/theme.js"></script>

<script type="text/javascript" src="../js/payProduct.js"></script>
</head>
<body>
<div class="easyui-layout" fit="true">
	<table id="dg" ></table>
	<div align="left" id="toolbar">
		<input class="easyui-textbox" id="searchtitle"  prompt="请输入节目名称" />
		<a class="easyui-linkbutton" data-options="plain:true,iconCls:'search'" onclick="searchData();">查询</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="add" plain="true" onclick="newImage()">新增</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="update" plain="true" onclick="editImage()">修改</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="delete" plain="true" onclick="delImage()">删除</a>
		<span style=" float: right">
	        <a href="#" class="easyui-linkbutton" id="btn_quarter1" onclick="searchData('')" data-options="iconCls:'all',plain:true,toggle:true,group:'g3',selected:true">全部</a>
	        <a href="#" class="easyui-linkbutton" id="btn_quarter4" onclick="searchData(1)" data-options="iconCls:'finish',plain:true,toggle:true,group:'g3'">预定义</a>
	        <a href="#" class="easyui-linkbutton" id="btn_quarter3" onclick="searchData(0)" data-options="iconCls:'excuting',plain:true,toggle:true,group:'g3'">自定义</a>
		</span>
	</div>
	<div id="dlg" class="easyui-dialog" style="width:400px;height:330px;padding:10px 20px"
		 closed="true" modal="true" buttons="#dlg-buttons">
		<div class="ftitle">节目信息</div>
		<form id="fm" method="post" enctype="multipart/form-data"  novalidate>
			<div class="fitem">
				<label>节目名称:</label>
				<input name="title" id="title" class="easyui-textbox" required="true" missingMessage="此选项必填" prompt="输入名称" data-options="validType:{length:[1,100]}">
			</div>
			<div class="fitem">
				<label>节目内容:</label>
				<textarea rows="5" class="textarea easyui-validatebox" name="content" id="content" required="true" missingMessage="此选项必填" prompt="输入节目内容" data-options="validType:{length:[1,2000]}"></textarea>
				<%--<input name="content" id="content" class="easyui-textbox" required="true" missingMessage="此选项必填" prompt="输入节目内容" data-options="validType:{length:[1,2000]}">--%>
			</div>
			<div class="fitem">
				<label>节目编号:</label>
				<input name="payProgramId" id="payProgramId" class="easyui-textbox" required="true" missingMessage="此选项必填" prompt="输入节目编号" data-options="validType:{length:[1,31]}">
			</div>
			<div class="fitem">
				<label>金额:</label>
				<input name="amount" id="amount" class="easyui-numberbox" required="true" missingMessage="此选项必填" prompt="输入金额" data-options="min:0,precision:2">
			</div>
			<div class="fitem">
				<label>单位:</label>
				<input name="unit" id="unit" class="easyui-textbox" required="true" missingMessage="此选项必填" prompt="输入单位" data-options="validType:{length:[1,31]}">
			</div>
			<div class="fitem">
				<label>折扣类型:</label>
				<select id="discountType" name="discountType" editable="false" class="easyui-combobox" panelHeight="60" style="width: 164px;">
					<option value="0" selected>无折扣</option>
					<option value="1">按比例</option>
					<option value="2">减金额</option>
					<option value="3">其他</option>
				</select>
			</div>
			<div class="fitem">
				<label>折扣比例:</label>
				<input name="rate" id="rate" class="easyui-numberbox" prompt="输入折扣比例（%）" data-options="min:0,precision:0">
			</div>
			<div class="fitem">
				<label>折扣金额:</label>
				<input name="disamount" id="disamount" class="easyui-numberbox" prompt="输入折扣金额" data-options="min:0,precision:2">
			</div>
			<div class="fitem">
				<label>排序:</label>
				<input name="sort" id="sort" class="easyui-numberbox" required="true" missingMessage="此选项必填" prompt="输入序号" data-options="min:0,precision:0">
			</div>
			<div class="fitem">
				<label>是否预定义:</label>
				<select id="ispredefine" name="ispredefine" editable="false" class="easyui-combobox" panelHeight="60" style="width: 164px;">
					<option value="1">是</option>
					<option value="0" selected>否</option>
				</select>
			</div>

		</form>
	</div>
	<div id="dlg-buttons" style="height:38px;">
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveImage()" style="width:90px">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="$('#dlg').dialog('close')" style="width:90px">取消</a>
	</div>
</div>
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
	.detail, .detailLabel, .detailHeader {
		background-color: white;
		border-bottom: 1px solid #ababab;
		border-right: 1px solid #ababab;
		color: black;
		font-family: Arial, Verdana, sans-serif;
		font-size: 11px;
	}
	.detailLabel {
		font-weight: bold;
		color: #4C4C4C;
		background-color: #F6F7F9;
		text-align: right;
	}
	.detailBlock{
		border-left: 1px solid #ababab;
		border-top: 1px solid #ababab;
	}
	.fitem input{
		width:160px;
	}
	.fitem textarea{
		width:160px;
		font-size: 12px;
	}
	.add {background-image: url("../images/add.png");}
	.delete {background-image: url("../images/delete.png");}
	.search {background-image: url("../images/search.png");}
	.update {background-image: url("../images/update.png");}
	.all {background-image: url("../images/all.png");}
	.finish {background-image: url("../images/finish.png");}
	.excuting {background-image: url("../images/excuting.png");}
</style>
</body>
</html>