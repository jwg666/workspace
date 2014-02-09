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
	var waitWorkDatagrid;
	$(function() {
		//我发起的订单修改申请
		searchForm = $('#searchForm').form();
		waitWorkDatagrid = $('#waitWorkDatagrid').datagrid({
			url : '${dynamicURL}/orderedit/orderEditAction!myOrderedit.do',
			pagination : true,
			pageList : [10,15,20],
			fit : true,
			singleSelect:true,
			fitColumns : true,
			nowrap : true,
			border : false,
			rownumbers:true,
			idField:'id',
			commonSort:true,
			remoteSort:true,
			columns : [ [ 
			{field:'ck',checkbox:true},
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
				field : 'orderCode',
				title : '订单号',
				align : 'center',
				width:100,
				formatter : function(value, row, index) {
					return "<a href='javascript:void(0)' style='color:blue' onclick='showPanorama(\""+row.orderCode+"\",\""+row.orderType+"\")'> "+row.orderCode+"</a>";
				}
			}, 
			 
			{
				field : 'applyByName',
				title : '申请人',
				align : 'center',
				width:100,
				formatter : function(value, row, index) {
					return row.applyByName;
				}
			},
			{
				field : 'applyDate',
				title : '申请日期',
				align :'center',
				width:100,
				formatter : function(value, row, index){
					return dateFormatYMD(row.applyDate);
				}
			},
			{
				field : 'state',
				title : '状态',
				align :'center',
				width:100,
				formatter : function(value, row, index){
					return row.statusInfo;
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
			,
			{
				field : 'reDo',
				title : '操作',
				align : 'center',
				width : 80,
				formatter : function(value, row, index) {
					if(row.status=='reject')
					return "<a href='javascript:void(0)' onclick='reApply(\""+row.batchNo+"\",\""+row.batchNo+"\")' style='color:blue'>重新发起申请</a>";
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
		
		$("#status").combobox({
			data: [{
				label: '正在审批',
				value: 'approval'
			},{
				label: '修改成功',
				value: 'success'
			},{
				label: '驳回',
				value: 'reject'
			}],
			valueField:'value',
			textField:'label',
			panelHeight:105
		});

		
	});
	
	function reApply(batchNo,orderCode){
						top.window.HROS.window.createTemp({
							title:"发起商务调度单",
							url:"${dynamicURL}/orderedit/orderEditAction!goReApplyOrderEdit.do?batchNo="+batchNo,
							width:800,height:400,isresize:true,isopenmax:true,isflash:false});
		
	 }
    //未完成代办查询
	function _search() {
		waitWorkDatagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	//未完成代办重置
	function cleanSearch() {
		waitWorkDatagrid.datagrid('load', {});
		searchForm.form('clear');
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
			title:"订单号:"+obj.orderCode+"-流程图",
			url:"${dynamicURL}/workflow/processAction!goTrace.do?processInstanceId="+obj.proinstId,
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
<body class="easyui-layout" data-options="fit:true">
             <div class="zoc" region="north" border="false"   collapsed="false" style="height: ${queryTaskKey == 'businessmanagerConfirm'?'50':'70'}px; overflow: auto;">
                 <form id="searchForm">
					<div class="part_zoc">
						<div class="oneline">
							<div class="item25">
								<div class="itemleft60">申请单号：</div>
								<div class="righttext">
									<input  name="batchNo"  type="text"  class="short50"/>
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
							<div class="item25 lastitem">
								<div class="itemleft80">申请单状态：</div>
								<div class="righttext">
									<input id="status" name="status"  class="short50"  type="text" />
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
   
</body>
</html>