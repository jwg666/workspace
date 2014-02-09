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
<jsp:include page="/common/common_js.jsp"></jsp:include>
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
					url : 'processListAction!datagrid.do',
					title : '任务列表管理',
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
						title : '活动Id',
						formatter : function(value, row, index) {
							return row.id;
						}
					}, {
						field : 'taskId',
						title : '任务Id',
						formatter : function(value, row, index) {
							return row.taskId;
						}
					}, {
						field : 'executionId',
						title : 'ExecutionId',
						formatter : function(value, row, index) {
							return row.executionId;
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
					}, {
						field : 'startTime',
						title : '任务开始时间',
						formatter : function(value, row, index) {
							return row.startTime;
						}
					}, {
						field : 'assignee',
						title : '当前处理人',
						hidden:true,
						formatter : function(value, row, index) {
							return row.assignee;
						}
					}, {
						field : 'getProcessDefinitionKey',
						title : 'Key',
						hidden : true,
						formatter : function(value, row, index) {
							return row.getProcessDefinitionKey;
						}
					} ] ],
					toolbar : [ {
						text : '查询',
						iconCls : 'icon-edit',
						handler : function() {
							search();
						}
					} ],
					//双击刷新流程信息和流程变量的信息
					onDblClickRow : function(e, rowIndex, rowData) {
						refresh(rowIndex);
						var task;
						$.ajax({
							url : 'processListAction!detailDatagrid.do',
							data : {
								'entity.id' : rowIndex.taskId
							},
							dataType : 'json',
							success : function(response) {
								task = response.rows[0];
								$('#assignee').html(task.assignee);
								$('#key').html(
										"流程Key： "
												+ task.getProcessDefinitionKey
												+ "&nbsp;&nbsp流程实例id： "
												+ task.processInstanceId);
								$('#executionId').val(task.executionId);
								$('#hidden').val(task.taskId);
								$("#graphTraceDom").attr("data",
										task.processInstanceId);
							}
						});

					}

				});
		
		searchTask = $('#searchTask').show().dialog({
			title : '查询',
			modal : true,
			closed : true,
			maximizable : false,
		});
		//查询流程信息列表	
		historicTaskDatagrid = $('#historicTaskDatagrid').datagrid({
			//url : 'taskListAction!historicTaskDatagrid.do',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			height : 260,
			singleSelect : true,
			pageList : [ 10 ],
			fit : false,
			fitColumns : true,
			nowrap : false,
			border : false,
			idField : 'id',
			
			columns : [ [ {
				field : 'historicName',
				title : '名称',
				formatter : function(value, row, index) {
					return row.historicName;
				}
			}, {
				field : 'historicPriority',
				title : '优先级',
				formatter : function(value, row, index) {
					return row.historicPriority;
				}
			}, {
				field : 'historicAssignee',
				title : '办理人',
				formatter : function(value, row, index) {
					return row.historicAssignee;
				}
			}, {
				field : 'claimTime',
				title : '认领日期',
				formatter : function(value, row, index) {
					return row.claimTime;
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
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			height : 400,
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
		var executionId = ob.executionId;
		historicTaskDatagrid.datagrid({
			url : 'taskListAction!historicTaskDatagrid.do?id='
					+ processInstanceId
		});
		variablesDatagrid.datagrid({
			url : 'processListAction!variablesDatagrid.do?id=' + executionId
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
		datagrid.datagrid('load', {
			"entity.processInstanceId" : processInstanceId,
		});
		searchTask.dialog('close');

	}
	function complete() {
		var taskId = $('#hidden').val();
		if(taskId==""){
			$.messager.alert('提示', '任务id不存在', '');
			return false;
		}
		$.ajax({
			url : 'taskListAction!complete.do?taskid=' + taskId,
			success : function(response) {
				$.messager.alert('提示', '完成任务', '');
			}
		});
	}
	function graphTrace() {
		var pid = $("#graphTraceDom").attr("data");
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
			url : 'processListAction!bathAdd.do',
			data : {
				effectRow : effectRow,
				executionId : $('#executionId').val()
			},
			dataType : 'json',
			success : function(data) {
				$.messager.show({
					title : '提示',
					msg : '修改成功！'
				});
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
	function goTaskList(){
		window.location.href="taskListAction!goTaskList";
	}
	function goprocess(){
		window.location.href="processListAction!goProcessList";
	}
</script>
<title>Activiti Explorer</title>
<link rel="stylesheet" type="text/css" href="${staticURL}/style/activi/index.css">
<body>
<input type="hidden" id="hidden">
<input type="hidden" id="executionId">
	<div class="easyui-layout" data-options="fit:true" style="width:100%;height:660px;">
	    <div data-options="region:'north',title:'',split:false" style="height:70px;">
	    <div style="height: 54px; width: 100%; overflow: hidden; padding-left: 0px; padding-top: 0px;">
			<div style="float: left; margin-left: 0px;">
				<div class="header" style="width: 100%;">
					<div style="overflow: hidden; height: 54px; width: 1300px;">
						<div style="height: 54px; width: 451px; overflow: hidden; float: left; padding-left: 0px; padding-top: 0px;">
							<div class="logo" style="width: 451px;"></div>
						</div>
						<div style="height: 54px; width: 80px; overflow: hidden; float: left; padding-left: 0px; padding-top: 0px;">
							<div tabindex="0" class="v-button main-menu-button v-button-link" role="button" style="height: 54px; width: 80px;">
								<span class="v-button-wrap" onclick="goTaskList()">
									<img alt="" class="v-icon" src="${staticURL}/style/activi/img/mm-tasks.png">
									<span class="v-button-caption">任务</span>
								</span>
							</div>
						</div>
						<div style="height: 54px; width: 80px; overflow: hidden; float: left; padding-left: 0px; padding-top: 0px;">
							<div tabindex="0" class="v-button main-menu-button v-button-link link active" role="button" style="height: 54px; width: 80px;">
								<span class="v-button-wrap" onclick="goprocess()">
									<img alt="" class="v-icon" src="${staticURL}/style/activi/img/mm-process.png">
									<span class="v-button-caption">流程</span>
								</span>
							</div>
						</div>
						<div style="height: 54px; width: 80px; overflow: hidden; float: left; padding-left: 0px; padding-top: 0px;">
							<div tabindex="0"
								class="v-button main-menu-button v-button-link link"
								role="button" style="height: 54px; width: 80px;">
								<span class="v-button-wrap">
								<img alt="" class="v-icon" src="${staticURL}/style/activi/img/mm-reports.png"><span
									class="v-button-caption">报表</span></span>
							</div>
						</div>
						<div style="height: 54px; width: 90px; overflow: hidden; float: left; padding-left: 0px; padding-top: 0px;">
							<div tabindex="0" class="v-button main-menu-button v-button-link link" role="button" style="height: 54px; width: 90px;">
								<span class="v-button-wrap">
									<img alt="" class="v-icon" src="${staticURL}/style/activi/img/mm-manage.png">
									<span class="v-button-caption">管理</span>
								</span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	    </div>  
	    <div data-options="region:'east',title:'',split:false" style="width:660px;">
		    <div class="block-holder" style="width: 600px; overflow: auto; padding-left: 0px; padding-top: 0px;">
					<div style="width: 600px; color: black;">
						<img src="${staticURL}/style/activi/img/process-50.png">
						<a href="javascript:void(0)" id="graphTraceDom" onclick="graphTrace()"> 
							<font style="color: #007DC3; font: 24px/26px Arial, Helvetica, sans-serif">流程信息(</font>
							<span id="key">流程Key：特技单增加  流程实例id：2397</span>
							<font style="color: #007DC3; font: 24px/26px Arial, Helvetica, sans-serif">)</font>
						</a>
						<br />
						<table id="historicTaskDatagrid"></table>
						<font style="color: #007DC3; font: 24px/26px Arial, Helvetica, sans-serif">流程变量</font><br />
						<table id="variablesDatagrid"></table>
					</div>
			</div>
		    <div style="width: 600px; overflow: auto; padding-left: 0px; padding-top: 0px;">
				<h4>相关内容<br>相关内容<br>相关内容<br>相关内容<br>相关内容<br>相关内容<br></h4>
			</div>
			<br>
		    <div style="height: 13px; width: 635px; overflow: auto; padding-left: 0px; padding-top: 0px;">
				<div style="width: 600px;">此任务无附加内容</div>
			</div>
			<br>
		    <div style="margin-left: 5px;" class="block-holder" style="height: 43px; width: 600px; overflow: auto; padding-left: 0px; padding-top: 0px;">
				<div tabindex="0" class="v-button" role="button" >
					<span class="v-button-wrap">
						<span class="v-button-caption">
							<a onclick="complete()">完成任务</a>
						</span>
					</span>
				</div>
				<div tabindex="0" class="v-button" role="button" >
					<span class="v-button-wrap">
						<span class="v-button-caption">
							<a onclick="">结束</a>
						</span>
					</span>
				</div>
			</div>
	    </div>  
	    <div data-options="region:'center',title:'',split:false" style="height:300px">
	    	<table id="datagrid"></table>
	    </div> 
	    <div data-options="region:'south',title:'',split:false" style="height:80px;">
			<br><br>
			<div class="block-holder" style="float: left; width:100%; text-align: center;">
				<h4>Activiti.org 版权所有。</h4>
			</div>
	    </div> 
	</div>
	<div id="workflowTraceDialog">
		<img alt="" src="">
	</div>
	<div id="searchUserDialog"
		style="display: none; width: 750px; height: 445px;">
		<table class="tableForm datagrid-toolbar"
			style="width: 100%; height: 50px;">
			<tr>
				<th>姓名名</th>
				<td><input id="userName" style="width: 155px;" /></td>
				<th>用户员工号</th>
				<td><input id="empCode" style="width: 155px;" /></td>
				<td><a href="javascript:void(0);" class="easyui-linkbutton"
					onclick="Usersearch();">过滤</a></td>
			</tr>
		</table>
		<table id="userDatagrid"></table>
	</div>
	<div id="searchTask"
		style="display: none; width: 400px; height: 80px;">
		<form id="searchTaskForm">
			<table class="tableForm datagrid-toolbar"
				style="width: 100%; height: 100%;">
				<tr>
					<th>流程实例id</th>
					<td><input id="processInstanceId" style="width: 155px;" /></td>
					<td><a href="javascript:void(0);" class="easyui-linkbutton"
						onclick="searchTasks()">过滤</a></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>
