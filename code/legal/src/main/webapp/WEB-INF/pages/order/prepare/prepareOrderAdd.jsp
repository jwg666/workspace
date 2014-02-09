<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">
var datagrid_contract_one;
var datagrid_contract_two;//选择物料对话框
var datagrid_materialDetail//物料详细condition表datagrid
var searchMaterialForm;
var contractDetailForm;
var selectMaterialDialog;
var searchMaterialDetailDialog;
function prepareOrder_detail() {
	datagrid_contract_one = $('#datagrid_contract_one').datagrid({
		rownumbers : true,
		//fit : true,
		height : 220,
		fitColumns : true,
		pagination : true,
		pagePosition : 'bottom',
		pageSize : 10,
		pageList : [ 10, 20, 30, 40 ],
		nowrap : true,
		border : false,
		idField : 'orderLinecode',
		columns : [ [ {
			field : 'orderLinecode',
			title : '行项目',
			width : 60,
			align : 'center',
			formatter : function(value, row, index) {
				return row.orderLinecode;
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
			width : 120,
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
			field : 'quantity',
			title : '数量',
			width : 80,
			align : 'center',
			sortable : true,
			formatter : function(value, row, index) {
				return row.quantity;
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
			width : 120,
			align : 'center',
			sortable : true,
			formatter : function(value, row, index) {
				return row.plcStatus;
			}
		}, {
			field : 'activeFlag',
			title : '滚动计划',
			width : 55,
			align : 'center',
			sortable : true,
			formatter : function(value, row, index) {
				return row.activeFlag;
			}
		} ] ]
	});
	//	$("#datagrid_contract_one").datagrid('loadData', mJson);
	$('#salesOrgCode').combobox({
		url : '${dynamicURL}/basic/sysLovAction!selectDealType.do?itemType=4',
		valueField : 'itemCode',textField : 'itemNameCn'});
	$('#salesChennel').combobox({
		url : '${dynamicURL}/basic/sysLovAction!selectDealType.do?itemType=3',
		valueField : 'itemCode',
		textField : 'itemNameCn'});
	$('#factoryProduceCode').combobox({
		url : '${dynamicURL}/security/departmentAction!selectDealType.do?deptType=0',
		valueField : 'deptCode',
		textField : 'deptNameCn'});
	$('#deptCode').combobox({
		url : '${dynamicURL}/security/departmentAction!selectDealType.do?deptType=1',
		valueField : 'deptCode',
		textField : 'deptNameCn'});
	$('#factorySettlementCode').combobox({
		url : '${dynamicURL}/security/departmentAction!selectDealType.do?deptType=0',
		valueField : 'deptCode',
		textField : 'deptNameCn'});
	$('#cc6').combobox({
		url : '${dynamicURL}/basic/sysLovAction!selectDealType.do?itemType=23',
		valueField : 'itemCode',
		textField : 'itemNameCn'});
	//选择国家
	$('#countryCodeId').combobox({
		url : '${dynamicURL}/basic/countryAction!combox.do',
		valueField : 'countryCode',
		textField : 'name'});
	
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
	searchMaterialDetailDialog = $('#searchMaterialDetailDialog').show().dialog({
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
	datagrid_materialDetail = $('#datagrid_materialDetail').datagrid({
		url : '${dynamicURL}/contract/contractConditionAction!searchContractCondition.do?contractLineItem='+ lineCode + '&contractCode=' + conCode,
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
				saveContractCondition();}
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
	$.ajax({
		type : 'POST',
		url : '${dynamicURL}/contract/contractConditionAction!saveContractCondition.do',
		data : {contactConditionEditList : jsonStr}, // params是其他参数 mylist 表示action接受的json的参数名
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
function addPrepare() {
	var contractDetailForm = $('#contractDetailForm');
	var listPrepareOrder = datagrid_contract_one.datagrid('getData');
	contractDetailForm.form('submit', {
		url : 'prepareOrderAction!addworkflow.action',	
		data : {
			listPrepareOrder : listPrepareOrder
		},
		dataType : 'json',
		onSubmit : function(param) {
			param.listPrepareOrder = JSON.stringify(listPrepareOrder.rows);
		},
		success : function(data) {
			var json = $.parseJSON(data);
			$.messager.alert('提示', json.msg);
			prepareOrderDetailDialog.dialog('close');
		}
	});
}
</script>
<div id="prepareOrderDetailDialog">
	<form id="contractDetailForm" method="post">
		<input type="hidden" id = "taskId" name="taskId" />
		<div class="navhead_zoc">
			<span>备货单新增页面</span>
		</div>
		<div class="part_zoc zoc">
			<div class="partnavi_zoc">
				<span>备货单基本信息：</span>
			</div>
			<div class="oneline">
				<div class="item33">
					<div class="itemleft">备货单号:</div>
					<div class="righttext">
						<input id="actPrepareCode" name="actPrepareCode" type="text"
							readonly="readonly" style="width: 140px;"/>
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">订单号:</div>
					<div class="righttext">
						<input name="orderNum" id="orderNum" type="text"
							style="width: 140px;" readonly="readonly" />
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">合同号:</div>
					<div class="righttext">
						<input name="contractCode" id="contractCode" type="text"
							style="width: 140px;" />
					</div>
				</div>
			</div>

			<div class="oneline">
				<div class="item33">
					<div class="itemleft">出口国家:</div>
					<div class="righttext">
						<input id="countryCode" type="text" name="countryCode"
							readonly="readonly" style="width: 140px;"/>
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">ROSH:</div>
					<div class="righttext">
						<input id="" type="text" name="" value="是" readonly="readonly" style="width: 140px;"/>
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">客户:</div>
					<div class="righttext">
						<input id="customerModel" name="customerModel"
							style="width: 140px;" readonly="readonly" />
					</div>
				</div>
			</div>

			<div class="oneline">
				<div class="item33">
					<div class="itemleft">商检批次号:</div>
					<div class="righttext">
						<input type="text" name="checkCode" id="checkCode"
							data-options="required:true" readonly="readonly" style="width: 140px;"/>
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">经营主体:</div>
					<div class="righttext">
						<input id="deptCode" class="easyui-combobox" name="deptCode"
							readonly="readonly"
							data-options="valueField:'deptCode',textField:'deptNameCn'"
							style="width: 140px;" />
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">是否买断:</div>
					<div class="righttext">
						<input name="orderBuyoutFlag" id="orderBuyoutFlag"
							style="width: 140px;" readonly="readonly" />
					</div>
				</div>
			</div>
			<div class="oneline">
				<div class="item33">
					<div class="itemleft">销售组织:</div>
					<div class="righttext">
						<input id="salesOrgCode" class="easyui-combobox"
							name="salesOrgCode"
							data-options="valueField:'itemCode',textField:'itemNameCn'"
							style="width: 140px;" />
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">销售渠道:</div>
					<div class="righttext">
						<input id="salesChennel" class="easyui-combobox"
							name="salesChennel"
							data-options="valueField:'itemCode',textField:'itemNameCn'"
							style="width: 140px;" />
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">结算方式:</div>
					<div class="righttext">
						<input id="cc6" class="easyui-combobox" name=""
							data-options="valueField:'itemCode',textField:'itemNameCn'"
							style="width: 140px;" />
					</div>
				</div>
			</div>
			<div class="oneline">
				<div class="item33">
					<div class="itemleft">HGVS订单号:</div>
					<div class="righttext">
						<input type="text" name="" id="" data-options="required:true" style="width: 140px;"/>
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">生产工厂:</div>
					<div class="righttext">
						<input id="factoryProduceCode" class="easyui-combobox"
							name="factoryProduceCode"
							data-options="valueField:'deptCode',textField:'deptNameCn'"
							style="width: 140px;" />
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">结算工厂:</div>
					<div class="righttext">
						<input id="factorySettlementCode" class="easyui-combobox"
							name="factorySettlementCode"
							data-options="valueField:'deptCode',textField:'deptNameCn'"
							style="width: 140px;" />
					</div>
				</div>
			</div>
		</div>
		<!--这里是第二部分内容-->
		<div class="part_zoc zoc">
			<div class="partnavi_zoc">
				<span>备货单时间选择：</span>
			</div>
			<div class="oneline">
				<div class="item33">
					<div class="itemleft">首样开始时间</div>
					<div class="righttext">
						<input type="text" name="firstSampleDate" id="firstSampleDate"
							class="easyui-datebox" />
					</div>
				</div>
			</div>
			<div class="oneline">
				<div class="item33">
					<div class="itemleft">生产计划开始</div>
					<div class="righttext">
						<input type="text" name="manuStartDate" id="manuStartDate"
							class="easyui-datebox" />
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">装箱计划开始</div>
					<div class="righttext">
						<input type="text" name="packingStartDate" id="packingStartDate"
							class="easyui-datebox" />
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">商检计划开始</div>
					<div class="righttext">
						<input type="text" name="checkStartDate" id="checkStartDate"
							class="easyui-datebox" />
					</div>
				</div>
			</div>
			<div class="oneline">
				<div class="item33">
					<div class="itemleft">生产计划结束</div>
					<div class="righttext">
						<input type="text" name="manuEndDate" id="manuEndDate"
							class="easyui-datebox" />
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">装箱计划开始</div>
					<div class="righttext">
						<input type="text" name="packingEndDate" id="packingEndDate"
							class="easyui-datebox" />
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">商检计划开始</div>
					<div class="righttext">
						<input type="text" name="checkEndDate" id="checkEndDate"
							class="easyui-datebox" />
					</div>
				</div>
			</div>
			<div class="item100">
				<div class="oprationbutt">
					<input type="button" value="保  存" onclick="addPrepare()" />
				</div>
			</div>
		</div>
		<div class="part_zoc zoc">
		<div class="oneline">
			<div>
				<table id="datagrid_contract_one"></table>
			</div>
		</div>
		</div>
	</form>
</div>



