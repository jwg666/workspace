<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="com.opensymphony.xwork2.ActionContext"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page"%>
<html>
	<head>
		<jsp:include page="/common/frameset/meta.jsp" />
	    <jsp:include page="/common/css_and_js.jsp" />
	</head>
	<body>
		<div class="wp">
	     	  <!-- 公共头部 -->
			  <div class="hd pr header">
			  	<jsp:include page="/common/frameset/header.jsp"/>
			  </div>
			  <div class="nav pr">
			  	<jsp:include page="/common/frameset/navigation.jsp" />
			  </div>
		</div>
	</body>
</html>
