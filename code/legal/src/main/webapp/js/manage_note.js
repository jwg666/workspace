var datagrid;
var searchForm;
var noteAddDialog;
var noteAddForm;
var noteEditDialog;
var noteEditForm;
$(function() {
		datagrid = $('#datagrid').datagrid({
			url : 'note!datagrid',
			title : '公告',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			fitColumns : true,
			nowrap : false,
			border : false,
			idField : 'id',
			
			columns : [ [ 
			   {field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.id;
						}
					},
			   {field:'content',title:'公告内容',align:'center',sortable:true,width : 100,
					formatter:function(value,row,index){
						return row.content;
					}
				},				
			   {field:'createTime',title:'创建时间',align:'center',sortable:true,width : 100,
					formatter:function(value,row,index){
						return timeStamp2String(row.createTime);
					}
				}
				]],
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
		noteAddDialog = $('#noteAddDialog').show().dialog({
			title : '添加公告',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '添加',
				handler : function() {
					noteAddForm.submit();
				}
			} ]
		});
		
		noteEditForm = $('#noteEditForm').form({
			url : 'note!edit.do',
			success : function(data) {
//				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					noteEditDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		noteEditDialog = $('#noteEditDialog').show().dialog({
			title : '编辑公告',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '编辑',
				handler : function() {
					noteEditForm.submit();
				}
			} ]
		});
});
function add() {
	$("#noteAddForm").form("clear");
	$('div.validatebox-tip').remove();
	$("#noteAddDialog").dialog('open');
}
function del() {
	var rows = datagrid.datagrid('getSelections');
	var ids = "";
	if (rows.length > 0) {
		$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
			if (r) {
				for ( var i = 0; i < rows.length; i++) {
					if(i!=rows.length-1)
						ids=ids+"ids="+rows[i].id+"&";
					else ids=ids+"ids="+rows[i].id;
				}
				$.ajax({
					url : 'note!delete',
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
			url : 'note!edit',
			data : {
				id : rows[0].id
			},
			dataType : 'json',
			cache : false,
			success : function(response) {
				noteEditForm.form("clear");
				noteEditForm.form('load', response);
				$('div.validatebox-tip').remove();
				$("#noteEditDialog").dialog('open');
				$.messager.progress('close');
			}
		});
	} else {
		$.messager.alert('提示', '请选择一项要编辑的记录！', 'error');
	}
}
function timeStamp2String(time) {
	var datetime = new Date();
	datetime.setTime(time);
	var year = datetime.getFullYear();
	var month = datetime.getMonth() + 1 < 10 ? "0" + (datetime.getMonth() + 1)
			: datetime.getMonth() + 1;
	var date = datetime.getDate() < 10 ? "0" + datetime.getDate() : datetime
			.getDate();
	var hour = datetime.getHours() < 10 ? "0" + datetime.getHours() : datetime
			.getHours();
	var minute = datetime.getMinutes() < 10 ? "0" + datetime.getMinutes()
			: datetime.getMinutes();
	var second = datetime.getSeconds() < 10 ? "0" + datetime.getSeconds()
			: datetime.getSeconds();
	return year + "-" + month + "-" + date + " " + hour + ":" + minute + ":"
			+ second;
}