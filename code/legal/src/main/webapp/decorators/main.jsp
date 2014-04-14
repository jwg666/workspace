<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.opensymphony.xwork2.doContext"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page"%>
<% 
	String module = ActionContext.getContext().getActionInvocation()
		.getProxy().getNamespace();
	if(module.startsWith("/")){
		module = module.substring(1,module.length());
	}
	request.setAttribute("_module_", module);
%>
<html>
    <head>
    <%@ include file="/common/meta.jsp" %>
    <title><decorator:title default="XXX系统"/></title>
    <jsp:include page="/common/css_and_js.jsp" />
   	<decorator:head/>
    </head>
<body<decorator:getProperty property="body.id" writeEntireProperty="true"/> <decorator:getProperty property="body.class" writeEntireProperty="true"/> >
     <div class="wp">
     	  <!-- 公共头部 -->
		  <div class="hd pr header">
		  	<jsp:include page="/common/header.jsp"/>
		  </div>
		  <div class="nav pr">
		  	<jsp:include page="/common/navigation.jsp" />
		  </div>
		  <div class="bd mainBodyWrap">
	  		<!-- 左侧菜单栏 -->
	  		
	  		<div id="left_menu_div" class="col-1 col-oneWrap">
	  			<decorator:usePage id="thePage" /> 
				<s:action name="leftMenu" namespace="/" executeResult="true">
					<s:param name="namespace" value="#request['_module_']"></s:param>
				</s:action>
	  		</div>
	  		<div class="clickBar"><img src="${staticURL}/style/images/closeclick.gif" /></div>
	  		<!-- 动态核心内容部分 -->
	  		<div id="contentDiv" class="col-2 col-twoWrap">
	  			<dl class="rightSideWrap">
	  				<decorator:body/>
	  			</dl>
	  		</div>
	  	</div>
	  	<!-- 页脚 -->
  		<jsp:include page="/common/footer.jsp"/>
	  </div>
<script type="text/javascript">
//显示/隐藏左侧菜单
var cookie_key = "_display_left_menu_";
$(".clickBar img").click(function(){
	var showLeft = $("#left_menu_div").is(":visible");
	var img = $(".clickBar img")[0];
	var imgUrl = img.src;
	if(!showLeft || showLeft == 'none'){
		$("#left_menu_div").show();
		img.src=imgUrl.replace("openclick.gif","closeclick.gif");
		$("#contentDiv").css({margin: "0 0.5px 0 199px"});
		setCookie(cookie_key,"true",10);
	}else{
		$("#left_menu_div").hide();
		img.src=imgUrl.replace("closeclick.gif","openclick.gif");
		$("#contentDiv").css({margin: "0 0.5px 0 10px"});
		setCookie(cookie_key,"false",10);
	}
}); 
$(document).ready(function () {
	var cookie_value = getCookie(cookie_key);//alert(cookie_value);
	var img = $(".clickBar img")[0];
	var imgUrl = img.src;
	if(cookie_value && cookie_value == 'false'){
		$("#left_menu_div").hide();
		img.src=imgUrl.replace("closeclick.gif","openclick.gif");
		$("#contentDiv").css({margin: "0 0.5px 0 10px"});
	}else{
		$("#left_menu_div").show();
		img.src=imgUrl.replace("openclick.gif","closeclick.gif");
		$("#contentDiv").css({margin: "0 0.5px 0 199px"});
	}
});
</script>
</body>
</html>
