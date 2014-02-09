<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
<jsp:include page="/common/common_js.jsp"></jsp:include>
<style type="text/css">
html,body {
	height: 100%;
	margin: 0;
}
</style>
<script type="text/javascript">
	var searchForm;
	var datagrid;
	var ctx = "${dynamicURL}"
	var searchUserDialog;
	var searchTask;
	//定义变量接收行的值
	var lastIndex;
	$(function() {
		//查询任务列表	
		searchForm = $('#searchForm').form();
		searchTaskForm = $('#searchTaskForm').form();
		datagrid = $('#datagrid').datagrid(
				{
					url : 'taskListAction!executionDatagrid.do',
					title : '流程列表管理',
					iconCls : 'icon-save',
					pagination : true,
					pagePosition : 'bottom',
					pageSize : 12,
					singleSelect : true,
					pageList : [ 12 ],
					fit : true,
					fitColumns : true,
					nowrap : false,
					border : false,
					idField : 'id',
					columns : [ [ {
						field : 'id',
						title : '流程Id',
						formatter : function(value, row, index) {
							return row.id;
						}
					}, {
						field : 'activityId',
						title : '当前节点ID',
						formatter : function(value, row, index) {
							return row.activityId;
						}
					}, {
						field : 'name',
						title : '当前节点name',
						formatter : function(value, row, index) {
							return row.name;
						}
					}, {
						field : 'processInstanceId',
						title : '流程实例id',
						formatter : function(value, row, index) {
							return row.processInstanceId;
						}
					}, {
						field : 'processDefinitionId',
						title : '流程定义id'
					} ] ],
					toolbar : [ {
						text : '查询',
						iconCls : 'icon-edit',
						handler : function() {
							search();
						}
					} ],
					//双击刷新流程信息和流程变量的信息
					onDblClickRow : function(rowIndex, rowData) {
						refresh(rowData);
						var task;

						$('#key').html(
								"流程Key： " + rowData.processDefinitionId
										+ "&nbsp;&nbsp流程实例id： "
										+ rowData.processInstanceId);
						$('#hidden').val(rowData.id);
						$("#graphTraceDom").attr("data",
								rowData.processInstanceId);

					}

				});
		searchTask = $('#searchTask').show().dialog({
			title : '查询',
			modal : true,
			closed : true,
			maximizable : false,
		});
		//查询流程信息列表	
		historicTaskDatagrid = $('#historicTaskDatagrid')
				.datagrid(
						{
							//url : 'taskListAction!historicTaskDatagrid.do',
							iconCls : 'icon-save',
							pagination : false,
							pagePosition : 'bottom',
							height : 360,
							toolbar : [ {
								iconCls : 'icon-back',
								text : "重做",
								handler : function() {
									var selectRows = $('#historicTaskDatagrid')
											.datagrid("getSelections");
									if (selectRows.length > 0) {
										var taskKeys = "";
										var taskName="";
										for ( var i = 0; i < selectRows.length; i++) {
											if (i < selectRows.length - 1) {
												taskKeys = taskKeys
														+ selectRows[i].taskKey
														+ ",";
												taskName=taskName+ selectRows[i].historicName
												+ ",";
											} else {
												taskKeys = taskKeys
														+ selectRows[i].taskKey;
												taskName = taskName
												+ selectRows[i].historicName;
											}
										}
										//alert(taskKeys);
										$.messager
												.confirm(
														'确认',
														'你确定要重做以下节点:'+taskName,
														function(r) {
															if (r) {
																$.ajax({
																	url : 'taskListAction!reDoTask.do',
																	data : {
																		'reDoTaskKeys' : taskKeys,
																		'taskid':$("#hidden").val()
																	},
																	dataType : 'json',
																	success : function(response) {
																		
																	}
																}); 
															}
														});

									}

								}
							} ],
							fit : false,
							nowrap : false,
							border : false,
							idField : 'id',
							columns : [ [ {
								field : 'ck',
								checkbox : true
							}, {
								field : 'historicName',
								title : '名称',
								formatter : function(value, row, index) {
									return row.historicName;
								}
							}, {
								field : 'taskKey',
								title : 'id'
							}

							, {
								field : 'historicAssignee',
								title : '办理人',
								formatter : function(value, row, index) {
									return row.historicAssignee;
								}
							}, {
								field : 'state',
								title : '状态',
								formatter : function(value, row, index) {
									return row.state;
								}
							}, {
								field : 'endTime',
								title : '完成时间',
								formatter : function(value, row, index) {
									return row.endTime;
								}
							}, {
								field : 'startTime',
								title : '开始时间',
								formatter : function(value, row, index) {
									return row.startTime;
								}
							} ] ],
						});
		//查询流程变量列表	
		variablesDatagrid = $('#variablesDatagrid').datagrid({
			//url : 'taskListAction!variablesDatagrid.do',
			iconCls : 'icon-save',
			pagination : false,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			height : 360,
			singleSelect : true,
			pageList : [ 10 ],
			fit : false,
			fitColumns : true,
			nowrap : false,
			border : false,
			idField : 'id',
			
			columns : [ [ {
				field : 'key',
				title : '名称',
				width : 100,
				formatter : function(value, row, index) {
					return row.key;
				}
			}, {
				field : 'value',
				title : '值',
				width : 100,
				formatter : function(value, row, index) {
					return row.value;
				},
				editor : {
					type : 'validatebox',
					options : {
						required : true
					}
				}
			} ] ],
			toolbar : [ {
				text : '保存',
				iconCls : 'icon-save',
				handler : function() {
					save();
				}
			}, '-', {
				text : '取消编辑',
				iconCls : 'icon-add',
				handler : function() {
					endEdit();
				}
			}, '-' ],
			//批量修改
			onClickRow : function(rowIndex) {
				if (lastIndex != rowIndex) {
					$('#variablesDatagrid').datagrid('endEdit', lastIndex);
					$('#variablesDatagrid').datagrid('beginEdit', rowIndex);
				}
				if ($('#variablesDatagrid').datagrid('getRows').length == 1) {
					$('#variablesDatagrid').datagrid('beginEdit', rowIndex);
				}
				lastIndex = rowIndex;
			}
		});
	});
	function refresh(ob) {
		var processInstanceId = ob.processInstanceId;
		historicTaskDatagrid.datagrid({
			url : 'taskListAction!historicActDatagrid.do?id='
					+ processInstanceId
		});
		variablesDatagrid
				.datagrid({
					url : 'taskListAction!executionVariablesDatagrid.do?processInstanceId='
							+ processInstanceId
				});

	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.form('clear');
	}
	function search() {
		searchTask.dialog('open');
		searchTaskForm.form('clear');
	}
	function searchTasks() {
		var processInstanceId = $('#processInstanceId').val();
		var processDefinitionKey = $('#processDefinitionKey').val();
		var taskDefKey = $('#taskDefKey').val();
		var businessformId = $('#businessformId').val();
		datagrid.datagrid('load', {
			"processInstanceId" : processInstanceId,
			"processDefinitionKey" : processDefinitionKey,
			"taskDefKey" : taskDefKey,
			"businessformId" : businessformId
		});
		searchTask.dialog('close');

	}
	function complete() {
		var executionId = $('#hidden').val();
		$.ajax({
			url : 'taskListAction!signalExecution.do?executionId='
					+ executionId,
			dataType : 'json',
			success : function(response) {
				if (response.success) {
					$.messager.alert('提示', '完成任务', '');
				} else {
					$.messager.alert('提示', '出现错误', '');
				}
			}
		});
	}
	function graphTrace() {
		var pid = $("#graphTraceDom").attr("data");
		/* var imageUrl = ctx
				+ "/workflow/processAction!loadImageByPid.do?processInstanceId="
				+ pid; */
		/* $('#workflowTraceDialog img').attr('src', imageUrl);

		$('#workflowTraceDialog').dialog({
			modal : true,
			resizable : false,
			title : '查看流程（按ESC键可以关闭）',
			width : document.documentElement.clientWidth * 0.95,
			height : document.documentElement.clientHeight * 0.95
		}); */
		if (typeof (parent.window.HROS) != "undefined") {
			parent.window.HROS.window
					.createTemp({
						title : "流程图",
						url : "${dynamicURL}/workflow/processAction!goTrace.do?processInstanceId="
								+ pid,
						width : 800,
						height : 400,
						isresize : false,
						isopenmax : true,
						isflash : false
					});
		} else {
			var imageUrl = ctx
					+ "/workflow/processAction!loadImageByPid.do?processInstanceId="
					+ pid;
			$('#workflowTraceDialog img').attr('src', imageUrl);
			$('#workflowTraceDialog').dialog({
				modal : true,
				resizable : false,
				title : '查看流程（按ESC键可以关闭）',
				width : document.documentElement.clientWidth * 0.95,
				height : document.documentElement.clientHeight * 0.95
			});
		}
	}
	function afreshAssignee() {
		searchUserDialog.dialog('open');
	}
	//任务重新分配
	function setAssignee() {
		var rows = userDatagrid.datagrid('getSelections');
		if (rows.length < 1) {
			$.messager.alert('提示', '请选择一个用户', '');
		}
		var taskid = $('#hidden').val();
		$.ajax({
			url : 'taskListAction!setAssignee.do',
			data : {
				'taskid' : taskid,
				'user.id' : rows[0].id
			},
			success : function(response) {
				$.messager.show({
					msg : '重新分配完成'
				});
				$('#assignee').html(rows[0].name);
				searchUserDialog.dialog('close');
			}
		});
	}
	// 查询用户
	function Usersearch() {
		var userName = $('#userName').val();
		var empCode = $('#empCode').val();
		userDatagrid.datagrid('load', {
			"user.name" : userName,
			"user.empCode" : empCode
		});

	}
	//编辑方法
	function save() {
		endEdit();
		var rows = $('#variablesDatagrid').datagrid('getChanges');
		//获取修改的数据
		var updated = $('#variablesDatagrid').datagrid('getChanges', "updated");
		var effectRow = new Object();
		if (updated.length) {
			//转换成json形式的字符串
			effectRow = JSON.stringify(updated);
		}
		$.ajax({
			url : 'taskListAction!bathAdd.do',
			data : {
				effectRow : effectRow,
				taskId : $('#hidden').val()
			},
			dataType : 'json',
			success : function(data) {

			}
		});
	}
	//结束编辑
	function endEdit() {
		var rowsSelect = $('#variablesDatagrid').datagrid('getRows');
		for ( var i = 0; i < rowsSelect.length; i++) {
			$('#variablesDatagrid').datagrid('endEdit', i);
		}
	}

	function goTaskList() {
		window.location.href = "taskListAction!goTaskList";
	}
	function goprocess() {
		window.location.href = "processListAction!goProcessList";
	}
</script>
<title>Activiti Explorer</title>
<link rel="stylesheet" type="text/css"
	href="${staticURL}/style/activi/index.css">
<body>
	<input type="hidden" id="hidden">
	<div class="easyui-layout" data-options="fit:true"
		style="width: 100%; height: 660px;">
		<div data-options="region:'north',title:'',split:false"
			style="height: 70px;">
			<div
				style="height: 54px; width: 100%; overflow: hidden; padding-left: 0px; padding-top: 0px;">
				<div style="float: left; margin-left: 0px;">
					<div class="header" style="width: 100%;">
						<div style="overflow: hidden; height: 54px; width: 1300px;">
							<div
								style="height: 54px; width: 451px; overflow: hidden; float: left; padding-left: 0px; padding-top: 0px;">
								<div class="logo" style="width: 451px;"></div>
							</div>
							<div
								style="height: 54px; width: 80px; overflow: hidden; float: left; padding-left: 0px; padding-top: 0px;">
								<div tabindex="0"
									class="v-button main-menu-button v-button-link" role="button"
									style="height: 54px; width: 80px;">
									<a href="${dynamicURL}/workflow/taskListAction!goTaskList.do">
										<span class="v-button-wrap" onclick="goTaskList()"> <img
											alt="" class="v-icon"
											src="${staticURL}/style/activi/img/mm-tasks.png"> <span
											class="v-button-caption">任务</span>
									</span>
									</a>
								</div>
							</div>
							<div
								style="height: 54px; width: 80px; overflow: hidden; float: left; padding-left: 0px; padding-top: 0px;">
								<div tabindex="0"
									class="v-button main-menu-button v-button-link link active"
									role="button" style="height: 54px; width: 80px;">
									<a
										href="${dynamicURL}/workflow/taskListAction!goExecutionList.do">
										<span class="v-button-wrap" onclick="goprocess()"> <img
											alt="" class="v-icon"
											src="${staticURL}/style/activi/img/mm-process.png"> <span
											class="v-button-caption">流程</span>
									</span>
									</a>
								</div>
							</div>
							<div
								style="height: 54px; width: 90px; overflow: hidden; float: left; padding-left: 0px; padding-top: 0px;">
								<div tabindex="0"
									class="v-button main-menu-button v-button-link link"
									role="button" style="height: 54px; width: 90px;">
									<a href="${dynamicURL}/workflow/processAction!processAction.do">
										<span class="v-button-wrap"> <img alt="" class="v-icon"
											src="${staticURL}/style/activi/img/mm-manage.png"> <span
											class="v-button-caption"> 管理 </span>
									</span>
									</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div data-options="region:'east',title:'',split:false"
			style="width: 660px;">
			<div class="block-holder"
				style="width: 600px; overflow: auto; padding-left: 0px; padding-top: 0px;">
				<div style="width: 600px; color: black;">
					<img src="${staticURL}/style/activi/img/process-50.png"> <a
						href="javascript:void(0)" id="graphTraceDom"
						onclick="graphTrace()"> <font
						style="color: #007DC3; font: 24px/26px Arial, Helvetica, sans-serif">流程信息(</font>
						<span id="key">流程Key：特技单增加 流程实例id：2397</span> <font
						style="color: #007DC3; font: 24px/26px Arial, Helvetica, sans-serif">)</font>
					</a> <br />
					<table id="historicTaskDatagrid"></table>
					<font
						style="color: #007DC3; font: 24px/26px Arial, Helvetica, sans-serif">流程变量</font><br />
					<table id="variablesDatagrid"></table>
				</div>
			</div>
			<br>
			<div style="margin-left: 5px;" class="block-holder"
				style="height: 43px; width: 600px; overflow: auto; padding-left: 0px; padding-top: 0px;">
				<div tabindex="0" class="v-button" role="button">
					<span class="v-button-wrap"> <span class="v-button-caption">
							<a onclick="complete()">完成</a>
					</span>
					</span>
				</div>
			</div>
		</div>
		<div data-options="region:'center',title:'',split:false"
			style="height: 300px">
			<table id="datagrid"></table>
		</div>
		<div data-options="region:'south',title:'',split:false"
			style="height: 80px;">
			<br>
			<br>
			<div class="block-holder"
				style="float: left; width: 100%; text-align: center;">
				<h4>Activiti.org 版权所有。</h4>
			</div>
		</div>
	</div>
	<div id="workflowTraceDialog">
		<img alt="" src="">
	</div>
	<div id="searchTask"
		style="display: none; width: 500px; height: 300px;">
		<form id="searchTaskForm">
			<table class="tableForm datagrid-toolbar"
				style="width: 100%; height: 100%;">

				<tr>
					<th>流程实例id</th>
					<td><input id="processInstanceId" style="width: 155px;" /></td>
					<td></td>
				</tr>
				<tr>
					<th>流程定义Key</th>
					<td><input id="processDefinitionKey" style="width: 155px;" /></td>
					<td></td>
				</tr>
				<tr>
					<th>节点ID</th>
					<td><input id="taskDefKey" style="width: 155px;" /></td>
					<td></td>
				</tr>
				<tr>
					<th>订单号</th>
					<td><input id="businessformId" style="width: 155px;" /></td>
					<td></td>
				</tr>

				<tr>
				<tr>
					<td>获取HOPE议付信息:</td>
					<td>getNegoInfoFromHope</td>
				</tr>
				<tr>
					<td>跟踪备货:</td>
					<td>followGoods</td>
				</tr>
				<tr>
					<td>获取装箱信息:</td>
					<td>getPackageInfo</td>
				</tr>
				<tr>
					<td>订单评审:</td>
					<td>orderAutoAudit</td>
				</tr>
				<tr>
					<td><a href="javascript:void(0);" class="easyui-linkbutton"
						onclick="searchTasks()">过滤</a>
					<td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>
