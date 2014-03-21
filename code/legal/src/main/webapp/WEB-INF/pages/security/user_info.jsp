<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript">
	var searchForm;
	var datagrid;
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户管理</title>
</head>
<body class="easyui-layout">
	<div region="north" class="zoc" border="false" title="过滤条件" collapsed="true"  style="height: 90px;overflow: hidden;" align="left">
	</div>
	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>
</body>
</html>