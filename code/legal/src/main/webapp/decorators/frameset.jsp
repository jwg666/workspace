<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.opensymphony.xwork2.ActionContext"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page"%>
<html>
    <head>
    <%@ include file="/common/meta.jsp" %>
    <jsp:include page="/common/css_and_js.jsp" />
    <decorator:head/>
    </head>
<body<decorator:getProperty property="body.id" writeEntireProperty="true"/> <decorator:getProperty property="body.class" writeEntireProperty="true"/> >
     <div class="wp">
		  <div class="bd mainBodyWrap">
	  		<div class="clickBar"><img src="${staticURL}/style/images/closeclick.gif" /></div>
	  		<!-- 动态核心内容部分 -->
	  		<div id="contentDiv" class="col-2 col-twoWrap">
	  			<dl class="rightSideWrap">
	  				<decorator:body/>
	  			</dl>
	  		</div>
	  	</div>
	  </div>
<script type="text/javascript">
//显示/隐藏左侧菜单
var cookie_key = "_display_left_menu_";
$(".clickBar img").click(function(){
	var leftFrame = window.parent.window.document.getElementsByTagName("frameset")[1];
	var showLeft = (leftFrame.cols == '15px,*');
	var img = $(".clickBar img")[0];
	var imgUrl = img.src;
	if(!showLeft){
		img.src=imgUrl.replace("closeclick.gif","openclick.gif");
		leftFrame.cols='15px,*';
	}else{
		img.src=imgUrl.replace("openclick.gif","closeclick.gif");
		leftFrame.cols='200px,*';
		leftFrame.width=0;
		setCookie(cookie_key,"false",10);
	}
}); 
$(document).ready(function () {
	$("#contentDiv").css({margin: "0 0.5px 0 10px"});
});
</script>

</body>
</html>
