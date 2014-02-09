<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.haier.openplatform.security.SessionSecurityConstants"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
	if(session.getAttribute(SessionSecurityConstants.KEY_USER_NAME) == null){
		response.sendRedirect("login.jsp");
	}
%>
<html>
<frameset rows="77px,*,27px" framespacing="0" frameborder="0" border="0"> 
	<!-- 上 -->
	<frame src="${dynamicURL}/common/frameset/top.jsp" scrolling="auto" noresize="true"/> 
	<frameset cols="200px,*" framespacing="0" frameborder="0" border="0" id="frameset-center" name="frameset-center">
		<frame id="frame-left" name="frame-left" src="${dynamicURL}/common/frameset/left.jsp" scrolling="auto" noresize="true"/> 
		<frame name="frame-content" src="${dynamicURL}/common/frameset/static.html" scrolling="auto" noresize="true"/> 
	</frameset> 
	<frame name="frame-footer" src="${dynamicURL}/common/frameset/footer.jsp" scrolling="auto" noresize="true"/>
</frameset>
</html>
