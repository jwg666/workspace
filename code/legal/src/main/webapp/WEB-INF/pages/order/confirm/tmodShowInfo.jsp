<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var searchForm;
	var treeDatagrid;
	function dateFormatYMDHMS(date) {
		if (date != null && date.length > 0) {
			date = date.replace("T", " ");
		}
		return date;
	}
	/*全部展开*/
	function expandAll() {
		var node = $('#tree').treegrid('getSelected');
		if (node) {
			$('#tree').treegrid('expandAll', node.id);
		} else {
			$('#tree').treegrid('expandAll');
		}
	}
	/*全部收缩*/
	function collapseAll() {
		var node = $('#tree').treegrid('getSelected');
		if (node) {
			$('#tree').treegrid('collapseAll', node.id);
		} else {
			$('#tree').treegrid('collapseAll');
		}
	}
	$(function() {
		//未完成订单确认列表
		searchForm = $('#searchForm').form();
		treeDatagrid = $('#tree').treegrid({
					animate : true,
					autoRowHeigh : true,
					collapsible : true,
					idField : 'actId',
					treeField : 'actName',
					url : '${dynamicURL}/salesOrder/salesOrderAction!testTree.action?orderCode=${orderCode}',
					toolbar : [ {
						text : '展开全部',
						iconCls : 'icon-redo',
						handler : function() {
							expandAll();
						}
					}, '-', {
						text : '收缩全部',
						iconCls : 'icon-undo',
						handler : function() {
							collapseAll();
						}
					}, '-', {
						text : '显示流程图',
						iconCls : 'icon-undo',
						handler : function() {
							showWorkflowDia();
						}
					} ],
					columns : [ [
							{
								field : 'actName',
								title : '活动名称',
							},
							{
								field : 'statusCode',
								title : '状态',
							},
							{
								field : 'planStartDate',
								title : '计划开始时间',
								width : 140,
								formatter : function(value, row, index) {
									return dateFormatYMD(row.planStartDate);
								}
							},
							{
								field : 'planFinishDate',
								title : '计划完成时间',
								formatter : function(value, row, index) {
									return dateFormatYMD(row.planFinishDate);
								}
							},
							{
								field : 'actualFinishDate',
								title : '实际完成时间',
								formatter : function(value, row, index) {
									return dateFormatYMDHMS(row.actualFinishDate);
								}
							},
							{
								field : 'actUserName',
								title : '责任人',
							},
							{
								field : 'actDesc',
								title : '活动描述',
								formatter : function(value, row, index) {
									if (row.statusCode == 'start') {
										return '开始';
									} else if (row.statusCode == 'end') {
										return '已完成';
									}
								}
							} ] ],
					onBeforeExpand : function(row) {
						var expandOrderCode = $("#orderCode").val();
						if(expandOrderCode == null || expandOrderCode == ""){
							expandOrderCode = '${orderCode}';
						}
						var url = "${dynamicURL}/salesOrder/salesOrderAction!testTreeChildren.action?treeId="
								+ row.actId
								+ "&orderCode="
								+ expandOrderCode;
						$("#tree").treegrid("options").url = url;
						return true;
					}
				});
	});
	
	//查询
	function _search() {
		var expandOrderCode = $("#orderCode").val();
		$('#tree').treegrid({url:'${dynamicURL}/salesOrder/salesOrderAction!testTree.action?orderCode='+expandOrderCode});
	}
	/*显示流程图*/
	function showWorkflowDia() {
		var orderCode = $("#orderCode").val();
		if(orderCode == null || orderCode == ""){
			orderCode = '${orderCode}';
		}
		if (null != orderCode && orderCode != "") {
			var url = '${dynamicURL}/salesOrder/salesOrderAction!findProidByBusid.action';
			$
					.ajax({
						type : "POST",
						url : url,
						data : {
							orderCode : orderCode
						},
						success : function(json) {
							var proid = $.parseJSON(json).obj;
							if (null != proid && "" != proid) {
								var imgURL = "${dynamicURL}/workflow/processAction!goTrace.do?processInstanceId="
										+ proid;
								parent.window.HROS.window.createTemp({
									title : "订单流程图-订单号" + orderCode,
									url : imgURL,
									width : 600,
									height : 200,
									isresize : false,
									isopenmax : true,
									isflash : false
								});
							}
						}
					});
		}
	}
</script>
</head>
<jsp:include page="orderProblem.jsp" />
<body>
	<div class="easyui-tabs" data-options="fit:true">
		<div title="订单T模式查看">
			<div id="checkSearch" class="easyui-layout" data-options="fit:true">
				<div class="zoc" region="north" border="false" collapsed="false"
					style="height: 30px; overflow: hidden;">
					<form id="searchForm">
						<div class="part_zoc">
							<div class="oneline">
								<div class="item33">
									<div class="itemleft60">订单编号：</div>
									<div class="righttext">
										<input id="orderCode" name="orderCode" type="text"  maxlength="32"
											class="short50" />
									</div>
								</div>
								<div class="item33">
								    <div class="oprationbutt">
									    <input type="button" value="查  询" onclick="_search();" /> 
								    </div>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div region="center" border="false">
					<table id="tree"></table>
				</div>
			</div>
		</div>
</body>
</html>