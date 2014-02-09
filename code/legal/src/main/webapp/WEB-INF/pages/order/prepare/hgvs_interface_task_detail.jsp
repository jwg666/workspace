<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript">
	var datagrid_contract_one;
	var datagrid_contract_two;//选择物料对话框
	var datagrid_materialDetail//物料详细condition表datagrid
	var searchMaterialForm;
	var contractDetailForm;
	var selectMaterialDialog;
	var searchMaterialDetailDialog;
	$(function() {
		var actPrepareCode = '${actPrepareCode}';
		$
				.ajax({
					url : "${dynamicURL}/prepare/queryPrepareAction!queryPrepareInfo.action",
					data : {
						actPrepareCode : actPrepareCode
					},
					dataType : "json",
					type : 'post',
					success : function(data) {
						$("#contractDetailForm").form('load', data);
					}
				});
		datagrid_contract_one = $('#datagrid_contract_one')
				.datagrid(
						{
							url : "${dynamicURL}/prepare/queryPrepareAction!datagridPrepareInfoItem.action",
							queryParams : {
								actPrepareCode : actPrepareCode
							},
							rownumbers : true,
							fit : true,
							fitColumns : true,
							pagination : true,
							pagePosition : 'bottom',
							pageSize : 10,
							pageList : [ 10, 20, 30, 40 ],
							nowrap : true,
							border : false,
							idField : 'orderLinecode',
							columns : [ [ {
								field : 'prodType',
								title : '产品大类',
								width : 80,
								align : 'center',
								formatter : function(value, row, index) {
									return row.prodType;
								}
							}, {
								field : 'haierModer',
								title : '海尔型号',
								width : 100,
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
								field : 'hrCode',
								title : 'HR认证',
								width : 150,
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.hrCode;
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
		//加载工厂信息
		$('#factorySettlementCode').combogrid({
			url:'${dynamicURL}/security/departmentAction!datagrid.do?deptParentCode=0',
			textField : 'deptNameCn',
			idField : 'deptCode',
			pagination : true,
			pageSize : 300,
			pageList : [ 300],
			panelWidth : 500,
			panelHeight : 220,
			toolbar : '#_FACTORYHISTORYT',
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
		//加载工厂信息
		$('#factoryCodeFinish').combogrid({
			url:'${dynamicURL}/security/departmentAction!datagrid.do?deptParentCode=0',
			textField : 'deptNameCn',
			idField : 'deptCode',
			pagination : true,
			pageSize : 300,
			pageList : [ 300],
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
	//备货单保存
	function updatePrepare() {
		var checkScheduleFlag = $("#checkScheduleFlag").val();
		if (checkScheduleFlag == 'true') {
			alert("该订单已经进行计划排定，不允许修改！");
			return;
		}
		var contractDetailForm = $('#contractDetailForm');
		contractDetailForm.form('submit', {
			url : 'prepareOrderAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				$.messager.alert('提示', json.msg);
				prepareOrderDetailDialog.dialog('close');
			}
		});
	}
	//导HGVS
	function hgvsInterface() {
		var actPrepareCodes = "actPrepareCodes=" + $("#actPrepareCode").val();
		$.messager.confirm('请确认', '您要进行导HGVS？', function(r) {
			if (r) {
				$.messager.progress({
					text : '数据加载中....',
					interval : 100
				});
				$.ajax({
					url : 'importHgvsInterfaceAction!hgvsInterface.do',
					data : actPrepareCodes,
					dataType : 'json',
					success : function(response) {
						if(response.success){
							$.messager.alert('提示','订单导HGVS成功！','info');
							$("#orderHgvsCode").val(response.orderCode);
							$.messager.progress('close');
							customWindow.reloaddata();
						}else{
							$.messager.alert('提示','导入失败：'+response.msg,'error');
							$.messager.progress('close');
							$("#orderHgvsCode").val(response.orderCode);
							customWindow.reloaddata();
						}
					}
				});
			}
		});
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
	//模糊查询工厂下拉列表
	function _FACTORYCCNMYT(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/security/departmentAction!datagrid.do?deptParentCode=0&deptNameCn='+ _CCNTEMP+'&deptCode='+_CCNCODE 
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询工厂信息输入框
	function _FACTORYCCNMYCLEANT(inputId, inputName, selectId) {
		$('#'+inputId).val("");
		$('#'+inputName).val("");
		$('#' + selectId)
		.combogrid(
				{
					url : '${dynamicURL}/security/departmentAction!datagrid.do?deptParentCode=0'
				});
	}
</script>
</head>
<body>
	<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'north',split:true,border:false"
			style="height: 230px; overflow:auto;">
			<form id="contractDetailForm">
				<div class="navhead_zoc">
					<span>备货单详细信息</span>
				</div>
				<div class="part_zoc">
					<div class="oneline">
						<div class="item33">
							<div class="itemleft80">备货单号:</div>
							<div class="righttext">
								<input id="actPrepareCode" name="actPrepareCode" type="text"
									readonly="readonly" style="background-color: #DDDDDD;" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft80">订单号:</div>
							<div class="righttext">
								<input name="orderNum" id="orderNum" type="text"
									readonly="readonly" style="background-color: #DDDDDD;" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft80">合同号:</div>
							<div class="righttext">
								<input name="contractCode" id="contractCode" type="text"
									readonly="readonly" style="background-color: #DDDDDD;" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft80">出口国家:</div>
							<div class="righttext">
								<input id="countryName" type="text" name="countryName"
									readonly="readonly" style="background-color: #DDDDDD;" />
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft80">ROSH:</div>
							<div class="righttext">
								<input id="" type="text" name="" value="是" readonly="readonly"
									style="background-color: #DDDDDD;" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft80">客户:</div>
							<div class="righttext">
								<input id="custname" name="custname" type="text"
									readonly="readonly" style="background-color: #DDDDDD;" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft80">商检批次号:</div>
							<div class="righttext">
								<input type="text" name="checkCode" id="checkCode"
									data-options="required:true" readonly="readonly"
									style="background-color: #DDDDDD;" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft80">经营主体:</div>
							<div class="righttext">
								<input id="deptname" type="text" name="deptname"
									readonly="readonly" style="background-color: #DDDDDD;" />
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft80">是否买断:</div>
							<div class="righttext">
								<input name="orderBuyoutFlag" type="text" id="orderBuyoutFlag"
									readonly="readonly" style="background-color: #DDDDDD;" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft80">销售组织:</div>
							<div class="righttext">
								<input id="salesOrgName" name="salesOrgName" type="text"
									readonly="readonly" style="background-color: #DDDDDD;" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft80">销售渠道:</div>
							<div class="righttext">
								<input id="salesChennel" name="salesChennel" type="text"
									readonly="readonly" style="background-color: #DDDDDD;" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft80">结算方式:</div>
							<div class="righttext">
								<input id="orderSettlementType" name="orderSettlementType"
									type="text" readonly="readonly"
									style="background-color: #DDDDDD;" />
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft80">HGVS订单号:</div>
							<div class="righttext">
								<input type="text" name="orderHgvsCode" id="orderHgvsCode"
									data-options="required:true" readonly="readonly"
									style="background-color: #DDDDDD;" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft80">生产工厂:</div>
							<input type="text" name="factoryProduceCode" style="width: 30px;border: 0px;font-size: 10px" disabled="disabled"/>
							<div class="righttext">
								<div class="rightselect_easyui">
								<input id="factoryCodeFinish" name="factoryProduceCode" class="short100"  type="text" disabled="disabled"/>
								</div>
							</div>
							<s:property value="factoryproducecode"/>
						</div>
						<div class="item33">
							<div class="itemleft80">结算工厂:</div>
							<input type="text" name="factorySettlementCode" style="width: 30px;border: 0px;font-size: 10px" disabled="disabled"/>
							<div class="righttext">
								<div class="rightselect_easyui">
								<input id="factorySettlementCode" name="factorySettlementCode" class="short100"  type="text" disabled="disabled"/>
								</div>
							</div>
						</div>
						<div class="item33">
							<div class="itemleft80">关联订单号:</div>
							<div class="righttext">
								<input type="text" name="belongCode" id="belongCode"
									readonly="readonly"
									style="background-color: #DDDDDD;"/>
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft80">生产计划开始：</div>
							<div class="righttext">
								<input type="text" name="manuStartDate" id="manuStartDate"
									disabled="disabled" class="easyui-datebox" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft80">装箱计划开始：</div>
							<div class="righttext">
								<input type="text" name="packingStartDate" id="packingStartDate"
									class="easyui-datebox" disabled="disabled"/>
							</div>
						</div>
						<div class="item33">
							<div class="itemleft80">商检计划开始：</div>
							<div class="righttext">
								<input type="text" name="checkStartDate" id="checkStartDate"
									class="easyui-datebox" disabled="disabled"/>
							</div>
						</div>
						<div class="item33">
							<div class="itemleft80">首样开始时间:</div>
							<div class="righttext">
								<input type="text" name="firstSampleDate" id="firstSampleDate"
									class="easyui-datebox" disabled="disabled"/>
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft80">生产计划结束：</div>
							<div class="righttext">
								<input type="text" name="manuEndDate" id="manuEndDate"
									class="easyui-datebox" disabled="disabled"/>
							</div>
						</div>
						<div class="item33">
							<div class="itemleft80">装箱计划结束：</div>
							<div class="righttext">
								<input type="text" name="packingEndDate" id="packingEndDate"
									class="easyui-datebox" disabled="disabled"/>
							</div>
						</div>
						<div class="item33">
							<div class="itemleft80">商检计划结束：</div>
							<div class="righttext">
								<input type="text" name="checkEndDate" id="checkEndDate"
									class="easyui-datebox" disabled="disabled"/>
							</div>
						</div>
					</div>
					<div class="item100" align="center">
						<div class="oprationbutt">
							<input type="hidden" name="checkScheduleFlag"
								id="checkScheduleFlag" />
							<input id="exportCon" type="button"
								onclick="hgvsInterface();" value="导入HGVS" />
						</div>
					</div>
				</div>
			</form>
		</div>
		<div region="center" border="false" class="part_zoc">
			<table id="datagrid_contract_one"></table>
		</div>
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
						onclick="_FACTORYCCNMY('_FACTORYCODEHISTORY','_FACTORYINPUTHISTORY','factoryCodeFinish')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_FACTORYCCNMYCLEAN('_FACTORYCODEHISTORY','_FACTORYINPUTHISTORY','factoryCodeFinish')" />
				</div>
			</div>
		</div>
	</div>
		<div id="_FACTORYHISTORYT">
		<div class="oneline">
		     <div class="item25">
				<div class="itemleft60">工厂编号：</div>
				<div class="righttext">
					<input class="short50" id="_FACTORYCODEHISTORYT" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">工厂名称：</div>
				<div class="righttext">
					<input class="short60" id="_FACTORYINPUTHISTORYT" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_FACTORYCCNMYT('_FACTORYCODEHISTORYT','_FACTORYINPUTHISTORYT','factorySettlementCode')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_FACTORYCCNMYCLEANT('_FACTORYCODEHISTORYT','_FACTORYINPUTHISTORYT','factorySettlementCode')" />
				</div>
			</div>
		</div>
	</div>
</body>
</html>