<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var searchForm;
	var datagrid;
	var bankAddDialog;
	var bankAddForm;
	var cdescAdd;
	var bankEditDialog;
	var bankEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	$(function() {
		//查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'bankAction!datagrid.do',
			title : '开证行列表',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 50,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			fitColumns : true,
			nowrap : false,
			border : false,
			columns : [ [ {
				field : 'ck',
				checkbox : true,
				formatter : function(value, row, index) {
					return row.bankId;
				}
			}, {
				field : 'bankName',
				title : '银行名称',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.bankName;
				}
			}, {
				field : 'country',
				title : '国家',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.countyname;
				}
			}, {
				field : 'creditLimit',
				title : '开证行额度',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.creditLimit;
				}
			}, {
				field : 'currency',
				title : '额度币种',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.currency;
				}
			}, {
				field : 'bankTyep',
				title : '开证行类型',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.bankTyep;
				}
			}, {
				field : 'highRiskFlag',
				title : '是否高危国家',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					if (row.highRiskFlag == "1") {
						return "是";
					} else {
						return "否";
					}
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
			}, {
				field : 'comments',
				title : '备注',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.comments;
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
			}, '-' ]
		});

		bankAddForm = $('#bankAddForm').form({
			url : 'bankAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					bankAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		bankAddDialog = $('#bankAddDialog').show().dialog({
			title : '添加开证行',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '添加',
				handler : function() {
					bankAddForm.submit();
				}
			} ]
		});

		bankEditForm = $('#bankEditForm').form({
			url : 'bankAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					bankEditDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		bankEditDialog = $('#bankEditDialog').show().dialog({
			title : '编辑开证行',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '编辑',
				handler : function() {
					bankEditForm.submit();
				}
			} ]
		});
		//加载国家信息
		$('#countryCodeFinish').combogrid({
			url : '${dynamicURL}/basic/countryAction!datagrid.do',
			textField : 'name',
			idField : 'countryCode',
			panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_COUNTRYHISTORY',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			columns : [ [ {
				field : 'countryCode',
				title : '国家编码',
				width : 20
			}, {
				field : 'name',
				title : '国家名称',
				width : 20
			} ] ]
		});
		//加载新增国家信息
		$('#addCountry').combogrid({
			url : '${dynamicURL}/basic/countryAction!datagrid.do',
			textField : 'name',
			idField : 'countryCode',
			panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_ADDCOUNTRY',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			columns : [ [ {
				field : 'countryCode',
				title : '国家编码',
				width : 20
			}, {
				field : 'name',
				title : '国家名称',
				width : 20
			} ] ]
		});
		//加载修改国家信息
		$('#editCountry').combogrid({
			url : '${dynamicURL}/basic/countryAction!datagrid.do',
			textField : 'name',
			idField : 'countryCode',
			panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_EDITCOUNTRY',
			rownumbers : true,
			pageSize : 500,
			pageList : [ 100, 200,300,500 ],
			fit : true,
			fitColumns : true,
			columns : [ [ {
				field : 'countryCode',
				title : '国家编码',
				width : 20
			}, {
				field : 'name',
				title : '国家名称',
				width : 20
			} ] ]
		});
		showCdescDialog = $('#showCdescDialog').show().dialog({
			title : '开证行描述',
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
		searchForm.form('clear');
	}
	function add() {
		bankAddForm.form("clear");
		$('div.validatebox-tip').remove();
		bankAddDialog.dialog('open');
	}
	function del() {
		var rows = datagrid.datagrid('getSelections');
		var ids = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if (i != rows.length - 1)
							ids = ids + "ids=" + rows[i].bankId + "&";
						else
							ids = ids + "ids=" + rows[i].bankId;
					}
					$.ajax({
						url : 'bankAction!delete.do',
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
				url : 'bankAction!showDesc.do',
				data : {
					bankId : rows[0].bankId
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					bankEditForm.form("clear");
					bankEditForm.form('load', response);
					$('div.validatebox-tip').remove();
					bankEditDialog.dialog('open');
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
			url : 'bankAction!showDesc.do',
			data : {
				bankId : row.bankId
			},
			dataType : 'json',
			cache : false,
			success : function(response) {
				if (response && response.cdesc) {
					showCdescDialog.find('div[name=cdesc]')
							.html(response.cdesc);
					showCdescDialog.dialog('open');
				} else {
					$.messager.alert('提示', '没有LC_BANK描述！', 'error');
				}
				$.messager.progress('close');
			}
		});
		datagrid.datagrid('unselectAll');
	}
	//模糊查询国家下拉列表
	function _CCNMY(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid(
				{
					url : '${dynamicURL}/basic/countryAction!datagrid.do?name='
							+ _CCNTEMP + '&countryCode=' + _CCNCODE
				});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询国家信息输入框
	function _CCNMYCLEAN(inputId, inputName, selectId) {
		$('#' + inputId).val("");
		$('#' + inputName).val("");
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/basic/countryAction!datagrid.do'
		});
	}
	
	function toUpper(value) {
		var elementId = value.attributes["id"].nodeValue;
		var lowerValue = $("#"+elementId).val();
		if(lowerValue != null) {
			$("#"+elementId).val(lowerValue.toUpperCase());
		}
	}
</script>
</head>
<body class="easyui-layout">
	<div class="zoc" region="north" border="false" collapsible="true"
					title="查询条件" collapsed="true" style="height: 170px; overflow: hidden;">
		<form id="searchForm">
			<div class="navhead_zoc">
				<span>开证行信息</span>
			</div>
			<div class="part_zoc">
				<div class="partnavi_zoc">
					<span>查询与操作：</span>
				</div>
				<div class="oneline">
					<div class="item25">
						<div class="itemleft60">开证行名称：</div>
						<div class="righttext">
							<input id="bankName" name="bankName" type="text"
								style="width: 125px" />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft60">国家：</div>
						<div class="rightselect_easyui">
							<input id="countryCodeFinish" name="country" class="short50"
								type="text" />
						</div>
					</div>
				    <div class="item25">
						<div class="itemleft80">开证行类型:</div>
						<div class="righttext_easyui">
	                    <input name="bankTyep" type="text"
											class="easyui-combobox short50"
											data-options="valueField:'itemCode',textField:'itemNameCn',url:'${dynamicURL}/basic/sysLovAction!comboxBankType.do'" />
						</div>
				    </div>
				    
				    <div class="item25">
					<div class="itemleft80">是否高危:</div>
					<div class="righttext_easyui">
						<s:textfield  cssClass="easyui-combobox short50" type="text" name="highRiskFlag" data-options="
			               valueField: 'label',
			               textField: 'value',
			              data: [{
				           label: '1',
				           value: '是'
			               },{
				           label: '0',
				           value: '否'
			               }]">
                    </s:textfield> 
					</div>
				</div>
				</div>
				<div class="oneline">
				    <div class="item25">
						<div class="oprationbutt">
							<input type="button" value="查  询" onclick="_search();" /> <input
								type="button" value="重  置" onclick="cleanSearch();" />
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>

	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>


	<div id="bankAddDialog"
		style="display: none; width: 800px; height: 200px;" align="center">
		<form id="bankAddForm" method="post">
			<div class="zoc" region="north" border="false" collapsible="true" style="height: 90px; overflow: hidden;">
				<div class="part_zoc">
					<div class="oneline">
						<div class="item25">
							<div class="itemleft60">银行名称:</div>
							<div class="righttext">
								<input name="bankName" id="addBankName" type="text" class="easyui-validatebox"
									data-options="" missingMessage="请填写银行名称" style="width: 155px;" onblur="toUpper(this);"/>
							</div>
						</div>
						<div class="item25">
							<div class="itemleft60">国家:</div>
							<div class="righttext">
								<input name="country" id="addCountry" type="text" class="easyui-validatebox"
									data-options="" missingMessage="请填写国家" style="width: 155px;" />
							</div>
						</div>
						<div class="item25">
							<div class="itemleft60">开证行额度:</div>
							<div class="righttext">
								<input name="creditLimit" type="text" class="easyui-validatebox"
									data-options="" missingMessage="请填写开证行额度" style="width: 155px;" />
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item25">
							<div class="itemleft60">额度币种:</div>
							<div class="righttext_easyui">
		                    <input name="currency" type="text" style="width: 155px;"
												class="easyui-combobox short50"
												data-options="valueField:'itemCode',textField:'itemNameCn',url:'${dynamicURL}/basic/sysLovAction!comboxCurrency.do'" />
							</div>
				        </div>
						<div class="item25">
							<div class="itemleft60">是否高危国家:</div>
							<div class="righttext">
								<select name="highRiskFlag">
									<option value="1">是</option>
									<option value="0">否</option>
								</select>
							</div>
						</div>
						<div class="item25">
							<div class="itemleft60">备注:</div>
							<div class="righttext">
								<input name="comments" type="text" class="easyui-validatebox"
									data-options="" missingMessage="请填写备注" style="width: 155px;" />
							</div>
						</div>
					</div>
					<div class="oneline">
					<div class="item25">
						<div class="itemleft60">类型:</div>
						<div class="righttext_easyui">
	                    <input name="bankTyep" type="text" style="width: 155px;"
											class="easyui-combobox short50"
											data-options="valueField:'itemCode',textField:'itemNameCn',url:'${dynamicURL}/basic/sysLovAction!comboxBankType.do'" />
						</div>
				    </div>
				    </div>
				</div>
			</div>
		</form>
	</div>

	<div id="bankEditDialog"
		style="display: none; width: 800px; height: 200px;" align="center">
		<form id="bankEditForm" method="post">
		<div class="zoc" region="north" border="false" collapsible="true" style="height: 90px; overflow: hidden;">
				<div class="part_zoc">
					<div class="oneline">
						<input type="hidden" name="bankId">
						<div class="item25">
							<div class="itemleft60">银行名称:</div>
							<div class="righttext">
								<input name="bankName" id="editBankName" type="text" readonly="readonly" class="easyui-validatebox"
									data-options="" missingMessage="请填写银行名称" style="width: 155px;" onblur="toUpper(this);"/>
							</div>
						</div>
						<div class="item25">
							<div class="itemleft60">国家:</div>
							<div class="righttext">
								<input name="country" id="editCountry" type="text" class="easyui-validatebox"
									data-options="" missingMessage="请填写国家" style="width: 155px;" />
							</div>
						</div>
						<div class="item25">
							<div class="itemleft60">开证行额度:</div>
							<div class="righttext">
								<input name="creditLimit" type="text" class="easyui-validatebox"
									data-options="" missingMessage="请填写开证行额度" style="width: 155px;" />
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item25">
							<div class="itemleft60">额度币种:</div>
							<div class="righttext_easyui">
		                    <input name="currency" type="text" style="width: 155px;"
												class="easyui-combobox short50"
												data-options="valueField:'itemCode',textField:'itemNameCn',url:'${dynamicURL}/basic/sysLovAction!comboxCurrency.do'" />
							</div>
				        </div>
						<div class="item25">
							<div class="itemleft60">是否高危国家:</div>
							<div class="righttext">
								<select name="highRiskFlag">
									<option value="1">是</option>
									<option value="0">否</option>
								</select>
							</div>
						</div>
						<div class="item25">
							<div class="itemleft60">备注:</div>
							<div class="righttext">
								<input name="comments" type="text" class="easyui-validatebox"
									data-options="" missingMessage="请填写备注" style="width: 155px;" />
							</div>
						</div>
					</div>
					
					<div class="oneline">
					<div class="item25">
						<div class="itemleft60">类型:</div>
						<div class="righttext_easyui">
	                    <input name="bankTyep" type="text" style="width: 155px;"
											class="easyui-combobox short50"
											data-options="valueField:'itemCode',textField:'itemNameCn',url:'${dynamicURL}/basic/sysLovAction!comboxBankType.do'" />
						</div>
				    </div>
				    </div>
					
				</div>
			</div>
		</form>
	</div>
	<div id="_COUNTRYHISTORY">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">国家编号：</div>
				<div class="righttext">
					<input class="short50" id="_COUNTRYCODEHISTORY" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">国家名：</div>
				<div class="righttext">
					<input class="short60" id="_COUNTRYINPUTHISTORY" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_CCNMY('_COUNTRYCODEHISTORY','_COUNTRYINPUTHISTORY','countryCodeFinish')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_CCNMYCLEAN('_COUNTRYCODEHISTORY','_COUNTRYINPUTHISTORY','countryCodeFinish')" />
				</div>
			</div>
		</div>
	</div>
	<div id="_ADDCOUNTRY">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">国家编号：</div>
				<div class="righttext">
					<input class="short50" id="_ADDCOUNTRYCODEHISTORY" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">国家名：</div>
				<div class="righttext">
					<input class="short60" id="_ADDCOUNTRYINPUTHISTORY" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_CCNMY('_ADDCOUNTRYCODEHISTORY','_ADDCOUNTRYINPUTHISTORY','addCountry')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_CCNMYCLEAN('_ADDCOUNTRYCODEHISTORY','_ADDCOUNTRYINPUTHISTORY','addCountry')" />
				</div>
			</div>
		</div>
	</div>
	<div id="_EDITCOUNTRY">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">国家编号：</div>
				<div class="righttext">
					<input class="short50" id="_EDITCOUNTRYCODEHISTORY" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">国家名：</div>
				<div class="righttext">
					<input class="short60" id="_EDITCOUNTRYINPUTHISTORY" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_CCNMY('_EDITCOUNTRYCODEHISTORY','_EDITCOUNTRYINPUTHISTORY','editCountry')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_CCNMYCLEAN('_EDITCOUNTRYCODEHISTORY','_EDITCOUNTRYINPUTHISTORY','editCountry')" />
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