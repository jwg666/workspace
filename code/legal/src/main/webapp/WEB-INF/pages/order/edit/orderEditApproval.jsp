<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<style>
.mainGrid .datagrid-header td,.mainGrid .datagrid-body td, .mainGrid .datagrid-footer td {
	border-style: solid;
	border-width: 0 1px 0 0;
}
.subGrid .datagrid-header td, .subGrid .datagrid-body td , .subGrid .datagrid-footer td {
	border-style: dotted;
	border-width: 0 1px 1px 0;
}
</style>
<script type="text/javascript">
$(function(){
	$(window).on('resize', function(){
		$("#orderEditGrid").datagrid("resize");
	});
	/* $("#redoTask").datagrid("loadData",jsonString.redoList);
	$("#userGrid").datagrid("loadData",jsonString.userCheckList); */
	$("#orderEditGrid").datagrid({
		view: detailview,
		url:"${dynamicURL}/orderedit/orderEditAction!showOrderEditDetail.do?batchNo=${batchNo}",
		columns : [[ 
		 			//{field : 'batchNo',title : '申请单号',width:250},
		 			{field : 'orderCode',title : '订单号',width:100},
		 			//{field : 'applyByName',title : '申请人',width:250},
		 			/* {field : 'applyDate',title : '申请日期',width:200,
						formatter : function(value, row, index){
							return dateFormatYMD(row.applyDate);
						}
					} */
					
					{field : 'orderDealType',title : '成交方式',width:60,formatter:function(value,row,index){return row.salesOrderQuery.orderDealType}},
					{field : 'orderShipDate',title : '出运时间',width:75,formatter:function(value,row,index){return row.salesOrderQuery.orderShipDate}},
					{field : 'orderSoldTo',title : '售达方',width:80,formatter:function(value,row,index){return row.salesOrderQuery.orderSoldTo}},
					{field : 'tcount',title : '调T次数',width:60,formatter:function(value,row,index){return value;}},
					
					{field : 'actSets1',title : '订单确认',width:75,formatter:function(value,row,index){return actSetFormat(value,row,index,"salesOrderConfirm")}},
					{field : 'actSets2',title : '订单审核',width:75,formatter:function(value,row,index){return actSetFormat(value,row,index,"businessManagerSalesOrder")}},
					{field : 'actSets3',title : '分备货单',width:75,formatter:function(value,row,index){return actSetFormat(value,row,index,"prepareOrder")}},
					{field : 'actSets4',title : '计划排定',width:75,formatter:function(value,row,index){return actSetFormat(value,row,index,"scheduling")}},
					{field : 'actSets5',title : '付款保障',width:75,formatter:function(value,row,index){return actSetFormat(value,row,index,"payMoney")}},
					{field : 'actSets6',title : '订舱',width:75,formatter:function(value,row,index){return actSetFormat(value,row,index,"subProcessBookCabin")}},
					{field : 'actSets7',title : '制单',width:75,formatter:function(value,row,index){return actSetFormat(value,row,index,"comprehensiveOrderTask")}},
					{field : 'actSets8',title : '报关',width:75,formatter:function(value,row,index){return actSetFormat(value,row,index,"declarationApply")}},
					{field : 'actSets9',title : '出运',width:75,formatter:function(value,row,index){return actSetFormat(value,row,index,"shipMent")}},
					{field : 'actSets0',title : '议付',width:75,formatter:function(value,row,index){return actSetFormat(value,row,index,"subProcessNego")}},
					{field : 'actSets10',title : '导GVS',width:75,formatter:function(value,row,index){return actSetFormat(value,row,index,"exportHGVS")}}
		 			
		 ]],
		 rowStyler: function(index,row){
                return 'background-color:rgb(154, 200, 238);font-weight:bold;';
                //return 'font-weight:bold;';
         },
		 detailFormatter:function(index,row){
             return '<div style="width:850px;float:left;margin-right:30px" class="subGrid"><table id="ddv-' + index + '"></table></div><div style="width:300px;float:left"><table id="ddv1-' + index + '"></table></div>';
         },
		 onExpandRow: function(index,row){
             $('#ddv-'+index).datagrid({
            	 data:row.orderEditItems,
                 fitColumns:true,
                 rownumbers:true,
                 loadMsg:'',
                 height:'auto',
                 columns:[[
                     {field:'itemParentString',title:'修改大项',width:100},
                     {field:'itemNameString',title:'修改小项',width:100},
                     {field:'editReasonString',title:'修改原因',width:100},
                     {field:'itemBeforeValue',title:'修改前',width:200},
                     {field:'itemAfterValue',title:'修改后',width:200}
                 ]],
                 onResize:function(){
                     $('#orderEditGrid').datagrid('fixDetailRowHeight',index);
                 },
                 onLoadSuccess:function(){
                     setTimeout(function(){
                         $('#orderEditGrid').datagrid('fixDetailRowHeight',index);
                     },0);
                 }
             });
             var json = row.other;
             if(json!=null&&json.length>0){
            	 json = $.parseJSON(json);
             }else{
            	 json = {"redoList":[]};
             }
             $('#ddv1-'+index).datagrid({
                 fitColumns:true,
                 rownumbers:true,
                 loadMsg:'',
                 height:json.redoList.length>5?150:'auto',
                 data:json.redoList,
                 columns:[[
                     {field:'name',title:'活动名称',width:100},
                     {field:'end',title:'完成时间',width:100}
                 ]],
                 onResize:function(){
                     $('#orderEditGrid').datagrid('fixDetailRowHeight',index);
                 },
                 onLoadSuccess:function(){
                     setTimeout(function(){
                         $('#orderEditGrid').datagrid('fixDetailRowHeight',index);
                     },0);
                 }
             });
             $('#orderEditGrid').datagrid('fixDetailRowHeight',index);
         },
         onLoadSuccess:function(data){
        	 if(data.rows.length > 0){
        		 var json = data.rows[0].other;
        		 var remark = data.rows[0].remark;
        		 if(json!=null&&json.length>0){
                	 json = $.parseJSON(json);
                 }else{
                	 json = {"userCheckList":[]};
                 }
        		 $("#userGrid").datagrid("loadData",json.userCheckList);
        		 $("#id_applyByName").val(data.rows[0].applyByName);
        		 $("#id_applyDate").val(data.rows[0].applyDateString);
        		 $("#remarkDiv").text(remark);
        		 if(data.rows[0].appendix&&data.rows[0].appendix!='null'&&data.rows[0].appendix!=''){
        		 $("#appendix").html('<strong>附件：</strong><a style="color: blue" target="_blank" href="${dynamicURL}/basic/fileUploadAction/downloadFile.do?fileId='+data.rows[0].appendix+'">下载</a>');
        		 }
        		 for(var i = 0,l = data.rows.length;i<l;i++){
        			 $(this).datagrid("expandRow",i);
        		 }
        	 }
         }
         
	});
});
	

function approval(){
	 var url="${dynamicURL}/orderedit/orderEditAction!doApproval.do";
	 dosubmit(url);
}
function reject(){
	 var url="${dynamicURL}/orderedit/orderEditAction!doReject.do";
	 dosubmit(url);
}
function dosubmit(url){
	
	 var appraiseContent = "";
	 if($("#id_appraiseContent").size()>0){
		 appraiseContent = $("#id_appraiseContent").val();
	 }
	 var taskId = $("#id_task").val();
	 $.messager.progress({
			text : '正在提交....',
			interval : 100
	 });
	 $.ajax({
	     url:url,
	     dataType:"json",
	     type:'post',
	     data:{
	    	 appraiseContent:appraiseContent,
	    	 taskId : taskId	 
	     },
	     success:function(data){
	    	 $.messager.progress('close');
			 if(data.success){
				$(".handelDiv").hide();
				customWindow.reloaddata();
				$.messager.show({
					title : '提示',
					msg : '任务完成！'
				});
			 }else{
				$.messager.show({
					title : '提示',
					msg : '任务处理失败！'+data.msg
				});
			 }
	     }
	}); 
} 
	
 function resultFormat(value,row,index){
	 if(value == '0')return "驳回";
	 else if(value == '1') return "通过";
 } 
 function roleFormat(value,row,index){
	 if(value == '0')return "商务评审";
	 else if(value == '1') return "闸口评审";
	 else if(value == '2') return "商务确认";
 } 
 function actSetFormat(value,row,index,actId){
	 var val = row.actSets;
	 if(val != null && typeof val != "string" ){
		 for(var i=0,l=val.length;i<l;i++){
			 if(val[i] != null && val[i].actId==actId){
				 return dateFormatYMDHMS(val[i].actualFinishDate);
			 }
		 }
	 }
 }
 function dateFormatYMDHMS(date) {
	if (date != null && date.length > 0) {
		date = date.substring(0,10);
	}
	return date;
}

</script>
<style type="">
.part_zoc{
	margin-bottom: 2px;
}
</style>
</head>
<body class="zoc">
	   <div class="part_zoc mainGrid" style="min-width:1000px">
	   		<div class="navhead_zoc"><span>
	   		<s:if test="%{queryTaskKey == 'businessmanagerCheck'}">
	   			商务中心审核商务调度单	
	   		</s:if>
	   		<s:elseif test="%{queryTaskKey == 'hurdleCheck'}">
	   			闸口人员审核商务调度单	
	   		</s:elseif>
	   		<s:elseif test="%{queryTaskKey == 'businessmanagerConfirm'}">
	   			商务中心确认商务调度单	
	   		</s:elseif>
	   		</span></div>
		   	<div class="partnavi_zoc">
				<span>▼商务调度单明细：</span>
			</div>
			<table id="orderEditGrid"></table>
	 </div>
	 
	 <div class="part_zoc" style="min-width:1000px">
		<div class="partnavi_zoc">
			<span>商务调度单描述：</span>
		</div>
		<div style="height: 200px;width: 100%;" >
			<div style="float: left;width: 250px;height: 100%;margin-right: 5px">
				<%-- <table class="easyui-datagrid" title="修改项" 
					data-options="rownumbers:true,singleSelect:true,collapsible:true,fit:true,fitColumns:true,url:'${dynamicURL}/orderedit/orderEditAction!findOrderEditItem.do?id=${id}'">
					<thead>
						<tr>
							<th data-options="field:'itemParentString',width:80">修改大项</th>
							<th data-options="field:'itemNameString',width:80">修改小项</th>
							<th data-options="field:'editReasonString',width:100">修改原因</th>
							<th data-options="field:'itemBeforeValue',width:80,align:'right'">修改前</th>
							<th data-options="field:'itemAfterValue',width:80,align:'right'">修改后</th>
						</tr>
					</thead>
				</table> --%>
				<table class="easyui-datagrid"  id="userGrid"  title="审批人员"
					data-options="singleSelect:true,collapsible:true,fit:true,fitColumns:true,url:''">
					<thead>
						<tr>
							<th data-options="field:'empCode',width:80">用户编码</th>
							<th data-options="field:'name',width:70">用户名</th>
							<th data-options="field:'groupName',width:100">权限组</th>
						</tr>
					</thead>
				</table>
			</div>
			<div style="float: left;width: 550px;height: 100%;margin-right: 5px">
				<!-- <table class="easyui-datagrid" title="重做节点"  id="redoTask"
					data-options="singleSelect:true,collapsible:true,fit:true,fitColumns:true,rownumbers:true,">
					<thead>
						<tr>
							<th data-options="field:'name',width:80">活动名称</th>
							<th data-options="field:'end',width:80,align:'right'">完成时间</th>
						</tr>
					</thead>
				</table> -->
				<table class="easyui-datagrid"  title="审批结果"
					data-options="rownumbers:true,singleSelect:true,collapsible:true,fit:true,fitColumns:true,url:'${dynamicURL}/orderedit/orderEditAction!findAppraiseItem.do?batchNo=${batchNo}'">
					<thead>
						<tr>
							<th data-options="field:'appraiseManName',width:60">审批人</th>
							<th data-options="field:'appraiseRole',width:60,formatter:roleFormat">审批节点</th>
							<th data-options="field:'passFlag',width:30,formatter:resultFormat">结果</th>
							<th data-options="field:'createDate',width:70,align:'left'">审批时间</th>
							<th data-options="field:'appraiseContent',width:280,align:'left'">审批意见</th>
						</tr>
					</thead>
				</table>
			</div>
			<div style="float:none;min-width: 250px;height: 100%;border-left: 1px solid #b5b6b7;z-index: -1" >
				<div class="panel-header" style="margin-left: 810px">
					<div class="panel-title">订单修改申请描述</div>
				</div>
				<div class="panel-body" style="height:145px;overflow: auto" id="remarkDiv">
				</div>
				
					<div  id="appendix" style="padding-top: 3px">
						
					</div>
			</div>
		</div>
	</div>
	
	
		<div class="part_zoc" style="min-width:1000px">
			<div class="partnavi_zoc">
				<span>审批：</span>
			</div>
			<form id="orderEditForm">
				<div style="height: 105px;width: 100%;">
					<div style="float: left;width: 600px;height: 100%">
						<div class="panel-header" style="width:100%;padding:0px;" >
								<div class="panel-title">审批意见</div>
						</div>
						<div class="panel-body" style="height:100%;width:100%">
							<textarea id="id_appraiseContent" name="appraiseContent" class="mod1" style="height:100%;width:100%"></textarea>
						</div>
					</div>
					<div style="float:none;min-width: 400px;height: 100%;border-left: 1px solid #b5b6b7;z-index: -1" >
						<div class="oneline">
							<div class="item33 lastitem" >
								<div class="itemleft100">申请人：</div>
								<div class="righttext"><input class="short80" disabled="true" id="id_applyByName" type="text" value="${applyByName}" /></div>
							</div>
						</div>
						<div class="oneline">
							<div class="item33 lastitem" >
								<div class="itemleft100">申请时间：</div>
								<div class="righttext"><input class="short80" disabled="true" id="id_applyDate" type="text" value="${applyDateString }"></div>
							</div>
						</div>
						<div class="oneline">
							<div class="item66 lastitem" >
								<div class="oprationbutt handelDiv" style="text-align: left;" >
									<input id="id_task" type="hidden" name="taskId" value="${taskId}" />
									<s:if test="%{queryTaskKey == 'businessmanagerConfirm'}">
										<input type="button" onclick="reject()" value="驳  回">
										<input type="button" onclick="approval()" value="确  认"> 
										<span style="color:red;font-size:12px">确保在SAP系统中已经把订单修改完成后点击 "确认" 按钮完成任务！</span>
									</s:if>
									<s:else>
										<input type="button" onclick="approval()" value="通  过">
										<input type="button" onclick="reject()" value="驳  回">
									</s:else>
								</div>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	
	
		
</body>
</html>