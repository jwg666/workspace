<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var searchForm;
	var datagrid;
	var detectionOrderAddDialog;
	var detectionOrderAddForm;
	var cdescAdd;
	var detectionOrderEditDialog;
	var detectionOrderEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	$(function() {
		//查询列表	
		searchForm = $('#searchForm').form();
		//fsName生产工厂
		$("#fsName").combogrid({
			url : '${dynamicURL}/security/departmentAction!datagirdSelect.action?deptType=0',
			idField : 'deptCode',
			textField : 'deptNameCn',
			panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_DEPT',
			rownumbers : true,
			pageSize : 100,
			pageList : [ 5, 10, 20 ],
			fit : true,
			fitColumns : true,
			columns : [ [ {
				field : 'deptCode',
				title : '工厂编号',
				width : 20
			}, {
				field : 'deptNameCn',
				title : '工厂名称',
				width : 20
			} ] ]
		});
		datagrid = $('#datagrid').datagrid({
			url : 'detectionOrderAction!difference5.do',
			title : '实测信息异常订单',
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
			idField : 'ORDER_NUM',
			queryParams : {
				"difference" : 5
			},
			columns : [ [ {
				field : 'ORDER_NUM',
				title : '订单号',
				align : 'center',
				sortable : true
			}, {
				field : 'MATERIAL_CODE',
				title : '物料号',
				align : 'center',
				sortable : true
			}, {
				field : 'DETECTION_GROSS_WEIGHT_SINGLE',
				title : '实测毛重(kg)',
				align : 'center',
				sortable : true
			}, {
				field : 'GROSS_WEIGHT',
				title : 'MDM毛重(kg)',
				align : 'center',
				sortable : true
			}, {
				field : 'MAOZHONGCHAYI',
				title : '毛重差异',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return (value * 100).toFixed(3) + "%"
				}
			}, {
				field : 'SHICETIJI',
				title : '实测体积(mm<sup>3</sup>)',
				align : 'center',
				sortable : true
			}, {
				field : 'MDMTIJI',
				title : 'MDM体积(mm<sup>3</sup>)',
				align : 'center',
				sortable : true
			}, {
				field : 'TIJICHAYI',
				title : '体积差异',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return (value * 100).toFixed(3) + '%'
				}
			}, {
				field : 'LENGTH',
				title : 'MDM长(mm)',
				align : 'center',
				sortable : true
			}, {
				field : 'WIDTH',
				title : 'MDM宽(mm)',
				align : 'center',
				sortable : true
			}, {
				field : 'HEIGHT',
				title : 'MDM高(mm)',
				align : 'center',
				sortable : true
			}, {
				field : 'DETECTION_LENTH',
				title : '实测长(mm)',
				align : 'center',
				sortable : true
			}, {
				field : 'DETECTION_WIDTH',
				title : '实测宽(mm)',
				align : 'center',
				sortable : true
			}, {
				field : 'DETECTION_HIGH',
				title : '实测高(mm)',
				align : 'center',
				sortable : true
			}, {
				field : 'FACTORY_NAME',
				title : '生产工厂',
				align : 'center',
				sortable : true
			}, {
				field : 'SHICE_CREATED_NAME',
				title : '实测信息录入人',
				align : 'center',
				sortable : true
			}, {
				field : 'SHICE_CREATED',
				title : '实测信息创建时间',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return dateFormatYMD(value);
				}
			}, {
				field : 'SHICE_MODIFY_NAME',
				title : '实测信息修改人',
				align : 'center',
				sortable : true
			}, {
				field : 'DETE_LAST_UPD',
				title : '实测信息修改时间',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return dateFormatYMD(value);
				}
			}, {
				field : 'HAIER_PRODUCT_CODE',
				title : '海尔型号',
				align : 'center',
				sortable : true
			}, {
				field : 'PROD_CODE',
				title : '客户型号',
				align : 'center',
				sortable : true
			}, {
				field : 'AFFIRM_CODE',
				title : '特技单号',
				align : 'center',
				sortable : true
			}, {
				field : 'ORDER_SHIP_DATE',
				title : '出运时间',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return dateFormatYMD(value);
				}
			}, {
				field : 'PROD_MGR_NAME',
				title : '产品经理',
				align : 'center',
				sortable : true
			} ] ],
			toolbar : [ {
				text : '导出',
				iconCls : 'icon-edit',
				handler : function() {
					exportExlx();
				}
			}, '-' ]
		});
	});

	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		searchForm.form('clear');
		$("#differenceId").numberbox("setValue", "5.000");
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}

	//方改成查看订单详细信息
	function showCdesc(index) {
		var rows = datagrid.datagrid('getRows');
		var row = rows[index];
		$.messager.progress({
			text : '数据加载中....',
			interval : 100
		});
		$.ajax({
			url : 'detectionOrderAction!showDesc.do',
			data : {
				actDetectionCode : row.actDetectionCode
			},
			dataType : 'json',
			cache : false,
			success : function(response) {
				if (response && response.cdesc) {
					showCdescDialog.find('div[name=cdesc]').html(response.cdesc);
					showCdescDialog.dialog('open');
				} else {
					$.messager.alert('提示', '没有首样质检表描述！', 'error');
				}
				$.messager.progress('close');
			}
		});
		datagrid.datagrid('unselectAll');
	}
	//重置查询生产工厂下拉列表
	function _cleanDeptMent(inputId, inputName, selectId) {
		$('#' + inputId).val("");
		$('#' + inputName).val("");
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/security/departmentAction!datagirdSelect.action?deptType=0'
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//模糊查询生产工厂下拉列表
	function _getDeptMent(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/security/departmentAction!datagirdSelect.action?deptType=0&deptNameCn=' + _CCNTEMP + '&deptCode=' + _CCNCODE
		});
	}
	function exportExlx(){
		$("#searchForm").attr("action", "detectionOrderAction!excelBarcodeOutput.action");
		$("#searchForm").submit();
	}
</script>
</head>
<body class="easyui-layout">
	<div region="north" border="false" collapsed="true" title="查询"
		class="zoc" style="height: 110px; overflow: hidden;"
		collapsible="true" collapsed="true">
		<form id="searchForm">
			<div class="part_zoc">
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">订单号:</div>
						<div class="righttext">
							<input name="orderNum" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">物料号:</div>
						<div class="righttext">
							<input name="taskType" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">
							<pre>差异&nbsp;&gt;</pre>
						</div>
						<div class="righttext">
							<input id="differenceId" name="difference" value="5.000"
								class="easyui-numberbox" data-options="precision:3" />%
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item66">
						<div class="itemleft">出运期:</div>
						<div class="righttext">
							<input name="created" class="easyui-datebox" />
						</div>
						<div class="itemleft">至:</div>
						<div class="righttext">
							<input name="lastUpd" class="easyui-datebox" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">生产工厂：</div>
						<div class="righttext">
							<!--  生产工厂，借用字段首样操作人-->
							<input name="fsName" id="fsName" />
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item25 lastitem">
						<div class="oprationbutt">
							<input type="button" onclick="_search();" value="查询" /><input
								type="button" onclick="cleanSearch();" value="清空" />
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>

	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>
	<div id="_DEPT">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft100">工厂编号：</div>
				<div class="righttext">
					<input class="short50" id="_DEPTMENTCODE" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft100">工厂名称：</div>
				<div class="righttext">
					<input class="short50" id="_DEPTMENTNAME" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_getDeptMent('_DEPTMENTCODE','_DEPTMENTNAME','fsName')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_cleanDeptMent('_DEPTMENTCODE','_DEPTMENTNAME','fsName')" />
				</div>
			</div>
		</div>
	</div>
</body>
</html>