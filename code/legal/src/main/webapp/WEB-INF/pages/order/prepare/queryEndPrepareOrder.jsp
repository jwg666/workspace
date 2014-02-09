<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript">
	var queryEndPrepareOrderDatagrid;
	var prepareOrderForm;
	$(function() {
		prepareOrderForm = $('#prepareOrderForm').form();
		queryEndPrepareOrderDatagrid = $('#queryEndPrepareOrderDatagrid').datagrid({
			title : '滚动计划报表',
			url : "${dynamicURL}/prepare/prepareOrderItemAction!queryEndPrepareOrder.do",
			pagination : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			height : 100,
			fitColumns : true,
			nowrap : true,
			border : false,
			checkOnSelect : false,
			selectOnCheck : false,
			singleSelect : true,
			columns : [ [ {
				field : 'factoryName',
				title : '工厂',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.factoryName;
				}
			}, {
				field : 'materialCode',
				title : '物料号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.materialCode;
				}
			}, {
				field : 'rollRate',
				title : '滚动计划周',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.rollRate);
				}
			}, {
				field : 'weekN',
				title : 'T+N周',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.weekN;
				}
			}, {
				field : 'weekStart',
				title : '周开始',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.weekStart);
				}
			}, {
				field : 'weekEnd',
				title : '周结束',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.weekEnd);
				}
			}, {
				field : 'actualQuantity',
				title : '评审数量',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.actualQuantity;
				}
			}, {
				field : 'prepareQuantity',
				title : '已分配数量',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.prepareQuantity;
				}
			}, {
				field : 'diffQuantity',
				title : '差异数量',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.diffQuantity;
				}
			} ] ]
		});
		$('#factoryCode').combogrid({
			url:'${dynamicURL}/security/departmentAction!datagrid.do?deptParentCode=0',
			textField : 'deptNameCn',
			idField : 'deptCode',
			pagination : true,
			pageSize : 10,
			pageList : [ 10],
			panelWidth : 500,
			panelHeight : 220,
			toolbar : '#_FACTORYHISTORY',
			rownumbers : true,
			fit : true,
			fitColumns : true,
			columns : [ [ {
				field : 'deptCode',
				title : '工厂编码',
				width : 20
			},{
				field : 'deptNameCn',
				title : '工厂名称',
				width : 20
			}  ] ]
		});

	});
	function _search() {
		queryEndPrepareOrderDatagrid.datagrid('load', sy.serializeObject(prepareOrderForm));
	}
	function cleanSearch() {
		queryEndPrepareOrderDatagrid.datagrid('load', {});
		prepareOrderForm.form('clear');
	}
	//模糊查询工厂下拉列表
	function _FACTORYCCNMY(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/security/departmentAction!datagrid.do?deptParentCode=0&deptNameCn='+ _CCNTEMP+'&deptCode='+_CCNCODE 
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询工厂信息输入框
	function _FACTORYCCNMYCLEAN(inputId, inputName, selectId) {
		$('#'+inputId).val("");
		$('#'+inputName).val("");
		$('#' + selectId)
		.combogrid(
				{
					url : '${dynamicURL}/security/departmentAction!datagrid.do?deptParentCode=0'
				});
	}
</script>
<body class="easyui-layout">
    <div region="north" border="false" class="zoc" collapsed="false"
		style="height: 120px; overflow: auto;" align="left">
		<form id="prepareOrderForm"  method="post">
				<div class="part_zoc">
					<div class="partnavi_zoc">
						<span>查询条件：</span>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft100">物料号：</div>
							<div class="righttext">
								<input id="materialCode" name="materialCode" type="text"  class="short50" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft100">工厂：</div>
							<div class="righttext">
								<input name="factoryCode" id="factoryCode" type="text" class="short100" />
							</div>
						</div>
					</div>
					<div  class="oneline">
					    <div class="item33">
							<div class="itemleft100">生产结束时间：</div>
							<div class="righttext">
								<input name="planEndDate" id="planEndDate"  class="easyui-datebox" editable="false"  style="width: 102px;" />
							</div>
						</div>
						<div class="item33">
						    <div class="itemleft100">月份：</div>
							<div class="righttext">
							    <input name="month" id="month"  class="easyui-datebox" editable="false"  style="width: 152px;" />
							</div>
						</div>
					</div>
					<div class="item100 lastitem">
			            <div class="oprationbutt">
				            <input type="button" value="查  询" onclick="_search();"/>
				            <input type="button" value="重  置"  onclick="cleanSearch();"/>
			            </div>
		            </div>
				</div>
			</form>
	</div>
	<div region="center" border="false" class="part_zoc">
		<table id="queryEndPrepareOrderDatagrid"></table>
	</div>
	<div id="_FACTORYHISTORY">
		<div class="oneline">
		     <div class="item25">
				<div class="itemleft60">工厂编号：</div>
				<div class="righttext">
					<input class="short50" id="_FACTORYCODEHISTORY" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">工厂名称：</div>
				<div class="righttext">
					<input class="short60" id="_FACTORYINPUTHISTORY" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_FACTORYCCNMY('_FACTORYCODEHISTORY','_FACTORYINPUTHISTORY','factoryCode')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_FACTORYCCNMYCLEAN('_FACTORYCODEHISTORY','_FACTORYINPUTHISTORY','factoryCode')" />
				</div>
			</div>
		</div>
	</div>
</body>
