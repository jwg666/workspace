<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>系统登录</title>
<link href="${staticURL}/style/newlogin.css?v=${jsCssVersion}" rel="stylesheet" />
<%/**
   *测试用include 
   */%>
<script type="text/javascript">
	var f = true;
	function showTestUser() {
		var user = document.getElementById("userPanel").innerHTML;
		document.getElementById("content").innerHTML=user;
		/* if (f) {
			document.getElementById("userPanel").style.display = "";
			f=false;
		} else {
			document.getElementById("userPanel").style.display = "none";
			f=true;
		} */
	}
	function enterDown(event){
		if(event.keyCode==13){
			document.getElementById("loginForm").submit();
		}
	}
</script>
<style>
 .formtable td{
	border-bottom: 1px solid #c0c0c0; 
	border-right: 1px solid #c0c0c0; 
 }
 .login_main_container>div.login_pad div.btn_container input{
 	display: none;
 }
<s:if test="%{singleLogin == 'true'}">
  .login_main_container>div,.login_main_container>p,.login_main_container>a{
 	display: none;
 } 
 .login_main_container>div.login_pad{
 	display: block;
 	margin:0 auto;
 	float: none;
 }
  div.login_main_container{
 	width: auto;
 } 

 .login_main_container>div.login_pad div.code>div{
 	display: none;
 }
 .login_main_container>div.login_pad div.code div.tip{
 	display: block;
 }
 .login_main_container>div.login_pad div.btn_container a.login{
 	display: none;
 }
 .login_main_container>div.login_pad div.btn_container input{
 	display: block;
 }
 </s:if>
</style>
</head>
<body class="login_body" onkeydown="enterDown(event)">
<div class="login_main_container">
  <div class="login_pad">
    <div class="logo">
    	<a href="#">
    	<!-- LOGO -->
    	<!--
    	<img src="${staticURL}/style/images/logo_login.png"/>
    	  -->
    	</a>
    	<p>法律援助系统</p>
    </div>
    <s:form action="login" namespace="/security" method="post" id="loginForm">
	    <div class="login_content">
	    	<div class="elem">
	        	<div class="name">用户名</div>
	        	<div class="text clearfix"><input type="text" name="userInfo.empCode" /> </div>
	      	</div>
	      	<div class="elem">
	        	<div class="name">密码</div>
	        	<div class="text clearfix"><input type="password" name="userInfo.password"  /></div>
	      	</div>
	      	<div class="elem">
	        	<div class="name">语言</div>
	        	<div class="text clearfix">
	        		<s:select name="localeInfo" list="#{'zh_CN':'中文','en_US':'英文'}" />
	        	</div>
	      	</div>
	      	<div class="elem code">
	       		<div class="name" style="display: none">验证码</div>
	        	<div class="text clearfix" style="display: none">
		        	<input type="text" name="checkCode" class="verif" />
		        	<span class="img"> 
		        	<!--
		        	<img id="checkCodeImg" src="${dynamicURL}/checkCode.action"
							onclick="changeValidateCode()" style="cursor: pointer;" />
							  -->
					</span>
	        	</div>
	        	<div class="tip">
	        	    <s:if test="hasActionErrors()||hasFieldErrors()">
						<div class="hiddendiv">
							<div id="errortips">
								<s:iterator value="actionErrors">
									<s:property />
								</s:iterator>
								<s:iterator value="fieldErrors">
									<s:iterator value="value">
										<s:property />
									</s:iterator>
								</s:iterator>
							</div>
						</div>
					</s:if>
					<s:else>
						<div class="hiddendiv"></div>
					</s:else>
	        	</div>
	      	</div>
	      	<br />
	      	<div class="btn_container clearfix">
	        	<a class="login">
	          		<div class="rig">
	            		<div onclick="loginSubmit()" class="content">登 录</div>
	          		</div>
	        	</a>
           		<input type="image" src="${staticURL}/style/images/login_btn.jpg" /> 
	      	</div>
	    </div>
	    <input type="hidden" name="redirectURL"
				value="<s:property value='#parameters.redirectURL'/>" />
		
	    <input type="hidden" name="singleLogin" value="${singleLogin }" />
    </s:form>
    <div style="margin-top: 10px">
    <!-- 
    <img src="${staticURL}/images/liantu.png" style="width: 170px">
     -->
    </div>
  </div>
  <div class="loginbotBG"></div>

  <div class="login_box">
    <div class="right">
      <div class="content">
      <h1>公告</h1>
      <div id="content" style="height: 300px;width: 520px; overflow: auto;">
      		${messageQuery.content}
      		  <p style="color: red;" >
				 公告上线
			  </p>
      	</div>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
		function loginSubmit() {
			document.getElementById("loginForm").submit();
		}
		function reset() {
			document.getElementById("loginForm").reset();
		}
		function changeValidateCode() {
			var timenow = new Date().getTime();
			var obj = document.getElementById("checkCodeImg");
			obj.src = "${dynamicURL}/checkCode.action?d=" + timenow;
		}
</script>
<!--标示是登陆页面  请不要删除！  -->
<!-- this-is-login-page-flag  -->
</body>
</html>