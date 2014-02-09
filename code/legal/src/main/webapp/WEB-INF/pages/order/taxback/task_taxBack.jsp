<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var searchForm;
	var searchHistoryForm
	var datagrid;
	var datagridHistory;
	$(function() {
		//查询列表	
		//java类中组合查询语句的时候退税表的字段row_id和其他表的重名  起了别名  TAX_ROW_ID  所以在此页面中接受row_id的应为 taxRowId
		searchForm = $('#searchForm').form();
		searchHistoryForm = $('#searchHistoryForm').form();
		datagrid = $('#datagrid')
				.datagrid(
						{
							url : 'taxBackInfoAction!taxBackTask.do?definitionKey=${definitionKey}&taskId=${taskId}',
							//title : '预申报列表',
							iconCls : 'icon-save',
							pagination : true,
							pagePosition : 'bottom',
							rownumbers : true,
							pageSize : 10,
							pageList : [ 10, 20, 30, 40 ],
							fit : true,
							nowrap : true,
							border : false,
							idField : 'taxRowId',
							onClickRow : onClickRow,
							columns : [ [
									{
										field : 'ck',
										checkbox : true,
										formatter : function(value, row, index) {
											return row.taxRowId;
										}
									},
									{
										field : 'orderCode',
										title : '订单号',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											var img;
											if (row.assignee
													&& row.assignee != 'null') {
												img = "<img width='16px' height='16px' title='个人任务' src='${staticURL}/easyui3.2/themes/icons/user.png' />&nbsp;"
											} else {
												img = "<img width='16px' height='16px' title='未认领的组任务' src='${staticURL}/easyui3.2/themes/icons/group.png' />&nbsp;"
											}
											return "<a href='javascript:void(0)' style='color:blue' > "
													+ img
													+ row.orderCode
													+ "</a>";
										}
									},{
										field : 'taxcode',
										title : '增值税发票号',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											return row.taxcode;
										}
									},
									{
										field : 'agencyBillCode',
										title : '代理清单号',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											return row.agencyBillCode;
										}
									},
									{
										field : 'taxBackDate',
										title : '退税活动结束日期',
										align : 'center',
										sortable : true,
										editor : {
											type : 'datebox',
											editable : false,
											options : {}
										},
										formatter : function(value, row, index) {
											return dateFormatYMD(row.taxBackDate);
										}
									},
									{
										field : 'createDate',
										title : '所属月份',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											return dateFormatYMD(row.createDate);
										}
									},
									{
										field : 'compreeCode',
										title : '综合通知单号',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											return row.compreeCode;
										}
									},
									{
										field : 'invoiceCompany',
										title : '结算公司',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											return row.invoiceCompany;
										}
									},
									{
										field : 'productCode',
										title : '产品大类',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											return row.productCode;
										}
									},
									{
										field : 'haierModel',
										title : '海尔型号',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											return row.haierModel;
										}
									},
									{
										field : 'unit',
										title : '计量单位',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											return row.unit;
										}
									},
									{
										field : 'amount',
										title : '数量',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											return row.amount;
										}
									},
									{
										field : 'moneyType',
										title : '原币币种',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											return row.moneyType;
										}
									},
									{
										field : 'price',
										title : '原币单价',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											return row.price;
										}
									},
									{
										field : 'exportAmount',
										title : '出口总额',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											return row.exportAmount;
										}
									},
									{
										field : 'shipFee',
										title : '运费保费',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											return row.shipFee;
										}
									},
									{
										field : 'fobAmount',
										title : 'FOB出口总额',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											return row.fobAmount;
										}
									},
									{
										field : 'usdExchangeRate',
										title : '美元兑人民币汇率',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											return row.usdExchangeRate;
										}
									},
									{
										field : 'applyAmount',
										title : '应退税申报额',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											return row.applyAmount;
										}
									},
									{
										field : 'prepareFactory',
										title : '备货厂家',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											return row.prepareFactory;
										}
									},
									{
										field : 'customDate',
										title : '报关日期',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											return dateFormatYMD(row.customDate);
										}
									},
									{
										field : 'agencyBillCode',
										title : '代理清单号',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											return row.agencyBillCode;
										}
									},
									{
										field : 'customCode',
										title : '报关单号',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											return row.customCode;
										}
									},
									{
										field : 'exportInvoiceCode',
										title : '出口发票号',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											return row.exportInvoiceCode;
										}
									},
									{
										field : 'originalUsdRate',
										title : '原币兑美元汇率',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											return row.originalUsdRate;
										}
									},
									{
										field : 'productFactory',
										title : '工厂编码',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											return row.productFactory;
										}
									},
									{
										field : 'customGoodsName',
										title : '海关商品名称',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											return row.customGoodsName;
										}
									},
									{
										field : 'customGoodsCode',
										title : '海关商品编码',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											return row.customGoodsCode;
										}
									},
									{
										field : 'doccode',
										title : '备案项号',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											return row.doccode;
										}
									},
									{
										field : 'booknum',
										title : '账册号',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											return row.booknum;
										}
									},
									{
										field : 'mergeValue',
										title : '备注',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											return row.mergeValue;
										}
									},
									{
										field : 'trace',
										title : '流程追踪',
										align : 'center',
										formatter : function(value, row, index) {
											return "<a href='javascript:void(0)' style='color:blue' onclick='traceImg("
													+ index + ")'>流程跟踪</a>";
										}
									} ] ],
							toolbar : [ {
								text : '申领',
								iconCls : 'icon-apply',
								handler : function() {
									quickApply();
								}
							}, '-', {
								text : '完成退税',
								iconCls : 'icon-check',
								handler : function() {
									completeTax();
								}
							}, '-', {
								text : '导入退税信息',
								iconCls : 'icon-edit',
								handler : function() {
									upload();
								}
							}, '-', {
								text : '导出',
								iconCls : 'icon-edit',
								handler : function() {
									exportSchedule();
								}
							}, '-' ],
							onRowContextMenu : function(e, rowIndex, rowData) {
								e.preventDefault();
								$(this).datagrid('unselectAll');
								$(this).datagrid('selectRow', rowIndex);
								$('#menu').menu('show', {
									left : e.pageX,
									top : e.pageY
								});
							}
						});

		datagridHistory = $('#datagridHistory')
				.datagrid(
						{
							url : 'taxBackInfoAction!taxBackHistoryTask.do?definitionKey=${definitionKey}&taskType=my&taskId=${taskId}',
							//title : '预申报列表',
							iconCls : 'icon-save',
							pagination : true,
							pagePosition : 'bottom',
							rownumbers : true,
							pageSize : 10,
							pageList : [ 10, 20, 30, 40 ],
							fit : true,
							//fitColumns : true,
							nowrap : true,
							border : false,
							idField : 'taxRowId',
							columns : [ [ {
								field : 'taxBackDate',
								title : '退税活动结束日期',
								align : 'center',
								width : 100,
								sortable : true,
								formatter : function(value, row, index) {
									return dateFormatYMD(row.taxBackDate);
								}
							}, {
								field : 'createDate',
								title : '所属月份',
								align : 'center',
								width : 100,
								sortable : true,
								formatter : function(value, row, index) {
									return dateFormatYMD(row.createDate);
								}
							}, {
								field : 'orderCode',
								title : '订单号',
								align : 'center',
								width : 100,
								sortable : true,
								formatter : function(value, row, index) {
									return row.orderCode;
								}
							}, {
								field : 'compreeCode',
								title : '综合通知单号',
								align : 'center',
								width : 100,
								sortable : true,
								formatter : function(value, row, index) {
									return row.compreeCode;
								}
							}, {
								field : 'invoiceCompany',
								title : '结算公司',
								align : 'center',
								width : 100,
								sortable : true,
								formatter : function(value, row, index) {
									return row.invoiceCompany;
								}
							}, {
								field : 'productCode',
								title : '产品大类',
								align : 'center',
								width : 100,
								sortable : true,
								formatter : function(value, row, index) {
									return row.productCode;
								}
							}, {
								field : 'haierModel',
								title : '海尔型号',
								align : 'center',
								width : 100,
								sortable : true,
								formatter : function(value, row, index) {
									return row.haierModel;
								}
							}, {
								field : 'unit',
								title : '计量单位',
								align : 'center',
								width : 100,
								sortable : true,
								formatter : function(value, row, index) {
									return row.unit;
								}
							}, {
								field : 'amount',
								title : '数量',
								align : 'center',
								width : 100,
								sortable : true,
								formatter : function(value, row, index) {
									return row.amount;
								}
							}, {
								field : 'moneyType',
								title : '原币币种',
								align : 'center',
								width : 100,
								sortable : true,
								formatter : function(value, row, index) {
									return row.moneyType;
								}
							}, {
								field : 'price',
								title : '原币单价',
								align : 'center',
								width : 100,
								sortable : true,
								formatter : function(value, row, index) {
									return row.price;
								}
							}, {
								field : 'exportAmount',
								title : '出口总额',
								align : 'center',
								width : 100,
								sortable : true,
								formatter : function(value, row, index) {
									return row.exportAmount;
								}
							}, {
								field : 'shipFee',
								title : '运费保费',
								align : 'center',
								width : 100,
								sortable : true,
								formatter : function(value, row, index) {
									return row.shipFee;
								}
							}, {
								field : 'fobAmount',
								title : 'FOB出口总额',
								align : 'center',
								width : 100,
								sortable : true,
								formatter : function(value, row, index) {
									return row.fobAmount;
								}
							}, {
								field : 'usdExchangeRate',
								title : '美元兑人民币汇率',
								align : 'center',
								width : 100,
								sortable : true,
								formatter : function(value, row, index) {
									return row.usdExchangeRate;
								}
							}, {
								field : 'applyAmount',
								title : '应退税申报额',
								align : 'center',
								width : 100,
								sortable : true,
								formatter : function(value, row, index) {
									return row.applyAmount;
								}
							}, {
								field : 'prepareFactory',
								title : '备货厂家',
								align : 'center',
								width : 100,
								sortable : true,
								formatter : function(value, row, index) {
									return row.prepareFactory;
								}
							}, {
								field : 'customDate',
								title : '报关日期',
								align : 'center',
								width : 100,
								sortable : true,
								formatter : function(value, row, index) {
									return dateFormatYMD(row.customDate);
								}
							}, {
								field : 'agencyBillCode',
								title : '代理清单号',
								align : 'center',
								width : 100,
								sortable : true,
								formatter : function(value, row, index) {
									return row.agencyBillCode;
								}
							}, {
								field : 'customCode',
								title : '报关单号',
								align : 'center',
								width : 100,
								sortable : true,
								formatter : function(value, row, index) {
									return row.customCode;
								}
							}, {
								field : 'exportInvoiceCode',
								title : '出口发票号',
								align : 'center',
								width : 100,
								sortable : true,
								formatter : function(value, row, index) {
									return row.exportInvoiceCode;
								}
							}, {
								field : 'originalUsdRate',
								title : '原币兑美元汇率',
								align : 'center',
								width : 100,
								sortable : true,
								formatter : function(value, row, index) {
									return row.originalUsdRate;
								}
							}, {
								field : 'productFactory',
								title : '工厂编码',
								align : 'center',
								width : 100,
								sortable : true,
								formatter : function(value, row, index) {
									return row.productFactory;
								}
							}, {
								field : 'customGoodsName',
								title : '海关商品名称',
								align : 'center',
								width : 100,
								sortable : true,
								formatter : function(value, row, index) {
									return row.customGoodsName;
								}
							}, {
								field : 'customGoodsCode',
								title : '海关商品编码',
								align : 'center',
								width : 100,
								sortable : true,
								formatter : function(value, row, index) {
									return row.customGoodsCode;
								}
							}, {
								field : 'mergeValue',
								title : '备注',
								align : 'center',
								width : 100,
								sortable : true,
								formatter : function(value, row, index) {
									return row.mergeValue;
								}
							} ] ],
							onRowContextMenu : function(e, rowIndex, rowData) {
								e.preventDefault();
								$(this).datagrid('unselectAll');
								$(this).datagrid('selectRow', rowIndex);
								$('#menu').menu('show', {
									left : e.pageX,
									top : e.pageY
								});
							},
							toolbar : [ {
								text : '导出',
								iconCls : 'icon-edit',
								handler : function() {
									exportHistory();
								}
							}, '-' ]
						});

		$('#productFactoryId')
				.combobox(
						{
							url : '${dynamicURL}/security/departmentAction!combox.do?deptType=0',
							valueField : 'deptCode',
							textField : 'deptNameCn'
						});
		$('#productCodeId').combobox({
			url : '${dynamicURL}/basic/prodTypeAction!combox.do',
			valueField : 'prodTypeCode',
			textField : 'prodType'
		});
	});

	function completeTax() {
		endEditing();
		var updateRows = datagrid.datagrid('getChecked');//获取被改变的记录
		if (updateRows.length > 0) {
			var jsonArray = new Array();
			for ( var i = 0, l = updateRows.length; i < l; i++) {
				if (updateRows[i].agencyBillCode == ''
						|| updateRows[i].agencyBillCode == null) {
					$.messager.show({
						title : '提示',
						msg : "没有代理清单号 ，无法完成退税!"
					});
					return;
				}
				if (updateRows[i].taxBackDate == ''
						|| updateRows[i].taxBackDate == null) {
					$.messager.show({
						title : '提示',
						msg : "请输入退税活动结束日期!"
					});
					return;
				}
				var json = {};
				json.rowId = updateRows[i].taxRowId;
				json.taxBackDate = updateRows[i].taxBackDate;
				json.taskId = updateRows[i].taskId;
				jsonArray.push(json);
			}
			var jsonStr = JSON.stringify(jsonArray);//将被改变的记录 转化成json形式   
			//var jsonStr = JSON.stringify(updateRows);
			$.ajax({
				url : "taxBackInfoAction!completeTaxBack.do",
				type : "post",
				data : {
					taxBackList : jsonStr
				},
				dataType : 'json',
				success : function(response) {
					datagrid.datagrid('load');
					datagrid.datagrid('unselectAll');
					$.messager.show({
						title : '提示',
						msg : response.msg
					});
				}
			});
		} else {
			$.messager.alert('提示', '请选择需要退税的订单！', 'error');
		}
	}

	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function HistorySearch() {
		datagridHistory.datagrid('load', sy.serializeObject(searchHistoryForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.form('clear');
	}
	function quickApply() {
		var rows = $("#datagrid").datagrid('getSelections');
		var rowIds = "";
		var taskIds = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要申领当前退税任务？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if (i != rows.length - 1) {
							rowIds = rowIds + "rowIds=" + rows[i].taxRowId
									+ "&";
							taskIds = taskIds + "taskIds=" + rows[i].taskId
									+ "&";
						} else {
							rowIds = rowIds + "rowIds=" + rows[i].taxRowId;
							taskIds = taskIds + "taskIds=" + rows[i].taskId;
						}
					}
					$.ajax({
						url : 'taxBackInfoAction!apply.do',
						data : rowIds + "&" + taskIds,
						dataType : 'json',
						type : "post",
						success : function(response) {
							$("#datagrid").datagrid('load');
							$("#datagrid").datagrid('unselectAll');
							$.messager.show({
								title : '提示',
								msg : response.msg
							});
						}
					});
				}
			});
		} else {
			$.messager.alert('提示', '请选择要申领退税记录！', 'error');
		}
	}
	var editIndex = undefined;
	function endEditing() {
		if (editIndex == undefined) {
			return true
		}
		if ($('#datagrid').datagrid('validateRow', editIndex)) {
			$('#datagrid').datagrid('endEdit', editIndex);
			editIndex = undefined;
			return true;
		} else {
			return false;
		}
	}
	function onClickRow(index) {
		if (editIndex != index) {
			if (endEditing()) {
				$('#datagrid').datagrid('selectRow', index).datagrid(
						'beginEdit', index);
				editIndex = index;
				$('#datagrid').datagrid('unselectAll');
			} else {
				$('#datagrid').datagrid('selectRow', editIndex);
			}
		}
	}

	function upload() {
		var upLoadExcelForm;
		uploadExcelDialog = $('#uploadExcelDialog')
				.show()
				.dialog(
						{
							title : '导入对账单信息',
							modal : true,
							closed : true,
							collapsible : true,
							buttons : [
									{
										text : '下载导入模板',
										handler : function() {
											window.location.href = "${dynamicURL}/basic/fileUploadAction/downloadFile.do?fileId=346";
											return false;
										}
									},
									{
										text : '导入',
										handler : function() {
											var fileName = $("#excleFile")
													.val();
											if ('' === fileName
													|| null == fileName) {
												$.messager.alert('提示', '请选择文件',
														'info');
												return;
											} else {
												upLoadExcelForm.submit();
											}
										}
									} ]
						});
		//加载导入excel方法
		upLoadExcelForm = $('#upLoadExcelForm').form({
			url : 'taxBackInfoAction!upload.action',
			success : function(data) {
				var json = $.parseJSON(data);
				var obj = json.obj;
				if (json && json.success) {
					$.messager.progress('close');
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('load');
					uploadExcelDialog.dialog('close');
					// 					$('#searchForm').form('load', obj);
				} else {
					$.messager.progress('close');
					$.messager.show({
						title : '失败',
						msg : json.msg
					});
					uploadExcelDialog.dialog('close');
				}
			}
		});
		uploadExcelDialog.dialog('open');
	}
	function hiddenSearchForm() {
		$("#checkSearch").layout("collapse", "north");
	}
	function hiddenHistorySearch() {
		$("#HistorySearch").layout("collapse", "north");
	}
	function traceImg(rowIndex) {
		var obj = $("#datagrid").datagrid("getData").rows[rowIndex];
		parent.window.HROS.window
				.createTemp({
					title : obj.name + "-订单编号:" + obj.orderCode + "-流程图",
					url : "${dynamicURL}/workflow/processAction!goTrace.do?processInstanceId="
							+ obj.procInstId,
					width : 800,
					height : 400,
					isresize : false,
					isopenmax : true,
					isflash : false
				});
	}
	function exportSchedule() {
		$("#searchForm").form('submit', {
			url : 'taxBackInfoAction!exportSchedule.action'
		});
	}
	function exportHistory() {
		$("#searchHistoryForm").form('submit', {
			url : 'taxBackInfoAction!exportHistory.action'
		});
	}
</script>
</head>
<body>
	<div id="tabs_id" class="easyui-tabs" data-options="fit:true">
		<div title="退税完成待办">
			<div id="checkSearch" class="easyui-layout" fit="true">
				<div class="zoc" region="north" border="false" collapsible="true"
					collapsed="true" style="height: 120px; overflow: hidden;">
					<div class="navhead_zoc">
						<span>退税</span>
					</div>
					<div class="part_zoc">
						<form id="searchForm">
							<div class="oneline">
								<div class="item25">
									<div class="itemleft60">工厂:</div>
									<div class="righttext">
										<input type="text" id="productFactoryId" name="productFactory" />
									</div>
								</div>
								<div class="item25">
									<div class="itemleft60">产品组:</div>
									<div class="righttext">
										<input type="text" id="productCodeId" name="productCode" />
									</div>
								</div>
								<div class="item25 lastitem">
									<div class="itemleft60">报关单号:</div>
									<div class="righttext">
										<input type="text" name="customCode" />
									</div>
								</div>
								<div class="item25">
									<div class="itemleft60">买断标识:</div>
									<div class="righttext">
										<select name="orderBuyoutFlag" style="width: 150px">
											<option value="">全部</option>
											<option value="0">代理</option>
											<option value="1">买断</option>
										</select>
									</div>
								</div>
							</div>
							<div class="oneline">
								<div class="item25">
									<div class="itemleft60">订单号:</div>
									<div class="righttext">
										<input type="text" name="orderCode" />
									</div>
								</div>
								<div class="item25">
									<div class="itemleft60">所属月份:</div>
									<div class="righttext">
										<input type="text" name="printDateStart"
											class="easyui-datebox" />
									</div>
								</div>
								<div class="item25 lastitem">
									<div class="itemleft60">至:</div>
									<div class="righttext">
										<input type="text" name="printDateEnd" class="easyui-datebox" />
									</div>
								</div>
							</div>
							<div class="item100 lastitem">
								<div class="oprationbutt">
									<input type="button" onclick="_search();" value="查  询" /> <input
										type="button" onclick="cleanSearch()" value="重  置" /><input
										type="button" onclick="hiddenSearchForm()" value="隐藏" />
								</div>
							</div>
						</form>
					</div>
				</div>
				<div region="center" border="false">
					<table id="datagrid"></table>
				</div>
			</div>
		</div>
		<div title="退税完成已办">
			<div id="HistorySearch" class="easyui-layout" fit="true">
				<div class="zoc" region="north" border="false" collapsible="true"
					collapsed="true" style="height: 120px; overflow: hidden;">
					<form id="searchHistoryForm">
						<div class="navhead_zoc">
							<span>退税</span>
						</div>
						<div class="part_zoc">
							<div class="oneline">
								<div class="item25">
									<div class="itemleft60">工厂:</div>
									<div class="righttext">
										<input type="text" id="productFactoryId" name="productFactory" />
									</div>
								</div>
								<div class="item25">
									<div class="itemleft60">产品组:</div>
									<div class="righttext">
										<input type="text" id="productCodeId" name="productCode" />
									</div>
								</div>
								<div class="item25 lastitem">
									<div class="itemleft60">报关单号:</div>
									<div class="righttext">
										<input type="text" name="customCode" />
									</div>
								</div>
								<div class="item25">
									<div class="itemleft60">买断标识:</div>
									<div class="righttext">
										<select name="orderBuyoutFlag" style="width: 150px">
											<option value="">全部</option>
											<option value="0">代理</option>
											<option value="1">买断</option>
										</select>
									</div>
								</div>
							</div>
							<div class="oneline">
								<div class="item25">
									<div class="itemleft60">订单号:</div>
									<div class="righttext">
										<input type="text" name="orderCode" />
									</div>
								</div>
								<div class="item25">
									<div class="itemleft60">所属月份:</div>
									<div class="righttext">
										<input type="text" name="printDateStart"
											class="easyui-datebox" />
									</div>
								</div>
								<div class="item25 lastitem">
									<div class="itemleft60">至:</div>
									<div class="righttext">
										<input type="text" name="printDateEnd" class="easyui-datebox" />
									</div>
								</div>
							</div>
							<div class="item100 lastitem">
								<div class="oprationbutt">
									<input type="button" onclick="HistorySearch();" value="查  询" />
									<input type="button" onclick="hiddenHistorySearch()" value="隐藏" />
								</div>
							</div>
						</div>
					</form>
				</div>
				<div region="center" border="false">
					<table id="datagridHistory"></table>
				</div>
			</div>
		</div>
	</div>
	<!-- <div id="tabs_id" class="easyui-tabs" data-options="fit:true" >
		<div title="待办审批">
			展开之后的content-part所显示的内容
			<table id="datagrid" ></table>
		</div>
		<div title="已完成的审批">
			展开之后的content-part所显示的内容
			<table id="datagridHistory" ></table>
		</div>
	</div> -->
	<div id="uploadExcelDialog"
		style="display: none; width: 400px; height: 100px;" align="center">
		<form id="upLoadExcelForm" method="post" enctype="multipart/form-data">
			<table class="tableForm">
				<tr>
					<th>导入对账单Excel信息:</th>
					<td><s:file id="excleFile" name="excleFile"></s:file></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>