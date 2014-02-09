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
					url : 'taskListAction!datagrid.do',
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
						title : '任务Id',
						formatter : function(value, row, index) {
							return row.id;
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
						field : 'createTime',
						title : '任务创建时间',
						formatter : function(value, row, index) {
							return row.createTime;
						}
					}, {
						field : 'assignee',
						title : '当前处理人',
						formatter : function(value, row, index) {
							return row.assignee;
						}
					}, {
						field : 'dueDate',
						title : '到期日',
						hidden : true,
						formatter : function(value, row, index) {
							return row.dueDate;
						}
					}, {
						field : 'priority',
						title : '级别',
						hidden : true,
						formatter : function(value, row, index) {
							return row.priority;
						}
					}, {
						field : 'description',
						title : '描述',
						hidden : true,
						formatter : function(value, row, index) {
							return row.description;
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
							url : 'taskListAction!detailDatagrid.do',
							data : {
								'entity.id' : rowIndex.id
							},
							dataType : 'json',
							success : function(response) {
								task = response.rows[0];
								$('#name').html(task.name);
								if (rowIndex.dueDate != null) {
									$('#dueDate').html(task.dueDate);
								}
								$('#createTime').html(task.createTime);
								if (rowIndex.description != null) {
									$('#description').html(task.description);
								}
								$('#groupIds').html(task.groupIds);
								$('#priority').html(task.priority);
								$('#getProcessDefinitionKey').html(
										"任务属于" + task.getProcessDefinitionKey
												+ "流程");
								$('#assignee').html(task.assignee);
								$('#key').html(
										"流程Key： "
												+ task.getProcessDefinitionKey
												+ "&nbsp;&nbsp流程实例id： "
												+ task.processInstanceId);
								$('#hidden').val(task.id);
								$("#graphTraceDom").attr("data",
										task.processInstanceId);
								changeTitleAndUrl(rowIndex.id);
							}
						});

					}

				});
		searchUserDialog = $('#searchUserDialog').show().dialog({
			title : '选择用户',
			modal : true,
			closed : true,
			maximizable : false,
			buttons : [ {
				text : '选择',
				handler : function() {
					setAssignee();
				}
			} ]
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
			pageSize : 50,
			height : 360,
			toolbar: [{
				iconCls: 'icon-back',
				text:"重做",
				handler: function(){
					var selectRows=$('#historicTaskDatagrid').datagrid("getSelections");
					if(selectRows.length>0){
					var taskKeys="";
					for(var i=0;i<selectRows.length;i++){
						if(i<selectRows.length-1){
						taskKeys=taskKeys+selectRows[i].taskKey+","
						}else{
						taskKeys=taskKeys+selectRows[i].taskKey;
						}
					}
					alert(taskKeys);
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
					
				}
			}],
			pageList : [ 50,100 ],
			fit : false,
			nowrap : false,
			border : false,
			idField : 'id',
			
			columns : [ [ 
			{
				field : 'ck',
				checkbox:true
			},
			 {
				field : 'historicName',
				title : '名称',
				formatter : function(value, row, index) {
					return row.historicName;
				}
			},
			{
				field:'taskKey',
				title:'id'
			}
			,  {
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
		//人员列表
		userDatagrid = $('#userDatagrid').datagrid({
			url : 'taskListAction!search.do',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			height : 315,
			singleSelect : true,
			pageList : [ 10 ],
			fit : false,
			fitColumns : false,
			nowrap : false,
			border : false,
			idField : 'id',
			
			columns : [ [ {
				field : 'ck',
				checkbox : true,
				formatter : function(value, row, index) {
					return row.lcNum;
				}
			},{
				field : 'empCode',
				title : '员工号',
				width : 150,
				formatter : function(value, row, index) {
					return row.empCode;
				}
			}, {
				field : 'name',
				title : '登陆名称',
				width : 150,
				formatter : function(value, row, index) {
					return row.name;
				}
			}, {
				field : 'name',
				title : '用户姓名',
				width : 150,
				formatter : function(value, row, index) {
					return row.name;
				}
			}, {
				field : 'email',
				title : '邮箱',
				width : 150,
				formatter : function(value, row, index) {
					return row.email;
				}
			}
			] ]
		});
	});
	function refresh(ob) {
		var processInstanceId = ob.processInstanceId;
		historicTaskDatagrid.datagrid({
			url : 'taskListAction!historicTaskDatagrid.do?id='
					+ processInstanceId
		});
		variablesDatagrid.datagrid({
			url : 'taskListAction!variablesDatagrid.do?id=' + ob.id
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
		var entityName = $('#entityName').val();
		var group = $('#group').val();
		var processInstanceId = $('#processInstanceId').val();
		var processDefinitionKey = $('#processDefinitionKey').val();
		var entityAssignee = $('#entityAssignee').val();
		var businessformId = $('#businessformId').val();
		datagrid.datagrid('load', {
			"entity.name" : entityName,
			"entity.processInstanceId" : processInstanceId,
			"processDefinitionKey" : processDefinitionKey,
			"group" : group,
			"entity.Assignee" : entityAssignee,
			"businessformId" : businessformId
		});
		searchTask.dialog('close');

	}
	function complete() {
		var taskId = $('#hidden').val();
		$.ajax({
			url : 'taskListAction!complete.do?taskid=' + taskId,
			success : function(response) {
				$.messager.alert('提示', '完成任务', '');
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
		parent.window.HROS.window.createTemp({
			title:"流程图",
			url:"${dynamicURL}/workflow/processAction!goTrace.do?processInstanceId="+pid,
			width:800,height:400,isresize:false,isopenmax:true,isflash:false});
	}
	function afreshAssignee() {
		searchUserDialog.dialog('open');
	}
	//任务重新分配
	function setAssignee() {
		var rows = userDatagrid.datagrid('getSelections');
		var userId;		
		if (rows.length < 1) {
			userId="0";
		}else{
			 userId=rows[0].id;
		}
		
		var taskid = $('#hidden').val();
		$.ajax({
			url : 'taskListAction!setAssignee.do',
			data : {
				'taskid' : taskid,
				'user.id' : userId
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
			"user.empCode":empCode
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
	//mengy 输出待办事项办理
	function changeTitleAndUrl(taskid) {
		$.ajax({
			url : 'scheduleUrlAndTitleAction!titleAndUrl.do',
			data : {
				taskId : taskid
			},
			dataType : 'json',
			cache : false,
			success : function(data) {
				$('#description').html(
						'<a target="_blank" href="../' + data.url + '">'
								+ data.title + '</a>');
			}
		});
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
							<div tabindex="0" class="v-button main-menu-button v-button-link active" role="button" style="height: 54px; width: 80px;">
								 <a href="${dynamicURL}/workflow/taskListAction!goTaskList.do" >
								<span class="v-button-wrap" onclick="goTaskList()">
									<img alt="" class="v-icon" src="${staticURL}/style/activi/img/mm-tasks.png">
									<span class="v-button-caption">任务</span>
								</span>
								</a>
							</div>
						</div>
						<div style="height: 54px; width: 80px; overflow: hidden; float: left; padding-left: 0px; padding-top: 0px;">
							<div tabindex="0" class="v-button main-menu-button v-button-link link" role="button" style="height: 54px; width: 80px;">
								<a href="${dynamicURL}/workflow/taskListAction!goExecutionList.do">
								<span class="v-button-wrap" onclick="goprocess()">
									<img alt="" class="v-icon" src="${staticURL}/style/activi/img/mm-process.png">
									<span class="v-button-caption">流程</span>
								</span>
								</a>
							</div>
						</div>
						<div style="height: 54px; width: 90px; overflow: hidden; float: left; padding-left: 0px; padding-top: 0px;">
							<div tabindex="0" class="v-button main-menu-button v-button-link link" role="button" style="height: 54px; width: 90px;">
								 <a href="${dynamicURL}/workflow/processAction!processAction.do" >
								<span class="v-button-wrap">
									<img alt="" class="v-icon" src="${staticURL}/style/activi/img/mm-manage.png">
									 <span class="v-button-caption">
									管理
									</span>
								</span>
								</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	    </div>  
	    <div data-options="region:'east',title:'',split:false" style="width:660px;">
			<div style="height: 55px; width: 600px; overflow: hidden; padding-left: 0px; padding-top: 0px;">
				<div class="title-block" style="width: 600px;">
					<div style="position: relative; overflow: hidden; height: 50px;">
						<div class="v-embedded v-embedded-image" style="width: 49px; height: 50px;">
							<img src="${staticURL}/style/activi/img/task-50.png">
						</div>
						<div style="height: 18px; overflow: hidden; padding-left: 0px; padding-top: 0px; position: absolute; left: 61px; top: 32px; width: 574px;">
							<div style="height: 18px; width: 92px; overflow: auto; float: left; padding-left: 0px; padding-top: 0px;">
								<div id="dueDate" class="task-duedate v-label-clickable">未设置到期日</div>
							</div>
							<div style="height: 18px; width: 32px; overflow: hidden; float: left; padding-left: 6px; padding-top: 0px;">
								<div id="priority" class="task-priority-medium">中</div>
							</div>
							<div style="height: 18px; width: 140px; overflow: hidden; float: left; padding-left: 6px; padding-top: 0px;">
								<div id="createTime" class="task-create-time">创建于当前 之前 </div>
							</div>
						</div>
						<div style="height: 27px; overflow: auto; padding-left: 0px; padding-top: 0px; position: absolute; left: 61px; top: 0px; width: 574px;">
							<div id="name" class="v-label v-label-h2 h2" style="width: 574px;">Investigate hardware </div>
						</div>
					</div>
				</div>
			</div>
			<div style="height: 25px; width: 635px; overflow: auto; padding-left: 0px; padding-top: 0px;">
				<div id="description"  style="width: 635px;">此任务没有描述。 </div>
			</div>	
		    <div style="height: 25px; width: 635px; overflow: auto; padding-left: 0px; padding-top: 0px;">
				<span id="getProcessDefinitionKey">任务属于流程: 'Fix system failure' </span>
			</div>
		    <div style="height: 135px; width: 600px; overflow: auto; padding-left: 0px; padding-top: 0px;">
				<div class="block-holder" style="width: 600px; height: 66px;">
					<div style="height: 25px; width: 600px; overflow: auto; padding-left: 0px; padding-top: 0px;">
						<div class="v-label h3" style="width: 600px;">参与人</div>
					</div>
					<div class="v-gridlayout" style="width: 600px;">
						<div style="position: relative; overflow: hidden; height: 36px;">
							<div style="height: 36px; overflow: auto; padding-left: 0px; padding-top: 0px; position: absolute; left: 0px; top: 0px; width: 306px;">
								<div style="float: left; margin-left: 0px;">
									<img src="${staticURL}/style/activi/img/user-32.png">
								</div>
								<div style="height: 36px; width: 99px; overflow: auto; float: left; padding-left: 6px; padding-top: 0px;">
										<br>
										<div style="height: 18px; width: 48px; overflow: auto; float: left; padding-left: 0px; padding-top: 0px;">
											<div>无所属人</div>
										</div>
										<div tabindex="0" class="v-button v-button-small small" role="button">
											<span class="v-button-wrap">
												<span class="v-button-caption">转让</span>
											</span>
										</div>
								</div>
							</div>
							<div style="height: 56px; overflow: auto; padding-left: 0px; padding-top: 0px; position: absolute; left: 318px; top: 0px; width: 317px;">
								<div style="height: 18px; width: 107px; overflow: hidden; padding-left: 0px; padding-top: 0px;">
									<h4><div id="assignee"> Kermit The Frog </div></h4>
								</div>
								<div style="height: 18px; width: 107px; overflow: auto; padding-left: 0px; padding-top: 0px;">
									<div style="height: 18px; width: 36px; overflow: auto; float: left; padding-left: 0px; padding-top: 0px;">
										<div class="v-label">办理人</div>
									</div>
									<div tabindex="0" class="v-button v-button-small">
										<span class="v-button-wrap">
											<span class="v-button-caption"><a onclick="afreshAssignee()">重新分配</a></span>
										</span>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div style="height: 18px; width: 550px; overflow: auto; padding-left: 0px; padding-top: 20px;">
									<div style="height: 18px; width: 86px; overflow: auto; float: left; padding-left: 0px; padding-top: 0px;">
										所属任务组：
									</div>
									<div id="groupIds">所属任务组</div>
								</div>
			</div>
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
			<br>
		    <div style="margin-left: 5px;" class="block-holder" style="height: 43px; width: 600px; overflow: auto; padding-left: 0px; padding-top: 0px;">
				<div tabindex="0" class="v-button" role="button" >
					<span class="v-button-wrap">
						<span class="v-button-caption">
							<a onclick="complete()">完成任务</a>
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
		style="display: none; width: 500px; height: 200px;">
		<form id="searchTaskForm">
			<table class="tableForm datagrid-toolbar"
				style="width: 100%; height: 100%;">
				<tr>
					<th>任务名称</th>
					<td><input id="entityName" style="width: 155px;" /></td>
					<td></td>
				</tr>
				<tr>
					<th>处理人</th>
					<td><input id="entityAssignee" style="width: 155px;" /></td>
					<td></td>
				</tr>
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
					<th>订单号</th>
					<td><input id="businessformId" style="width: 155px;" /></td>
					<td></td>
				</tr>
				<tr>
					<th>所属组</th>
					<td><input id="group" style="width: 155px;" /></td>
					<td><a href="javascript:void(0);" class="easyui-linkbutton"
						onclick="searchTasks()">过滤</a>
					<td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>
