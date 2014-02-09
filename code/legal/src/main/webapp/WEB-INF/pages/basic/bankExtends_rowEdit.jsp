<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var searchForm;
	var datagrid;
	var bankExtendsAddDialog;
	var bankExtendsAddForm;
	var cdescAdd;
	var bankExtendsEditDialog;
	var bankExtendsEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	$(function() {
		//查询列表	
		searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'bankExtendsAction!datagrid.do',
			title : '开证行客户关系列表',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			fitColumns : true,
			nowrap : false,
			border : false,
			idField : 'rowId',
			
			columns : [ [ {
				field : 'ck',
				checkbox : true,
				formatter : function(value, row, index) {
					return row.rowId;
				}
			}, {
				field : 'bankId',
				title : '银行',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.bankName;
				}
			}, {
				field : 'customer',
				title : '客户',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.customerName;
				}
			}, {
				field : 'creditLimit',
				title : '额度',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.creditLimit;
				}
			}, {
				field : 'currency',
				title : '币种',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.currency;
				}
			}, {
				field : 'comments',
				title : '备注',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.comments;
				}
			}, {
				field : 'activeFlag',
				title : '有效标识',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					if (row.activeFlag == "1") {
						return "有效";
					} else {
						return "无效";
					}
				}
			} ] ],
			toolbar : [ {
				text : '增加',
				iconCls : 'icon-add',
				handler : function() {
					add();
				}
			}, '-', {
				text : '删除',
				iconCls : 'icon-remove',
				handler : function() {
					del();
				}
			}, '-', {
				text : '修改',
				iconCls : 'icon-edit',
				handler : function() {
					edit();
				}
			}, '-', {
				text : '取消选中',
				iconCls : 'icon-undo',
				handler : function() {
					datagrid.datagrid('unselectAll');
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

		bankExtendsAddForm = $('#bankExtendsAddForm').form({
			url : 'bankExtendsAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					bankExtendsAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		bankExtendsAddDialog = $('#bankExtendsAddDialog').show().dialog({
			title : '添加开证行客户关系',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '添加',
				handler : function() {
					bankExtendsAddForm.submit();
				}
			} ]
		});

		bankExtendsEditForm = $('#bankExtendsEditForm').form({
			url : 'bankExtendsAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					bankExtendsEditDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		bankExtendsEditDialog = $('#bankExtendsEditDialog').show().dialog({
			title : '编辑开证行客户关系',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '编辑',
				handler : function() {
					bankExtendsEditForm.submit();
				}
			} ]
		});

		showCdescDialog = $('#showCdescDialog').show().dialog({
			title : '开证行客户关系描述',
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
		$('#custCode')
				.combogrid(
						{
							url : '${dynamicURL}/basic/customerAction!datagrid0.action?',
							idField : 'customerId',
							textField : 'name',
							panelWidth : 600,
							panelHeight : 220,
							toolbar : '#CNNQUERY',
							pagination : true,
							pagePosition : 'bottom',
							rownumbers : true,
							pageSize : 5,
							pageList : [ 5, 10 ],
							fit : true,
							fitColumns : true,
							nowrap : true,
							border : false,
							columns : [ [ {
								field : 'customerId',
								title : '客户编号',
								width : 10
							}, {
								field : 'name',
								title : '客户名称',
								width : 10
							} ] ]
						});
		$('#addCustCode')
		.combogrid(
				{
					url : '${dynamicURL}/basic/customerAction!datagrid0.action',
					idField : 'customerId',
					textField : 'name',
					panelWidth : 600,
					panelHeight : 220,
					toolbar : '#ADDCNNQUERY',
					pagination : true,
					pagePosition : 'bottom',
					rownumbers : true,
					pageSize : 5,
					pageList : [ 5, 10 ],
					fit : true,
					fitColumns : true,
					nowrap : true,
					border : false,
					columns : [ [ {
						field : 'customerId',
						title : '客户编号',
						width : 10
					}, {
						field : 'name',
						title : '客户名称',
						width : 10
					} ] ]
				});
		$('#editCustCode')
		.combogrid(
				{
					url : '${dynamicURL}/basic/customerAction!datagrid0.action',
					idField : 'customerId',
					textField : 'name',
					panelWidth : 600,
					panelHeight : 220,
					toolbar : '#EDITCNNQUERY',
					pagination : true,
					pagePosition : 'bottom',
					rownumbers : true,
					pageSize : 5,
					pageList : [ 5, 10 ],
					fit : true,
					fitColumns : true,
					nowrap : true,
					border : false,
					columns : [ [ {
						field : 'customerId',
						title : '客户编号',
						width : 10
					}, {
						field : 'name',
						title : '客户名称',
						width : 10
					} ] ]
				});
		$('#addBankId')
		.combogrid(
				{
					url : '${dynamicURL}/basic/bankAction!datagrid.do',
					idField : 'bankId',
					textField : 'bankName',
					panelWidth : 600,
					panelHeight : 220,
					toolbar : '#ADDBANKID',
					pagination : true,
					pagePosition : 'bottom',
					rownumbers : true,
					pageSize : 5,
					pageList : [ 5, 10 ],
					fit : true,
					fitColumns : true,
					nowrap : true,
					border : false,
					columns : [ [ {
						field : 'bankId',
						title : '银行编号',
						width : 10
					}, {
						field : 'bankName',
						title : '银行名称',
						width : 10
					} ] ]
				});
		$('#editBankId')
		.combogrid(
				{
					url : '${dynamicURL}/basic/bankAction!datagrid.do',
					idField : 'bankId',
					textField : 'bankName',
					panelWidth : 600,
					panelHeight : 220,
					toolbar : '#EDITBANKID',
					pagination : true,
					pagePosition : 'bottom',
					rownumbers : true,
					pageSize : 5,
					pageList : [ 5, 10 ],
					fit : true,
					fitColumns : true,
					nowrap : true,
					border : false,
					columns : [ [ {
						field : 'bankId',
						title : '银行编号',
						width : 10
					}, {
						field : 'bankName',
						title : '银行名称',
						width : 10
					} ] ]
				});
	});

	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.find('input').val('');
	}
	function add() {
		bankExtendsAddForm.form("clear");
		$('div.validatebox-tip').remove();
		bankExtendsAddDialog.dialog('open');
	}
	function del() {
		var rows = datagrid.datagrid('getSelections');
		var ids = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if (i != rows.length - 1)
							ids = ids + "ids=" + rows[i].rowId + "&";
						else
							ids = ids + "ids=" + rows[i].rowId;
					}
					$.ajax({
						url : 'bankExtendsAction!delete.do',
						data : ids,
						dataType : 'json',
						success : function(response) {
							datagrid.datagrid('load');
							datagrid.datagrid('unselectAll');
							$.messager.show({
								title : '提示',
								msg : '删除成功！'
							});
						}
					});
				}
			});
		} else {
			$.messager.alert('提示', '请选择要删除的记录！', 'error');
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
				url : 'bankExtendsAction!showDesc.do',
				data : {
					rowId : rows[0].rowId
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					bankExtendsEditForm.form("clear");
					CCNMY('','','editCustCode',response.customer);
					CCNMYBANK('','','editBankId',response.bankId);
					bankExtendsEditForm.form('load', response);
					$('div.validatebox-tip').remove();
					bankExtendsEditDialog.dialog('open');
					$.messager.progress('close');
				}
			});
		} else {
			$.messager.alert('提示', '请选择一项要编辑的记录！', 'error');
		}
	}
	function showCdesc(index) {
		var rows = datagrid.datagrid('getRows');
		var row = rows[index];
		$.messager.progress({
			text : '数据加载中....',
			interval : 100
		});
		$.ajax({
			url : 'bankExtendsAction!showDesc.do',
			data : {
				rowId : row.rowId
			},
			dataType : 'json',
			cache : false,
			success : function(response) {
				if (response && response.cdesc) {
					showCdescDialog.find('div[name=cdesc]')
							.html(response.cdesc);
					showCdescDialog.dialog('open');
				} else {
					$.messager.alert('提示', '没有LC_BANK_EXTENDS描述！', 'error');
				}
				$.messager.progress('close');
			}
		});
		datagrid.datagrid('unselectAll');
	}
	function CCNMY(inputId, inputId2, selectId,code) {
		var _CCNTEMP = '';
		var _CCNTEMP2 = '';
		if(code!=''){
			_CCNTEMP2=code;
		}else{
			var _CCNTEMP = $('#' + inputId).val();
			var _CCNTEMP2 = $('#' + inputId2).val();
		}
		var url = '${dynamicURL}/basic/customerAction!datagrid0.action?name='
				+ _CCNTEMP;
		if ("" != _CCNTEMP2) {
			url = url + '&customerId=' + _CCNTEMP2;
		}
		$('#' + selectId).combogrid({
			url : url
		});
	}
	//重置查询客户信息输入框
	function _CCNMYCLEAN(inputId, inputName, selectId) {
		$('#' + inputId).val("");
		$('#' + inputName).val("");
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/basic/customerAction!datagrid0.action'
		});
	}
	//查询银行信息
	function CCNMYBANK(inputId, inputId2, selectId,code) {
		var _CCNTEMP = '';
		var _CCNTEMP2 = '';
		if(code!=''){
			_CCNTEMP2=code;
		}else{
			var _CCNTEMP = $('#' + inputId).val();
			var _CCNTEMP2 = $('#' + inputId2).val();
		}
		var url = '${dynamicURL}/basic/bankAction!datagrid.do?bankName='
				+ _CCNTEMP;
		if ("" != _CCNTEMP2) {
			url = url + '&bankId=' + _CCNTEMP2;
		}
		$('#' + selectId).combogrid({
			url : url
		});
	}
	//重置查询银行信息输入框
	function _CCNMYBANKCLEAN(inputId, inputName, selectId) {
		$('#' + inputId).val("");
		$('#' + inputName).val("");
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/basic/bankAction!datagrid.do'
		});
	}
</script>
</head>
<body class="easyui-layout">
	<div class="zoc" region="north" border="false" collapsible="true"
		style="height: 110px; overflow: hidden;">
		<form id="searchForm">
			<div class="navhead_zoc">
				<span>开证行扩展信息</span>
			</div>
			<div class="part_zoc">
				<div class="partnavi_zoc">
					<span>查询与操作：</span>
				</div>
				<div class="oneline">
					<div class="item25">
						<div class="itemleft60">开证行名称：</div>
						<div class="righttext">
							<input id="portName" name="portName" type="text"
								style="width: 125px" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft60">客户：</div>
						<div class="righttext">
							<input id="custCode" name="customer" type="text"
								style="width: 200px" />
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


	<div id="bankExtendsAddDialog"
		style="display: none; width: 1000px; height: 150px;" align="center">
		<form id="bankExtendsAddForm" method="post">
			<div class="zoc" region="north" border="false" collapsible="true"
				style="height: 110px; overflow: hidden;">
				<div class="part_zoc">
					<div class="oneline">
						<div class="item33">
							<div class="itemleft60">银行</div>
							<div class="righttext">
								<input name="bankId" id="addBankId" type="text" class="easyui-validatebox"
									data-options="" missingMessage="请填写银行ID" style="width: 155px;" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft60">额度</div>
							<div class="righttext">
								<input name="creditLimit" type="text" class="easyui-validatebox"
									data-options="" missingMessage="请填写额度" style="width: 155px;" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft60">币种</div>
							<div class="righttext">
								<input name="currency" type="text" class="easyui-validatebox"
									data-options="" missingMessage="请填写币种" style="width: 155px;" />
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft60">客户</div>
							<div class="righttext">
								<input id="addCustCode" name="customer" type="text"
								style="width: 200px" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft60">有效标识</div>
							<div class="righttext">
								<select name="activeFlag">
									<option value="1">是</option>
									<option value="0">否</option>
								</select>
							</div>
						</div>
						<div class="item33">
							<div class="itemleft60">备注</div>
							<div class="righttext">
								<input name="comments" type="text" class="easyui-validatebox"
									data-options="" missingMessage="请填写备注" style="width: 155px;" />
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>

	<div id="bankExtendsEditDialog"
		style="display: none; width: 1000px; height: 150px;" align="center">
		<form id="bankExtendsEditForm" method="post">
			<div class="zoc" region="north" border="false" collapsible="true"
				style="height: 110px; overflow: hidden;">
				<div class="part_zoc">
					<div class="oneline">
						<div class="item33">
							<input type="hidden" name="rowId">
							<div class="itemleft60">银行</div>
							<div class="righttext">
								<input name="bankId" id="editBankId" type="text" class="easyui-validatebox"
									data-options="" missingMessage="请填写银行ID" style="width: 155px;" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft60">额度</div>
							<div class="righttext">
								<input name="creditLimit" type="text" class="easyui-validatebox"
									data-options="" missingMessage="请填写额度" style="width: 155px;" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft60">币种</div>
							<div class="righttext">
								<input name="currency" type="text" class="easyui-validatebox"
									data-options="" missingMessage="请填写币种" style="width: 155px;" />
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft60">客户</div>
							<div class="righttext">
								<input id="editCustCode" name="customer" type="text"
								style="width: 200px" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft60">有效标识</div>
							<div class="righttext">
							<select name="activeFlag">
									<option value="1">是</option>
									<option value="0">否</option>
								</select>
							</div>
						</div>
						<div class="item33">
							<div class="itemleft60">备注</div>
							<div class="righttext">
								<input name="comments" type="text" class="easyui-validatebox"
									data-options="" missingMessage="请填写备注" style="width: 155px;" />
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	<div id="CNNQUERY">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">客户编号：</div>
				<div class="righttext">
					<input class="short50" id="CNNINPUT2" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">客户名称：</div>
				<div class="righttext">
					<input class="short50" id="CNNINPUT" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item100">
				<div class="oprationbutt">
					<input type="button" value="查询"
						onclick="CCNMY('CNNINPUT','CNNINPUT2','custCode','')" />
				</div>
			</div>
		</div>
	</div>
	<div id="ADDCNNQUERY">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">客户编号：</div>
				<div class="righttext">
					<input class="short50" id="ADDCNNINPUT2" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">客户名称：</div>
				<div class="righttext">
					<input class="short50" id="ADDCNNINPUT" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div class="right">
					<input type="button" value="查询"
						onclick="CCNMY('ADDCNNINPUT','ADDCNNINPUT2','addCustCode','')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_CCNMYCLEAN('ADDCNNINPUT','ADDCNNINPUT2','addCustCode')" />
				</div>
			</div>
		</div>
	</div>
	<div id="EDITCNNQUERY">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">客户编号：</div>
				<div class="righttext">
					<input class="short50" id="EDITCNNINPUT2" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">客户名称：</div>
				<div class="righttext">
					<input class="short50" id="EDITCNNINPUT" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="CCNMY('EDITCNNINPUT','EDITCNNINPUT2','editCustCode','')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_CCNMYCLEAN('EDITCNNINPUT','EDITCNNINPUT2','editCustCode')" />
				</div>
			</div>
		</div>
	</div>
	<div id="ADDBANKID">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">银行编号：</div>
				<div class="righttext">
					<input class="short50" id="ADDBANKIDINPUT2" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">银行名称：</div>
				<div class="righttext">
					<input class="short50" id="ADDBANKIDINPUT" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="CCNMYBANK('ADDBANKIDINPUT','ADDBANKIDINPUT2','addBankId','')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_CCNMYBANKCLEAN('ADDBANKIDINPUT','ADDBANKIDINPUT2','addBankId')" />
				</div>
			</div>
		</div>
	</div>
	<div id="EDITBANKID">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">银行编号：</div>
				<div class="righttext">
					<input class="short50" id="EDITBANKIDINPUT2" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">银行名称：</div>
				<div class="righttext">
					<input class="short50" id="EDITBANKIDINPUT" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="CCNMYBANK('EDITBANKIDINPUT','EDITBANKIDINPUT2','editBankId','')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_CCNMYBANKCLEAN('EDITBANKIDINPUT','EDITBANKIDINPUT2','editBankId')" />
				</div>
			</div>
		</div>
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