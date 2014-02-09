<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>

<style type="">
	#dialog table td{ 
		border: 1px solid #b5b6b7;
		border-collapse: inherit;
		border-spacing:0px;
	}
</style>
<script type="text/javascript" charset="utf-8">
	var searchForm;
	var checkFinishSearch;
	var waitWorkDatagrid;
	var waitWorkFinishDatagrid;
	var orderConfirmAppid = null;
	$(function() {
		//未完成订单确认列表
		searchForm = $('#searchForm').form();
		checkFinishSearch = $('#checkFinishSearch').form();
		waitWorkDatagrid = $('#waitWorkDatagrid').datagrid({
			url : '${dynamicURL}/orderedit/orderEditAction!${taskMethod}.do',
			pagination : true,
			pageList : [10,15,20],
			fit : true,
			fitColumns : true,
			commonSort:true,
			remoteSort:true,
			nowrap : true,
			border : false,
			rownumbers:true,
			idField:'orderEditId',
			columns : [ [ 
			{field:'ck',checkbox:true},
			{
				field : 'batchNo',
				title : '申请单号',
				align : 'center',
				width:100,
				formatter : function(value, row, index) {
					//return row.orderEditId;
					return "<a href='javascript:void(0)' style='color:blue'  onclick='doTask("+ '"' + row.taskId + '"' + ")' >"+row.batchNo+"</a>";
				}
			},
			{
				field : 'orderEditItems',
				title : '明细',
				align : 'center',
				width:400,
				formatter : function(value, row, index) {
					if(value!=null){
						var text = "";
						for(var i = 0,l=value.length;i<l;i++){
							if(value[i]!=null){
								text = text + value[i].itemParentString+"-"+value[i].itemNameString+",";
							}
						}
						if(text.length>0){
							return '<span title="'+text+'">'+text+'</span>';
						}
					}
				}
			}, 
			{
				field : 'applyByName',
				title : '申请人',
				align : 'center',
				width:70,
				formatter : function(value, row, index) {
					return row.applyByName;
				}
			},
			{
				field : 'applyDate',
				title : '申请日期',
				align :'center',
				width:75,
				formatter : function(value, row, index){
					return dateFormatYMD(row.applyDate);
				}
			},
			{
				field : 'trace',
				title : '流程追踪',
				align : 'center',
				width : 80,
				formatter : function(value, row, index) {
					return "<a href='javascript:void(0)' style='color:blue'>流程跟踪</a>";
				}
			}
		] ],
		onClickCell:function(rowIndex, field, value){
			if(field == 'trace'){
				var obj=$(this).datagrid("getData").rows[rowIndex];
				traceImg(obj);
			}
		}	,
		onLoadSuccess : function(data) {
		}
		});
		//完成的任务
		waitWorkFinishDatagrid = $('#waitWorkFinishDatagrid').datagrid({
			url : '${dynamicURL}/orderedit/orderEditAction!${hisTaskMethod}.do',
			pagination : true,
			pageList : [10,15,20],
			fit : true,
			nowrap : true,
			border : false,
			singleSelect : true,
			rownumbers:true,
			fitColumns : true,
			idField:'orderEditId',
			columns : [ [ 
			{
				field : 'batchNo',
				title : '申请单号',
				align : 'center',
				width:100,
				formatter : function(value, row, index) {
					//return row.orderEditId;
					return "<a href='javascript:void(0)' style='color:blue' onclick='viewOrderEdit("+ '"' + row.batchNo + '",'+ '"' + row.orderCode + '"' + ")' >"+row.batchNo+"</a>";
				}
			},
			{
				field : 'orderEditItems',
				title : '明细',
				align : 'center',
				width:400,
				formatter : function(value, row, index) {
					if(value!=null){
						var text = "";
						for(var i = 0,l=value.length;i<l;i++){
							if(value[i]!=null){
								text = text + value[i].itemParentString+"-"+value[i].itemNameString+",";
							}
						}
						if(text.length>0){
							return '<span title="'+text+'">'+text+'</span>';
						}
					}
				}
			}, 
			{
				field : 'applyByName',
				title : '申请人',
				align : 'center',
				width:70,
				formatter : function(value, row, index) {
					return row.applyByName;
				}
			},
			{
				field : 'applyDate',
				title : '申请日期',
				align :'center',
				width:75,
				formatter : function(value, row, index){
					return dateFormatYMD(row.applyDate);
				}
			},
			{
				field : 'trace',
				title : '流程追踪',
				align : 'center',
				width : 80,
				formatter : function(value, row, index) {
					return "<a href='javascript:void(0)' style='color:blue'>流程跟踪</a>";
				}
			}			
   		] ],
		onClickCell:function(rowIndex, field, value){
			if(field == 'trace'){
				var obj=$(this).datagrid("getData").rows[rowIndex];
				traceImg(obj);
			}
		}
		
		});
		
		$('#dialog').dialog({  
		    title: '消息',  
		    width: 400,  
		    height: 200,  
		    closed: true,  
		    cache: false,  
		    modal: true,
		    buttons:[{
				text:'Close',
				handler:function(){$('#dialog').dialog("close")}
			}]
		});  
	});
    //未完成代办查询
	function _search() {
		waitWorkDatagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	//未完成代办重置
	function cleanSearch() {
		waitWorkDatagrid.datagrid('load', {});
		searchForm.form('clear');
	}
	//完成代办查询
	function _finishSearch() {
		waitWorkFinishDatagrid.datagrid('load', sy.serializeObject(checkFinishSearch));
	}
	//完成代办重置
	function FinishCleanSearch() {
		waitWorkFinishDatagrid.datagrid('load', {});
		checkFinishSearch.form('clear');
	}

	
	
	
	 
	function approval(){
		 var url="${dynamicURL}/orderedit/orderEditAction!doBatchApproval.do";
		 dosubmit(url);
	 }
	 function reject(){
		 var url="${dynamicURL}/orderedit/orderEditAction!doBatchReject.do";
		 dosubmit(url);
	 }
	 function dosubmit(url){
		 var rows = waitWorkDatagrid.datagrid("getSelections");
		 if(rows==null || rows.length<1){
			 $.messager.show({
					title : '提示',
					msg : '请至少选择一条任务'
			});
		 }else{
			 var taskIds = "";
			 for(var i = 0,l=rows.length-1;i<l;i++){
				 taskIds =taskIds+rows[i].taskId+","; 
			 }
			 taskIds = taskIds+rows[rows.length-1].taskId;
			 $.messager.progress({
					text : '正在提交....',
					interval : 100
			});
			 $.ajax({
			     url:url,
			     dataType:"json",
			     type:'post',
			     data:{
			    	 taskIds : taskIds	 
			     },
			     success:function(data){
			    	 $.messager.progress('close');
		 			 if(data.success){
		 				if(data.obj!=null){
			 				var resultFail ="";
			 				var resultSuc ="";
		 					for(var m in data.obj){
		 						var editOrderId = "";
		 						for(var i=0,l=rows.length;i<l;i++){
		 							if(rows[i].taskId == m){
		 								editOrderId = rows[i].orderEditId;
		 								break;
		 							}
		 						}
		 						if(data.obj[m] =='success'){
		 							resultSuc = resultSuc + editOrderId + " | ";		
		 						}else{
		 							resultFail = resultFail + editOrderId + " | ";
		 						}	
		 					}
		 					if(resultFail.length<1){
		 						$.messager.show({
									title : '提示',
									msg : '任务处理完成！'
								});	 						
		 					}else{
			 					$($("#successTd td").get(1)).html(resultSuc);
			 					$($("#failTd td").get(1)).html(resultFail);
			 					$('#dialog').dialog("open");
		 					}
		 				}
		 				reloaddata();
		 			 }else{
		 				$.messager.show({
							title : '提示',
							msg : '任务处理失败！'
						});
		 			 }
			     }
			});	 
		 }
		  
	 } 
	
	
	function doTask(taskId){
		parent.window.HROS.window.createTemp({
			title:"待办任务 -商务调度单",
			url:"${dynamicURL}/orderedit/orderEditAction!goApproval.do?taskId="+taskId,
			width:800,height:400,isresize:false,isopenmax:true,isflash:false,customWindow:window});
	}
	function viewOrderEdit(batchNo,orderCode){
		parent.window.HROS.window.createTemp({
			title:"申请单号："+batchNo+"-订单号:"+orderCode+"-商务调度单",
			url:"${dynamicURL}/orderedit/orderEditAction!viewOrderEdit.do?batchNo="+batchNo,
			width:800,height:400,isresize:true,isopenmax:true,isflash:false});
	}
	
	//刷新代办和已完成代办
	function reloaddata() {
		waitWorkDatagrid.datagrid('unselectAll');
		waitWorkDatagrid.datagrid('reload');
		waitWorkFinishDatagrid.datagrid('reload');
		parent.window.showTaskCount();
	}
	function traceImg(obj){
		parent.window.HROS.window.createTemp({
			title:obj.taskName+"-订单号:"+obj.orderCode+"-流程图",
			url:"${dynamicURL}/workflow/processAction!goTrace.do?processInstanceId="+obj.processinstanceId,
			width:800,height:400,isresize:false,isopenmax:true,isflash:false});
	}
	//跳转到订单全景图页面
	function showPanorama(id,orderType) {
		var url = '${dynamicURL}/salesOrder/salesOrderAction!panoramaShow.action?orderCode=' + id + '&orderType=' + orderType;
		parent.window.HROS.window.createTemp({
			title:"订单全景图-订单号"+id,
			url:url,
			width:800,height:400,isresize:false,isopenmax:true,isflash:false});
	}
</script>
</head>
<body>
<div  class="easyui-tabs"  data-options="fit:true">
			<s:if test="%{queryTaskKey == 'businessmanagerCheck'}">
	   			<div title="商务调度单-商务中心审核待办"> 	
	   		</s:if>
	   		<s:elseif test="%{queryTaskKey == 'hurdleCheck'}">
	   			<div title="商务调度单-闸口人员审核待办">
	   		</s:elseif>
	   		<s:elseif test="%{queryTaskKey == 'businessmanagerConfirm'}">
	   			<div title="商务调度单-商务中心确认待办">
	   		</s:elseif>
        <div id="checkSearch" class="easyui-layout" data-options="fit:true">
             <div class="zoc" region="north" border="false"   collapsed="false" style="height: ${queryTaskKey == 'businessmanagerConfirm'?'50':'70'}px; overflow: auto;">
                 <form id="searchForm">
					<div class="part_zoc" style="min-width: ${queryTaskKey != 'businessmanagerConfirm'?'730':'970'}px;">
						<div class="oneline">
							<div class="item25">
								<div class="itemleft60">申请单号：</div>
								<div class="righttext">
									<input id="batchNo" name="batchNo"  type="text"  class="short50"/>
								</div>
							</div>
							<div class="item25">
								<div class="itemleft60">订单编号：</div>
								<div class="righttext">
									<input id="orderCode" name="orderCode"  class="orderAutoComple" type="text"  class="short50" />
								</div>
							</div>
							<div class="item25 lastitem">
								<div class="itemleft80">申请人：</div>
								<div class="righttext">
									<input id="applyBy" name="applyByName"  class="short50"  type="text" />
								</div>
							</div>
							<s:if test="%{queryTaskKey == 'businessmanagerConfirm'}">
								<div class="item25 lastitem" >
									<div class="oprationbutt">
								        <input type="button" value="查  询" onclick="_search();"/>
								        <input type="button" value="重  置"  onclick="cleanSearch();"/>
							        </div>
								</div>
							</s:if>
						</div>
						 <s:if test="%{queryTaskKey != 'businessmanagerConfirm'}">
						<div>
							<div class="item50 lastitem">
								<div class="oprationbutt">
							        <input type="button" value="查  询" onclick="_search();"/>
							        <input type="button" value="重  置"  onclick="cleanSearch();"/>
							        <s:if test="%{queryTaskKey == 'hurdleCheck'}">
                                        <input type="button" value="批量通过"  onclick="approval();"/>
                                        <input type="button" value="批量驳回"  onclick="reject();"/>
                                    </s:if>
						       </div>
							</div>
						</div>
						</s:if>
					</div>
				</form>
             </div>
             <div region="center" border="false">
				<table id="waitWorkDatagrid"></table>
			</div>
        </div>
    </div>
    <div title="已完成待办">
        <div id="checkFinishSearchDIV" class="easyui-layout" data-options="fit:true">
            <div class="zoc" region="north" border="false"  collapsed="false" style="height: 50px; overflow: hidden;">
                <form id="checkFinishSearch">
					<div class="part_zoc">
					<div class="oneline">
							<div class="item25">
								<div class="itemleft60">申请单号：</div>
								<div class="righttext">
									<input id="batchNo" name="batchNo"  type="text"  class="short50"
										 />
								</div>
							</div>
							<div class="item25">
								<div class="itemleft60">订单编号：</div>
								<div class="righttext">
									<input id="orderCode" name="orderCode"  class="orderAutoComple" type="text"  class="short50"
										 />
								</div>
							</div>
							<div class="item25">
								<div class="itemleft80">申请人：</div>
								<div class="righttext">
									<input id="applyBy" name="applyByName"  class="short50"  type="text" />
								</div>
							</div>
							<div class="item25 lastitem" >
								<div class="oprationbutt">
							        <input type="button" value="查  询" onclick="_finishSearch();"/>
							        <input type="button" value="重  置"  onclick="FinishCleanSearch();"/>
						        </div>
							</div>
						</div>
					</div>
				</form>
            </div>
            <div region="center" border="false">
			    <table id="waitWorkFinishDatagrid"></table>
		    </div>
        </div>
    </div>
</div>
<div id="dialog" style="width:300px;height:200px;">
	<table style="width: 100%">
		<tr style="height: 55px" id="successTd"><td width="50">完成的申请单:</td><td width="150"></td></tr>
		<tr style="height: 55px" id="failTd"><td>失败的申请单:</td><td></td></tr>
	</table>
</div>  
</body>
</html>