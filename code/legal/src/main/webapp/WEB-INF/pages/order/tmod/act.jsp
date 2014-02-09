<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var actAddDialog;
	var actAddForm;
	var cdescAdd;
	var actEditDialog;
	var actEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'actAction!datagrid.do',
			title : 'T模式',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			fitColumns : true,
			nowrap : true,
			border : false,
			idField : 'rowId',
			
			columns : [ [ 
			{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.rowId;
						}
					},
			   {field:'rowId',title:'唯一标识',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.rowId;
					}
				},				
			   {field:'orderNum',title:'订单号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.orderNum;
					}
				},				
			   {field:'actId',title:'活动ID',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.actId;
					}
				},				
			   {field:'planFinishDate',title:'计划完成时间',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.planFinishDate);
					}
				},				
			   {field:'actualFinishDate',title:'实际完成时间',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.actualFinishDate);
					}
				},				
			   {field:'actUserId',title:'责任人',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.actUserId;
					}
				},				
			   {field:'statusCode',title:'完成状态。start 开始  end  完成',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.statusCode;
					}
				},				
			   {field:'comments',title:'备注。如果有强制结束的，在这里体现强制',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.comments;
					}
				},				
			   {field:'activeFlag',title:'有效标识',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.activeFlag;
					}
				},				
			   {field:'createdBy',title:'创建人',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.createdBy;
					}
				},				
			   {field:'created',title:'创建时间',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.created);
					}
				},				
			   {field:'lastUpdBy',title:'最后更新人',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.lastUpdBy;
					}
				},				
			   {field:'lastUpd',title:'最后更新时间',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.lastUpd);
					}
				},				
			   {field:'modificationNum',title:'修改次数',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.modificationNum;
					}
				}				
			 ] ],
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

		actAddForm = $('#actAddForm').form({
			url : 'actAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					actAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		actAddDialog = $('#actAddDialog').show().dialog({
			title : '添加SO_ACT',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '添加',
				handler : function() {
					actAddForm.submit();
				}
			} ]
		});
		
		
		

		actEditForm = $('#actEditForm').form({
			url : 'actAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					actEditDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		actEditDialog = $('#actEditDialog').show().dialog({
			title : '编辑SO_ACT',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '编辑',
				handler : function() {
					actEditForm.submit();
				}
			} ]
		});


		showCdescDialog = $('#showCdescDialog').show().dialog({
			title : 'SO_ACT描述',
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
		searchForm.find('input').val('');
	}
	function add() {
		actAddForm.form("clear");
		$('div.validatebox-tip').remove();
		actAddDialog.dialog('open');
	}
	function del() {
		var rows = datagrid.datagrid('getSelections');
		var ids = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if(i!=rows.length-1)
							ids=ids+"ids="+rows[i].rowId+"&";
						else ids=ids+"ids="+rows[i].rowId;
					}
					$.ajax({
						url : 'actAction!delete.do',
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
				url : 'actAction!showDesc.do',
				data : {
					rowId : rows[0].rowId
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					actEditForm.form("clear");
					actEditForm.form('load', response);
					$('div.validatebox-tip').remove();
					actEditDialog.dialog('open');
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
			url : 'actAction!showDesc.do',
			data : {
				rowId : row.rowId
			},
			dataType : 'json',
			cache : false,
			success : function(response) {
				if (response && response.cdesc) {
					showCdescDialog.find('div[name=cdesc]').html(response.cdesc);
					showCdescDialog.dialog('open');
				} else {
					$.messager.alert('提示', '没有SO_ACT描述！', 'error');
				}
				$.messager.progress('close');
			}
		});
		datagrid.datagrid('unselectAll');
	}
</script>
</head>
<body class="easyui-layout">
	<div region="north" border="false" title="过滤条件" collapsed="true"  style="height: 110px;overflow: hidden;" align="left">
		<form id="searchForm">
			<table class="tableForm datagrid-toolbar" style="width: 100%;height: 100%;">
				<tr>
					<th>查询字段需要手工修改</th>
					<td><input name="hotelid" style="width:155px;" /></td>
				</tr>
				<tr>
					<th>创建时间</th>
					<td><input name="ccreatedatetimeStart" class="easyui-datebox" editable="false" style="width: 155px;" />至<input name="ccreatedatetimeEnd" class="easyui-datebox" editable="false" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>最后修改时间</th>
					<td><input name="cmodifydatetimeStart" class="easyui-datebox" editable="false" style="width: 155px;" />至<input name="cmodifydatetimeEnd" class="easyui-datebox" editable="false" style="width: 155px;" /><a href="javascript:void(0);" class="easyui-linkbutton" onclick="_search();">过滤</a><a href="javascript:void(0);" class="easyui-linkbutton" onclick="cleanSearch();">取消</a></td>
				</tr>
			</table>
		</form>
	</div>
	
	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>

	<div id="menu" class="easyui-menu" style="width:120px;display: none;">
		<div onclick="add();" iconCls="icon-add">增加</div>
		<div onclick="del();" iconCls="icon-remove">删除</div>
		<div onclick="edit();" iconCls="icon-edit">编辑</div>
	</div>

	<div id="actAddDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="actAddForm" method="post">
			<table class="tableForm">
						<tr>
							<th>唯一标识</th>
							<td>
								<input name="rowId" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写唯一标识"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>订单号</th>
							<td>
								<input name="orderNum" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写订单号"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>活动ID</th>
							<td>
								<input name="actId" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写活动ID"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>计划完成时间</th>
							<td>
								<input name="planFinishDate" type="text" class="easyui-datebox" data-options="" missingMessage="请填写计划完成时间"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>实际完成时间</th>
							<td>
								<input name="actualFinishDate" type="text" class="easyui-datebox" data-options="" missingMessage="请填写实际完成时间"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>责任人</th>
							<td>
								<input name="actUserId" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写责任人"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>完成状态。start 开始  end  完成</th>
							<td>
								<input name="statusCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写完成状态。start 开始  end  完成"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>备注。如果有强制结束的，在这里体现强制</th>
							<td>
								<input name="comments" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写备注。如果有强制结束的，在这里体现强制"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>有效标识</th>
							<td>
								<input name="activeFlag" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写有效标识"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>创建人</th>
							<td>
								<input name="createdBy" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写创建人"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>创建时间</th>
							<td>
								<input name="created" type="text" class="easyui-datebox" data-options="" missingMessage="请填写创建时间"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>最后更新人</th>
							<td>
								<input name="lastUpdBy" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写最后更新人"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>最后更新时间</th>
							<td>
								<input name="lastUpd" type="text" class="easyui-datebox" data-options="" missingMessage="请填写最后更新时间"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>修改次数</th>
							<td>
								<input name="modificationNum" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写修改次数"  style="width: 155px;"/>						
							</td>
						</tr>
					
					
					
			</table>
		</form>
	</div>

	<div id="actEditDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="actEditForm" method="post">
			<table class="tableForm">
						<tr>
						<th>唯一标识</th>
							<td>
								<input name="rowId" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写唯一标识"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>订单号</th>
							<td>
								<input name="orderNum" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写订单号"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>活动ID</th>
							<td>
								<input name="actId" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写活动ID"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>计划完成时间</th>
							<td>
								<input name="planFinishDate" type="text" class="easyui-datebox" data-options="" missingMessage="请填写计划完成时间"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>实际完成时间</th>
							<td>
								<input name="actualFinishDate" type="text" class="easyui-datebox" data-options="" missingMessage="请填写实际完成时间"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>责任人</th>
							<td>
								<input name="actUserId" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写责任人"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>完成状态。start 开始  end  完成</th>
							<td>
								<input name="statusCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写完成状态。start 开始  end  完成"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>备注。如果有强制结束的，在这里体现强制</th>
							<td>
								<input name="comments" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写备注。如果有强制结束的，在这里体现强制"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>有效标识</th>
							<td>
								<input name="activeFlag" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写有效标识"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>创建人</th>
							<td>
								<input name="createdBy" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写创建人"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>创建时间</th>
							<td>
								<input name="created" type="text" class="easyui-datebox" data-options="" missingMessage="请填写创建时间"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>最后更新人</th>
							<td>
								<input name="lastUpdBy" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写最后更新人"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>最后更新时间</th>
							<td>
								<input name="lastUpd" type="text" class="easyui-datebox" data-options="" missingMessage="请填写最后更新时间"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>修改次数</th>
							<td>
								<input name="modificationNum" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写修改次数"  style="width: 155px;"/>
							</td>
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