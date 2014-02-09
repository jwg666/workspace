<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="/struts-jquery-tags" prefix="sj"%>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
var searchForm;
var searchHistoricForm;
var datagrid;
var showErrorDialog;
var myJson;
$(function() {
	//查询列表	
	searchForm = $('#searchForm').form();
	searchHistoricForm = $('#searchHistoricForm').form();
	datagridList = $('#datagridList').datagrid({
		url : 'prepareOrderAction!prepareRollplanReleaseList.action',
		title : '滚动计划闸口待办任务列表',
		iconCls : 'icon-save',
		pagination : true,
		pagePosition : 'bottom',
		rownumbers : true,
		pageSize : 10,
		height : 500,
		pageList : [ 10, 20, 30, 40 ],
		fitColumns : true,
		nowrap : true,
		border : false,
		idField : 'orderCode',
		columns : [ [ {
			field : 'ck',
			checkbox : true,
			formatter : function(value, row, index) {
				return row.orderCode;}
						},{
			field : 'taskId',
			title : 'TaskId',
			hidden : true,
			align : 'center',
			sortable : true,
			formatter : function(value, row, index) {
				return row.taskId;}
						},{
			field : 'actPrepareCode',
			title : '序号',
			align : 'center',
			width : 15,
			sortable : true,
			formatter : function(value, row, index) {
				return ++index;}
						}, {
			field : 'orderCode',
			title : '订单号',
			align : 'center',
			width : 35,
			sortable : true,
			formatter : function(value, row, index) {
				return "<a href='javascript:void(0)' id='tooltip_"
						+ row.orderCode
						+ "' class=\"easyui-tooltip\" style='color:blue'   onclick='addprepareOrderByOrderCode(\""
						+ row.orderCode + "\",\""
						+ row.taskId + "\")' >"
						+ row.orderCode + "</a>";
			}
						}, {
			field : 'deptNameCn',
			title : '工厂',
			align : 'center',
			width : 70,
			sortable : true,
			formatter : function(value, row, index) {
				return row.deptNameCn;
				}
						}, {
			field : 'deptname',
			title : '经营体',
			align : 'center',
			width : 30,
			sortable : true,
			formatter : function(value, row, index) {
					return row.deptname;}
						}, {
			field : 'countryName',
			title : '出口国家',
			align : 'center',
			width : 30,
			sortable : true,
			formatter : function(value, row, index) {
					return row.countryName;
					}
						},  {
			field : 'orderShipDate',
			title : '备单生产时间',
			align : 'center',
			width : 30,
			sortable : true,
			formatter : function(value, row, index) {
					return dateFormatYMD(row.orderShipDate);
					}
						}, {
			field : 'itemNameCn',
			title : '市场区域',
			align : 'center',
			width : 30,
			sortable : true,
			formatter : function(value, row, index) {
				return row.itemNameCn;
							}
						},  {
			field : 'orderexecmanager',
			title : '订单经理',
			align : 'center',
			width : 30,
			sortable : true,
			formatter : function(value, row, index) {
				return row.orderexecmanager;
							}
						}, {
			field : 'managerName',
			title : '产品经理',
			align : 'center',
			width : 30,
			sortable : true,
			formatter : function(value, row, index) {
				return row.managerName;
							}
						}, {
			field : 'releaseFlag',
			title : '闸口状态',
			align : 'center',
			width : 20,
			sortable : true,
			formatter : function(value, row, index) {
				return row.releaseFlag;
							}
						} ,{
			field : 'message',
			title : '申请原因',
			align : 'center',
			width : 30,
			sortable : true,
			formatter : function(value, row, index) {
				return row.message;
							}
						} ,{
			field : 'addirmnum',
			title : '下载附件',
			align : 'center',
			width : 30,
			sortable : true,
			formatter : function(value, row, index) {
				return "<a href='javascript:void(0)' id='tooltip_"
						+ row.addirmnum
						+ "' class=\"easyui-tooltip\" style='color:blue'   onclick='dowlandFile(\""
						+ row.addirmnum + "\")' >"
						+ row.addirmnum + "</a>";
							}
						} ] ],
					});
	
	
	datagrid = $('#datagrid').datagrid({
		url : 'prepareOrderAction!prepareRollplanRelease.action',
		title : '滚动计划闸口待办任务列表',
		iconCls : 'icon-save',
		pagination : true,
		pagePosition : 'bottom',
		rownumbers : true,
		pageSize : 10,
		height : 500,
		pageList : [ 10, 20, 30, 40 ],
		fitColumns : true,
		nowrap : true,
		border : false,
		idField : 'orderCode',
		columns : [ [ {
			field : 'ck',
			checkbox : true,
			formatter : function(value, row, index) {
				return row.orderCode;}
						},{
			field : 'taskId',
			title : 'TaskId',
			hidden : true,
			align : 'center',
			sortable : true,
			formatter : function(value, row, index) {
				return row.taskId;}
						},{
			field : 'actPrepareCode',
			title : '序号',
			align : 'center',
			width : 15,
			sortable : true,
			formatter : function(value, row, index) {
				return ++index;}
						}, {
			field : 'orderCode',
			title : '订单号',
			align : 'center',
			width : 35,
			sortable : true,
			formatter : function(value, row, index) {
				return "<a href='javascript:void(0)' id='tooltip_"
						+ row.orderCode
						+ "' class=\"easyui-tooltip\" style='color:blue'   onclick='addprepareOrderByOrderCode(\""
						+ row.orderCode + "\",\""
						+ row.taskId + "\")' >"
						+ row.orderCode + "</a>";
			}
						}, {
			field : 'deptNameCn',
			title : '工厂',
			align : 'center',
			width : 70,
			sortable : true,
			formatter : function(value, row, index) {
				return row.deptNameCn;
				}
						}, {
			field : 'deptname',
			title : '经营体',
			align : 'center',
			width : 30,
			sortable : true,
			formatter : function(value, row, index) {
					return row.deptname;}
						}, {
			field : 'countryName',
			title : '出口国家',
			align : 'center',
			width : 30,
			sortable : true,
			formatter : function(value, row, index) {
					return row.countryName;
					}
						},  {
			field : 'orderShipDate',
			title : '备单生产时间',
			align : 'center',
			width : 30,
			sortable : true,
			formatter : function(value, row, index) {
					return dateFormatYMD(row.orderShipDate);
					}
						}, {
			field : 'itemNameCn',
			title : '市场区域',
			align : 'center',
			width : 30,
			sortable : true,
			formatter : function(value, row, index) {
				return row.itemNameCn;
							}
						},  {
			field : 'orderexecmanager',
			title : '订单经理',
			align : 'center',
			width : 30,
			sortable : true,
			formatter : function(value, row, index) {
				return row.orderexecmanager;
							}
						}, {
			field : 'managerName',
			title : '产品经理',
			align : 'center',
			width : 30,
			sortable : true,
			formatter : function(value, row, index) {
				return row.managerName;
							}
						}, {
			field : 'releaseFlag',
			title : '闸口状态',
			align : 'center',
			width : 20,
			sortable : true,
			formatter : function(value, row, index) {
				return row.releaseFlag;
							}
						} ,{
			field : 'message',
			title : '申请原因',
			align : 'center',
			width : 30,
			sortable : true,
			formatter : function(value, row, index) {
				return row.message;
							}
						} ,{
			field : 'addirmnum',
			title : '下载附件',
			align : 'center',
			width : 30,
			sortable : true,
			formatter : function(value, row, index) {
				return "<a href='javascript:void(0)' id='tooltip_"
						+ row.addirmnum
						+ "' class=\"easyui-tooltip\" style='color:blue'   onclick='dowlandFile(\""
						+ row.addirmnum + "\")' >"
						+ row.addirmnum + "</a>";
							}
						} ] ],
			toolbar : [ {
							text : '释放',
							iconCls : 'icon-edit',
							handler : function() {
								outReleaseFlag();
							}
						}, '-',{
							text : '拒绝',
							iconCls : 'icon-edit',
							handler : function() {
								goBackDialog();
							}
						}, '-', '-',{
							text : '批量拒绝',
							iconCls : 'icon-edit',
							handler : function() {
								goBackDialogList();
							}
						}, '-'],
					});
		showErrorDialog = $('#showErrorDialog').show().dialog({
			title : '拒绝原因',
			modal : true,
			closed : true,
			maximizable : true,
			width : 450,
			height : 150,
			buttons : [{
				text : '完成',
				iconCls : 'icon-edit',
				handler : function() {
					goBackReleaseFlag();
				}
			} ]
		});
	});
	
//以后要改成批量释放
function outReleaseFlag() {
	$.messager.progress({
			text : '数据释放中....',
			interval : 100
		});
	var rows = $('#datagrid').datagrid('getChecked');
	for(var i = 0; i<rows.length; i++){
	    $.ajax({
		    url : 'prepareOrderAction!releaseRollFlag.do',
		    data : {
			    orderCodes : rows[i].orderCode + "," + rows[i].actPrepareCode + "," +rows[i].taskId
			},
		    dataType : 'json',
		    cache : false,
		    success : function(){
		    	$.messager.progress('close');
		    	datagrid.datagrid('unselectAll');
		    	datagrid.datagrid('reload');
		    	top.window.showTaskCount();
		    }
	     });
	}
	$.messager.progress('close');
}		

//拒绝原因对话框
function goBackDialog(){
	var rows = $('#datagrid').datagrid('getChecked');
	if(rows.length == 1){
		showErrorDialog.dialog('open');
	}else{
		$.messager.alert('提示', '请选择一条数据!', 'error');
	}
	
}

//单个写明原因回滚到备货单
function goBackReleaseFlag() {
	var rows = $('#datagrid').datagrid('getChecked');
	var titles = $("#titleName").val();
	if(titles == ""){
		$.messager.alert('提示', '请填写拒绝原因!');
	}else{ 
		$.ajax({
			url : 'prepareOrderAction!releaseBackRollFlag.do',
			data : {
				orderCodes : rows[0].orderCode + "," + rows[0].actPrepareCode + "," +rows[0].taskId + "," + titles
			},
			dataType : 'json',
			cache : false,
			async : false
		});
		datagrid.datagrid('unselectAll');
		datagrid.datagrid('load',{});
		top.window.showTaskCount();
		$.messager.show({title : '提示', msg : '数据被拒绝成功!'});
	}
	showErrorDialog.dialog('close');
}
//批量写明原因回滚到备货单
function goBackDialogList(){
	var rows = $('#datagrid').datagrid('getChecked');
	if(rows.length == 0){
		$.messager.alert('提示', '请先选择要操作数据!');
	}else{
		for(var i = 0; i < rows.length; i++){
			$.ajax({
				url : 'prepareOrderAction!releaseBackRollFlagList.do',
				data : {
					orderCodes : rows[i].orderCode + "," + rows[i].actPrepareCode + "," +rows[i].taskId + ","
				},
				dataType : 'json',
				cache : false,
				async : false,
				success : function(){
					
				}
			});
		}
		datagrid.datagrid('reload');
		$.messager.show({title : '提示', msg : '数据被拒绝成功!'});
		top.window.showTaskCount();
	}	
}

function _search() {
	datagrid.datagrid('load', sy.serializeObject(searchForm));
}
		
function _searchList() {
	datagridList.datagrid('load', sy.serializeObject(searchHistoricForm));
}


function addprepareOrderByOrderCode(orderCode, taskId) {
	$.getJSON('${dynamicURL}/deskgadget/gadgetAction/orderShortcut.do?orderCode='+orderCode, function(data){
		if(data.success){
			if(data.obj.orderAuditFlag == 2){
				$("#errorMsg").html("订单已取消");
			}else{
				var url = '${dynamicURL}/salesOrder/salesOrderAction!panoramaShow.action?orderCode=' + data.obj.orderCode + '&orderType=' + data.obj.orderType;
				parent.window.HROS.window.createTemp({title:"订单全景图-订单号"+data.obj.orderCode,url:url,width:800,height:400,isresize:true,isflash:false});
			}
		}else{
			$("#errorMsg").html(data.msg);
		}
	});
}
//下载附件
function dowlandFile(fileid) {
	window.open("${dynamicURL}/basic/fileUploadAction/downloadFile.do?fileId="+fileid);
}
</script>
</head>
	<div id="tabs_id" class="easyui-tabs" data-options="fit:true" >
		<div title="闸口待办页面">
			<!--展开之后的content-part所显示的内容-->
				<div class="part_zoc" region="north" border="false" collapsible="true"
					collapsed="true" style="height: 60px; overflow : auto;">
					<div class="partnavi_zoc"><span>查询与操作：</span></div>
					<form id="searchForm">
					<s:hidden name="loginName" id="loginName" />
						<div class="oneline">
							<div class="item33">
								<div class="itemleft">订单号:</div>
								<div class="righttext">
									<input name="orderCode" type="text" />
								</div>
							</div>
							<div class="item33">
								<input type="button" onclick="_search();" value="查  询" />
							</div>
						</div>
					</form>
				</div>
				<div region="center" border="false" class="part_zoc">
					<table id="datagrid"></table>
				</div>
		</div>
		
	<div title="闸口完成页面">
			<div class="part_zoc" region="north" border="false" collapsible="true"
				collapsed="true" style="height: 60px; overflow: hidden;">
				<div class="partnavi_zoc"><span>查询与操作：</span></div>
				<form id="searchHistoricForm">
				<s:hidden name="loginName" id="loginName" />
					<div class="oneline">
							<div class="item33">
								<div class="itemleft">订单号:</div>
								<div class="righttext">
									<input name="orderCode" type="text" />
								</div>
							</div>
							<div class="item33">
								<input type="button" onclick="_searchList();" value="查  询" />
							</div>
						</div>
				</form>
			</div>
			<div region="center" border="false" class="part_zoc">
				<table id="datagridList"></table>
			</div>
		</div>
    </div>
    
    <div id="showErrorDialog" style="margin-top: 1%; ">
		<form id="showLoadExcelInfoForm" method="post" enctype="multipart/form-data">
			<textarea rows="3" cols="50" id = "titleName"></textarea>
		</form>
	</div>
    
</html>