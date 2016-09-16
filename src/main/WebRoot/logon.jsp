<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>登录页面</title>

		<script type="text/javascript"
			src="easyUI/jquery-1.9.1.min.js"></script>
		<script type="text/javascript"
			src="js/jQuery.md5.js"></script>
	</head>
	<body onload="load()">
		<table align="center" style="margin-top: 240px;">
			<tr>
				<td style="font-size: 16px; font-weight: bold;">
					用户名：
				</td>
				<td>
					<input type="text" name="username" id="username"
						style="width: 328px; height: 37px; padding: 8px 0 0 5px;" />
				</td>
			</tr>
			<tr>
				<td style="font-size: 16px; font-weight: bold;">
					密<span style="visibility: hidden;">空</span>码：
				</td>
				<td>
					<input type="password" name="password" id="password"
						style="width: 328px; height: 37px; padding: 8px 0 0 5px;" />
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="button" value="提&nbsp;&nbsp;&nbsp;&nbsp;交" id="btn"
						onclick="logon()"
						style="width: 100px; height: 37px; padding: 3px 0 0 6px; font-size: 16px;" />
				</td>
			</tr>
		</table>
	</body>
	<script type="text/javascript">
      $(function(){ 
          $(document).keydown(function(event){ 
           if(event.keyCode==13){ 
            $("#btn").click(); 
           } 
          }); 
        });  
       function logon(){
          $("#btn").attr("disabled", true);
          var username = $("#username").val();
          var password = $("#password").val();
          if(username == ''){
             alert('用户名不能为空！');
             $("#username").focus();
             $("#btn").attr("disabled",false);
             return;
          }
          if(password == ''){
             alert('密码不能为空！');
             $("#password").focus();
             $("#btn").attr("disabled",false);
             return;
          }
          $.ajax({
             type:"post",
             url:"home/login",
             data:"username=" + username + "&password=" + $.md5($.md5(password)),
             success:function(data){
               if(data == 'true'){
                  location.href='admin/newIndex.jsp';
               }else{
                  alert('用户名或者密码错误，请重新登录！');
               }
             },
             error:function(msg){
                alert('未知错误！');
             },
             complete: function() {       
                $("#btn").attr("disabled",false);
             }  
          });
       }  
  </script>
</html>
