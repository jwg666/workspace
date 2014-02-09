<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	$(function() {
		$.messager.progress({
			text : '数据加载中....',
			interval : 100
		});
		guaranteesEditForm = $('#guaranteesEditForm').form({
			url : 'guaranteesAction!finMgrEdit.action',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.alert('提示', json.msg, 'info', function() {
						customWindow.refreshDatagrid();
						parent.window.HROS.window.close(currentappid);
					});
				} else {
					$.messager.alert('提示', json.msg, 'error', function() {
						customWindow.refreshDatagrid();
						parent.window.HROS.window.close(currentappid);
					});
				}
			},
			onLoadSuccess : function(data) {
				$("#customerCode0").combogrid({
					url : '${dynamicURL}/basic/customerAction!datagrid0.action?customerId=' + data.customerCode,
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
					} ] ],
					onLoadSuccess:function(){
						$("#_CNNINPUT").val($("#customerCode0").combogrid('getText'));
						$(this).datagrid("clearSelections");
					}
				});

			}
		});

		if ($("#guaranteesHidden").val() == '') {
			$.messager.alert('消息', '保函记录未找到，可能已经被删除', 'info', function() {
				$.messager.progress('close');
			});
			return;
		}
		$.ajax({
			url : 'guaranteesAction!showDesc.action',
			data : {
				guarantees : $("#guaranteesHidden").val(),
			},
			dataType : 'json',
			cache : false,
			success : function(response) {
				if (response == null) {
					$.messager.alert('消息', '保函记录未找到，可能已经被删除', 'info', function() {
						$.messager.progress('close');
					});
					return;
				}
				var taskId = $("#taskIdHidden").val();
				guaranteesEditForm.form("clear");
				guaranteesEditForm.form('load', response);
				$("#taskIdHidden").val(taskId);
				$("#guaranteesOldHidden").val(response.guarantees);
				$('div.validatebox-tip').remove();
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

		guaranteesEditDialog = $('#guaranteesEditDialog').show().dialog({
			title : '编辑保函维护',
			modal : true,
			closed : true,
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
									$.messager.alert('提示', '保函名已存在，请重新输入。', function() {
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
	});
	//判断是否存在保函 号
	function existGuarantees(editFlag) {
		var guarantees_;
		if ($("#guarantees0").val() == $("#guaranteesOldHidden").val()) {
			return;
		}
		guarantees_ = $("#guarantees0").val();
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
						$("#guarantees0").focus();

					});
				} else {
					return;
				}
			}
		});
	}

	function saveEdit() {
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

	function _CCNMY(inputId, selectId) {
		var _CCNTEMP = $('#' + inputId).val()
		$('#' + selectId).combogrid({
			url : '../basic/customerAction!datagrid0.action?name=' + _CCNTEMP
		});
		$('#' + inputId).val(_CCNTEMP);
	}
	//保存数据，完成工作流节点
	function saveSchedule() {
		guaranteesEditForm.submit();
	}
</script>
</head>
<body class="zoc">
	<s:hidden id="guaranteesHidden" name="guarantees"></s:hidden>
	<form id="guaranteesEditForm">
		<s:hidden id="taskIdHidden" name="taskId"></s:hidden>
		<div class="part_zoc">
			<div class="oneline">
				<div class="item33">
					<div class="itemleft">保函号：</div>
					<div class="righttext">
						<input name="guarantees" id="guarantees0" type="text"
							class="easyui-validatebox" required="true"
							missingMessage="请填写保函号" style="width: 155px;" /><input
							id="guaranteesOldHidden" type="hidden" name="guaranteesOld" />
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">受益人</div>
					<div class="righttext">
						<input name="beneficiaries" type="text" class="easyui-combobox"
							data-options="required:true,editable:false,url : '../basic/saleOrgAction!combox.action',valueField : 'saleOrgCode',textField : 'saleOrgName'" missingMessage="请填写受益人" style="width: 155px;" />
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">客户：</div>
					<div class="righttext">
						<select name="customerCode" 
							style="width: 155px;" data-options="required:true,editable:false" missingMessage="请填写客户名称"
							id="customerCode0"></select>
					</div>
				</div>
			</div>
			<div class="oneline">
				<div class="item33">
					<div class="itemleft">开证行</div>
					<div class="righttext">
						<input name="bankName" type="text" class="easyui-validatebox"
							required="true" missingMessage="请填写开证行" style="width: 155px;" />
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">改证次数</div>
					<div class="righttext">
						<input name="modifyNum" type="text"
							class="easyui-validatebox easyui-numberbox" required="true"
							missingMessage="请填写改证次数" style="width: 155px;" />
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">类型</div>
					<div class="righttext">
						<!-- <input name="payType" type="text" class="easyui-validatebox"
								data-options="required:true" missingMessage="请填写类型"
								style="width: 155px;" />  -->
						<select class="easyui-combobox" name="payType" required="true"
							missingMessage="请填写类型" style="width: 155px;">
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
							style="width: 155px;" name="currency" data-options="required:true,editable:false"
							missingMessage="请填写币种"></select>
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">金额</div>
					<div class="righttext">
						<input name="amount" type="text" class="easyui-numberbox"
							required="true" missingMessage="请填写金额" style="width: 155px;" />
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
							required="true" missingMessage="请填写付款周期" style="width: 155px;" />
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">单证交单期</div>
					<div class="righttext">
						<input name="docAgainstDay" type="text" class="easyui-validatebox"
							required="true" missingMessage="请填写单证交单期" style="width: 155px;" />
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">开证日</div>
					<div class="righttext">
						<input name="startDate" type="text" class="easyui-datebox"
							id="startDateEdit" required="true" missingMessage="请填写开证日"
							style="width: 155px;" />
					</div>
				</div>
			</div>
			<div class="oneline">
				<div class="item33">
					<div class="itemleft">到期日</div>
					<div class="righttext">
						<input name="endDate" type="text" class="easyui-datebox"
							id="endDateEdit" required="true" missingMessage="请填写到期日"
							style="width: 155px;" />
					</div>
				</div>
				<!-- <div class="item33">
					<div class="itemleft">有效期</div>
					<div class="righttext">
						<input name="valid" type="text" class="easyui-datebox"
							required="true" missingMessage="请填写有效期" style="width: 155px;" />
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
			<div class="oneline">
				<div class="item100">
					<div class="oprationbutt">
						<input type="button" value="保存" onclick="saveSchedule();" />
					</div>
				</div>
			</div>
		</div>
	</form>

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
						onclick="_CCNMY('_CNNINPUT','customerCode0')" />
				</div>
			</div>
		</div>
	</div>
</body>
</html>