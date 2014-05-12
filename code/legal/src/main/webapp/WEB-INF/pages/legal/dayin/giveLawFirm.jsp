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
function dayin(){
 	var printObj = $("#printBody").clone(true);
	printObj.width(1220);
	printObj.find("#optBnts").remove();
	printObj = gridToTable(printObj);
	printObj.find("#datagridDiv table").addClass("table2").width("100%").parent().addClass("part_zoc").width("100%");
	lodopPrintAutoWidth(printObj);
}
</script>
<title>给予法律援助决定书</title>
</head>

<body id="body">
<div  style="overflow: auto;min-width: 1220px" align="center"  id="printBody" >
<div class="title">指派通知书</div>
<div class="soufan" style="width: 50%">
<s:textfield id="legalWord" name="legalCaseQuery.legalWord" type="text" style="border:none"/>
<font size=4>援申字[</font><s:textfield id="legalCode" name="legalCaseQuery.legalCode" type="text" style="border:none"/><font size=4>]第</font><s:textfield id="legalNo" name="legalCaseQuery.legalNo" type="text" style="border:none"/><font size=4>号</font></div>

 <table style="border:0;" width="50%"  cellspacing="0"  cellpadding="0" align="center" >

  <tr style="height:30px;">
    
    <td  width="20%"><nobr><font size=4>发往单位：</font></nobr></td>
    <td  width="80%" align="left" >
        <s:textfield type="text" id="departmentQueryname" name="departmentQuery.name" style="border:0;background:transparent; width: 600px"/>
    </td>
  </tr>
  <tr style="height:30px;">
        <td  width="20%"><nobr><font size=4>受援人：</font></nobr></td>
        <td  width="80%" align="left">
        <s:textfield type="text" id="legalApplicantQueryname" name="legalApplicantQuery.name" style="border:0;background:transparent; width: 600px"/>
    </td>
  </tr >
   <tr style="height:30px;">
        <td width="20%" ><nobr><font size=4>案由：</font></nobr></td>
        <td width="80%" align="left">
        <s:textfield type="text" id="legalApplicantQueryname" name="legalApproveQuery.approveContent" style="border:0;background:transparent; width: 600px"/>
    </td>
  </tr>
   <tr style="height:30px;">
        <td  width="20%"><nobr><font size=4>经办人：</font></nobr></td>
        <td width="80%" align="left">
        <s:textfield type="text" id="legalApplicantQueryname" name="" style="border:0;background:transparent; width: 600px"/>
    </td>
  </tr>
     <tr style="height:30px;">
        <td  width="20%"><nobr><font size=4>日期：</font></nobr></td>
        <td width="80%" align="left">
        <s:textfield type="text" id="legalApplicantQueryname" name="" style="border:0;background:transparent; width: 600px"/>
    </td>
  </tr>
  <tr style="height:30px;"></tr>
</table>
<hr />
<br />
<br />
<br />
<div class="title">指派通知书</div>
<div class="soufan" style="width: 50%">
<s:textfield id="legalWord" name="legalCaseQuery.legalWord" type="text" style="border:none"/>
<font size=4>援申字</font>[<s:textfield id="legalCode" name="legalCaseQuery.legalCode" type="text" style="border:none"/>]<font size=4>第</font><s:textfield id="legalNo" name="legalCaseQuery.legalNo" type="text" style="border:none"/><font size=4>号</font></div>

 <table style="border:0;" width="50%"  cellspacing="0"  cellpadding="0" align="center" >
 
    <tr style="height:30px;">
    
    <td  width="30%"><input id="kindOfCrowd14" name="kindOfCrowdOther" type="text" class="sq_input" size="17" />：</td>
    <td  width="70%" align="left" >
        
    </td>
  </tr>
  <tr style="height:30px;">
      <td><div style="letter-spacing: 7px;"><nobr><font size=4>本中心(处)决定对<input id="kindOfCrowd14" name="kindOfCrowdOther" type="text" class="sq_input" size="25" />一案提供法律援助，现</font></nobr></div> </td>
  </tr>
    <tr style="height:30px;">
      <td><div style="letter-spacing: 7px;"><nobr><font size=4>指派你单位承办该案，自收到本通知书之日起<input id="kindOfCrowd15" name="kindOfCrowdOther1" type="text" class="sq_input" size="10" />个工作日内 </font></nobr></div></td>
  </tr>
    <tr style="height:30px;">
      <td><div style="letter-spacing: 7px;"><nobr><font size=4>安排合适承办人，并自安排之日起5个工作日内将承办人姓名和联系</font></nobr></div></td>
    </tr>
        <tr style="height:30px;">
      <td><div style="letter-spacing: 7px;"><nobr><font size=4>安排合适承办人，并自安排之日起5个工作日内将承办人姓名和联系</font></nobr></div></td>
    </tr>
     <tr style="height:30px;">
      <td><div style="letter-spacing: 7px;"><nobr><font size=4>方式告知受援人和本中心（处），与受援人或其法定代理人、近亲属</font></nobr></div></td>
    </tr>
     <tr style="height:30px;">
      <td><div style="letter-spacing: 7px;"><nobr><font size=4>签订委托代理辩护协议</font></nobr></div></td>
    </tr>
 </table>
 
 <table style="border:0;" width="50%"  cellspacing="0"  cellpadding="0" align="center" >

  <tr style="height:30px;">
    
    <td  width="30%"><nobr><font size=4>法律援助中心(处)：</font></nobr></td>
    <td  width="70%" align="left" >
        <s:textfield type="text" id="" name="" style="border:0;background:transparent; width: 600px"/>
    </td>
  </tr>
  <tr style="height:30px;">
        <td  width="30%"><nobr><font size=4>联系人：</font></nobr></td>
        <td  width="70%" align="left">
        <s:textfield type="text" id="legalApplicantQueryname" name="" style="border:0;background:transparent; width: 600px"/>
    </td>
  </tr >
   <tr style="height:30px;">
        <td width="30%" ><nobr><font size=4>联系方式：</font></nobr></td>
        <td width="70%" align="left">
        <s:textfield type="text" id="legalApplicantQueryname" name="" style="border:0;background:transparent; width: 600px"/>
    </td>
  </tr>
  <tr style="height:30px;"></tr>
  <tr style="height:30px;"></tr>
  <tr style="height:30px;"></tr>
     <tr style="height:30px;">
        <td width="30%" ></td>
        <td width="70%" style="text-align:right;" >
        	 <s:if test="legalCaseQuery.yinzhId!=null&&legalCaseQuery.yinzhId!=0">
		        <img id="imgYinz" alt="公章" src="${dynamicURL}/portal/uploadFileAction/downloadImage.do?fileId=${legalCaseQuery.yinzhId}" width="100px" height="100px" onclick="selectYinz();">
		    </s:if>
		    <s:else>
		        <img id="imgYinz" alt="公章" src="../legal/images/yinzhang.gif" width="100px" height="100px" onclick="selectYinz();">
		    </s:else>
        </td>
  </tr>
       <tr style="height:30px;">
        <td width="30%" ></td>
        <td width="70%" style="text-align:right;">
        <div style="letter-spacing: 7px;"><nobr><font size=4><input id="kindOfCrowd15" name="kindOfCrowdOther1" type="text" class="sq_input" size="10" />年<input id="kindOfCrowd15" name="kindOfCrowdOther1" type="text" class="sq_input" size="10" />月<input id="kindOfCrowd15" name="kindOfCrowdOther1" type="text" class="sq_input" size="10" />日 </font></nobr></div>
        </td>
  </tr>
  <tr>
    <td colspan="2" style="text-align:center;">
        <input type="button" value="打印" style="width: 60px;" onclick="dayin()" />
    </td>
  </tr>
</table>
</div>
<div id="yinzhangWin-window" class="earyui-window" title="选择印章" style="width: 550px; height: 350px; padding: 0px; background:#fafafa; "> 
	<table id="datagrid"></table>
</div>
<form action="" id="legalCaseEditForm">
	<input type="hidden" id="caseId" name="id" value="${legalCaseQuery.id}">
	<input type="hidden" id='yinzhId' name="yinzhId">
</form>
</body>
</html>
