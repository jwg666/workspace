<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<link type="text/css" rel="stylesheet" href="../legal/cmsimages/css.css"/>
<script type="text/javascript" charset="utf-8">
var yinzhangWin;
var datagrid;
var legalCaseEditForm;
$(function(){
   yinzhangWin=$('#yinzhangWin-window').window({  
	    href:'',  
	    title:'选择印章',           
	    closed: true,  
	    minimizable:false,  
	    maximizable:false,    
	    collapsible:false,  
	    cache:false,  
	    shadow:false  
	});
   datagrid = $('#datagrid').datagrid({
		url : '${dynamicURL}/portal/searchUploadFile.do?remarks=sign',
		title : '图章列表',
		iconCls : 'icon-save',
		pagination : true,
		pagePosition : 'bottom',
		rownumbers : true,
		pageSize : 10,
		pageList : [ 10, 20, 30, 40 ],
		fit : true,
		fitColumns : false,
		nowrap : true,
		border : false,
		idField : 'id',
		
		frozenColumns:[ [ 
			{field:'ck',checkbox:true},
							
			{field:'download',title:'预览',align:'left',width:40,
				formatter:function(value,row,index){
					if(row.status!="1"){
						return '';
					}else if(row.contentType != null && row.contentType.indexOf("image")>-1){
						return '<a href="${dynamicURL}/portal/uploadFileAction/downloadImage.do?fileId=' + row.id + '" target="_blank"  ><img style="height:20px;" src="${dynamicURL}/portal/uploadFileAction/downloadImage.do?fileId='+ row.id +  '"/></a>';
					}else{
						return '<a href="${dynamicURL}/portal/fileUploadAction/downloadFile.do?fileId='+row.id+'" target="_blank" >下载 </a>';
						
					}
					var iconUrl = fmtIcon(row.contentType);
					if(!iconUrl){
						return row.id;
					}else{
						return row.id+'<img style="height:20px;" src="' + staticURL + iconUrl + '" />';
					}
				}
			},				
			{field:'fileName',title:'图章名',align:'center',width:200,
				formatter:function(value,row,index){
					if(row.contentType != null && row.contentType.indexOf("image")>-1){
						return '<a href="${dynamicURL}/portal/uploadFileAction/downloadImage.do?fileId=' + row.id + '" target="_blank"  >' + row.fileName + '</a>';
					}else{
						return row.fileName;
					}
				}
			},
			
			{field:'status',title:'状态',align:'center',width:90,
				formatter:function(value,row,index){
					if(row.status=="1"){
						return "有效";
					}else{
						return "无效";
					}
				}
			}
		] ],
		columns : [ [ 
           {field:'createBy',title:'创建人',align:'center',width:90,
				formatter:function(value,row,index){
					return row.createBy;
				}
			},				
		   {field:'createDate',title:'创建时间',align:'center',width:100,
				formatter:function(value,row,index){
					return dateFormatYMD(row.createDate);
				}
			}		   
		 ] ],
		toolbar : [  {
			text : '确认选择',
			iconCls : 'icon-add',
			handler : function() {
				setYinz();
			}
		}, '-', {
			text : '取消选中',
			iconCls : 'icon-undo',
			handler : function() {
				datagrid.datagrid('unselectAll');
			}
		}, '-' ]
	});
   
   legalCaseEditForm = $('#legalCaseEditForm').form({
		url : 'legalCaseAction!edit.do',
		success : function(data) {
			var json = $.parseJSON(data);
			if (json && json.success) {
				$.messager.show({
					title : '成功',
					msg : json.msg
				});
			} else {
				$.messager.show({
					title : '失败',
					msg : '更新印章失败！'
				});
			}
		}
	});
   
});


function selectYinz(){
	yinzhangWin.window('open');
}
function setYinz(){
	var rows = datagrid.datagrid('getSelections');
	if(rows.length==1){		
		$("#imgYinz").attr("src","${dynamicURL}/portal/fileUploadAction/downloadImage.do?fileId="+rows[0].id);
		$("#yinzhId").val(rows[0].id);
		yinzhangWin.window('close');
        legalCaseEditForm.submit();
	}else{
		$.messager.alert('Warning','请选择一个印章');
	}
	
}
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
<title>给予法律援助决定书</title>
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
<div class="soufan mt50">
 <s:if test="legalCaseQuery.yinzhId!=null&&legalCaseQuery.yinzhId!=0">
        <img id="imgYinz" alt="公章" src="${dynamicURL}/portal/uploadFileAction/downloadImage.do?fileId=${legalCaseQuery.yinzhId}" width="100px" height="100px" onclick="selectYinz();">
    </s:if>
    <s:else>
        <img id="imgYinz" alt="公章" src="../legal/images/yinzhang.gif" width="100px" height="100px" onclick="selectYinz();">
    </s:else>
</div>
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
<div id="yinzhangWin-window" class="earyui-window" title="选择印章" style="width: 550px; height: 350px; padding: 0px; background:#fafafa; "> 
	<table id="datagrid"></table>
</div>
<form action="" id="legalCaseEditForm">
	<input type="hidden" id="caseId" name="id" value="${legalCaseQuery.id}">
	<input type="hidden" id='yinzhId' name="yinzhId">
</form>
</body>
</html>