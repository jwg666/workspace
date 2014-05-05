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
	<div class="title mt20">法律援助律师会见在押犯罪嫌疑人、被告人公函</div>
<div class="soufan">崂刑援会函字[
<s:textfield name="legalCaseQuery.legalCode" size="width:30px;" cssClass="gh_inputmen"></s:textfield>
]第
<s:textfield name="legalCaseQuery.legalNo" size="width:30px;" cssClass="gh_inputmen"></s:textfield>
号</div>
<div id="dayinid" class="gh_zw">
  <div class="gh_title">
     <input name="" type="text" class="gh_input" size="20"/>&nbsp;：
  </div>
  <div class="gh_nei">
  &nbsp;&nbsp;&nbsp;&nbsp;根据《中华人民共和国刑事诉讼法》及《中华人民共和国律师法》关于法律援助的规定，现指派承担法律援助义务的
  <span class="bbf" style="width: 140px;display：inline;"><s:textfield name="departmentQuery.name" type="text" cssClass="gh_input" size="20"/></span>
   律师事务所律师
   <span class="bbf" style="width: 140px;display：inline;"><s:textfield name="legalCaseQuery.agentWriteName" type="text" cssClass="gh_input" size="20"/></span>
   
   前往你处会见
   <span class="bbf" style="width: 140px;display：inline;"><input name="" type="text" class="gh_input" size="20"/></span>
   案的犯罪嫌疑人（被告人）
   <span class="bbf" style="width: 140px;display：inline;"><input name="" type="text" class="gh_input" s size="20"/>，</span>
   请予安排。</div>
  <div class="gh_nei3 mt20">&nbsp;&nbsp;&nbsp;&nbsp;特此函告</div>
  <div class="gh_nei3">&nbsp;&nbsp;&nbsp;&nbsp;承办人联系方式：${departmentQuery.officePhone}</div>
</div>
<div class="soufan mt50">(公章)</div>
<div class="soufan">
<span class="bbf" style="width: 60px;display：inline;">
<s:textfield name="legalCaseQuery.year" type="text" cssClass="gh_input2" size="5"/>
</span>年
<span class="bbf" style="width: 60px;display：inline;">
<s:textfield name="legalCaseQuery.month" type="text" cssClass="gh_input2" size="5"/>
</span>
月
<span class="bbf" style="width: 60px;display：inline;">
<s:textfield name="legalCaseQuery.day" type="text" cssClass="gh_input2" size="5"/>
</span>日</div>
</body>
</html>