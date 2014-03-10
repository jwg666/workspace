<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>资源管理</title>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript">
	var treegrid;
	$(function(){
		treegrid = $("#treegrid").treegrid({
		    url:'resourceInfoAction!treegrid',
		    idField:'id',
		    treeField:'name',
		    columns:[[
		        {field:'id',title:'id',width:30},
		        {field:'name',title:'名称',width:80},
		        {field:'url',title:'URL',width:180},
		        {field:'code',title:'编码',width:80}
		    ]]
		});
	});
</script>
</head>
<body class="easyui-layout">
	<div region="center" border="false">
		<table id="treegrid"></table>
	</div>
</body>
</html>