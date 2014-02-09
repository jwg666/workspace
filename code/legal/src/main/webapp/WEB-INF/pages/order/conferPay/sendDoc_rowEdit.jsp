<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var searchForm;
	var editRow = undefined;
	var datagrid;
	$(function() {
		searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'sendDocAction!datagrid.action',
			title : '列表',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			pageSize : 20,
			pageList : [ 10, 20, 30, 40, 50, 100 ],
			fit : true,
			fitColumns : false,
			rownumbers : true,
			nowrap : false,
			border : false,
			idField : 'obid',
			
			columns : [ [ {
				field : 'ck',
				checkbox : true,
				formatter : function(value, row, index) {
					return row.rowId;
				}
			}, {
				field : 'orderNum',
				title : '订单号',
				align : 'center',
				sortable : false,
				formatter : function(value, row, index) {
					return row.orderNum;
				}
			}, 
			{
				field : 'country',
				title : '国家',
				align : 'center',
				sortable : false,
				formatter : function(value, row, index) {
					return row.country;
				}
			},
			{
				field : 'customer',
				title : '客户',
				align : 'center',
				sortable : false,
				formatter : function(value, row, index) {
					return row.customer;
				}
			},{
				field : 'shipDate',
				title : '出运期',
				align : 'center',
				sortable : false,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.shipDate);
				}
			}, {
				field : 'pay',
				title : '付款保障总额',
				align : 'center',
				sortable : false,
				formatter : function(value, row, index) {
					return row.pay;
				}
			}, {
				field : 'cash',
				title : '收汇总额',
				align : 'center',
				sortable : false,
				formatter : function(value, row, index) {
					return row.cash;
				}
			}, {
				field : 'sendHopeFlag',
				title : '议付发送HOPE标识',
				align : 'center',
				sortable : false,
				formatter : function(value, row, index) {
					if(row.sendHopeFlag=="0"){
						return "未发";
					}else{
						return "已发";
					}
				}
			}, {
				field : 'sendHopeDate',
				title : '发送时间',
				align : 'center',
				sortable : false,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.sendHopeDate);
				}
			}, {
				field : 'sendHopeName',
				title : '发送人',
				align : 'center',
				sortable : false,
				formatter : function(value, row, index) {
					return row.sendHopeName;
				}
			}, {
				field : 'sendDocFlag',
				title : '寄送提单标识',
				align : 'center',
				sortable : false,
				formatter : function(value, row, index) {
					if(row.sendDocFlag=="0"){
						return "未发";
					}else{
						return "已发";
					}
				}
			}, {
				field : 'sendDocDate',
				title : '寄送时间',
				align : 'center',
				sortable : false,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.sendDocDate);
				}
			}, {
				field : 'sendDocName',
				title : '寄送人',
				align : 'center',
				sortable : false,
				formatter : function(value, row, index) {
					return row.sendDocName;
				}
			} ] ],
			toolbar : [ {
				text : '发送HOPE',
				iconCls : 'icon-add',
				handler : function() {
					goHOPE();
				}
			}, '-', {
				text : '确认寄送提单',
				iconCls : 'icon-remove',
				handler : function() {
					updateSendDocFlag();
				}
			},'-' ]
		});

	});

	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.form('clear');
	}
	function goHOPE(){
		var rows = datagrid.datagrid('getSelections');
		var orderNums = [];
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要发送当前所选项目？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if(rows[i].pay!=rows[i].cash){
							$.messager.show({
								title : '提示',
								msg : "收汇总额和付款保障总额不相等，不允许发送！"
							});
							return;
						}
						orderNums.push(rows[i].orderNum);
					}
					$.ajax({
						url : 'sendDocAction!goHOPE.action',
						data : {
							orderNums : orderNums.join(',')
						},
						dataType : 'json',
						success : function(response) {
							$.messager.show({
								title : '提示',
								msg : response.msg
							});
							datagrid.datagrid('load');
							datagrid.datagrid('unselectAll');
						}
					});
				}
			});
		} else {
			$.messager.alert('提示', '请选择要发送的记录！', 'error');
		}
	}
	function updateSendDocFlag(){
		var rows = datagrid.datagrid('getSelections');
		var orderNums = [];
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要确认当前所选项目？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if(rows[i].pay!=rows[i].cash){
							$.messager.show({
								title : '提示',
								msg : "收汇总额和付款保障总额不相等，不允许发送！"
							});
							return;
						}
						orderNums.push(rows[i].orderNum);
					}
					$.ajax({
						url : 'sendDocAction!updateSendDocFlag.action',
						data : {
							orderNums : orderNums.join(',')
						},
						dataType : 'json',
						success : function(response) {
							$.messager.show({
								title : '提示',
								msg : response.msg
							});
							datagrid.datagrid('load');
							datagrid.datagrid('unselectAll');
						}
					});
				}
			});
		} else {
			$.messager.alert('提示', '请选择要确认的记录！', 'error');
		}
	}
</script>
</head>
<body class="easyui-layout">
	<div id="checkSearch" class="easyui-layout" fit="true">
				<div class="zoc" region="north" border="false" collapsible="true"
					 style="height: 110px; overflow: hidden;">
					<form id="searchForm">
						<div class="navhead_zoc">
							<span>D/F寄单记录</span>
						</div>
						<div class="part_zoc">
							<div class="partnavi_zoc">
								<span>查询与操作：</span>
							</div>
							<div class="oneline">
								<div class="item25">
									<div class="itemleft80">订单编号：</div>
									<div class="righttext">
										<input id="orderNum" name="orderNum" type="text"
											style="width: 125px" />
									</div>
								</div>
								<div class="item25">
									<div class="itemleft80">出运时间：</div>
									<div class="righttext">
										<input id="shipDate" name="shipDate" type="text"
											style="width: 125px" class="easyui-datebox"/>
									</div>
								</div>
								<div class="item25">
									<div class="itemleft80">已发送HOPE：</div>
									<div class="rightselect_easyui">
										<select name="sendHopeFlag">
											<option value="">全部</option>
											<option value="1">已提</option>
											<option value="0">未提</option>
										</select>
									</div>
								</div>
								<div class="item25">
									<div class="itemleft80">已寄送提单：</div>
									<div class="righttext">
										<select name="sendDocFlag">
											<option value="">全部</option>
											<option value="1">已提</option>
											<option value="0">未提</option>
										</select>
									</div>
								</div>
							</div>
							<div class="item100">
								<div class="oprationbutt">
									<input type="button" value="查  询" onclick="_search();" /> <input
										type="button" value="重  置" onclick="cleanSearch();" /> 
								</div>
							</div>
						</div>
					</form>
				</div>
	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>

</body>
</html>