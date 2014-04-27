<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<link type="text/css" rel="stylesheet" href="../legal/cmsimages/css.css"/>
<script type="text/javascript" charset="utf-8">

function dayin() {
	var printObj = $("body").clone(true);
	printObj.find("#optBnts").remove();
	printObj = gridToTable(printObj);
	printObj.find("#dayinid input").addClass("gh_input");
	lodopPrintAutoWidth(printObj);
}
</script>
<style type="text/css">
 	.bbf{
	    
	    height: 28px;
	    line-height: 20px;
	    border-bottom: 1px dotted black;
	}
</style>
</head>
<body class="easyui-layout">
    <div class="buttons" style="text-align: right;">
		<a href="#" class="easyui-linkbutton" id="optBnts"
				onclick="dayin();"
				data-options="iconCls:'icon-print'">打印</a>
	</div>
	<div class="title mt20">刑事法律援助公函</div>
<div class="soufan">崂刑援函字[
<s:textfield name="legalCaseQuery.legalCode" size="width:30px;" cssClass="gh_inputmen"></s:textfield>
]第
<s:textfield name="legalCaseQuery.legalNo" size="width:30px;" cssClass="gh_inputmen"></s:textfield>
号</div>
<div class="gh_zw">
  <div class="gh_title">
    <input name="" type="text" class="gh_input" size="20"/>
    &nbsp;： </div>
  <div class="gh_nei">&nbsp;&nbsp;&nbsp;&nbsp;本中心对
  <span class="bbf" style="width: 140px;display：inline;">
  <input name="" type="text" class="gh_input" size="15"/></span>（犯罪嫌疑人/被告人/自诉人/受害人）
  <span class="bbf" style="width: 140px;display：inline;">
  <input name="" type="text" class="gh_input" size="30"/></span>一案, 已指派
  <span class="bbf" style="width: 140px;display：inline;">
  <input name="" type="text" class="gh_input" size="20"/></span>（承办机构）
  <span class="bbf" style="width: 140px;display：inline;">
  <input name="" type="text" class="gh_input" size="15"/></span>（承办人）律师担任其（辩护人/代理人）。 </div>
  <div class="gh_nei3 mt20">&nbsp;&nbsp;&nbsp;&nbsp;特此函告</div>
  <div class="gh_nei3">&nbsp;&nbsp;&nbsp;&nbsp;承办人联系方式：${departmentQuery.officePhone}</div>
</div>
<div class="soufan mt50">(公章)</div>
<div class="soufan">
<span class="bbf" style="width: 60px;display：inline;">
<input name="" type="text" class="gh_input2" size="5"/>
</span>年
<span class="bbf" style="width: 60px;display：inline;">
<input name="" type="text" class="gh_input2" size="5"/>
</span>
月
<span class="bbf" style="width: 60px;display：inline;">
<input name="" type="text" class="gh_input2" size="5"/>
</span>日</div>
</body>
</html>