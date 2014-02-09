<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<script type="text/javascript">
	var datagrid_contract_one;
	var datagrid_contract_two;//选择物料对话框
	var datagrid_materialDetail//物料详细condition表datagrid
	var searchMaterialForm;
	var contractDetailForm;
	var selectMaterialDialog;
	var searchMaterialDetailDialog;
	function query_hgvsInterface_log_detail() {
		datagrid_contract_one = $('#datagrid_contract_one').datagrid({
			pagination : false,
			rownumbers : true,
			pageSize : 10,
			height : 150,
			checkbox : true,
			pageList : [ 10, 20, 30, 40 ],
			//fit : true,
			fitColumns : true,
			nowrap : true,
			border : false,
			idField : 'orderItemLinecode',
			

			columns : [ [ {
				field : 'orderItemLinecode',
				title : '行项目',
				width : 60,
				align : 'center',
				formatter : function(value, row, index) {
					return row.orderItemLinecode;
				}
			}, {
				field : 'prodTcode',
				title : '产品大类',
				width : 80,
				align : 'center',
				formatter : function(value, row, index) {
					return row.prodTcode;
				}
			}, {
				field : 'haierModer',
				title : '海尔型号',
				width : 80,
				align : 'center',
				formatter : function(value, row, roindex) {
					return row.haierModer;
				}
			}, {
				field : 'customerModel',
				title : '客户型号',
				width : 80,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.customerModel;
				}
			}, {
				field : 'addirmNum',
				title : '特技单号',
				width : 80,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.addirmNum;
				}
			}, {
				field : 'materialCode',
				title : '物料号',
				width : 80,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.materialCode;
				}
			}, {
				field : 'prodQuantity',
				title : '数量',
				width : 80,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.prodQuantity;
				}
			}, {
				field : 'hrDate',
				title : 'HR认证',
				width : 150,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.hrDate;
				}
			}, {
				field : 'plcStatus',
				title : '生命周期状态',
				width : 150,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.plcStatus;
				}
			}, {
				field : 'releaseFlag',
				title : '滚动计划',
				width : 55,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.releaseFlag;
				}
			} ] ]
		});

		datagrid_contract_two = $('#datagrid_contract_two').datagrid({
			pagination : false,
			rownumbers : true,
			pageSize : 10,
			height : 150,
			checkbox : true,
			pageList : [ 10, 20, 30, 40 ],
			//fit : true,
			fitColumns : true,
			nowrap : true,
			border : false,
			idField : 'orderItemLinecode',
			
			columns : [ [ {
				field : 'orderItemLinecode',
				title : '行项目',
				width : 60,
				align : 'center',
				formatter : function(value, row, index) {
					return row.orderItemLinecode;
				}
			}, {
				field : 'orderNum',
				title : '订单号',
				width : 80,
				align : 'center',
				formatter : function(value, row, index) {
					return row.orderNum;
				}
			}, {
				field : 'haierModer',
				title : '海尔型号',
				width : 80,
				align : 'center',
				formatter : function(value, row, roindex) {
					return row.haierModer;
				}
			}, {
				field : 'materialCode',
				title : '物料号',
				width : 80,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.materialCode;
				}
			}, {
				field : 'prodQuantity',
				title : 'HGVS销售订单',
				width : 80,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.prodQuantity;
				}
			}, {
				field : 'hrDate',
				title : '错误提示',
				width : 150,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.hrDate;
				}
			} ] ]
		});

		//	$("#datagrid_contract_one").datagrid('loadData', mJson);
		$('#salesOrgCode')
				.combobox(
						{
							url : '${dynamicURL}/basic/sysLovAction!selectDealType.do?itemType=4',
							valueField : 'itemCode',
							textField : 'itemNameCn'
						});

		$('#salesChennel')
				.combobox(
						{
							url : '${dynamicURL}/basic/sysLovAction!selectDealType.do?itemType=3',
							valueField : 'itemCode',
							textField : 'itemNameCn'
						});
		$('#factoryProduceCode')
				.combobox(
						{
							url : '${dynamicURL}/security/departmentAction!selectDealType.do?deptType=0',
							valueField : 'deptCode',
							textField : 'deptNameCn'
						});
		$('#deptCode')
				.combobox(
						{
							url : '${dynamicURL}/security/departmentAction!selectDealType.do?deptType=1',
							valueField : 'deptCode',
							textField : 'deptNameCn'
						});
		$('#factorySettlementCode')
				.combobox(
						{
							url : '${dynamicURL}/security/departmentAction!selectDealType.do?deptType=0',
							valueField : 'deptCode',
							textField : 'deptNameCn'
						});

		$('#cc6')
				.combobox(
						{
							url : '${dynamicURL}/basic/sysLovAction!selectDealType.do?itemType=23',
							valueField : 'itemCode',
							textField : 'itemNameCn'
						});
		//选择国家
		$('#countryCodeId').combobox({
			url : '${dynamicURL}/basic/countryAction!combox.do',
			valueField : 'countryCode',
			textField : 'name'
		});
		//成交方式
		$('#contractDealstyleId')
				.combobox(
						{
							url : '${dynamicURL}/basic/sysLovAction!selectDealType.do?itemType=2',
							valueField : 'itemCode',
							textField : 'itemName'
						});
		$('#contractTypeIdDetail')
				.combobox(
						{ //合同类型 
							url : '${dynamicURL}/basic/sysLovAction!selectDealType.do?itemType=16',
							valueField : 'itemCode',
							textField : 'itemName'
						});
		$('#contractPaytypeId')
				.combobox(
						{ //付款方式 
							url : '${dynamicURL}/basic/sysLovAction!selectDealType.do?itemType=1',
							valueField : 'itemCode',
							textField : 'itemName'
						});
		$('#contractPayconditionId')
				.combobox(
						{ //付款条件
							url : '${dynamicURL}/basic/sysLovAction!selectDealType.do?itemType=10',
							valueField : 'itemCode',
							textField : 'itemName'
						});
		$('#currencyId')
				.combobox(
						{ //付款条件
							url : '${dynamicURL}/basic/sysLovAction!selectDealType.do?itemType=13',
							valueField : 'itemCode',
							textField : 'itemName'
						});
		contractDetailForm = $('#contractDetailForm').form({
			url : 'prepareOrderAction!editSales.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					saveMaterial();
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

	}
	//增加行，选择物料
	function openMaterialDialog() {
		searchMaterialForm = $('#searchMaterialForm').form();
		selectMaterialDialog = $('#selectMaterialDialog').show().dialog({
			title : '添加物料号',
			modal : true,
			closed : true,
			maximizable : true
		});
		searchMaterialForm.form('clear');
		selectMaterialDialog.dialog('open');
	}
	//查询物料主数据
	function searchMaterial() {
		datagrid_contract_two.datagrid('load', sy
				.serializeObject(searchMaterialForm));
	}
	//查看物料明细
	function materialDetail(lineCode, conCode) {
		var contractType = $("#contractTypeIdDetail").combobox('getValue');
		if (contractType != 'A07') {//只有备件合同才有物料明细
			return false;
		}
		searchMaterialDetailDialog = $('#searchMaterialDetailDialog').show()
				.dialog({
					title : '物料明细',
					modal : true,
					closed : true,
					maximizable : true
				});
		if (conCode == null) {
			$.messager.alert('提示', '请先保存该物料号！', 'error');
			return false;
		}
		var editIndex = undefined;
		datagrid_materialDetail = $('#datagrid_materialDetail')
				.datagrid(
						{
							url : '${dynamicURL}/contract/contractConditionAction!searchContractCondition.do?contractLineItem='
									+ lineCode + '&contractCode=' + conCode,
							iconCls : 'icon-save',
							rownumbers : true,
							pagination : false,
							fit : true,
							fitColumns : true,
							nowrap : true,
							border : false,
							idField : 'rowId',
							onClickRow : onClickRow,
							columns : [],
							toolbar : [ {
								text : '保存',
								iconCls : 'icon-save',
								handler : function() {
									saveContractCondition();
								}
							}, '-' ]
						});
		searchMaterialDetailDialog.dialog('open');
	}
	//行编辑代码
	var editIndex = undefined;
	function endEditing() {
		if (editIndex == undefined) {
			return true
		}
		if ($('#datagrid_materialDetail').datagrid('validateRow', editIndex)) {
			$('#datagrid_materialDetail').datagrid('endEdit', editIndex);
			editIndex = undefined;
			return true;
		} else {
			return false;
		}
	}
	function onClickRow(index) {
		if (editIndex != index) {
			if (endEditing()) {
				$('#datagrid_materialDetail').datagrid('selectRow', index)
						.datagrid('beginEdit', index);
				editIndex = index;
				$('#datagrid_materialDetail').datagrid('unselectAll');
			} else {
				$('#datagrid_materialDetail').datagrid('selectRow', editIndex);
			}
		}
	}
	//保存物料明细到condition表
	function saveContractCondition() {
		endEditing();
		// 		var updateRows = datagrid_materialDetail.datagrid("getChanges");
		var updateRows = datagrid_materialDetail.datagrid("getRows");
		//统计总值-后台获取
		// 		var sumNum = 0;
		// 		for(var i=0;i<updateRows.length;i++){
		// 			sumNum += Number(updateRows[i].conditionValue);
		// 		}
		var jsonStr = JSON.stringify(updateRows)//会生成 [{"key":9,"value":10,"name":11},{"key":9,"value":10,"name":10}] 格式的字符串
		$
				.ajax({
					type : 'POST',
					url : '${dynamicURL}/contract/contractConditionAction!saveContractCondition.do',
					data : {
						contactConditionEditList : jsonStr
					}, // params是其他参数 mylist 表示action接受的json的参数名
					dataType : 'json',
					success : function(response) {
						if (response.success) {
							$.messager.show({
								title : '提示',
								msg : response.msg
							});
							searchMaterialDetailDialog.dialog('close');
						} else {
							$.messager.alert('提示', response.msg, 'error');
						}
					}
				});
	}
	//添加物料
	function addMaterial() {
		var rows_one = datagrid_contract_one.datagrid("getData").rows;
		var rows_two = datagrid_contract_two.datagrid('getSelections');
		if (rows_two.length > 0) {
			for ( var i = 0; i < rows_two.length; i++) {
				var ifRepeat = 0; //0不重复可提取，1重复
				if (rows_one.length != 0) {
					for ( var j = 0; j < rows_one.length; j++) {
						if (rows_one[j].materialCode == rows_two[i].materialCode
								&& rows_one[j].affirmCode == rows_two[i].affirmCode
								&& rows_one[j].customerModel == rows_two[i].prodCode
								&& rows_one[j].contractHaierModel == rows_two[i].haierProductCode) {
							ifRepeat = 1;
						}
					}
				}
				if (rows_one.length == 0 || ifRepeat == 0) {
					datagrid_contract_one.datagrid('appendRow', {
						contractProdTcode : rows_two[i].prodType,
						contractHaierModel : rows_two[i].haierProductCode,
						customerModel : rows_two[i].prodCode,
						affirmCode : rows_two[i].affirmCode,
						materialCode : rows_two[i].materialCode,
						ids : rows_two[i].rowId
					});
				}
			}
			$.messager.show({
				title : '提示',
				msg : '添加完成！'
			});
		} else {
			$.messager.alert('提示', '请选择一项物料号！', 'error');
		}
	}
	//保存物料、合同修改
	function doContractItemSave() {
		if (contractDetailForm.form('validate')) {
			$.ajax({
				url : '${dynamicURL}/contract/contractAction!add.do?'
						+ $("#contractDetailForm").serialize(),
				dataType : 'json',
				cache : false,
				success : function(response) {
					if (response.success) {
						saveMaterial();
					} else {
						$.messager.alert('提示', response.msg, 'error');
					}
				}
			});
		}
	}

	//保存物料
	function saveMaterial() {
	}

	//备货单保存
	function add111() {
		var contractDetailForm = $('#contractDetailForm');
		//		alert($("#contractDetailForm").serialize());
		contractDetailForm.form('submit', {
			url : 'prepareOrderAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				$.messager.alert('提示', json.msg);
				prepareOrderDetailDialog.dialog('close');
			}
		});
	}

	//审核
	function doContractItemCheck() {
		$.ajax({
			url : '${dynamicURL}/contract/contractAction!edit.do?'
					+ $("#contractDetailForm").serialize(),
			data : {
				ifCheck : "1"
			},
			dataType : 'json',
			cache : false,
			success : function(response) {
				$.messager.show({
					title : '提示',
					msg : '审核完成！'
				});
				prepareOrderDetailDialog.dialog('close');
				datagrid.datagrid('load');
			}
		});
	}
</script>
</head>
<body>
	<div id="prepareOrderDetailDialog"
		style="display: none; width: 1000px; height: 507px;">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'north',split:true,border:false"
				style="height: 200px; overflow: hidden;">
				<form id="contractDetailForm">
					<input type="hidden" name="rowId" />
					<table id="tableHeader" class="tableForm datagrid-toolbar "
						style="width: 100%;">
						<tr>
							<th>备货单号:</th>
							<td><input id="actPrepareCode" name="actPrepareCode"
								type="text" readonly="readonly" /></td>
							<th>订单号:</th>
							<td><input name="orderNum" id="orderNum" type="text"
								style="width: 140px;" readonly="readonly" /></td>
							<th>合同号:</th>
							<td><input name="contractCode" id="contractCode" type="text"
								style="width: 120px;" /></td>
						</tr>
						<tr>
							<th>出口国家:</th>
							<td><input id="countryCode" type="text" name="countryCode"
								readonly="readonly" /></td>
							<th>ROSH:</th>
							<td><input id="" type="text" name="" value="是"
								readonly="readonly" /></td>
							<th>客户:</th>
							<td><input id="customerModel" name="customerModel"
								style="width: 120px;" readonly="readonly" /></td>
						</tr>
						<tr>
							<th>商检批次号:</th>
							<td><input type="text" name="checkCode" id="checkCode"
								data-options="required:true" readonly="readonly" /></td>
							<th>经营主体:</th>
							<td><input id="deptCode" class="easyui-combobox"
								name="deptCode" readonly="readonly"
								data-options="valueField:'deptCode',textField:'deptNameCn'"
								style="width: 140px;" /></td>
							<th>是否买断:</th>
							<td><input name="orderBuyoutFlag" id="orderBuyoutFlag"
								style="width: 120px;" readonly="readonly" /></td>
						</tr>
						<tr>
							<th>销售组织:</th>
							<td><input id="salesOrgCode" class="easyui-combobox"
								name="salesOrgCode"
								data-options="valueField:'itemCode',textField:'itemNameCn'"
								style="width: 140px;" /></td>
							<th>销售渠道:</th>
							<td><input id="salesChennel" class="easyui-combobox"
								name="salesChennel"
								data-options="valueField:'itemCode',textField:'itemNameCn'"
								style="width: 140px;" /></td>
							<th>结算方式:</th>
							<td><input id="cc6" class="easyui-combobox" name=""
								data-options="valueField:'itemCode',textField:'itemNameCn'"
								style="width: 140px;" /></td>
						</tr>
						<tr>
							<th>HGVS订单号:</th>
							<td><input type="text" name="" id=""
								data-options="required:true" /></td>
							<th>生产工厂:</th>
							<td><input id="factoryProduceCode" class="easyui-combobox"
								name="factoryProduceCode"
								data-options="valueField:'deptCode',textField:'deptNameCn'"
								style="width: 140px;" /></td>
							<th>结算工厂:</th>
							<td><input id="factorySettlementCode"
								class="easyui-combobox" name="factorySettlementCode"
								data-options="valueField:'deptCode',textField:'deptNameCn'"
								style="width: 140px;" /></td>
						</tr>
						<tr>
							<th>首样开始时间:</th>
							<td><input type="text" name="firstSampleDate"
								id="firstSampleDate" class="easyui-datebox" /></td>
						</tr>
						<tr>
							<th>生产计划开始</th>
							<td><input type="text" name="manuStartDate"
								id="manuStartDate" class="easyui-datebox" /></td>
							<th>装箱计划开始</th>
							<td><input type="text" name="packingStartDate"
								id="packingStartDate" class="easyui-datebox" /></td>
							<th>商检计划开始</th>
							<td><input type="text" name="checkStartDate"
								id="checkStartDate" class="easyui-datebox" /></td>
						</tr>
						<tr>
							<th>生产计划结束</th>
							<td><input type="text" name="manuEndDate" id="manuEndDate"
								class="easyui-datebox" /></td>
							<th>装箱计划开始</th>
							<td><input type="text" name="packingEndDate"
								id="packingEndDate" class="easyui-datebox" /></td>
							<th>商检计划开始</th>
							<td><input type="text" name="checkEndDate" id="checkEndDate"
								class="easyui-datebox" /></td>
						</tr>
					</table>
				</form>
			</div>
			<div style="height: 150px; " data-options="region:'center'">
				<table id="datagrid_contract_one"></table>
			</div>
			<div style="height: 150px;" data-options="region:'center'">
				<table id="datagrid_contract_two"></table>
			</div>
		</div>
	</div>
	<div id="selectMaterialDialog"
		style="display: none; width: 800px; height: 450px;">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'north',split:true,border:false"
				style="height: 82px; overflow: hidden;">
				<form id="searchMaterialForm">
					<table class="tableForm datagrid-toolbar" style="width: 100%;">
						<tr>
							<th>产品大类</th>
							<td><input name="prodType" class="easyui-combobox"
								data-options="valueField:'prodTypeCode',textField:'prodType',url:'${dynamicURL}/basic/prodTypeAction!combox.do'" /></td>
							<th>物料号</th>
							<td><input type="text" name="materialCode" /></td>
							<th>生产工厂</th>
							<td><input name="factoryCode" class="easyui-combobox"
								style="width: 150px;"
								data-options="valueField:'deptCode',textField:'deptNameCn',url:'${dynamicURL}/security/departmentAction!combox.do?deptType=0'" /></td>
						</tr>
						<tr>
							<th>海尔型号</th>
							<td><input type="text" name="haierProductCode" /></td>
							<th>客户型号</th>
							<td><input type="text" name="prodCode" /></td>
							<th>特技单号</th>
							<td><input type="text" name="affirmCode"
								style="width: 150px;" /></td>
						</tr>
						<tr>
							<td><a href="javascript:void(0);" class="easyui-linkbutton"
								onclick="searchMaterial();">查询</a><a href="javascript:void(0);"
								class="easyui-linkbutton" onclick="addMaterial();">添加到合同明细</a> <a
								href="javascript:void(0);" class="easyui-linkbutton"
								onclick="selectMaterialDialog.dialog('close');">返回</a></td>
						</tr>
					</table>
				</form>
			</div>
			<div data-options="region:'center',border:false">
				<table id="datagrid_contract_two"></table>
			</div>
		</div>
	</div>
	<div id="searchMaterialDetailDialog"
		style="display: none; width: 800px; height: 450px;">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'center',border:false">
				<table id="datagrid_materialDetail"></table>
			</div>
		</div>
	</div>
</body>
</html>