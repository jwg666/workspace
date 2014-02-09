<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var searchForm;
	var datagrid;
	var prepareOrderAddDialog;
	var prepareOrderAddForm;
	var cdescAdd;
	var prepareOrderEditDialog;
	var prepareOrderEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	$(function() {
		//查询列表	
		searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'schedulePlanAction!datagrid.do',
			title : '排定计划<span style="color:red;">（单击订单显示订单明细）</span>',
			iconCls : 'icon-save',
			pagination : true,
			checkOnSelect:false,
			selectOnCheck:false,
			singleSelect : true, 
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 20,
			pageList : [ 10, 20, 30, 40 ],
			height : 250,
			fitColumns : true,
			fit : true,
			border : false,
			idField : 'actPrepareCode',
			
			columns : [ [ {
				field : 'ck',
				checkbox : true,
				formatter : function(value, row, index) {
					return row.orderNum;
				}
			}, {
				field : 'orderNum',
				title : '订单号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return '<span style="color: red;" >'+row.orderNum+'</span>';
				}
			}, {
				field : 'factoryProduceCode',
				title : '生产工厂',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.factoryProduceCode;
				}
			}, {
				field : 'factoryProduceCode',
				title : '经营体',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.factoryProduceCode;
				}
			}, {
				field : 'countryName',
				title : '国家',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.countryName;
				}
			}, {
				field : 'itemName',
				title : '市场区域',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.itemName;
				}
			}, {
				field : 'orderProdManager',
				title : '产品经理',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.orderProdManager;
				}
			}, {
				field : 'releaseFlag',
				title : '闸口状态',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					if (row.releaseFlag == "1") {
						return "已经释放";
					} else if (row.releaseFlag == "0") {
						return "拒绝释放";
					} else {
						return "";
					}
				}
			} ] ] ,
			onClickRow : function(value, row, index) {
				findOrderItems(row.orderNum);
			}	

		});

		//加载国家信息
		$('#countryCode').combobox({
			url : 'queryPrepareAction!selectCountryInfo',
			valueField : 'countryCode',
			textField : 'name'
		});
		showCdescDialog = $('#showCdescDialog').show().dialog({
			title : '小备单生成表描述',
			modal : true,
			closed : true,
			maximizable : true
		});

		iframeDialog = $('#iframeDialog').show().dialog({
			title : 'POP弹出页面',
			modal : true,
			closed : true,
			maximizable : true
		});
	});

	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.form("clear");
		datagrid.datagrid('clearSelections');
		datagrid.datagrid('clearChecked');
		//searchForm.find('input').val('');
	}
	function add() {
		prepareOrderAddForm.form("clear");
		$('div.validatebox-tip').remove();
		prepareOrderAddDialog.dialog('open');
	}
	//计划排定
	function schedulePlan() {
		var rows = datagrid.datagrid('getChecked');
		var codes = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要进行计划排定？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if (i != rows.length - 1)
							codes = codes + "codes=" + rows[i].orderNum + "&";
						else
							codes = codes + "codes=" + rows[i].orderNum;
					}
					$.ajax({
						url : 'schedulePlanAction!schedulePlan.do',
						data : codes,
						dataType : 'json',
						success : function(response) {
							datagrid.datagrid('load');
							datagrid.datagrid('unselectAll');
							$.messager.show({
								title : '提示',
								msg : '计划排定成功！'
							});
						}
					});
				}
			});
		} else {
			$.messager.alert('提示', '请选择要计划排定的订单！', 'error');
		}
	}
	function edit() {
		var rows = datagrid.datagrid('getSelections');
		if (rows.length == 1) {
			$.messager.progress({
				text : '数据加载中....',
				interval : 100
			});
			$.ajax({
				url : 'schedulePlanAction!showDesc.do',
				data : {
					actPrepareCode : rows[0].actPrepareCode
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					prepareOrderEditForm.form("clear");
					prepareOrderEditForm.form('load', response);
					$('div.validatebox-tip').remove();
					prepareOrderEditDialog.dialog('open');
					$.messager.progress('close');
				}
			});
		} else {
			$.messager.alert('提示', '请选择一项要编辑的记录！', 'error');
		}
	}
	//查看订单明细
	function findOrderItems(orderCode) {
		$('#datagridItem').datagrid({
			url : 'schedulePlanAction!datagridByOrderCode.do',
			queryParams : {
				orderNum : orderCode
			},
			title : '订单号为<span style="color: red;">'+orderCode+'</span>的订单明细：',
			iconCls : 'icon-save',
			//pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			fitColumns : true,
			border : false,
			idField : 'actPrepareCode',
			
			columns : [ [ {
				field : 'prodType',
				title : '产品大类',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.prodType;
				}
			}, {
				field : 'haierModer',
				title : '海尔型号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.haierModer;
				}
			}, {
				field : 'customerModel',
				title : '客户型号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.customerModel;
				}
			}, {
				field : 'addirmNum',
				title : '特技单号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.addirmNum;
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
				field : 'quantity',
				title : '数量',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.quantity;
				}
			} ] ]
		});
	}
</script>
</head>
<body class="easyui-layout">
	<div region="north" border="false" class="zoc" collapsed="false"
		style="height: 150px; overflow: auto;" align="left">
		<form id="searchForm">
			<div class="navhead_zoc">
				<span>计划排定</span>
			</div>
			<div class="part_zoc">
				<div class="partnavi_zoc">
					<span>查询与操作：</span>
				</div>
				<div class="oneline">
					<div class="item25">
						<div class="itemleft60">订单编号：</div>
						<div class="righttext">
							<input id="orderNum" name="orderNum" type="text"
								style="width: 125px" />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft60">备货单号：</div>
						<div class="righttext">
							<input id="actPrepareCode" name="actPrepareCode" type="text"
								style="width: 125px" />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft60">国家：</div>
						<div class="rightselect_easyui">
							<input id="countryCode" name="countryCode" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft60">客户：</div>
						<div class="righttext">
							<input id="actPrepareCode" name="actPrepareCode" type="text"
								style="width: 125px" />
						</div><
					</div>
				</div>
				<div class="item100">
					<div class="oprationbutt">
						<input type="button" value="查  询" onclick="_search();" /> <input
							type="button" value="重  置" onclick="cleanSearch();" /> <input
							type="button" value="计划排定" onclick="" />
					</div>
				</div>
			</div>
		</form>
	</div>

	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>
	<div region="south" style="height: 180px;" border="false">
		<table id="datagridItem"></table>
	</div>

	<div id="showCdescDialog"
		style="display: none; overflow: auto; width: 500px; height: 400px;">
		<div name="cdesc"></div>
	</div>

	<div id="iframeDialog"
		style="display: none; overflow: auto; width: 600px; height: 400px;">
		<iframe name="iframe" id="iframe" src="#" scrolling="auto"
			frameborder="0" style="width: 100%; height: 100%;"> </iframe>
	</div>
</body>
</html>