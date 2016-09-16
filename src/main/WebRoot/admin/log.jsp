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
<script type="text/javascript" src="../js/jquery.min.js"></script>
<script type="text/javascript" src="../js/ajaxInterceptor.js"></script>
<script type="text/javascript" src="../easyUI/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../easyUI/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="../js/jquery.cookie.js"></script>
<script type="text/javascript" src="../js/theme.js"></script>

<script type="text/javascript" src="../js/log.js"></script>
</head>
<body>
<div class="easyui-layout" fit="true">
	<table id="dg" ></table>
	<div id="btns" >
		<table width="100%;">
		<tr>
			<td>    <input type="hidden" name="compareName" value="lastChangedTime">
					从:<input class="easyui-datetimebox" id="start" prompt="开始时间" editable="false"/>
					到:<input class="easyui-datetimebox" id="end" prompt="结束时间" editable="false"/>
					<a class="easyui-linkbutton" plain="true" iconCls="icon-search" onclick="searchLog()">查询</a>
					<a class="easyui-linkbutton" plain="true" iconCls="icon-clear" onclick="clearIt()">重置</a>
				    <a class="easyui-linkbutton" plain="true" iconCls="icon-remove" onclick="del()">删除</a>
			</td>
				
			<td align="right">
					清除日志方式:<input class="easyui-combobox" id="clearLogType" editable="false" style="width: 100px;"/>
					<span id="manual">
						<input id="theEndTime" prompt="请选择清除截止时间" class="easyui-datetimebox" editable="false"/>
						<a class="easyui-linkbutton" plain="true" iconCls="icon-remove" onclick="clearLog()">手动清除</a>
					</span>
					<span id="auto">
						日志保留最长时间（月）:
						<select class="easyui-combobox" id="logRemainDay">
								<option value="30">1</option>
							    <option value="91">3</option>
							    <option value="183">6</option>
							    <option value="365">12</option>
						</select>
					</span>		
					<a class="easyui-linkbutton" plain="true" onclick="saveLogDay()" iconCls="icon-save">保存设定</a>
			</td>	   
		</tr>
	   </table>	
	</div>
</div>
</body>
</html>