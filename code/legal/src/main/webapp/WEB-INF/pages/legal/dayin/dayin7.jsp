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
	<div class="title mt20">终止法律援助公函</div>
<div class="soufan">崂援终函字[
<s:textfield name="legalCaseQuery.legalCode" size="width:30px;" cssClass="gh_inputmen"></s:textfield>
]第
<s:textfield name="legalCaseQuery.legalNo" size="width:30px;" cssClass="gh_inputmen"></s:textfield>
号</div>
<div class="gh_zw">
  <div class="gh_title">
    <input name="" type="text" class="gh_input" size="20"/>
    &nbsp;： </div>
  <div class="gh_nei">&nbsp;&nbsp;&nbsp;&nbsp;本中心给予
  <span class="bbf" style="width: 140px;display：inline;">
  <input name="" type="text" class="gh_input" size="15"/></span>（受援人）
  <span class="bbf" style="width: 140px;display：inline;">
  <input name="" type="text" class="gh_input" size="30"/></span>一案的法律援助
  <span class="bbf" style="width: 140px;display：inline;">
  <input name="" type="text" class="gh_input" size="20"/></span>(法律援助公函编号/法律援助案件指派号)，因
  <span class="bbf" style="width: 140px;display：inline;">
  <input name="" type="text" class="gh_input" size="40"/></span>，根据
  <span class="bbf" style="width: 140px;display：inline;">
  <input name="" type="text" class="gh_input" size="30"/></span>的规定，决定终止法律援助。</div>
  <div class="gh_nei3 mt20">&nbsp;&nbsp;&nbsp;&nbsp;特此函告</div>
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