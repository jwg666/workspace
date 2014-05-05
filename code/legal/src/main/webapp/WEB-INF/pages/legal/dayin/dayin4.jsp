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
	<div class="title mt20">给予法律援助决定书</div>
<div class="soufan">崂援决字[
<s:textfield name="legalCaseQuery.legalCode" size="width:30px;" cssClass="gh_inputmen"></s:textfield>
]第
<s:textfield name="legalCaseQuery.legalNo" size="width:30px;" cssClass="gh_inputmen"></s:textfield>
号</div>
<div class="gh_zw">
  <div class="gh_title">
    <input name="" type="text" class="gh_input" size="20"/>
    &nbsp;： </div>
  <div class="gh_nei">&nbsp;&nbsp;&nbsp;&nbsp;你于
  <span class="bbf" style="width: 40px;display：inline;">
  <s:textfield name="legalCaseQuery.year" type="text" cssClass="gh_input" size="10"/></span>年
  <span class="bbf" style="width: 40px;display：inline;">
  <s:textfield name="legalCaseQuery.month" type="text" cssClass="gh_input" size="7"/>
  </span>月
  <span class="bbf" style="width: 40px;display：inline;">
  <s:textfield name="legalCaseQuery.day" type="text" cssClass="gh_input" size="7"/>
  </span>日向本中心提出的
  <span class="bbf" style="width: 140px;display：inline;">
  <s:textfield name="legalCaseQuery.description" type="text" cssClass="gh_input" size="30"/></span>一案法律援助申请，经审查，符合法律援助条件，现决定给予法律援助，提供法律援助的方式为
  <span class="bbf" style="width: 140px;display：inline;">
  <input name="" type="text" class="gh_input" size="20"/></span>。</div>
  <div class="gh_nei3 mt20">&nbsp;&nbsp;&nbsp;&nbsp;特此通知</div>
  <div class="gh_nei3">&nbsp;&nbsp;&nbsp;&nbsp;承办机构联系方式：${departmentQuery.officePhone}</div>
</div>
<div class="soufan mt50">(公章)</div>
<div class="soufan">
<span class="bbf" style="width: 60px;display：inline;">
<s:textfield name="legalCaseQuery.year1" type="text" cssClass="gh_input2" size="5"/>
</span>年
<span class="bbf" style="width: 60px;display：inline;">
<s:textfield name="legalCaseQuery.month1" type="text" cssClass="gh_input2" size="5"/>
</span>
月
<span class="bbf" style="width: 60px;display：inline;">
<s:textfield name="legalCaseQuery.day1" type="text" cssClass="gh_input2" size="5"/>
</span>日</div>
</body>
</html>