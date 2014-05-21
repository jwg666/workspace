<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link type="text/css" rel="stylesheet" href="cmsimages/css.css"/>
<jsp:include page="/common/common_js.jsp"></jsp:include>
        <style type="text/css">
        td_line
        {
                border-bottom-width: 1px;
                border-bottom-style: solid;
        }
        </style>
<script type="text/javascript">
	$(function(){
		$("#getSignButton").click(function (){
	        var id = document.applets[0].secureSign();
	        if(id==null||id==''){
	            alert("没有获取到签名");
	        }else{
	            alert(id);
	        }
	    });
	});
</script>
<title>法律援助申请表</title>
</head>

<body id="body">
	<script src="deployJava.js"></script>
    <script>
        var attributes = { code:'com.neusoft.legal.applet.GetSignImage.class',
            archive:'sign.jar',  width:200, height:100} ;
        var parameters = {jnlp_href: 'sign.jnlp'} ;
        deployJava.runApplet(attributes, parameters, '1.7');
    </script>
    <!-- 
        <applet codebase="."
                code="com.neusoft.legal.applet.GetSignImage.class"
                name="signApplet"
                archive="sign.jar"
                width="200"
                height="100"
                id="signApplet" MAYSCRIPT>
        </applet>
    -->
<input type="button" name="" id="getSignButton" value="获取签名ID"/>
</body>
</html>
