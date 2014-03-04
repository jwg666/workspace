<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="${staticURL}/style/activi/index.css">
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var processAddDialog;
	var processAddForm;
	var cdescAdd;
	var processEditDialog;
	var processEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'processAction!datagrid.do',
			title : '流程定义管理',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			pageList : [ 5, 10, 15, 20 ],
			fit : true,
			fitColumns : false,
			nowrap : true,
			border : false,
			idField : 'id',
			
			columns : [ [ 
			{field:'id',title:'id',
						formatter:function(value,row,index){
							return row.id;
						}
					},
			   {field:'processDefinitionId',title:'processDefinitionId',align:'center',
					formatter:function(value,row,index){
						return row.id;
					}
				},				
			   {field:'deploymentId',title:'deploymentId',align:'center',
					formatter:function(value,row,index){
						return row.deploymentId;
					}
				},				
			   {field:'name',title:'name',align:'center',
					formatter:function(value,row,index){
						return row.name;
					}
				},				
			   {field:'key',title:'key',align:'center',
					formatter:function(value,row,index){
						return row.key;
					}
				}				
				,				
			   {field:'version',title:'version',align:'center',
					formatter:function(value,row,index){
						return row.version;
					}
				}				
				,				
			   {field:'resourceName',title:'resourceName',align:'center',
					formatter:function(value,row,index){
						return "<a target='_blank' href='processAction!loadByDeployment.do?deploymentId="+row.deploymentId+"&resourceName="+row.resourceName+"'>"+row.resourceName+"</a>";
					}
				}				
				,				
			   {field:'diagramResourceName',title:'diagramResourceName',align:'center',
					formatter:function(value,row,index){
						return "<a target='_blank' href='processAction!loadImage.do?deploymentId="+row.deploymentId+"&resourceName="+row.diagramResourceName+"'>"+row.diagramResourceName+"</a>";
					}
				}				
				,				
			   {field:'deploymentTime',title:'deploymentTime',align:'center',
					formatter:function(value,row,index){
						return row.deploymentTime;
					}
				}				
				,				
			   {field:'isSuspended',title:'是否挂起',align:'center',
					formatter:function(value,row,index){
						var html=row.isSuspended+"|"
						if(row.isSuspended){
							html=html+'<a href="active.do?deploymentId='+row.id+'">激活</a>';
						}else{
							html=html+'<a href="processAction!suspended.do?deploymentId='+row.id+'">挂起</a>';
						}
						return html;
					}
				}				
			 ] ],
			toolbar : [ {
				text : '部署流程',
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

		processAddForm = $('#processAddForm').form({
			url : 'processAction!deploy.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					processAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		processAddDialog = $('#processAddDialog').show().dialog({
			title : '部署流程',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '部署',
				handler : function() {
					//processAddForm.submit();
					$("#loading").ajaxStart(function(){
						$(this).show();
					}).ajaxComplete(function(){
						$(this).hide();
					});
					
					$.ajaxFileUpload
					(
						{
							url:'processAction!deploy.do', 
							secureuri:false,
							fileElementId:'processFile',
							dataType: 'json',
							success: function (data, status)
							{
								if (data.success) {
									$.messager.show({
										title : '成功',
										msg : data.msg
									}); 
									datagrid.datagrid('reload');
									processAddDialog.dialog('close');
							 	} else {
									$.messager.show({
										title : '失败',
										msg : '操作失败！'
									});
								} 
							},
							error: function (data, status, e)
							{
								alert(e);
							}
						}
					)
					
				}
			} ]
		});
		
		
		

		processEditForm = $('#processEditForm').form({
			url : 'processAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					processEditDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		processEditDialog = $('#processEditDialog').show().dialog({
			title : '编辑CD_BUDGET',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '编辑',
				handler : function() {
					processEditForm.submit();
				}
			} ]
		});


		showCdescDialog = $('#showCdescDialog').show().dialog({
			title : 'CD_BUDGET描述',
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
		//从新加载datagrid并将form序列化作为参数替换queryParams传给后台
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.find('input').val('');
	}
	function add() {
		processAddForm.find('input,textarea').val('');
		$('div.validatebox-tip').remove();
		processAddDialog.dialog('open');
	}
	function del() {
		var rows = datagrid.datagrid('getSelections');
		var ids = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if(i!=rows.length-1)
							ids=ids+"deploymentIds="+rows[i].deploymentId+"&";
						else ids=ids+"deploymentIds="+rows[i].deploymentId;
					}
					$.ajax({
						url : 'processAction!delete.do',
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
				url : 'processAction!showDesc.do',
				data : {
					id : rows[0].id
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					processEditForm.find('input,textarea').val('');
					processEditForm.form('load', response);
					$('div.validatebox-tip').remove();
					processEditDialog.dialog('open');
					$.messager.progress('close');
				}
			});
		} else {
			$.messager.alert('提示', '请选择一项要编辑的记录！', 'error');
		}
	}
	function _search(){
		var processDefinitionId=$("#processDefinitionId").val();
		var deploymentId=$("#deploymentId").val();
		var key=$("#key").val();
		datagrid.datagrid('load',{
			"key": key,
			"deploymentId": deploymentId,
			"processDefinitionId":processDefinitionId
		});
	}
</script>
</head>
<body class="easyui-layout">
	<div region="north" border="false"  class="zoc" title="过滤条件" collapsed="false"  style="height: 150px;overflow: hidden;" align="left">
<div style="height: 54px; width: 100%; overflow: hidden; padding-left: 0px; padding-top: 0px;">
			<div style="float: left; margin-left: 0px;">
				<div class="header" style="width: 100%;">
					<div style="overflow: hidden; height: 54px; width: 1300px;">
						<div style="height: 54px; width: 451px; overflow: hidden; float: left; padding-left: 0px; padding-top: 0px;">
							<div class="logo" style="width: 451px;"></div>
						</div>
						<div style="height: 54px; width: 80px; overflow: hidden; float: left; padding-left: 0px; padding-top: 0px;">
							<div tabindex="0" class="v-button main-menu-button v-button-link" role="button" style="height: 54px; width: 80px;">
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
							<div tabindex="0" class="v-button main-menu-button v-button-link link active" role="button" style="height: 54px; width: 90px;">
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
<form id="searchForm">
			<div class="oneline"  style="padding-top: 5px">
				<div class="item33">
					<div class="itemleft80">processDefinitionId ：</div>
					<div class="rightselect_easyui">
						<input type="text"  style="width: 153px;"  id="processDefinitionId" name="processDefinitionId"  />
					</div>
				</div>
				<div class="item33">
					<div class="itemleft80">deploymentId：</div>
					<div class="rightselect_easyui">
						<input name="deploymentId"  id="deploymentId" style="width: 155px;" />
					</div>
				</div>
				<div class="item33 lastitem">
					<div class="itemleft80">key:</div>
					<div class="rightselect_easyui">
						<input name="key"  id="key" style="width: 155px;" />
					</div>
				</div>
			</div>
			<div class="oneline">
				<div class="item100 lastitem">
					<div class="oprationbutt">
						<input type="button" onclick="_search()" value="查询" />
					</div>
				</div>
			</div>
		</form>
	</div>
	
	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>

	<div id="menu" class="easyui-menu" style="width:120px;display: none;">
		<div onclick="add();" iconCls="icon-add">部署流程</div>
		<div onclick="del();" iconCls="icon-remove">删除</div>
		<div onclick="edit();" iconCls="icon-edit">编辑</div>
		
	</div>

	<div id="processAddDialog" style="display: none;width: 400px;height: 200px;" align="center">
		<form id="processAddForm" method="post">
			<table class="tableForm">
						<tr>
							<th colspan="2" >上传流程定义文件</th>
						</tr>
						<tr>
							<th>流程定义文件</th>
							<td>
							<input name="processFile" id="processFile" type="file" class="easyui-validatebox" data-options="" missingMessage="请上传流程文件"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th colspan="2" >支持文件格式：zip、bar、bpmn、bpmn20.xml</th>
						</tr>
			</table>
		</form>
	</div>


	<div id="showCdescDialog" style="display: none;overflow: auto;width: 500px;height: 400px;">
		<div name="cdesc"></div>
	</div>
	
	<div id="iframeDialog" style="display: none;overflow: auto;width: 600px;height: 400px;">
	<iframe name="iframe" id="iframe" src="#"  scrolling="auto" frameborder="0" style="width:100%;height:100%;">
    </iframe>
</div>
</body>
</html>