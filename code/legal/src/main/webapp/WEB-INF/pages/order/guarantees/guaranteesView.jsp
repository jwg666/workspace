<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%/**
	保函的查询页面，不能修改
	---修改的代码还留着
*/ %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var searchForm;
	var datagrid;
	var guaranteesAddDialog;
	var guaranteesAddForm;
	var cdescAdd;
	var guaranteesEditDialog;
	var guaranteesEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	$(function() {
		//查询列表	
		searchForm = $('#searchForm').form();
		
		$('#dateGrid_version').datagrid({
			title : '保函修改历史',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			autoRowHeight : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			singleSelect : true,
			fitColumns : false,
			nowrap : true,
			border : false,
			columns : [ [
			{
				field : 'guarantees',
				title : '保函号',
				width : 100,
				align : 'center',
				sortable : true
			}, {
				field : 'beneficiaries',
				title : '受益人',
				width : 100,
				align : 'center',
				sortable : true
			}, {
				field : 'customerCode',
				title : '客户名称',
				width : 100,
				align : 'center',
				sortable : true
			}, {
				field : 'bankName',
				title : '开证行',
				width : 200,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.bankName;
				}
			}, {
				field : 'notifyBank',
				title : '通知行',
				width : 200,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.notifyBank;
				}
			}, {
				field : 'modifyNum',
				title : '改证次数',
				width : 100,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.modifyNum;
				}
			}, {
				field : 'payType',
				title : '类别',
				width : 100,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					if (value == "1") {
						return '保函';
					}
					if (value == "2") {
						return '备用信用证';
					}
				}
			}, {
				field : 'currency',
				title : '币种',
				width : 100,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.currency;
				}
			}, {
				field : 'amount',
				title : '金额',
				width : 100,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.amount;
				}
			}, {
				field : 'cycleFlag',
				title : '循环标识',
				width : 100,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					if (value == '1') {
						return '可循环';
					} else {
						return '不可循环';
					}
				}
			}, {
				field : 'payPeriod',
				title : '付款周期',
				align : 'center',
				width : 100,
				sortable : true,
				formatter : function(value, row, index) {
					return row.payPeriod;
				}
			}, {
				field : 'docAgainstDay',
				title : '单证交单期',
				width : 200,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.docAgainstDay;
				}
			}, {
				field : 'startDate',
				title : '开证日',
				width : 200,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.startDate);
				}
			}, {
				field : 'endDate',
				title : '到期日',
				width : 200,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.endDate);
				}
			}/* , {
				field : 'valid',
				title : '有效期',
				width : 100,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.valid;
				}
			} */ ] ]
		});
		
		datagrid = $('#datagrid').datagrid({
			url : 'guaranteesAction!datagrid.do',
			title : '保函维护列表',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			autoRowHeight : false,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			singleSelect : true,
			fitColumns : false,
			nowrap : true,
			border : false,
			onDblClickRow : function(index, row) {
				//查看明细
				showDesc(row.guarantees);
			},
			//idField : 'guarantees',
			columns : [ [ {
				field : 'ck',
				checkbox : true,
				formatter : function(value, row, index) {
					return row.guarantees;
				}
			}, {
				field : 'guarantees',
				title : '保函号',
				width : 100,
				align : 'center',
				sortable : true,
				formatter:function(value, row, index){
					return '<a href="#" style="color:blue" onclick="showDesc(\''+row.guarantees+'\');return false;">'+row.guarantees+'</a>'
				}
			}, {
				field : 'beneficiaries',
				title : '受益人',
				width : 100,
				align : 'center',
				sortable : true
			}, {
				field : 'customerCode',
				title : '客户编码',
				width : 100,
				align : 'center',
				sortable : true
			}, {
				field : 'customerName',
				title : '客户名',
				width : 200,
				align : 'center',
				sortable : true
			}, {
				field : 'bankName',
				title : '开证行',
				width : 200,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.bankName;
				}
			}, {
				field : 'notifyBank',
				title : '通知行',
				width : 200,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.notifyBank;
				}
			}, {
				field : 'modifyNum',
				title : '改证次数',
				width : 100,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.modifyNum;
				}
			}, {
				field : 'payType',
				title : '类别',
				width : 100,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					if (value == "1") {
						return '保函';
					}
					if (value == "2") {
						return '备用信用证';
					}
				}
			}, {
				field : 'currency',
				title : '币种',
				width : 100,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.currency;
				}
			}, {
				field : 'amount',
				title : '金额',
				width : 100,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.amount;
				}
			}, {
				field : 'cycleFlag',
				title : '循环标识',
				width : 100,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					if (value == '1') {
						return '可循环';
					} else {
						return '不可循环';
					}
				}
			}, {
				field : 'payPeriod',
				title : '付款周期',
				align : 'center',
				width : 100,
				sortable : true,
				formatter : function(value, row, index) {
					return row.payPeriod;
				}
			}, {
				field : 'docAgainstDay',
				title : '单证交单期',
				width : 200,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.docAgainstDay;
				}
			}, {
				field : 'startDate',
				title : '开证日',
				width : 200,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.startDate);
				}
			}, {
				field : 'endDate',
				title : '到期日',
				width : 200,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.endDate);
				}
			}/* , {
				field : 'valid',
				title : '有效期',
				width : 100,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.valid;
				}
			} */, {
				field : 'docAuditFlag',
				title : '单证审核标识',
				width : 100,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					if (value == '1') {
						return '通过';
					} else if (value == '0') {
						return "不通过";
					} else {
						return '';
					}
				}
			}, {
				field : 'docAuditOpenion',
				title : '单证审核意见',
				align : 'center',
				width : 200,
				sortable : true,
				formatter : function(value, row, index) {
					if (null != row.docAuditOpenion) {
						try {
							var json = $.parseJSON(row.docAuditOpenion);
							return json.result;
						} catch (err) {
							return '';
						}
					} else {
						return '';
					}
				}
			}, {
				field : 'docAuditCode',
				title : '单证审核人',
				width : 100,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.docAuditCode;
				}
			}, {
				field : 'finAuditFlag',
				title : '财务审核标识',
				width : 100,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					if (value == '1') {
						return '通过';
					} else if (value == '0') {
						return "不通过";
					} else {
						return '';
					}
				}
			}, {
				field : 'finAuditOpenion',
				title : '财务审核意见',
				width : 200,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					if (null != row.finAuditOpenion) {
						try {
							var json = $.parseJSON(row.finAuditOpenion);
							return json.result;
						} catch (err) {
							$.messager.alert('数据错误', err, 'error');
						}
					} else {
						return '';
					}
				}
			}, {
				field : 'finAuditCode',
				title : '财务审核人',
				width : 100,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.finAuditCode;
				}
			} ] ],
			toolbar : [],
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
		guaranteesDescDialog = $('#guaranteesDescDialog').show().dialog({
			title : '保函信息',
			modal : true,
			closed : true,
			maximized:true,
			maximizable : true
		});
		guaranteesDescForm = $("#guaranteesDescForm").form({
			onLoadSuccess : function(data) {
				if (data.payType == '1') {
					$("#payTypeDesc").html('保函');
				} else {
					$("#payTypeDesc").html('备用信用证');
				}
				if (data.cycleFlag == '1') {
					$("#cycleFlagDesc").html('是');
				} else {
					$("#cycleFlagDesc").html('否');
				}
				$.messager.progress('close');

			}
		});
		guaranteesAddForm = $('#guaranteesAddForm').form({
			url : 'guaranteesAction!add.action',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					guaranteesAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		guaranteesAddDialog = $('#guaranteesAddDialog').show().dialog({
			title : '添加保函',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '添加',
				handler : function() {
					if ($("#guarantees").val() != '') {
						$.ajax({
							url : 'guaranteesAction!existGuarantees.action',
							dataType : 'json',
							data : {
								"guarantees" : $("#guarantees").val()
							},
							success : function(json) {
								if (json.success) {
									$.messager.alert('提示', '保函号已存在，请重新输入。', 'info', function() {
										$("#guarantees").focus();
									});
								} else {
									if (guaranteesAddForm.form('validate')) {
										//判断时间范围
										var sDate = new Date($("#startDateAdd").val())
										var eDate = new Date($("#endDateAdd").val())
										if (sDate > eDate) {
											$.messager.alert('提示', '开证日必须早于到期日', 'error');
											$("#startDateAdd").focus();
										} else {
											guaranteesAddForm.submit();
										}
									}
								}
							}
						});
					} else {
						guaranteesAddForm.submit();
					}
				}
			} ]
		});

		guaranteesEditForm = $('#guaranteesEditForm').form({
			url : 'guaranteesAction!edit.action',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					guaranteesEditDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		guaranteesEditDialog = $('#guaranteesEditDialog').show().dialog({
			title : '编辑保函维护',
			modal : true,
			closed : true,
			resizable : true,
			maximizable : true,
			buttons : [ {
				text : '保存',
				handler : function() {
					if ($("#guarantees0").val() != '' && $("#guarantees0").val() != $("#guaranteesOldHidden").val()) {
						$.ajax({
							url : 'guaranteesAction!existGuarantees.action',
							dataType : 'json',
							data : {
								"guarantees" : $("#guarantees0").val()
							},
							success : function(json) {
								if (json.success) {
									$.messager.alert('提示', '保函号已存在，请重新输入。', function() {
										$("#guarantees0").focus();
									});
								} else {
									if (guaranteesEditForm.form('validate')) {
										//判断时间范围
										var sDate = new Date($("#startDateEdit").val())
										var eDate = new Date($("#endDateEdit").val())
										if (sDate > eDate) {
											$.messager.alert('提示', '开证日必须早于到期日', 'error');
											$("#startDateEdit").focus();
										} else {
											guaranteesEditForm.submit();
										}
									}
								}
							}
						});
					} else {
						if (guaranteesEditForm.form('validate')) {
							//判断时间范围
							var sDate = new Date($("#startDateEdit").val())
							var eDate = new Date($("#endDateEdit").val())
							if (sDate > eDate) {
								$.messager.alert('提示', '开证日必须早于到期日', 'error');
								$("#startDateEdit").focus();
							} else {
								guaranteesEditForm.submit();
							}
						}
					}
				}
			} ]
		});

		showCdescDialog = $('#showCdescDialog').show().dialog({
			title : '保函维护描述',
			modal : true,
			closed : true,
			resizable : true,
			maximizable : true
		});

		iframeDialog = $('#iframeDialog').show().dialog({
			title : 'POP弹出页面',
			modal : true,
			closed : true,
			maximizable : true
		});

		$("#currencySearch").combobox({
			url : 'guaranteesAction!comboCurrency.action',
			valueField : 'itemCode',
			textField : 'itemNameCn'
		});

	});

	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.form('clear');
	}
	function _CCNMY(inputId, selectId) {
		var _CCNTEMP = $('#' + inputId).val()
		$('#' + selectId).combogrid({
			url : '../basic/customerAction!datagrid0.action?name=' + _CCNTEMP
		});
		$('#' + inputId).val(_CCNTEMP);
	}
	function add() {
		guaranteesAddForm.form("clear");
		$('div.validatebox-tip').remove();
		$("#customerCode").combogrid({
			url : '${dynamicURL}/basic/customerAction!datagrid0.action',
			textField : 'name',
			idField : 'customerId',
			panelWidth : 500,
			panelHeight : 220,
			toolbar : '#_CNNQUERY',
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
				field : 'name',
				title : '客户名称',
				width : 20
			} ] ]
		});
		$("#currency").combobox({
			url : 'guaranteesAction!comboCurrency.action',
			valueField : 'itemCode',
			textField : 'itemNameCn'
		});
		guaranteesAddDialog.dialog('open');
	}
	function del() {
		var rows = datagrid.datagrid('getSelections');
		var ids = "";
		if (rows.length == 1) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					$.ajax({
						url : 'guaranteesAction!delete.action',
						data : {
							"guarantees" : rows[0].guarantees
						},
						dataType : 'json',
						success : function(response) {
							if (response.success) {
								$.messager.show({
									title : '提示',
									msg : '删除成功！'
								});
							} else {
								$.messager.show({
									title : '提示',
									msg : '删除失败！'
								});
							}
							datagrid.datagrid('load');
							datagrid.datagrid('unselectAll');

						}
					});
				}
			});
		} else {
			$.messager.alert('提示', '请选择一条要删除的记录！', 'error');
		}
	}
	function edit() {
		var rows = datagrid.datagrid('getSelections');
		if (rows.length == 1) {
			//只有审核意见都不为空时，说明已经审核完毕，可以修改。
			if (rows[0].docAuditFlag != null && rows[0].finAuditFlag != null) {
				$.messager.progress({
					text : '数据加载中....',
					interval : 100
				});
				$.ajax({
					url : 'guaranteesAction!showDescExternal.action',
					data : {
						guarantees : rows[0].guarantees
					},
					dataType : 'json',
					cache : false,
					success : function(response) {
						if (response == null) {
							$.messager.alert('消息', '记录未找到，可能已经被删除', 'info', function() {
								datagrid.datagrid('load');
								$.messager.progress('close');
							});
							return;
						}
						guaranteesEditForm.form("clear");
						guaranteesEditForm.form('load', response);
						$("#guaranteesOldHidden").val(response.guarantees);
						$('div.validatebox-tip').remove();
						$("#customerCode0").combogrid({
							url : '../basic/customerAction!datagrid0.action?customerId=' + response.customerCode,
							textField : 'name',
							idField : 'customerId',
							panelWidth : 500,
							panelHeight : 220,
							toolbar : '#_CNNQUERYHISTORY',
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
								field : 'name',
								title : '客户名称',
								width : 20
							} ] ]
						});
						$("#customerCode0").combogrid('setValue', response.customerCode);
						$("#currency0").combobox({
							url : 'guaranteesAction!comboCurrency.action',
							valueField : 'itemCode',
							textField : 'itemNameCn',
							onLoadSuccess : function() {
								$("#currency0").combobox('setValue', response.currency);
							}
						});
						guaranteesEditDialog.dialog('open');
						$.messager.progress('close');
					}
				});
			} else {
				$.messager.alert('提示', '该记录正在审核流程中，不能修改', 'error');
			}
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
			url : 'guaranteesAction!showDesc.do',
			data : {
				guarantees : row.guarantees
			},
			dataType : 'json',
			cache : false,
			success : function(response) {
				if (response && response.cdesc) {
					showCdescDialog.find('div[name=cdesc]').html(response.cdesc);
					showCdescDialog.dialog('open');
				} else {
					$.messager.alert('提示', '没有保函维护描述！', 'error');
				}
				$.messager.progress('close');
			}
		});
		datagrid.datagrid('unselectAll');
	}
	//判断是否存在保函 号
	function existGuarantees(editFlag) {
		var guarantees_;
		if (editFlag) {
			if ($("#guarantees0").val() == $("#guaranteesOldHidden").val()) {
				return;
			}
			guarantees_ = $("#guarantees0").val();
		} else {
			guarantees_ = $("#guarantees").val();
		}
		if (guarantees_ == '') {
			return;
		}
		$.ajax({
			url : 'guaranteesAction!existGuarantees.action',
			dataType : 'json',
			data : {
				"guarantees" : guarantees_
			},
			success : function(json) {
				if (json.success) {
					$.messager.alert('提示', '保函号已存在，请重新输入。', 'info', function() {
						if (editFlag) {
							$("#guarantees0").focus();
						} else {
							$("#guarantees").focus();
						}
					});
				} else {
					return;
				}
			}
		});
	}
	//查看保函信息
	function showDesc(guarantees) {
		//descForm.load
		$("#guaranteesDescForm").form('load', 'guaranteesAction!showDescExternal.action?guarantees=' + guarantees);
		guaranteesDescDialog = $("#guaranteesDescDialog").show();
		guaranteesDescDialog.dialog('open');
		$.messager.progress();
		datagrid.datagrid('unselectAll');
		
		$('#dateGrid_version').datagrid({url : 'guaranteesVersionAction!datagrid.do',queryParams:{
			guarantees:guarantees
		}});
	}
</script>
</head>
<body class="easyui-layout zoc">
	<div region="north" border="false" collapsed="true" title="保函查询"
		style="height: 170px;">
		<div class="part_zoc">
			<form id="searchForm">
				<div class="oneline">
					<div class="item25">
						<div class="itemleft80">受益人：</div>
						<div class="righttext">
							<span><input name="beneficiaries" type="text"
								maxlength="120" class="short50" /></span>
						</div>
					</div>
					<div class="item25">
						<div class="itemleft80">客户名称：</div>
						<div class="righttext">
							<span><input name="customerName" type="text"
								class="short50" /></span>
						</div>
					</div>
					<div class="item25">
						<div class="itemleft80">客户编码：</div>
						<div class="righttext">
							<span><input name="customerCode" type="text"
								maxlength="32" class="short50" /></span>
						</div>
					</div>
					<div class="item25">
						<div class="itemleft80">开证行：</div>
						<div class="righttext">
							<span><input name="bankName" type="text" class="short50"
								maxlength="120" /></span>
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item25">
						<div class="itemleft80">保函号：</div>
						<div class="righttext">
							<span><input name="guarantees" type="text" class="short50"
								maxlength="64" /></span>
						</div>
					</div>
					<div class="item25">
						<div class="itemleft80">改证次数：</div>
						<div class="righttext">
							<span><input name="modifyNum" type="text" class="short50"
								maxlength="19" /></span>
						</div>
					</div>
					<div class="item25">
						<div class="itemleft80">类别：</div>
						<div class="righttext">
							<select class="easyui-combobox" name="payType">
								<option value="">全部</option>
								<option value="1">保函</option>
								<option value="2">备用信用证</option>
							</select>
						</div>
					</div>
					<div class="item25">
						<div class="itemleft80">币种：</div>
						<div class="righttext">
							<select class="easyui-combobox" name="currency"
								id="currencySearch" style="width: 100px;"></select>
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item25">
						<div class="itemleft80">金额：</div>
						<div class="righttext">
							<span><input name="amount" type="text" maxlength="19"
								data-options="precision:2" class="short50 numberbox" /></span>
						</div>
					</div>
					<div class="item25">
						<div class="itemleft80">开证日：</div>
						<div class="righttext">
							<span><input name="startDate" type="text"
								class="short50 easyui-datebox" /></span>
						</div>
					</div>
					<div class="item25">
						<div class="itemleft80">到期日：</div>
						<div class="righttext">
							<span><input name="endDate" type="text"
								class="short50  easyui-datebox" /></span>
						</div>
					</div>
					<!-- <div class="item25">
						<div class="itemleft80">有效期：</div>
						<div class="righttext">
							<span><input name="valid" type="text" class="short50" /></span>
						</div>
					</div> -->
				</div>
				<div class="oneline">
					<div class="item25">
						<div class="itemleft80">循环标识：</div>
						<div class="righttext">
							<select class="easyui-combobox" name="cycleFlag" class="short50">
								<option value="">全部</option>
								<option value="1">可循环</option>
								<option value="0">不可循环</option>
							</select>
						</div>
					</div>
					<div class="item25">
						<div class="itemleft80">付款周期：</div>
						<div class="righttext">
							<span><input name="payPeriod" type="text" class="short50"
								maxlength="19" /></span>
						</div>
					</div>
					<div class="item25">
						<div class="itemleft80">单证交单期：</div>
						<div class="righttext">
							<span><input name="docAgainstDay" type="text"
								maxlength="32" class="short50" /></span>
						</div>
					</div>
					<div class="item25">
						<div class="itemleft100">单证审核标识：</div>
						<div class="righttext">
							<select class="easyui-combobox short50" name="docAuditFlag">
								<option value="">全部</option>
								<option value="1">通过</option>
								<option value="0">不通过</option>
							</select>
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item25">
						<div class="itemleft100">财务审核标识：</div>
						<div class="righttext">
							<select class="easyui-combobox short50" name="finAuditFlag">
								<option value="">全部</option>
								<option value="1">通过</option>
								<option value="0">不通过</option>
							</select>
						</div>
					</div>
					<div class="item50">
						<div class="rightbutt">
							<input type="button" value="查询" onclick="_search();" /><input
								type="button" value="清空"
								onclick="$('#searchForm').form('clear');_search();" />
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>

	<div region="center" style="height: 400px;">
		<table id="datagrid"></table>
	</div>

	<div id="menu" class="easyui-menu" style="width: 120px; display: none;">
		<div onclick="add();" iconCls="icon-add">增加</div>
		<div onclick="del();" iconCls="icon-remove">删除</div>
		<div onclick="edit();" iconCls="icon-edit">编辑</div>
	</div>

	<div id="guaranteesAddDialog"
		style="display: none; width: 1015px; height: 350px;">
		<form id="guaranteesAddForm" method="post">
			<div class="part_zoc">
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">保函号：</div>
						<div class="righttext">
							<input name="guarantees" id="guarantees" type="text"
								class="easyui-validatebox" data-options="required:true"
								missingMessage="请填写保函号" style="width: 155px;" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">受益人</div>
						<div class="righttext">
							<input name="beneficiaries" type="text"
								class="easyui-validatebox" data-options="required:true"
								missingMessage="请填写受益人" style="width: 155px;" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">客户：</div>
						<div class="righttext">
							<select name="customerCode" class="easyui-validatebox"
								style="width: 155px;" data-options="required:true"
								missingMessage="请填写客户名称" id="customerCode"></select>
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">开证行</div>
						<div class="righttext">
							<input name="bankName" type="text" class="easyui-validatebox"
								data-options="required:true" missingMessage="请填写开证行"
								style="width: 155px;" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">改证次数</div>
						<div class="righttext">
							<input name="modifyNum" type="text"
								class="easyui-validatebox easyui-numberbox"
								data-options="required:true" missingMessage="请填写改证次数"
								style="width: 155px;" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">类型</div>
						<div class="righttext">
							<!-- <input name="payType" type="text" class="easyui-validatebox"
								data-options="required:true" missingMessage="请填写类型"
								style="width: 155px;" /> -->
							<select class="easyui-combobox easyui-validatebox" name="payType"
								data-options="required:true" missingMessage="请填写类型"
								style="width: 155px;">
								<option value="1">保函</option>
								<option value="2">备用信用证</option>
							</select>
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">币种</div>
						<div class="righttext">
							<select id="currency" class="easyui-validatebox"
								style="width: 155px;" name="currency"
								data-options="required:true" missingMessage="请填写币种"></select>
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">金额</div>
						<div class="righttext">
							<input name="amount" type="text" class="easyui-numberbox"
								data-options="precision:2,required:true"
								missingMessage="请填写金额" style="width: 155px;" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">是否循环</div>
						<div class="righttext">
							<input type="checkbox" name="cycleFlag" value="1" />
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">付款周期</div>
						<div class="righttext">
							<input name="payPeriod" type="text" class="easyui-validatebox"
								data-options="required:true" missingMessage="请填写付款周期"
								style="width: 155px;" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">单证交单期</div>
						<div class="righttext">
							<input name="docAgainstDay" type="text"
								class="easyui-validatebox" data-options="required:true"
								missingMessage="请填写单证交单期" style="width: 155px;" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">开证日</div>
						<div class="righttext">
							<input name="startDate" type="text" class="easyui-datebox"
								id="startDateAdd"
								data-options="required:true,formatter:function(date){return date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate();}"
								missingMessage="请填写开证日" style="width: 155px;" />
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">到期日</div>
						<div class="righttext">
							<input name="endDate" type="text" class="easyui-datebox"
								id="endDateAdd"
								data-options="required:true,formatter:function(date){return date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate();}"
								missingMessage="请填写到期日" style="width: 155px;" />
						</div>
					</div>
					<!-- <div class="item33">
						<div class="itemleft">有效期</div>
						<div class="righttext">
							<input name="valid" type="text" class="easyui-validatebox"
								data-options="required:true" missingMessage="请填写有效期"
								style="width: 155px;" />
						</div>
					</div> -->
					<!-- <div class="item33">
						<div class="itemleft">是否有效</div>
						<div class="righttext">
							<input type="checkbox" name="activeFlag" value="1" checked="checked" />
						</div>
					</div> -->
				</div>
			</div>
		</form>
	</div>

	<div id="guaranteesEditDialog"
		style="display: none; width: 1015px; height: 350px;" align="center">
		<form id="guaranteesEditForm" method="post">
			<div class="part_zoc">
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">保函号：</div>
						<div class="righttext">
							<input name="guarantees" id="guarantees0" type="text"
								class="easyui-validatebox" data-options="required:true"
								missingMessage="请填写保函号" style="width: 155px;" /><input
								id="guaranteesOldHidden" type="hidden" name="guaranteesOld" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">受益人</div>
						<div class="righttext">
							<input name="beneficiaries" type="text"
								class="easyui-validatebox" data-options="required:true"
								missingMessage="请填写受益人" style="width: 155px;" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">客户：</div>
						<div class="righttext">
							<select name="customerCode" class="easyui-validatebox"
								style="width: 155px;" data-options="required:true"
								missingMessage="请填写客户名称" id="customerCode0"></select>
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">开证行</div>
						<div class="righttext">
							<input name="bankName" type="text" class="easyui-validatebox"
								data-options="required:true" missingMessage="请填写开证行"
								style="width: 155px;" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">改证次数</div>
						<div class="righttext">
							<input name="modifyNum" type="text"
								class="easyui-validatebox easyui-numberbox"
								data-options="required:true" missingMessage="请填写改证次数"
								style="width: 155px;" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">类型</div>
						<div class="righttext">
							<!-- <input name="payType" type="text" class="easyui-validatebox"
								data-options="required:true" missingMessage="请填写类型"
								style="width: 155px;" />  -->
							<select class="easyui-combobox easyui-validatebox" name="payType"
								data-options="required:true" missingMessage="请填写类型"
								style="width: 155px;">
								<option value="1">保函</option>
								<option value="2">备用信用证</option>
							</select>
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">币种</div>
						<div class="righttext">
							<select id="currency0" class="easyui-validatebox"
								style="width: 155px;" name="currency"
								data-options="required:true" missingMessage="请填写币种"></select>
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">金额</div>
						<div class="righttext">
							<input name="amount" type="text" class="easyui-numberbox"
								data-options="precision:2,required:true" missingMessage="请填写金额"
								style="width: 155px;" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">是否循环</div>
						<div class="righttext">
							<input type="checkbox" name="cycleFlag" value="1" />
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">付款周期</div>
						<div class="righttext">
							<input name="payPeriod" type="text" class="easyui-validatebox"
								data-options="required:true" missingMessage="请填写付款周期"
								style="width: 155px;" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">单证交单期</div>
						<div class="righttext">
							<input name="docAgainstDay" type="text"
								class="easyui-validatebox" data-options="required:true"
								missingMessage="请填写单证交单期" style="width: 155px;" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">开证日</div>
						<div class="righttext">
							<input name="startDate" type="text" class="easyui-datebox"
								id="startDateEdit"
								data-options="required:true,formatter:function(date){return date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate();}"
								missingMessage="请填写开证日" style="width: 155px;" />
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">到期日</div>
						<div class="righttext">
							<input name="endDate" type="text" class="easyui-datebox"
								id="endDateEdit"
								data-options="required:true,formatter:function(date){return date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate();}"
								missingMessage="请填写到期日" style="width: 155px;" />
						</div>
					</div>
					<!-- <div class="item33">
						<div class="itemleft">有效期</div>
						<div class="righttext">
							<input name="valid" type="text" class="easyui-validatebox"
								data-options="required:true" missingMessage="请填写有效期"
								style="width: 155px;" />
						</div>
					</div> -->
					<!-- <div class="item33">
						<div class="itemleft">是否有效</div>
						<div class="righttext">
							<input type="checkbox" name="activeFlag" value="1" checked="checked" />
						</div>
					</div> -->
				</div>
			</div>
		</form>
	</div>
<div id="guaranteesDescDialog"
		style="display: none; width: 1000px; height: 500px;" align="center">
		<form id="guaranteesDescForm" method="post">
			<div class="part_zoc">
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">保函号：</div>
						<div class="righttext">
							<input name="guarantees" id="guarantees0" type="text"
								readonly="readonly" style="width: 155px;" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">受益人</div>
						<div class="righttext">
							<input name="beneficiaries" type="text" readonly="readonly"
								style="width: 155px;" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">客户：</div>
						<div class="righttext">
							<input type="text" name="customerName" readonly="readonly"></input>
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">开证行</div>
						<div class="righttext">
							<input name="bankName" type="text" readonly="readonly"
								style="width: 155px;" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">改证次数</div>
						<div class="righttext">
							<input name="modifyNum" type="text" readonly="readonly"
								style="width: 155px;" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">类型</div>
						<div class="righttext">
							<!-- <input name="payType" type="text" class="easyui-validatebox"
								data-options="required:true" missingMessage="请填写类型"
								style="width: 155px;" />  -->
							<div id="payTypeDesc"></div>
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">币种</div>
						<div class="righttext">
							<input type="text" name="currency" readonly="readonly" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">金额</div>
						<div class="righttext">
							<input name="amount" type="text" readonly="readonly"
								style="width: 155px;" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">是否循环</div>
						<div class="righttext">
							<div id="cycleFlagDesc"></div>
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">付款周期</div>
						<div class="righttext">
							<input name="payPeriod" type="text" readonly="readonly"
								style="width: 155px;" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">单证交单期</div>
						<div class="righttext">
							<input name="docAgainstDay" type="text" readonly="readonly"
								style="width: 155px;" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">开证日</div>
						<div class="righttext">
							<input name="startDate" type="text" readonly="readonly"
								style="width: 155px;" />
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">到期日</div>
						<div class="righttext">
							<input name="endDate" type="text" readonly="readonly"
								style="width: 155px;" />
						</div>
					</div>
					<!-- <div class="item33">
						<div class="itemleft">有效期</div>
						<div class="righttext">
							<input name="valid" type="text" readonly="readonly"
								style="width: 155px;" />
						</div>
					</div> -->
					<div class="item33">
						<div class="itemleft">通知行</div>
						<div class="righttext">
							<input type="text" name="notifyBank" class="easyui-validatebox"
								data-options="required:true" missingMessage="请填写通知行"
								style="width: 155px;"/>
						</div>
					</div>
				</div>
			</div>
		</form>
		
		<div style="width:100%;height:400px">
			<table id="dateGrid_version"></table>
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
	<div id="_CNNQUERY">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">客户名：</div>
				<div class="righttext">
					<input class="short60" id="_CNNINPUT" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="righttext">
					<input type="button" value="查询"
						onclick="_CCNMY('_CNNINPUT','customerCode')" />
				</div>
			</div>
		</div>
	</div>
	<div id="_CNNQUERYHISTORY">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">客户名：</div>
				<div class="righttext">
					<input class="short60" id="_CNNINPUTHISTORY" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="righttext">
					<input type="button" value="查询"
						onclick="_CCNMY('_CNNINPUTHISTORY','customerCode0')" />
				</div>
			</div>
		</div>
	</div>
</body>
</html>