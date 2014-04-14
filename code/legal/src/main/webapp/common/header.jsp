<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %> 
<div class="logo pa">
  <a href="" style="float:left;"><img src="${staticURL}/images/logo.jpg" alt="" /></a>
  <div class="sysName">HOP演示系统</div>
</div>
<div class="msg pa" style="width:auto; text-align:right; top:5px; line-height:20px;"> 
		<div style="float: left;margin-left:300px;width:55%;margin-right: 30px;font-weight: bolder;display:inline;">
			<marquee onMouseover="this.stop()" onMouseout="this.start()" scrolldelay="251"><span style="color: red;"><s:property value="#session['expiredDate']"/></span></marquee>
		</div> 
			 <b><a href="${dynamicURL}/security/updatePasswordInit.do">[修改密码]</a></b>&nbsp|&nbsp
			 <b><a href="${dynamicURL}/security/logout.do" >[注销]</a></b> 
			 <div>
				<span>
					您好，<a href="${dynamicURL}/security/viewUser.do" title="我的信息"><strong style="color: red;"><s:property value="#session['_user_name']"/></strong></a>欢迎来到海尔信息门户   &nbsp; 您上次登录IP：<strong style="color: red;"><s:property value="#session['_user_last_login_ip']"/></strong>
				</span> 
			</div>
</div>  
