<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page"%>
<% 
	String module = request.getParameter("namespace");
	if(module==null){
		module = "security";
	}
	request.setAttribute("_module_", module);
%>
<html>
	<head>
		<jsp:include page="/common/frameset/meta.jsp" />
	    <jsp:include page="/common/css_and_js.jsp" />
	</head>
	<body style="overflow-x:hidden;overflow-y:auto">
		<div class="wp">
	     	  <div class="bd mainBodyWrap">
		  		<!-- 左侧菜单栏 -->
		  		<div id="left_menu_div" class="col-1 col-oneWrap">
					<s:action name="leftMenu" namespace="/" executeResult="true">
						<s:param name="namespace" value="#request['_module_']"></s:param>
					</s:action>
		  		</div>
		  		</div>
		</div>
	</body>
</html>