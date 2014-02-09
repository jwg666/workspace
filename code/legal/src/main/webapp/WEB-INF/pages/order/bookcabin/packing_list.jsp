<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<style>
table.formtable {
	border: 1px solid #CCCCCC;
	background-color: #f2f2f2;
	border-collapse: collapse;
}

.formtable tr.tr th {
	height: 17px;
	padding: 3px;
	width: 250px;
	text-align: center;
}

.formtable tr.tr td {
	width: 250px;
	height: 17px;
}

.formtable tr.tr td.t-title {
	padding: 7px 5px 7px 10px;
	font-size: 14px;
	font-weight: bold;
	color: #FFFF;
}

.formtable tr.tr td.t-content {
	padding: 10px 12px 10px 10px;
	font-size: 18px;
	font-weight: bold;
}

.formtable tr.tr td.t-head {
	background: #f2f2f2;
}

.oneLine {
	BORDER-BOTTOM-COLOR: #000000;
	BORDER-RIGHT-WIDTH: 0px;
	BACKGROUND: Transparent;
	BORDER-TOP-WIDTH: 0px;
	BORDER-BOTTOM-WIDTH: 1px;
	HEIGHT: 18px;
	BORDER-LEFT-WIDTH: 0px;
}
</style>
<script type="text/javascript" charset="utf-8">
	var searchForm;
	var searchPackForm;
	var datagrid;
	var datagrid_toolbar;
	var editIndex = undefined;
	var editRow;
	var packingListAddDialog;
	var packingListAddForm;
	var printFlag=true;
	var showLoadExcelInfoForm;
	var showLoadExcelDialog;
	$(function() {

		//查询列表	
		searchForm = $('#searchForm').form();
		searchPackForm = $('#searchPackForm').form();
		datagrid_toolbar = $('#datagrid_toolbar').datagrid({
			border : false,
			pagination : false,
			toolbar : [ {
				text : '<s:text name="global.form.select" >查询</s:text>',
				iconCls : 'icon-search',
				handler : function() {
					_search();
				}
			}, '-', {
				text : '<s:text name="global.form.select" >发票确认</s:text>',
				iconCls : 'icon-search',
				handler : function() {
					updateAcceptFlag();
				}
			}, '-', {
				text : '打印预览',
				iconCls : 'icon-edit',
				handler : function() {
					print();
					// 					$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>', '维护中...', 'info');
				}
			}, '-' , {
				text : '套打/导出',
				iconCls : 'icon-edit',
				handler : function() {
					appletPrint();
					// 					$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>', '维护中...', 'info');
				}
			}, '-']
		});
		datagrid = $('#datagrid').datagrid({
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 30,
			pageList : [ 10, 20, 30, 50, 100 ],
			fit : true,
			fitColumns : true,
			nowrap : true,
			border : false,
			showFooter : true,
			// 			idField : 'orderCode',
			onDblClickRow : function(rowIndex, rowData) {
				onClickRow(rowIndex);
			},
			
			columns : [ [ {
				field : 'ck',
				checkbox : true,
				hidden : true,
				formatter : function(value, row, index) {
					return row.orderCode;
				}
			}, {
				field : 'orderCode',
				title : 'Marks',
				align : 'center',
				sortable : true,
				rowspan : 2,
				width : 70,
				formatter : function(value, row, index) {
					return row.orderCode;
				}
			},  {
				field : 'marks',
				title : 'Marks',
				align : 'center',
				sortable : true,
				hidden : true,
				formatter : function(value, row, index) {
					return row.marks;
				}
			},{
				field : 'printFalg',
				title : 'printFalg',
				align : 'center',
				sortable : true,
				hidden : true,
				formatter : function(value, row, index) {
					return row.printFalg;
				}
			},/* {
						field : 'loadingBoxCode',
						title : 'Container No.',
						align : 'center',
						sortable : true,rowspan:2,
						editor:'text',
						width : 120
					}, */{
				title : 'Description of Goods',
				align : 'center',
				colspan : 4,
				sortable : true
			}, {
				field : 'prodQuantity',
				title : 'Quantity',
				align : 'center',
				sortable : true,
				rowspan : 2,
				width : 70,
				editor : {
					type : 'numberbox'
				},
				formatter : function(value, row, index) {
					if (row.unit == null) {
						return row.prodQuantity;
					} else {
						return row.prodQuantity + ' ' + row.unit;
					}
				},
			}, {
				field : 'netWeight',
				title : 'Net weight',
				align : 'center',
				sortable : true,
				rowspan : 2,
				editor:{type:'numberbox',options:{precision:2}}, 
				width : 70,
				formatter : function(value, row, index) {
					if(row.netWeight>=0){
	     				return Number(row.netWeight).toFixed(2)+' KGS';
	     			}else{
	     				return '';
	     			}
				},
			}, {
				field : 'grossWeight',
				title : 'Gross weight',
				align : 'center',
				sortable : true,
				rowspan : 2,
				editor : {
					type : 'numberbox',
					options : {
						precision : 2
					}
				},
				width : 70,
				formatter : function(value, row, index) {
					if(row.grossWeight>=0){
	     				return Number(row.grossWeight).toFixed(2)+' KGS';
	     			}else{
	     				return '';
	     			}
				},
			}, {
				field : 'packages',
				title : 'Packages',
				align : 'center',
				sortable : true,
				rowspan : 2,
				editor : {
					type : 'numberbox',
				},
				width : 50,
				formatter : function(value, row, index) {
					if(row.grossWeight>=0){
	     				return row.packages;
	     			}else{
	     				return '';
	     			}
				},
			},{
				field : 'packagesUnit',
				title : 'Pack Unit',
				align : 'center',
				sortable : true,
				rowspan : 2,
				width : 40,
				editor : {
					type : 'text',
				},
				formatter : function(value, row, index) {
					return row.packagesUnit;
				},
			} ,{
				field : 'unit',
				title : 'UNIT',
				align : 'center',
				sortable : true,
				rowspan : 2,
				width : 120,
				hidden : true,
				formatter : function(value, row, index) {
					return row.unit;
				},
			} ], [ {field : 'haierProdDesc',title:'GOODS DESC',align : 'center',editor:'text',width:70,
				formatter : function(value, row, index) {
					//if(row.prodModel==null || row.prodModel==""){
						return row.haierProdDesc;
					//}
						//return row.prodModel;
				}},{
				field : 'haierModel',
				title : 'HAERI MODEL',
				align : 'center',
				editor : 'text',
				width : 60
			}, {
				field : 'customerModel',
				title : 'CUSTOMER MODEL',
				align : 'center',
				editor : 'text',
				width : 60
			}, {
				field : 'simpleCode',
				title : 'SIMPLE CODE',
				align : 'center',
				editor : 'text',
				width : 60
			} ] ],
			loadFilter : function(data) {
				if (data.total > 0) {
					searchPackForm.form('load', data.rows[0]);
					if(data.rows[0].printFalg=="1"){
						$("#printFlag").html("订单已经打印！");
					}
				} else {
					searchPackForm.find('.tr input').val('');
				}
				return data;
			},
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
		packingListAddForm = $('#packingListAddForm').form({
			url : 'packingListAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					packingListAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		packingListAddDialog = $('#packingListAddDialog').show().dialog({
			title : '添加箱单发票',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '添加',
				handler : function() {
					packingListAddForm.submit();
				}
			} ]
		});
		searchPackForm.find('input').attr("readonly", true);
		searchPackForm.find('textarea').attr("readonly", true);
		var orderCode1 = '${orderCode}';
		var orderType1 = '${orderType}';
		$('#orderCodeId').val(orderCode1);
		_search();
		//加载导入excel方法
		showLoadExcelInfoForm = $('#showLoadExcelInfoForm').form({
			url : 'packingListAction!exportPackingList.action',
			success : function(data) {
				$.messager.progress('close');
				var json = $.parseJSON(data);
				var obj = json.obj;
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});

					var rowId = obj.rowId;
					datagrid.datagrid({
						queryParams : {
							rowId : rowId
						}
					});
					showLoadExcelDialog.dialog('close');
					//$('#searchForm').form('load', obj);
				} else {
					$.messager.show({
						title : '失败',
						msg : json.msg
					});
				}
			}
		});
		showLoadExcelDialog = $('#showLoadExcelDialog').show().dialog({
			title : '导入箱单发票',
			modal : true,
			closed : true,
			collapsible : true,
			buttons : [ {
				text : '下载导入模板',
				handler : function() {
					window.location.href = "${dynamicURL}/basic/fileUploadAction/downloadFile.do?fileId=40102";
					return false;
				}
			},{
				text : '导入',
				handler : function() {
					if($("#excleFile").val()==""){
						return "请先选择导入的模板！";
					}
					$.messager.progress({
						text : '数据加载中....',
						interval : 100
						});
					showLoadExcelInfoForm.submit();
				}
			} ]
		});
	});
	//查询
	function _search() {
		findBookCode();
		_search_BJ_SJ();
	}
	function _search_BJ_SJ() {
		datagrid.datagrid({
			url : '${dynamicURL}/bookorder/packingListAction!datagrid.do?'
					+ searchForm.serialize(),
			toolbar : [ {
				text : 'SAVE',
				iconCls : 'icon-save',
				handler : function() {
					save();//操作
				}
			}, '-', {
				text : 'ADD',
				iconCls : 'icon-add',
				handler : function() {
					add();
				}
			}, '-',{
				text : 'DELETE',
				iconCls : 'icon-remove',
				handler : function() {
					deleteRow();//操作
				}
			}, '-', {
				text : 'ROLLBACK',
				iconCls : 'icon-redo',
				handler : function() {
					rollBack();//操作
				}
			}, '-', {
				text : 'EXPORT',
				handler : function() {
					exportPackingList();
				}
			}]
		});
	}
	//导入箱单发票
	function exportPackingList() {
		showLoadExcelInfoForm.form('clear');
		$('div.validatebox-tip').remove();
		showLoadExcelDialog.dialog('open');
		$("#exportBookCode").val($("#bookCode").val());
	}
	//新增
	function add() {
		packingListAddForm.form("clear");
		$("#addBookCode").val($("#bookCode").val());
		$('div.validatebox-tip').remove();
		packingListAddDialog.dialog('open');
	}
	//保存行记录-先删除数据库记录，在保存页面上的记录
	function save() {
		checkEmp();
		if(printFlag){
			endEditing();
			var bookCode = $("#bookCode").val();
			var rows = datagrid.datagrid('getRows');
			if (rows.length > 0) {
				var jsonStr = JSON.stringify(rows)//会生成 [{"key":9,"value":10,"name":11},{"key":9,"value":10,"name":10}] 格式的字符串
				$
						.ajax({
							type : 'POST',
							url : '${dynamicURL}/bookorder/packingListAction!savePackingList.do',
							data : {
								packingList : jsonStr,
								bookCode : bookCode
							},
							async : false,
							dataType : 'json',
							success : function(response) {
								$.messager
										.show({
											title : '<s:text name="global.form.prompt" >提示</s:text>',
											msg : response.msg
										});
								datagrid.datagrid('load');
							}
						});
			}
		}
	}
	//删除行记录
	function deleteRow() {
		checkEmp();
		if(printFlag){
			var rows = datagrid.datagrid('getSelections');
			var packingListIds = "";
			if (rows.length > 0) {
				if (rows[0].packingListId != null) {//删除数据库
					$.messager
							.confirm(
									'请确认',
									'您要删除当前所选项目？',
									function(r) {
										if (r) {
											for ( var i = 0; i < rows.length; i++) {
												if (i != rows.length - 1)
													packingListIds = packingListIds
															+ "packingListIds="
															+ rows[i].packingListId
															+ "&";
												else
													packingListIds = packingListIds
															+ "packingListIds="
															+ rows[i].packingListId;
											}
											$
													.ajax({
														url : '${dynamicURL}/bookorder/packingListAction!deletePackingList.do',
														data : packingListIds,
														dataType : 'json',
														success : function(response) {
															$.messager.show({
																title : '提示',
																msg : '删除成功！'
															});
															datagrid
																	.datagrid('load');
														}
													});
										}
									});
				} else {//页面删除
					var rows = datagrid.datagrid('getSelections');
					for ( var i = 0; i < rows.length; i++) {
						var index = datagrid.datagrid('getRowIndex', rows[i]);//获取某行的行号
						datagrid.datagrid('deleteRow', index); //通过行号移除该行
					}
				}
			} else {
				$.messager.alert('提示', '请选择要删除的记录！', 'error');
			}
		}
	}
	//回滚行记录
	function rollBack() {
		checkEmp();
		if(printFlag){
			var bookCode = $("#bookCode").val();
			$.messager
					.confirm(
							'请确认',
							'您要回退当前订单？',
							function(r) {
								if (r) {
									$
											.ajax({
												url : '${dynamicURL}/bookorder/packingListAction!deleteByOrderCode.do',
												data : {
													bookCode : bookCode
												},
												dataType : 'json',
												success : function(response) {
													$.messager.show({
														title : '提示',
														msg : '回退完成！'
													});
													datagrid.datagrid('load');
												}
											});
								}
							});
		}
	}
	//行编辑

	function endEditing() {
		if (editIndex == undefined) {
			return true
		}
		if (datagrid.datagrid('validateRow', editIndex)) {
			datagrid.datagrid('endEdit', editIndex);
			editIndex = undefined;
			return true;
		} else {
			return false;
		}
	}
	function checkEmp(){
		$
		.ajax({
			url : '${dynamicURL}/bookorder/packingListAction!checkEmp.do',
			async : false,
			data : {
				bookCode : $("#bookCode").val()
			},
			dataType : 'json',
			cache : false,
			success : function(response) {
				if(response.success){
					printFlag= true;
				}else{
					$.messager.show({
						title : '提示',
						msg : response.msg
					});
					printFlag= false;
				}
			}
		});
	}
	function onClickRow(index) {
		//var orderType=document.getElementById('orderType').value;
		/* if(orderType=='bz'||orderType=='hb'){
		 return false;
		} */
		if (editIndex != index) {
			if (endEditing()) {
				datagrid.datagrid('selectRow', index).datagrid('beginEdit',
						index);
				editIndex = index;
				datagrid.datagrid('unselectAll');
			} else {
				datagrid.datagrid('selectRow', editIndex);
			}
		}
	}
	function print() {
		$.ajax({
			url : '${dynamicURL}/bookorder/packingListAction!checkIsSave.do',
			async : false,
			data : {
				bookCode : $("#bookCode").val()
			},
			dataType : 'json',
			cache : false,
			success : function(response) {
				//如果已经保存就不再进行保存
				if(response.success){
					save();
				}
			}
		});
		$("textarea").each(function() {
			$(this).text($(this).val());
		});
		var orderCode = document.getElementById('orderCodeId').value;
		if (orderCode != null && orderCode != '') {
			findBookCode();
		}
		var bookCode = $("#bookCode").val();
		 parent.window.HROS.window
				.createTemp({
				title : "箱单发票打印预览",
					url : '${dynamicURL}/bookorder/packingListAction!printPackingList.do?orderCode='
							+ orderCode + '&bookCode=' + bookCode,
					width : 800,
					height : 400,
					isresize : false,
					isopenmax : true,
					isflash : false,
					customWindow : window
			});

		/* 		 var printObj = $("#printBody").clone(true);
		 printObj.find("tr#datagrid_toolbar").height("auto");
		 printObj.find("tr#datagridTr").height("auto");
		 printObj.find("#textareaFlag").text(printObj.find("#textareaFlag textarea").val());
		 printObj.find(".partnavi_zoc").remove();
		 var count = lodopPrintAutoWidth(gridToTable(printObj)); */
	}
	//获取订舱编号
	function findBookCode() {
		var orderCode = document.getElementById('orderCodeId').value;
		$.ajax({
			url : '${dynamicURL}/custorder/custOrderAction!findBookCode.do',
			data : {
				orderCode : orderCode
			},
			dataType : 'json',
			async : false,
			cache : false,
			success : function(response) {
				$("#bookCode").val(response.msg);
			}
		});
	}
	//确认发票
	function updateAcceptFlag() {
		$
				.ajax({
					url : '${dynamicURL}/bookorder/packingListAction!updateAcceptFlag.do',
					async : false,
					data : {
						bookCode : $("#bookCode").val()
					},
					dataType : 'json',
					cache : false,
					success : function(response) {
						if(response.success){
							$.messager.show({
								title : '提示',
								msg : '确认完成'
							});
						}else{
							$.messager.show({
								title : '提示',
								msg : response.msg
							});
						}
					}
				});
	}
	//套打
	function appletPrint(){
		//保存
		$.ajax({
					url : '${dynamicURL}/bookorder/packingListAction!checkIsSave.do',
					async : false,
					data : {
						bookCode : $("#bookCode").val()
					},
					dataType : 'json',
					cache : false,
					success : function(response) {
						//如果已经保存就不再进行保存
						if(response.success){
							save();
						}
					}
				});
		//记录打印
		$.ajax({
					url : '${dynamicURL}/bookorder/packingListAction!updatePrintFlag.do',
					async : false,
					data : {
						bookCode : $("#bookCode").val()
					},
					dataType : 'json',
					cache : false,
					success : function(response) {
					}
				});
		if($("#bookCode").val().indexOf("-")>=0){
			var bookCode=$("#bookCode").val().split("-");
			window.open("http://hrois.haier.net/report/Report-Guage.do?reportId=1281c8c4-7a21-4829-b1cb-cd8531b3cb21&book_code="+bookCode[0]+"&falg="+bookCode[1]);
			//window.open("http://hrois.haier.net/report/unieap/pages/report/jsp/show/Print.jsp?reportId=1281c8c4-7a21-4829-b1cb-cd8531b3cb21&silent=yes&isResultant=false&book_code="+bookCode[0]+"&falg="+bookCode[1]);
		}else{
			window.open("http://hrois.haier.net/report/Report-Guage.do?reportId=1281c8c4-7a21-4829-b1cb-cd8531b3cb21&book_code="+$("#bookCode").val());
			//window.open("http://hrois.haier.net/report/unieap/pages/report/jsp/show/Print.jsp?reportId=1281c8c4-7a21-4829-b1cb-cd8531b3cb21&silent=yes&isResultant=false&book_code="+$("#bookCode").val());
		}
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><s:text name="order.custorder.packinglist">箱单</s:text></title>
</head>
<body class="easyui-layout zoc">
	<div region="north" border="false" class="zoc" collapsed="false"
		style="overflow: auto;" align="left">
		<form id="searchForm">
			<div class="partnavi_zoc">
				<span><s:text name="order.custorder.packinglist">箱单</s:text></span>
			</div>
			<div class="oneline">
				<div class="item33">
					<div class="itemleft60">
						<s:text name="global.order.number">订单号</s:text>
					</div>
					<div class="righttext">
						<input type="text" name="orderCode" onblur="findBookCode()"
							id="orderCodeId" class="orderAutoComple" />
					</div>
				</div>
				<div class="item25">
					<div class="itemleft60">订舱号：</div>
					<div class="righttext">
						<input name="bookCode" id="bookCode" readonly="readonly"
							type="text" />
					</div>
				</div>
				<div class="item33">
					<div class="itemleft100">是否按整机提报：</div>
					<div class="rightselect_easyui">
						<select id="queryFlag" name="queryFlag">
							<option value="0">是</option>
							<option value="1">否</option>
						</select>
					</div>
					<div class="itemleft100">(散件订单)</div>
				</div>
				<div class="item33">
					<div class="itemleft100" id="printFlag" style="color: red;"></div>
				</div>
				<%-- <div class="item33 lastitem">
					<div class="itemleft80"><s:text name="global.order.ordertype" >订单类型</s:text>：</div>
					<div class="righttext">
					  	<select name="orderType" id="orderType" style="width:140px" >
						    <option value="bz"><s:text name="global.order.ordertypeBZ" >标准订单</s:text></option>
						    <option value="hb"><s:text name="global.order.ordertypeHB" >合并报关订单</s:text></option>
						    <option value="sj"><s:text name="global.order.ordertypeSJ" >散件订单</s:text></option>
						    <option value="bj"><s:text name="global.order.ordertypeBJ" >备件订单</s:text></option>
					  	</select>
					</div>
				</div> --%>
			</div>
		</form>
		<div class="datagrid-toolbar">
			<table id="datagrid_toolbar" style="height: 28px;"></table>
		</div>
	</div>
	<div region="center" id="printBody" border="false"
		style="overflow: auto;" class="zoc" align="center">

		<div class="part_zoc zoc" style="width: 1000px;">
			<div class="partnavi_zoc" align="left">
				<span><s:text name="order.custorder.packinglist">箱单</s:text></span>
			</div>
			<form id="searchPackForm" style="height: 100%; width: 1000px;">
				<table width="100%" class="formtable" style="height: 100%;">
					<tr class="tr">
						<td colspan="4" class="t-head"><a href="#"><img
								src="${staticURL}/style/images/logo_login.png" /></a></td>
					</tr>
					<tr class="tr" style="height: 50px">
						<td colspan="4" class="t-head" align="center"
							style="vertical-align: top; text-align: center; font-family: arial, 微软雅黑; font-size: 20px; font-weight: bold;">&nbsp;PACKING
							&nbsp;&nbsp;LIST&nbsp;</td>
					</tr>
					<tr class="tr">
						<td class="t-title" colspan="4" style="text-align: left;">Shipping
							Marks:</td>

					</tr>
					<tr class="tr">
						<td rowspan="2" colspan="2" class="t-content" id='textareaFlag'
							style="width: 500px"><textarea name="" rows="2" cols="50"
								style="resize: none"></textarea></td>
						<th style="text-align: right;">NO:</th>
						<td><input type="text" class="oneLine" name="invoiceNum" /></td>
					</tr>
					<tr class="tr">
						<th style="text-align: right;">DATE:</th>
						<td><input type="text" class="oneLine"
							name="orderShipStringDate" /></td>
					</tr>
					<tr class="tr">
						<td colspan="4">&nbsp;</td>
					</tr>
					<tr style="height: 258px;" id="datagridTr">
						<td colspan="4"
							style="border-bottom: 1px solid #A4B5C2; border-top: 1px solid #A4B5C2;">
							<table id="datagrid"></table>
						</td>
					</tr>
					<tr class="tr">
						<td colspan="4">&nbsp;</td>
					</tr>
					<tr class="tr">
						<th colspan="2" style="text-align: right;">SHIPPED ON:</th>
						<td colspan="2"><input type="text" class="oneLine"
							name="orderShipStringDate" style="width: 180px;" /></td>
					</tr>
					<tr class="tr">
						<th colspan="2" style="text-align: right;">SHIPPED BY:</th>
						<td colspan="2"><input type="text" class="oneLine"
							name="itemNameCn" style="width: 180px;" /></td>
					</tr>
					<tr class="tr">
						<th colspan="2" style="text-align: right;">PO NO.:</th>
						<td colspan="2"><input type="text" class="oneLine"
							name="orderPoCode" style="width: 180px;" /></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	
	<div id="packingListAddDialog" style="display: none;width: 800px;height: 230px;overFlow-x: hidden;" align="center">
		<form id="packingListAddForm" method="post">
		<div class="part_zoc zoc">
						<div class="oneline">
							<div class="itemleft60">订单号:</div>
							<div class="righttext">
								<input name="marks" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写订单号"  style="width: 155px;"/>						
							</div>
							<div class="itemleft60">唛头:</div>
							<div class="righttext">
								<input name="orderCode" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写唛头"  style="width: 155px;"/>						
							</div>
							<div class="itemleft60">箱号:</div>
							<div class="righttext">
								<input name="loadingBoxCode" type="text" class="easyui-validatebox" missingMessage="请填写箱号"  style="width: 155px;"/>						
							</div>
						</div>
						<div class="oneline">
							<div class="itemleft60">海尔型号:</div>
							<div class="righttext">
								<input name="haierModel" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写海尔型号"  style="width: 155px;"/>						
							</div>
							<div class="itemleft60">客户型号:</div>
							<div class="righttext">
								<input name="customerModel" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写客户型号"  style="width: 155px;"/>						
							</div>
							<div class="itemleft60">简码:</div>
							<div class="righttext">
								<input name="simpleCode" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写简码"  style="width: 155px;"/>						
							</div>
						</div>
						<div class="oneline">
							<div class="itemleft60">数量:</div>
							<div class="righttext">
								<input name="prodQuantity" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写数量"  style="width: 155px;"/>						
							</div>
							<div class="itemleft60">单位:</div>
							<div class="righttext">
								<input name="unit" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写数量"  style="width: 155px;"/>						
							</div>
							<div class="itemleft60">净重:</div>
							<div class="righttext">
								<input name="netWeight" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写净重"  style="width: 155px;"/>						
							</div>
						</div>
						<div class="oneline">
						<div class="itemleft60">毛重:</div>
							<div class="righttext">
								<input name="grossWeight" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写净毛重"  style="width: 155px;"/>						
						</div>
						<div class="itemleft60">订舱号:</div>
							<div class="righttext">
								<input name="bookCode" id="addBookCode" type="text" class="easyui-validatebox"  readonly="readonly" style="width: 155px;"/>						
							</div>
						<div class="itemleft60">货描:</div>
							<div class="righttext">
								<input name="haierProdDesc" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写货描"  style="width: 155px;"/>						
							</div>
						</div>
						<div class="oneline">
						<div class="itemleft60">件数:</div>
							<div class="righttext">
								<input name="packages" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写件数"  style="width: 155px;"/>						
						</div>
						<div class="itemleft60">件数单位:</div>
							<div class="righttext">
								<input name="packagesUnit"  type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写单位"  style="width: 155px;"/>						
							</div>
						</div>
			</div>
		</form>
	</div>
	<div id="showLoadExcelDialog"
		style="display: none; width: 400px; height: 150px;" align="center">
		<form id="showLoadExcelInfoForm" method="post"
			enctype="multipart/form-data">
			<table class="tableForm">
				<tr>
					<th>订舱单号:</th>
					<td><s:textfield name="bookCode" id="exportBookCode" readonly="true"></s:textfield></td>
				</tr>
				<tr>
					<th>导入箱单发票信息:</th>
					<td><s:file name="excleFile" id="excleFile"></s:file></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>