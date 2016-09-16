<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<html>
<head>
<link rel="Shortcut Icon" href="../image/02.ico" type="image/x-icon">
<title>西藏广电后台管理系统</title>
<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
<link rel="stylesheet" href="../js/ext/resources/css/ext-all.css"
	type="text/css">
<script language="JavaScript" src="../js/ext/adapter/ext/ext-base.js"></script>
<script language="JavaScript" src="../js/ext/js/ext-all.js"></script>
<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->

<link rel="stylesheet" type="text/css" href="../css/default.css" />
<link rel="stylesheet" type="text/css"
	href="../easyUI/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="../easyUI/themes/icon.css" />
<script type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="../js/jQuery.easyui.js"></script>
<script type="text/javascript" src="../js/outlook2.js"></script>
<script type="text/javascript" src="../js/date.js"> </script>

<style type="text/css">
</style>
<script type="text/javascript">
	 var _menus = {"menus":[
		                {"menuid":"15","icon":"icon-sys","menuname":"资讯管理",
							"menus":[{"menuname":"分类管理","icon":"icon-chart_bars","url":"category.jsp"},
								     {"menuname":"文章管理","icon":"icon-books","url":""},
								     {"menuname":"轮播图片","icon":"icon-application_cascades","url":"scrollImg.jsp"}
			                         ]
						},
						{"menuid":"25","icon":"icon-sys","menuname":"商品管理",
							"menus":[{"menuname":"商品列表","icon":"icon-houses","url":"exchangedGoods.jsp"},
									{"menuname":"节目列表","icon":"icon-pages","url":"payProduct.jsp"}
								]

						},
						{"menuid":"35","icon":"icon-sys","menuname":"兑换记录管理",
							"menus":[{"menuname":"兑换记录","icon":"icon-dataManageS","url":""}
								]

						},
						{"menuid":"45","icon":"icon-sys","menuname":"付费管理",
							"menus":[{"menuname":"在线充值记录","icon":"icon-status_onlines","url":"rechargeRecord.jsp"},
									{"menuname":"购买节目记录","icon":"icon-phones","url":""}
								]
						},
						{"menuid":"65","icon":"icon-sys","menuname":"故障申报",
							"menus":[{"menuname":"故障申报","icon":"icon-informations","url":"failureReport.jsp"}
								]
						},
						{"menuid":"75","icon":"icon-sys","menuname":"系统管理",
							"menus":[
									{"menuname":"用户管理","icon":"icon-usersss","url":""},
									{"menuname":"微信绑定","icon":"icon-userGroup","url":"userBindWechat.jsp"},
									{"menuname":"物流信息","icon":"icon-status_onlines","url":"expressinfo.jsp"},
									{"menuname":"日志查询","icon":"icon-books","url":"log.jsp"}
								]
						}
				]};
    
        //关闭个人信息窗口
        function closeDialog() {
            $('#modifyWindow').window('close');
        }
		//安全退出
		function safeOut(){
			if(confirm("系统提示: 您确定要退出吗?")){
				location.href = "../logout" ;
			}
		}
		
		
//检查密码
function checkPass1(){  
	var pass1=$.trim($("#pass1").val());
	if(pass1==''){
		alert("密码不能为空");
		return false;
	}else{
		var reg=/^[a-zA-Z0-9_]{3,12}$/;
		if(reg.test(pass1)){
			return true;
		}else{
			alert("密码必须为3~12位的字母、数字、下划线组成！");
			return false;
		}
	}
}

//检查重复密码
function checkPass2(){
		var pass1=$.trim($("#pass1").val());
		var pass2=$.trim($("#pass2").val());
		if(pass2==''){
			alert("重复密码不能为空");
			return false;
		}
		var reg=/^[a-zA-Z0-9_]{3,12}$/;
		if(reg.test(pass2)){
			if(pass2==pass1){
				return true;
			}else{
				alert('两次输入密码不一致！');
				return false;
			}
		}else{
			alert("重复密码也必须为3~12位的字母、数字、下划线组成！");
			return false;
		}
}


//检查手机
function checkPhone(){
	var telephone=$.trim($("#telephone").val());
	if(telephone!=''){
		var reg=/^[1]\d{10}$/;
		if(reg.test(telephone)){
			return true;
		}else{
			alert('手机号码填写错误！');
			return false;
		}
	}
	return true;
}




//检查邮箱
function checkEmail(){
	var email=$.trim($("#email").val());
	if(email!=''){
		var reg=/^\w+@\w+(\.[a-zA-Z]{2,3}){1,2}$/;
		if(reg.test(email)){
			return true;
		}else{
			alert('邮箱格式错误！');
			return false;
		}
	}
	return true;
}





//个人设置
function modifyInfo(){
            	$.ajax({
            		url:'/ZXJC/UserServlet?flag=getInfo',
            		data:{contentId:$("#contentId").val()},
            		type:'post',
            		dataType:'json',
            		success:function(data){ 	
            				$("#realName").val(data.realName);
            				$("#telephone").val(data.telephone);
            				$("#email").val(data.email);
            				$("#pass1").val(data.password);
            				$("#pass2").val(data.password);
            			    $("#modifyWindow").window({
            					closed:false
            				});
            		},
            		error:function(){
            			alert("请求失败！");	
            		}
            	});


}
		
        //保存个人信息
        function saveInfo() {
           if(checkPass1()&&checkPass2()&&checkPhone()&&checkEmail()){
           		var contentId=$("#contentId").val();
            	var realName=$.trim($("#realName").val());
            	var telephone=$.trim($("#telephone").val());
            	var email=$.trim($("#email").val());
            	var password=$.trim($("#pass1").val());
            			
            	$.ajax({
					url:'/ZXJC/UserServlet?flag=saveInfo',
					data:{realName:realName,telephone:telephone,email:email,password:password,contentId:contentId},
					dataType:'text',
					type:'post',
					success:function(data){
						if(data=='true'){
							  alert("保存成功！");	
							 closeDialog();
						}else{
							alert("保存失败，请重试！");	
						}
					},
					error:function(data){
						alert("请求失败，请重试！");
					}
				});
            			
           	  
           }   
        }

        $(function() {
         newDate();//初始化时间
         //控制回车键
         $(document).keydown(function(event){ 
          		if(event.keyCode==13){ 
            		$("#btnEp").click(); 
           		} 
      	});
    });
        
    </script>
</head>
<body class="easyui-layout" style="overflow-y: hidden" scroll="no">
	<input type="hidden" value="${contentId }" id="contentId" />

	<!-- 最上边导航栏开始 -->
	<div region="north" split="false" border="false"
		style="overflow: hidden; height: 70px; background: url(../img/zxjcxt.jpg) no-repeat #326f9b; line-height: 60px; color: #fff;">
		<!--<span style="padding-left:30px; font-size: 20px; color: white; font-weight: bold;visibility: hidden;">&nbsp;&nbsp;在线监测服务系统&nbsp;&nbsp;</span>-->
		<span style="float:right; padding-right:20px;margin-top: 18px;"
			class="head"> 欢迎 ${USERNAME } 登陆 <a
			href="javascript:void(0)" onclick="modifyInfo()">修改信息</a> <a
			href="javascript:void(0)" onclick="safeOut()">安全退出</a> </span> <font
			id="dateID" style="margin-right: 25%;margin-top: 18px;float:right;"></font>
	</div>
	<!-- 最上边导航栏结束  -->
	<!-- 下面导航开始 -->
	<div region="south" split="false"
		style="height: 25px; background: steelblue; ">
		<div class="footer">Copyright &copy; 2013-2016 All Rights
			Reserved 西藏珂尔信息有限公司版权所有</div>
	</div>
	<!-- 下面导航结束 -->

	<div region="west" split="true" title="导航菜单" style="width:225px;"
		id="west">
		<div class="easyui-accordion" fit="true" border="false">
			<!--  导航内容 -->

		</div>

	</div>

	<div id="mainPanle" region="center"
		style="background: #eee; overflow-y:hidden;">
		<div id="tabs" class="easyui-tabs" fit="true" border="false">
			<!-- <div title="可视化展示" style="overflow:hidden;" id="home">
				<div id="container"></div>
					图表插件
				<div id="chartdiv" style="width:630; height:200;"></div>
			</div> -->
		</div>
	</div>

	<!--修改个人信息窗口-->
	<div id="modifyWindow" class="easyui-window" title="修改个人信息"
		modal="true" style="width: 300px;height: 220px;top:150px;left: 600px;"
		closed="true">
		<table style="margin-left: 25px;margin-top: 15px;">
			<tr>
				<td>用户名：</td>
				<td><input id="userName" readonly="readonly" maxlength="12"
					value="${userName}" type="text" />
				</td>
			</tr>
			<%--<tr>
				<td>真实姓名：</td>
				<td><input id="realName" maxlength="12" type="text" />
				</td>
			</tr>
			<tr>
				<td>手机号码：</td>
				<td><input id="telephone" maxlength="12" onblur="checkPhone()"
					type="text" />
				</td>
			</tr>
			<tr>
				<td>邮箱：</td>
				<td><input id="email" onblur="checkEmail()" type="text" />
				</td>
			</tr>--%>
			<tr>
				<td>密码：</td>
				<td><input id="pass1" maxlength="50" class="pass"
					onblur="checkPass1()" type="password" />
				</td>
			</tr>
			<tr>
				<td>确认密码：</td>
				<td><input id="pass2" maxlength="50" class="pass"
					onblur="checkPass2()" type="password" />
				</td>
			</tr>
		</table>

		<div id="modifyBtns" style="text-align:center;margin-top: 15px; ">
			<a class="easyui-linkbutton" plain="false" style="width: 70px;"
				onclick="saveInfo()">保存</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a
				class="easyui-linkbutton" plain="false" style="width: 70px;"
				onclick="closeDialog()">取消</a>
		</div>

	</div>

	<div id="mm" class="easyui-menu" style="width:150px;">
		<div id="mm-tabclose">关闭</div>
		<div id="mm-tabcloseall">全部关闭</div>
		<div id="mm-tabcloseother">除此之外全部关闭</div>
		<div class="menu-sep"></div>
		<div id="mm-tabcloseright">当前页右侧全部关闭</div>
		<div id="mm-tabcloseleft">当前页左侧全部关闭</div>
		<div class="menu-sep"></div>
		<div id="mm-exit">退出</div>
	</div>
</body>
</html>