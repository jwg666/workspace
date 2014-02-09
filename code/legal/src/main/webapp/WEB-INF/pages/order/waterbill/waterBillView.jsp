<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var searchForm;
	var datagrid;
	var waterBillAddDialog;
	var waterBillAddForm;
	var cdescAdd;
	var waterBillEditDialog;
	var waterBillEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	$(function() {
		//查询列表	
		searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'waterBillAction!datagrid.do',
			queryParams : {
				"activeFlag" : $("#activeFlag").val()
			},
			title : '水单',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			singleSelect : true,
			fitColumns : true,
			nowrap : true,
			border : false,
			//idField : 'waterBillCode',
			
			columns : [ [ {
				field : 'ck',
				checkbox : true,
				formatter : function(value, row, index) {
					return row.waterBillCode;
				}
			}, {
				field : 'waterBillCode',
				title : '水单编号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.waterBillCode;
				}
			}, {
				field : 'customerCode',
				title : '客户编号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.customerCode;
				}
			}, {
				field : 'customerName',
				title : '客户名称',
				align : 'center',
				sortable : true
			}, {
				field : 'currency',
				title : '币种',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.currency;
				}
			}, {
				field : 'amount',
				title : '金额',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.amount;
				}
			}, {
				field : 'activeFlag',
				title : '是否有效',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					if (value == '1') {
						return '有效';
					} else {
						return '无效';
					}
				}
			}, {
				field : 'createdBy',
				title : '创建人',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.createdBy;
				}
			}, {
				field : 'created',
				title : '创建日期',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.created);
				}
			}, {
				field : 'lastUpdBy',
				title : '修改人',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.lastUpdBy;
				}
			}, {
				field : 'lastUpd',
				title : '修改日期',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.lastUpd);
				}
			} ] ]
		});

		waterBillAddForm = $('#waterBillAddForm').form({
			url : '${dynamicURL}/waterBill/waterBillAction!add.action',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					waterBillAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		waterBillAddDialog = $('#waterBillAddDialog').show().dialog({
			title : '添加水单',
			modal : true,
			closed : true,
			maximizable : true
		});

		waterBillEditForm = $('#waterBillEditForm').form({
			url : 'waterBillAction!edit.action',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					waterBillEditDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			},
			onLoadSuccess : function(data) {
				//customerCode客户编号
				$('#customerCode0').combogrid({
					url : '${dynamicURL}/basic/customerAction!datagrid0.action?customerId=' + data.customerCode,
					textField : 'name',
					idField : 'customerId',
					panelWidth : 600,
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
						field : 'customerId',
						title : '客户编号',
						width : 20
					}, {
						field : 'name',
						title : '客户名称',
						width : 20
					} ] ],
					onLoadSuccess : function() {
						$("#_CNNINPUTHISTORY").val($("#customerCode0").combogrid('getText'));
						$(this).datagrid("clearSelections");
					}
				});
			}
		});
		showUploadTemplateDialog = $('#uploadTemplateDialog').show().dialog({
			title : '上传附件',
			modal : true,
			closed : true,
			collapsible : true,
			buttons : [ {
				text : '上传',
				handler : function() {
					showUploadTemplateForm.submit();
				}
			} ]
		});
		showUploadTemplateForm = $('#uploadTemplateForm').form({
			url : '${dynamicURL}/basic/fileUploadAction/uplaodFile.do',
			success : function(data) {
				var json = $.parseJSON(data);
				var obj = json.obj;
				if (json && json.success) {
					$("#uploadFileId").val(obj.id);
					$("#uploadFileName").val(obj.fileName);
					$.messager.show({
						title : '成功',
						msg : '文件上传成功'
					});
				} else {
					$.messager.show({
						title : '失败',
						msg : '文件上传失败'
					});
				}
				showUploadTemplateDialog.dialog('close');
			}
		});
		waterBillEditDialog = $('#waterBillEditDialog').show().dialog({
			title : '编辑水单',
			modal : true,
			closed : true,
			maximizable : true
		});

		showCdescDialog = $('#showCdescDialog').show().dialog({
			title : '水单维护描述',
			modal : true,
			closed : true,
			maximizable : true
		});

	});

	function _search() {
		if ($("#showInvalid").attr('checked') == 'checked') {
			$("#activeFlag").val('');
		} else {
			$("#activeFlag").val('1');
		}
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.find('input').val('');
	}
	function add() {
		waterBillAddForm.form("clear");
		$('div.validatebox-tip').remove();
		$("#currency").combobox({
			url : '../guarantees/guaranteesAction!comboCurrency.action',
			valueField : 'itemCode',
			textField : 'itemNameCn'
		});
		//custCodeId客户编号
		$('#customerCode').combogrid({
			url : '${dynamicURL}/basic/customerAction!datagrid0.action',
			textField : 'name',
			idField : 'customerId',
			panelWidth : 600,
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
				field : 'customerId',
				title : '客户编号',
				width : 20
			}, {
				field : 'name',
				title : '客户名称',
				width : 20
			} ] ]
		});
		waterBillAddDialog.dialog('open');
	}
	function invalid() {
		var rows = datagrid.datagrid('getSelections');
		if (rows.length == 1) {
			//已经使用的水单不能被置为无效
			$.messager.progress({
				text : '数据加载中....',
				interval : 100
			});
			$.ajax({
				url : 'waterBillAction!waterBillUsed.action',
				type : 'post',
				data : {
					"waterBillCode" : rows[0].waterBillCode
				},
				dataType : 'json',
				success : function(response) {
					if (response && response.success) {
						$.messager.alert('提示', '水单已经被使用', 'info');
					} else {
						$.messager.confirm('请确认', '您要将该水单置为无效？', function(r) {
							if (r) {
								$.ajax({
									url : 'waterBillAction!delete.action',
									data : {
										"waterBillCode" : rows[0].waterBillCode
									},
									dataType : 'json',
									success : function(response) {
										datagrid.datagrid('load');
										datagrid.datagrid('unselectAll');
										$.messager.show({
											title : '提示',
											msg : '设置成功！'
										});
									}
								});
							}else{
								$.messager.progress('close');
							}
						});
					}
					$.messager.progress('close');
				}
			});
		} else {
			$.messager.alert('提示', '请选择一条要删除的记录！', 'error');
		}
	}
	function edit() {
		var rows = datagrid.datagrid('getSelections');
		if (rows.length == 1) {

			//已经使用的水单不能被修改
			$.messager.progress({
				text : '数据加载中....',
				interval : 100
			});
			$.ajax({
				url : 'waterBillAction!waterBillUsed.action',
				type : 'post',
				data : {
					"waterBillCode" : rows[0].waterBillCode
				},
				dataType : 'json',
				success : function(response) {
					if (response && response.success) {
						$.messager.alert('提示', '水单已经被使用', 'info');
						$.messager.progress('close');
					} else {
						$.ajax({
							url : 'waterBillAction!showDesc.do',
							data : {
								waterBillCode : rows[0].waterBillCode
							},
							dataType : 'json',
							cache : false,
							success : function(response) {
								waterBillEditForm.form("clear");
								waterBillEditForm.form('load', response);
								$('div.validatebox-tip').remove();
								$("#waterBillCodeOldHidden").val(response.waterBillCode);
								$("#currency0").combobox({
									url : '../guarantees/guaranteesAction!comboCurrency.action',
									valueField : 'itemCode',
									textField : 'itemNameCn',
									onLoadSuccess : function() {
										$("#currency0").combobox('setValue', response.currency);
									}
								});
								waterBillEditDialog.dialog('open');
								//加载修改历史记录
								$("#modifyHistoryDatagrid").datagrid({
									url : 'waterBillLogAction!datagrid.action',
									queryParams : {
										"billNum" : response.waterBillCode
									},
									title : '水单管理',
									iconCls : 'icon-save',
									pagination : true,
									pagePosition : 'bottom',
									rownumbers : true,
									pageSize : 10,
									pageList : [ 10, 20, 30, 40 ],
									fit : true,
									singleSelect : true,
									fitColumns : false,
									nowrap : true,
									border : false,
									columns : [ [ {
										field : 'billNum',
										title : '水单号',
										width : 100,
										hidden : true
									}, {
										field : 'modifyName',
										title : '修改人',
										width : 75
									}, {
										field : 'modifyDate',
										title : '修改时间',
										width : 100,
										formatter : function(value) {
											return dateFormatYMD(value);
										}
									}, {
										field : 'fileName',
										title : '附件',
										width : 100,
										formatter : function(value, row, index) {
											var result_;
											if(row.fileName == null){
												result_="";
											}
											else{
												result_=value;
											}
											return '<a href="#" onclick="downloadDoc(' + index + ')">' + result_ + '</a>';
										}
									}, {
										field : 'modifyReason',
										title : '修改原因',
										width : 400
									} ] ]
								});
								$.messager.progress('close');
							}
						});
					}
				}
			});
		} else {
			$.messager.alert('提示', '请选择一项要编辑的记录！', 'error');
		}
	}
	function downloadDoc(index) {
		var rowData = $("#modifyHistoryDatagrid").datagrid('getRows')[index]
		var fileId = rowData.doc;
		if (fileId) {
			window.open("${dynamicURL}/basic/fileUploadAction/downloadFile.do?fileId=" + fileId);
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
			url : 'waterBillAction!showDesc.do',
			data : {
				waterBillCode : row.waterBillCode
			},
			dataType : 'json',
			cache : false,
			success : function(response) {
				if (response && response.cdesc) {
					showCdescDialog.find('div[name=cdesc]').html(response.cdesc);
					showCdescDialog.dialog('open');
				} else {
					$.messager.alert('提示', '没有水单维护描述！', 'error');
				}
				$.messager.progress('close');
			}
		});
		datagrid.datagrid('unselectAll');
	}
	function extistWaterCode(editFlag) {
		var waterBillCode_;
		if (editFlag) {
			if ($("#waterBillCode0").val() == $("#waterBillCodeOldHidden").val()) {
				return;
			}
			waterBillCode_ = $("#waterBillCode0").val();
		} else {
			waterBillCode_ = $("#waterBillCode").val();
		}
		if (waterBillCode_ == '') {
			return;
		}
		$.ajax({
			url : 'waterBillAction!extistWaterBillCode.action',
			dataType : 'json',
			data : {
				"waterBillCode" : waterBillCode_
			},
			success : function(json) {
				if (json.success) {
					$.messager.alert('提示', '水单号已存在，请重新输入。', 'info', function() {
						if (editFlag) {
							$("#waterBillCode0").focus();
						} else {
							$("#waterBillCode").focus();
						}
					});
				} else {
					return;
				}
			}
		});
	}
	function save() {
		waterBillCode_ = $("#waterBillCode").val();
		if (waterBillCode_ != '') {
			$.ajax({
				url : 'waterBillAction!extistWaterBillCode.action',
				dataType : 'json',
				data : {
					"waterBillCode" : $("#waterBillCode").val()
				},
				success : function(json) {
					if (json.success) {
						$.messager.alert('提示', '水单号已存在，请重新输入。', 'info', function() {
							$("#waterBillCode").focus();
						});
					} else {
						waterBillAddForm.submit();
					}
				}
			});
		} else {
			waterBillAddForm.submit();
		}
	}
	//编辑水单页面，点击保存，验证水单号的唯一性，通过则保存，不通过则提示
	function saveEdit() {
		if ($("#waterBillCode0").val() != '' && $("#waterBillCode0").val() != $("#waterBillCodeOldHidden").val()) {
			$.ajax({
				url : 'waterBillAction!extistWaterBillCode.action',
				dataType : 'json',
				data : {
					"waterBillCode" : $("#waterBillCode0").val()
				},
				success : function(json) {
					if (json.success) {
						$.messager.alert('提示', '水单号已存在，请重新输入。', 'info', function() {
							$("#waterBillCode0").focus();
						});
					} else {
						waterBillEditForm.submit();
					}
				}
			});
		} else {
			waterBillEditForm.submit();
		}
	}
	function _CCNMY(inputId, selectId) {
		var _CCNTEMP = $('#' + inputId).val()
		var _CCNTEMPID = $('#' + inputId + 'ID').val()
		$('#' + selectId).combogrid({
			url : '../basic/customerAction!datagrid0.action?name=' + _CCNTEMP + '&customerId=' + _CCNTEMPID
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	showUploadTemplateDialog = $('#uploadTemplateDialog').show().dialog({
		title : '上传附件',
		modal : true,
		closed : true,
		collapsible : true,
		buttons : [ {
			text : '上传',
			handler : function() {
				showUploadTemplateForm.submit();
			}
		} ]
	});
	function uploadTemplate() {
		showUploadTemplateDialog.dialog("open");
	}

	//把水单置为有效
	function active() {
		var rows = datagrid.datagrid('getSelections');
		if (rows.length == 1) {
			$.messager.progress({
				text : '数据加载中....',
				interval : 100
			});

			$.messager.confirm('请确认', '您要将该水单置为有效？', function(r) {
				if (r) {
					$.ajax({
						url : 'waterBillAction!active.action',
						data : {
							"waterBillCode" : rows[0].waterBillCode
						},
						dataType : 'json',
						success : function(response) {
							datagrid.datagrid('load');
							datagrid.datagrid('unselectAll');
							$.messager.show({
								title : '提示',
								msg : '设置成功！'
							});
							$.messager.progress('close');
						}
					});
				}else{
					$.messager.progress('close');
				}
			});

		} else {
			$.messager.alert('提示', '请选择一条要删除的记录！', 'error');
		}
	}
</script>
</head>
<body class="easyui-layout zoc">
	<div region="north" border="false" collapsed="true" title="水单查询"
		style="height: 150px;">
		<div region="north">
			<form id="searchForm">
				<div class="part_zoc">
					<div class="oneline">
						<div class="item33">
							<div class="itemleft">水单号：</div>
							<div class="righttext">
								<input name="waterBillCode" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft">客户名称：</div>
							<div class="righttext">
								<input name="customerName" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft">客户编码：</div>
							<div class="righttext">
								<input name="customerCode" />
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item50">
							<div class="itemleft">创建时间：</div>
							<div class="righttext">
								<input name="createDateStart" class="easyui-datebox" />至 <input
									name="createDateEnd" class="easyui-datebox" />
							</div>
						</div>
						<div class="item33 lastItem">
							<div class="rightcheckbox">
								<input id="showInvalid" type="checkbox" checked="checked" />显示无效
								<input id="activeFlag" name="activeFlag" value="" type="hidden" />
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item100">
							<div class="oprationbutt">
								<input type="button" value="查询" onclick="_search();" /><input
									type="button" value="清空"
									onclick="$('#searchForm').form('clear');$('#showInvalid').attr('checked','checked');_search();" />
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>

	<div region="center" border="false" style="height: 300px;">
		<table id="datagrid"></table>
	</div>

	<div id="menu" class="easyui-menu" style="width: 120px; display: none;">
		<div onclick="add();" iconCls="icon-add">增加</div>
		<div onclick="invalid();" iconCls="icon-remove">置为无效</div>
		<div onclick="active();" iconCls="icon-remove">置为有效</div>
		<div onclick="edit();" iconCls="icon-edit">编辑</div>
	</div>

	<div id="waterBillAddDialog"
		style="display: none; width: 800px; height: 230px;">
		<form id="waterBillAddForm" method="post">
			<div class="part_zoc">
				<div class="partnavi_zoc">水单信息</div>
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">水单编号：</div>
						<div class="righttext">
							<input name="waterBillCode" type="text" id="waterBillCode"
								class="easyui-validatebox" data-options="required:true"
								missingMessage="请填写水单编号" style="width: 155px;" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">客户编号：</div>
						<div class="righttext">
							<input type="text" id="customerCode" name="customerCode"
								data-options="required:true" missingMessage="请填写客户编号"
								style="width: 155px;"></input>
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">币种：</div>
						<div class="righttext">
							<select data-options="required:true" missingMessage="请选择币种"
								name="currency" id="currency" style="width: 100px;"></select>
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">金额：</div>
						<div class="righttext">
							<input name="amount" type="text" class="easyui-numberbox"
								required="true" data-options="precision:2"
								missingMessage="请输入金额" style="width: 155px;" />
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item100">
						<input type="button" value="保存" onclick="save();">
					</div>
				</div>
			</div>
		</form>
	</div>

	<div id="waterBillEditDialog"
		style="display: none; width: 800px; height: 400px;">
		<form id="waterBillEditForm" method="post">
			<div class="part_zoc">
				<div class="partnavi_zoc">水单信息</div>
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">水单编号：</div>
						<div class="righttext">
							<input name="waterBillCode" type="text" id="waterBillCode0"
								class="easyui-validatebox" data-options="required:true"
								missingMessage="请填写水单编号" style="width: 155px;" /> <input
								name="waterBillCodeOld" type="hidden"
								id="waterBillCodeOldHidden" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">客户编号：</div>
						<div class="righttext">
							<!-- <input name="customerCode" type="text" class="easyui-validatebox"
								data-options="required:true" missingMessage="请填写客户编号"
								style="width: 155px;" /> -->
							<input type="text" id="customerCode0" name="customerCode"
								data-options="required:true" missingMessage="请填写客户编号"
								style="width: 155px;"></input>
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">币种：</div>
						<div class="righttext">
							<select missingMessage="请选择币种" data-options="required:true"
								name="currency" id="currency0" style="width: 155px;"></select>
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">金额：</div>
						<div class="righttext">
							<input name="amount" type="text" class="easyui-numberbox"
								required="true" data-options="precision:2"
								missingMessage="请输入金额" style="width: 155px;" />
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">修改原因：</div>
						<div class='righttext'>
							<input name="reason" maxlength="500" class="easyui-validatebox" data-options="required:true"></input>
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">上传附件：</div>
						<div class="righttext">
							<div class="righttext">
								<input name="uploadFileName" id="uploadFileName" readonly="readonly" class="easyui-validatebox"  data-options="required:true"/>
							</div>
							<div class="rightbutt">
								<input type="image"
									src="${dynamicURL}/assets/style/demo/img/more.png"
									onclick="uploadTemplate();return false;" />
							</div>
							<input type="hidden" id="uploadFileId" name="upDoc" />
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item100">
						<input type="button" value="保存" onclick="saveEdit();" />
					</div>
				</div>
			</div>
		</form>
		<table id="modifyHistoryDatagrid"></table>
	</div>

	<div id="showCdescDialog"
		style="display: none; overflow: auto; width: 500px; height: 400px;">
		<div name="cdesc"></div>
	</div>

	<div id="_CNNQUERY">
		<div class="oneline">
			<div class="item33">
				<div class="itemleft60">客户编号：</div>
				<div class="righttext">
					<input class="short30" id="_CNNINPUTID" type="text" />
				</div>
				<div class="itemleft60">客户名：</div>
				<div class="righttext">
					<input class="short30" id="_CNNINPUT" type="text" />
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
			<div class="item33">
				<div class="itemleft60">客户编号：</div>
				<div class="righttext">
					<input class="short30" id="_CNNINPUTHISTORYID" type="text" />
				</div>
				<div class="itemleft60">客户名：</div>
				<div class="righttext">
					<input class="short30" id="_CNNINPUTHISTORY" type="text" />
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
	<div id="uploadTemplateDialog" style="margin-top: 1%; width: 500px;">
		<form id="uploadTemplateForm" method="post"
			enctype="multipart/form-data">
			<table class="tableForm">
				<tr style="margin-top: 3%">
					<th>选择上传的附件:</th>
					<td><s:file name="upload"></s:file></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>