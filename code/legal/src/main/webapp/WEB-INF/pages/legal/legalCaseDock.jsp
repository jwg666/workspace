<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>法律援助综合信息管理系统</title>
<jsp:include page="/common/common_js.jsp"></jsp:include>

</head>
<body>
<div class="zoc">
		<div id="errorMsg" style="color:red;text-align: center;"></div>
	<div class="part_zoc" style="min-width: 200px;padding: 0;margin: 0">
		<div class="oneline">
			<div class="item33">
				<div class="itemleft80">案件编号：</div>
				<div class="righttext">
					<input type="text" name="caseId" id="caseId" class="orderAutoComple">
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item33">
				<div class="oprationbutt">
					<input type="button" id="processImageId" value="查看流程图">
					<input type="button" id="processPanoramaId" value="查看详细信息">
				</div>
			</div>
		</div>
	</div>

</div>

</body>
</html>