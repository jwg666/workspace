<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	/**
	 *费用经理审核新增或修改的保函
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var searchForm;
	var datagrid;
	var datagridHistory;
	var guaranteesAddDialog;
	var guaranteesAddForm;
	var cdescAdd;
	var guaranteesEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	var guaranteesDescForm;
	function _CCNMY(inputId, selectId) {
		var _CCNTEMP = $('#' + inputId).val()
		var _CCNTEMPID = $('#' + inputId + 'ID').val()
		$('#' + selectId).combogrid({
			url : '../basic/customerAction!datagrid0.action?name=' + _CCNTEMP + '&customerId=' + _CCNTEMPID
		});
		$('#' + inputId).val(_CCNTEMP);
	}
	$(function() {
		//customerCode客户编号
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
		//customerCodeHistory客户编号
		$('#customerCodeHistory').combogrid({
			url : '${dynamicURL}/basic/customerAction!datagrid0.action',
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
			} ] ]
		});
		//查询列表	
		guaranteesDescForm = $("guaranteesDescForm");
		searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid(
				{
					url : 'guaranteesAction!financialScheduleList.action?definitionKey=finModify&dataSharing=103&taskType=my',
					title : '待办事项列表',
					pagination : true,
					pagePosition : 'bottom',
					rownumbers : true,
					pageSize : 10,
					pageList : [ 10, 20, 30, 40 ],
					fit : true,
					fitColumns : false,
					nowrap : true,
					border : false,
					//idField : 'guarantees',
					columns : [ [
							{
								field : 'ck',
								checkbox : true,
								formatter : function(value, row, index) {
									return row.guarantees;
								}
							},
							{
								field : 'guarantees',
								title : '保函号',
								width : 100,
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									var img;
									if (row.assignee && row.assignee != 'null') {
										img = "<img width='16px' height='16px' title='个人任务' src='${staticURL}/easyui3.2/themes/icons/user.png' />&nbsp;"
									} else {
										img = "<img width='16px' height='16px' title='未申领的组任务' src='${staticURL}/easyui3.2/themes/icons/group.png' />&nbsp;"
									}
									return "<a href='javascript:void(0)' style='color:blue' onclick='gotoCheck(\"" + row.guarantees + "\",\"" + row.taskId
											+ "\")' >" + img + row.guarantees + "</a>";
								}
							}, {
								field : 'saleOrgName',
								title : '受益人',
								width : 200,
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
								widht : 100,
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
								width : 100,
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
								align : 'center',
								width : 100,
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
									if (null == value) {
										return '';
									} else {
										var r = $.parseJSON(value)
										if (null == r) {
											return '';
										}
										return r.result;
									}
								}
							}, {
								field : 'docAuditCode',
								title : '单证审核人',
								width : 100,
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									if (null == row.docAuditOpenion) {
										return '';
									} else {
										var r = $.parseJSON(row.docAuditOpenion)
										if (null == r) {
											return '';
										}
										return r.user;
									}
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
									if (null == value) {
										return '';
									} else {
										var r = $.parseJSON(value)
										if (null == r) {
											return '';
										}
										return r.result;
									}
								}
							}, {
								field : 'finAuditCode',
								title : '财务审核人',
								width : 100,
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									if (null == row.finAuditOpenion) {
										return '';
									} else {
										var r = $.parseJSON(row.finAuditOpenion)
										if (null == r) {
											return '';
										}
										return r.user;
									}
								}
							},{
								field : 'trace',
								title : '流程追踪',
								align : 'center',
								width : 80,
								formatter : function(value, row, index) {
									return "<a href='javascript:void(0)' style='color:blue' onclick='traceImg(" + index + ")'>流程跟踪</a>";
								}
							} ] ],
					toolbar : [ {
						text : '修改',
						iconCls : 'icon-check',
						handler : function() {
							//只能选择一条记录
							var rows=datagrid.datagrid('getSelections')
							if(rows.length==1){
								gotoCheck(rows[0].guarantees,rows[0].taskId);
							}else{
								$.messager.alert('提示','请选择一条记录','warning');
							}
						}
					}, '-', {
						text : '申领',
						iconCls : 'icon-apply',
						handler : function() {
							//可以多条申领
							applyTasks();
						}
					}, '-', {
						text : '取消选中',
						iconCls : 'icon-undo',
						handler : function() {
							datagrid.datagrid('unselectAll');
						}
					}, '-' ]
				});
		searchFormHistory = $('#searchFormHistory').form();
		datagridHistory = $('#datagridHistory').datagrid({
			url : 'guaranteesAction!orderMgrHistory.action?definitionKey=finModify&dataSharing=86&taskType=my',
			title : '保函维护列表',
			pagination : true,
			pagePosition : 'bottom',
			singleSelect : true,
			rownumbers : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			fitColumns : false,
			nowrap : true,
			border : false,
			//idField : 'guarantees',
			columns : [ [ {
				field : 'guarantees',
				title : '保函号',
				width : 100,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return '<a href="javascript:void(0)" style="color:blue" onclick="showDesc(\'' + row.guarantees + '\')" >' + row.guarantees + '</a>';
				}
			}, {
				field : 'saleOrgName',
				title : '受益人',
				width : 200,
				align : 'center',
				sortable : true
			}, {
				field : 'customerCode',
				title : '客户编码',
				width : 200,
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
				width : 100,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.payPeriod;
				}
			}, {
				field : 'docAgainstDay',
				title : '单证交单期',
				align : 'center',
				width : 100,
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
				width : 200,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					if (null == value) {
						return '';
					} else {
						var r = $.parseJSON(value)
						if (null == r) {
							return '';
						}
						return r.result;
					}
				}
			}, {
				field : 'docAuditCode',
				title : '单证审核人',
				width : 100,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					if (null == row.docAuditOpenion) {
						return '';
					} else {
						var r = $.parseJSON(row.docAuditOpenion)
						if (null == r) {
							return '';
						}
						return r.user;
					}
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
					if (null == value) {
						return '';
					} else {
						var r = $.parseJSON(value)
						if (null == r) {
							return '';
						}
						return r.result;
					}
				}
			}, {
				field : 'finAuditCode',
				title : '财务审核人',
				width : 100,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					if (null == row.finAuditOpenion) {
						return '';
					} else {
						var r = $.parseJSON(row.finAuditOpenion)
						if (null == r) {
							return '';
						}
						return r.user;
					}
				}
			} ] ]
		});
		showCdescDialog = $('#showCdescDialog').show().dialog({
			title : '保函维护描述',
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

		$("#currencySearch").combobox({
			url : 'guaranteesAction!comboCurrency.action',
			valueField : 'itemCode',
			textField : 'itemNameCn'
		});
		guaranteesDescDialog = $('#guaranteesDescDialog').show().dialog({
			title : '保函信息',
			modal : true,
			closed : true,
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
	});

	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.form('clear');
	}

	//查看保函信息
	function showDesc(guarantees) {
		//descForm.load
		guaranteesDescForm.form('load', 'guaranteesAction!showDescExternal.action?guarantees=' + guarantees);
		guaranteesDescDialog = $("#guaranteesDescDialog").show();
		guaranteesDescDialog.dialog('open');
		$.messager.progress();
		datagrid.datagrid('unselectAll');
	}
	function createOrderMgrSchedule() {
		$.ajax({
			url : 'guaranteesAction!createOrderMgrTask.action',
			type : 'post',
			dataType : 'json',
			success : function(response) {
				alert(response.msg);
			}
		});
	}
	//申领任务
	function applyTasks() {
		var rows = datagrid.datagrid('getSelections');
		var taskIds = '';
		if (rows.length < 1) {
			$.messager.alert('提示', '请选择一条保函记录', 'info', function() {
			});
		} else {
			$.messager.confirm('提示', '您要申领当前任务？', function(r) {
				if (r) {
					//拼接taskIds
					for ( var i = 0; i < rows.length; i++) {
						if (i != rows.length - 1) {
							taskIds = taskIds + "taskIds=" + rows[i].taskId + "&";
						} else {
							taskIds = taskIds + "taskIds=" + rows[i].taskId;
						}
					}
					//ajax请求申领，提示申领成功或失败
					$.ajax({
						url : 'guaranteesAction!orderMgrClaimTasks.action',
						data : taskIds,
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
		}
	}
	function gotoCheck(guarantees, taskId) {

		//打开审核页面
		$.ajax({
			url : '../workflow/scheduleUrlAndTitleAction!titleAndUrl.action',
			data : {
				taskId : taskId
			},
			dataType : 'json',
			cache : false,
			success : function(response) {
				if ('javascript:void(0)' != response.url) {
					var url = '${dynamicURL}/' + response.url;
					parent.window.HROS.window.close('guarantees_' + taskId);
					parent.window.HROS.window.createTemp({
						title : "保函号:" + guarantees,
						url : url,
						width : 800,
						height : 400,
						appid : 'guarantees_' + taskId,
						isresize : false,
						isopenmax : true,
						isflash : false,
						customWindow : window
					});
				} else {
					$.messager.alert('提示', '当前您无法执行该任务！', 'error');
				}
			}
		});
	}
	function traceImg(rowIndex) {
		var obj = $("#datagrid").datagrid("getData").rows[rowIndex];
		parent.window.HROS.window.createTemp({
			title : "保函号:" + obj.guarantees + "-流程图",
			url : "${dynamicURL}/workflow/processAction!goTrace.do?processInstanceId=" + obj.procInstId,
			width : 800,
			height : 400,
			isresize : false,
			isopenmax : true,
			isflash : false,
			customWindow : window
		});
	}
	function refreshDatagrid() {
		datagrid.datagrid('reload');
		datagridHistory.datagrid('reload');
		top.window.showTaskCount();
	}
</script>
</head>
<body>
	<div class="easyui-tabs" data-options="fit:true">
		<div title="待审核保函">
			<div class="easyui-layout" fit="true">
				<div region="north" border="false" class="zoc" collapsible="true"
					collapsed="true" title="保函查询" style="height: 180px;">
					<div class="part_zoc">
						<form id="searchForm">
							<div class="oneline">
								<div class="item25">
									<div class="itemleft80">受益人：</div>
									<div class="righttext">
										<span><input name="beneficiaries" type="text"
											class="short50" /></span>
									</div>
								</div>
								<div class="item25">
									<div class="itemleft80">客户编码：</div>
									<div class="righttext">
										<span><input name="customerCode" type="text"
											id="customerCode" class="short50" /></span>
									</div>
								</div>
								<div class="item25">
									<div class="itemleft80">开证行：</div>
									<div class="righttext">
										<span><input name="bankName" type="text"
											class="short50" /></span>
									</div>
								</div>
							</div>
							<div class="oneline">
								<div class="item25">
									<div class="itemleft80">保函号：</div>
									<div class="righttext">
										<span><input name="guarantees" type="text"
											class="short50" /></span>
									</div>
								</div>
								<div class="item25">
									<div class="itemleft80">改证次数：</div>
									<div class="righttext">
										<span><input name="modifyNum" type="text"
											class="short50" /></span>
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
										<span><input name="amount" type="text"
											class="short50 numberbox" /></span>
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
										<span><input name="valid" type="text" class="easyui-datebox short50" /></span>
									</div>
								</div> -->
							</div>
							<div class="oneline">
								<div class="item25">
									<div class="itemleft80">循环标识：</div>
									<div class="righttext">
										<select class="easyui-combobox" name="cycleFlag"
											class="short50">
											<option value="">全部</option>
											<option value="1">可循环</option>
											<option value="0">不可循环</option>
										</select>
									</div>
								</div>
								<div class="item25">
									<div class="itemleft80">付款周期：</div>
									<div class="righttext">
										<span><input name="payPeriod" type="text"
											class="short50" /></span>
									</div>
								</div>
								<div class="item25">
									<div class="itemleft80">单证交单期：</div>
									<div class="righttext">
										<span><input name="docAgainstDay" type="text"
											class="short50" /></span>
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
								<div class="item25">
									<div class="itemleft">任务类型：</div>
									<div class="righttext">
										<select class="easyui-combobox short50" name="taskType">
											<option value="">全部</option>
											<option value="my">个人任务</option>
											<option value="group">组任务</option>
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
			</div>
		</div>
		<div title="历史任务">
			<div class="easyui-layout" fit="true">
				<div region="north" border="false" class="zoc" collapsible="true"
					collapsed="true" title="保函查询" style="height: 180px;">
					<div class="part_zoc">
						<form id="searchFormHistory">
							<div class="oneline">
								<div class="item25">
									<div class="itemleft80">受益人：</div>
									<div class="righttext">
										<span><input name="beneficiaries" type="text"
											class="short50" /></span>
									</div>
								</div>
								<div class="item25">
									<div class="itemleft80">客户编码：</div>
									<div class="righttext">
										<span><input name="customerCode" type="text"
											id="customerCodeHistory" class="short50" /></span>
									</div>
								</div>
								<div class="item25">
									<div class="itemleft80">开证行：</div>
									<div class="righttext">
										<span><input name="bankName" type="text"
											class="short50" /></span>
									</div>
								</div>
							</div>
							<div class="oneline">
								<div class="item25">
									<div class="itemleft80">保函号：</div>
									<div class="righttext">
										<span><input name="guarantees" type="text"
											class="short50" /></span>
									</div>
								</div>
								<div class="item25">
									<div class="itemleft80">改证次数：</div>
									<div class="righttext">
										<span><input name="modifyNum" type="text"
											class="short50" /></span>
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
											id="currencySearchHistory" style="width: 100px;"></select>
									</div>
								</div>
							</div>
							<div class="oneline">
								<div class="item25">
									<div class="itemleft80">金额：</div>
									<div class="righttext">
										<span><input name="amount" type="text"
											class="short50 numberbox" /></span>
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
										<span><input name="valid" type="text" class="easyui-datebox short50" /></span>
									</div>
								</div> -->
							</div>
							<div class="oneline">
								<div class="item25">
									<div class="itemleft80">循环标识：</div>
									<div class="righttext">
										<select class="easyui-combobox" name="cycleFlag"
											class="short50">
											<option value="">全部</option>
											<option value="1">可循环</option>
											<option value="0">不可循环</option>
										</select>
									</div>
								</div>
								<div class="item25">
									<div class="itemleft80">付款周期：</div>
									<div class="righttext">
										<span><input name="payPeriod" type="text"
											class="short50" /></span>
									</div>
								</div>
								<div class="item25">
									<div class="itemleft80">单证交单期：</div>
									<div class="righttext">
										<span><input name="docAgainstDay" type="text"
											class="short50" /></span>
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
					<table id="datagridHistory"></table>
				</div>
			</div>
		</div>
	</div>

	<div id="guaranteesDescDialog"
		style="display: none; width: 1000px; height: 200px;" align="center">
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
						onclick="_CCNMY('_CNNINPUTHISTORY','customerCodeHistory')" />
				</div>
			</div>
		</div>
	</div>
</body>
</html>