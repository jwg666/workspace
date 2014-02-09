<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>系统登录</title>
<link href="${staticURL}/style/newlogin.css" rel="stylesheet" />
<link rel="shortcut icon" href="${staticURL}/images/haier.ico" />
<%/**
   *测试用include 
   */%>
<script type="text/javascript">
	var f = true;
	function showTestUser() {
		if (f) {
			document.getElementById("userPanel").style.display = "";
			f=false;
		} else {
			document.getElementById("userPanel").style.display = "none";
			f=true;
		}
	}
</script>
</head>
<body style="background-color: #ffffff;">
	<div
		style="height:135px;background-image: url('${staticURL}/style/images/header_bg.jpg');background-repeat: repeat-x;">
		<a
			style="position: absolute;top:21px;left:200px;display: block;background-image: url('${staticURL}/style/images/logo_big.jpg');width: 205px;height: 47px;"></a>
		<div class="logInSysName">海外订单跟踪管理系统</div>
	</div>
	<div class="main">
		<div class="big">
			<div class="loginBgWrap">
				<div class="logintopBG">
					<span>用户登录</span>
				</div>
				<div class="mbg">
					<div class="login">

						<div class="form">
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
							<s:form action="login" namespace="/security" method="post" id="loginForm">
								<div class="user">
									<span class="text">用户名：</span> <input name="user.empCode"
										class="input" value="" />
								</div>
								<div class="user">
									<span class="text">密 码：</span> 
									<input type="password" name="user.password" value="111111" class="input" />
								</div>
								<div class="user">
									<span class="text">语 言：</span>
									<s:select name="localeInfo" list="#{'zh_CN':'中文','en_US':'英文'}" />
								</div>
								<div class="user">
									<span class="text">验证码：</span>
									<s:textfield name="checkCode" cssClass="input1" />
									<span class="img"> <img id="checkCodeImg"
										src="${dynamicURL}/checkCode.action"
										onclick="changeValidateCode()" style="cursor: pointer;" />
									</span>
								</div>
								<!-- <input type="hidden" name="checkCodeEnabled" value="false" /> -->
								<div class="user"
									style="margin-left: 55px; padding-bottom: 5px;">
									<a href="${dynamicURL}/security/retrieveUserPassword.action"
										class="forgetPW">忘记密码？</a>
									<div style="margin: 0 0 0 30px; float: left;">
										<input type="checkbox" style="float: left;" id="isSaveCookis"
											name="isSaveCookis"><b
											style="padding: 0 0 0 3px; float: left;">记住密码</b>
									</div>
								</div>
								<div class="loginBUTTON">
									<a onClick="loginSubmit()" class="loginBOTN">登录</a> 
									<a onClick="reset()" class="loginRESET">重置</a>
									<input type="submit" style="display: none;" />
								</div>
								<input type="hidden" name="redirectURL"
									value="<s:property value='#parameters.redirectURL'/>" />
							</s:form>
						</div>
					</div>
				</div>
				<div class="loginbotBG"></div>
				<span><input type="button" value="显示测试用户名"
					onclick="showTestUser();" /></span>如果您的浏览器不支持本系统 请<a href="${dynamicURL}/FirefoxSetup21.0.exe">点击下载火狐浏览器</a>
				<div id="userPanel"
					style="width: 500px; height: 250px; overflow: scroll; position: absolute; top: 10px; left: 10px; border: solid #000 1px; display: none;">
					<table border="1px" style="width: 600px; background-color: #ddd">
						<tr>
							<td>模块</td>
							<td>角色</td>
							<td>登录名</td>
							<td>密码</td>
							<td>数据权限</td>
						</tr>
						<tr>
							<td rowspan="4">特技单</td>
							<td rowspan="2">产品经理</td>
							<td>BX-CPJL</td>
							<td>111111</td>
							<td>冰箱产品经理</td>
						</tr>
						<tr>
							<td>KT-CPJL</td>
							<td>111111</td>
							<td>空调产品经理</td>
						</tr>
						<tr>
							<td rowspan="1">型号经理</td>
							<td>BX-XHJL</td>
							<td>111111</td>
							<td>冰箱型号经理</td>
						</tr>
						<tr>
							<td rowspan="1">工厂技术处经理</td>
							<td>BX-GCJSC<br />KT-GCJSC</td>
							<td>111111</td>
							<td>中一中二冰箱工厂技术处<br />青岛空调总公司</td>
						</tr>
						
						<tr>
							<td rowspan="10">信用证</td>
							<td rowspan="3">银行摘录员</td>
							
							
							<td></td>
						</tr>
						<tr>
							<td>BANKER1</td>
							<td>111111</td>
							<td></td>
						</tr>
						<tr>
							<td>BANKER2</td>
							<td>111111</td>
							<td></td>
						</tr>
						<tr>
							<td></td><td></td><td></td>
						</tr>
						<tr>
							<td rowspan="3">经营体长</td>
							<td>MZ-JYTZ</td>
							<td>111111</td>
							<td></td>
						</tr>
						<tr>
							<td>JYTZ01</td>
							<td>111111</td>
							<td></td>
						</tr>
						<tr>
							<td>JYTZ02</td>
							<td>111111</td>
							<td></td>
						</tr>
						<tr>
							<td rowspan="3">单证经理</td>
							<td>DZJL02</td>
							<td>111111</td>
							<td></td>
						</tr>
						<tr>
							<td>DZJL01</td>
							<td>111111</td>
							<td></td>
						</tr>
						<tr>
							<td></td><td></td>
							<td></td>
						</tr>
						
						<tr>
							<td rowspan="2">快递叫件</td>
							<td >快递录入员</td>
							<td>KD-LR</td>
							<td>111111</td>
							<td></td>
						</tr>
						<tr>
						    <td>费用部门审核员</td>
							<td>KD-SH</td>
							<td>111111</td>
							<td>【1】【49】</td>
						</tr>
					 
					</table>
				</div>
			</div>
		</div>
	</div>
	<div
		style="width: 100%; margin: 0 auto; text-align: center; background-image: url('${staticURL}/style/images/footer_bg.jpg');background-repeat: repeat-x; height: 89px; position: absolute; bottom: 0; line-height: 89px;">
		Copyright © 2012 海尔集团版权所有</div>
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
</body>
</html>