<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var searchForm;
	var datagrid;
	var detectionOrderAddDialog;
	var detectionOrderAddForm;
	var cdescAdd;
	var detectionOrderEditDialog;
	var detectionOrderEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	$(function() {
		//查询列表	
		searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'detectionOrderAction!datagrid.do',
			title : '首样质检表列表',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			//fitColumns : true,
			nowrap : true,
			border : false,
			idField : 'actDetectionCode',
			
			columns : [ [ {
				field : 'ck',
				checkbox : true,
				formatter : function(value, row, index) {
					return row.actDetectionCode;
				}
			}, {
				field : 'actDetectionCode',
				title : '首样质检唯一标识',
				align : 'center',
				sortable : true,
				hidden : true,
				formatter : function(value, row, index) {
					return row.actDetectionCode;
				}
			}, {
				field : 'orderNum',
				title : '订单号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.orderNum;
				}
			}, {
				field : 'fsResult',
				title : '首样结论',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.fsResult;
				}
			}, {
				field : 'fsName',
				title : '首样操作人',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.fsName;
				}
			}, {
				field : 'fsDate',
				title : '首样操作时间',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.fsDate);
				}
			}, {
				field : 'qualifiedResilt',
				title : '质量合格结论',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.qualifiedResilt;
				}
			}, {
				field : 'qualifiedName',
				title : '质量合格操作人',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.qualifiedName;
				}
			}, {
				field : 'qualifiedDate',
				title : '质量合格操作时间',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.qualifiedDate);
				}
			}, {
				field : 'actualDetection',
				title : '是否有实测信息',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.actualDetection;
				}
			}, {
				field : 'activeFlag',
				title : '有效状态',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.activeFlag;
				}
			}, {
				field : 'createdBy',
				title : '创建人Id',
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
				title : '修改人Id',
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
			}, {
				field : 'modificationNum',
				title : '修改次数',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.modificationNum;
				}
			} ] ],
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

		detectionOrderAddForm = $('#detectionOrderAddForm').form({
			url : 'detectionOrderAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					detectionOrderAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		detectionOrderAddDialog = $('#detectionOrderAddDialog').show().dialog({
			title : '添加首样质检表',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '添加',
				handler : function() {
					detectionOrderAddForm.submit();
				}
			} ]
		});

		detectionOrderEditForm = $('#detectionOrderEditForm').form({
			url : 'detectionOrderAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					detectionOrderEditDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		detectionOrderEditDialog = $('#detectionOrderEditDialog').show().dialog({
			title : '编辑首样质检表',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '编辑',
				handler : function() {
					detectionOrderEditForm.submit();
				}
			} ]
		});

		showCdescDialog = $('#showCdescDialog').show().dialog({
			title : '首样质检表描述',
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
		detectionOrderAddForm.form("clear");
		$('div.validatebox-tip').remove();
		detectionOrderAddDialog.dialog('open');
	}
	function del() {
		var rows = datagrid.datagrid('getSelections');
		var ids = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if (i != rows.length - 1)
							ids = ids + "ids=" + rows[i].actDetectionCode + "&";
						else
							ids = ids + "ids=" + rows[i].actDetectionCode;
					}
					$.ajax({
						url : 'detectionOrderAction!delete.do',
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
				url : 'detectionOrderAction!showDesc.do',
				data : {
					actDetectionCode : rows[0].actDetectionCode
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					detectionOrderEditForm.form("clear");
					detectionOrderEditForm.form('load', response);
					$('div.validatebox-tip').remove();
					detectionOrderEditDialog.dialog('open');
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
			url : 'detectionOrderAction!showDesc.do',
			data : {
				actDetectionCode : row.actDetectionCode
			},
			dataType : 'json',
			cache : false,
			success : function(response) {
				if (response && response.cdesc) {
					showCdescDialog.find('div[name=cdesc]').html(response.cdesc);
					showCdescDialog.dialog('open');
				} else {
					$.messager.alert('提示', '没有首样质检表描述！', 'error');
				}
				$.messager.progress('close');
			}
		});
		datagrid.datagrid('unselectAll');
	}
</script>
</head>
<body class="easyui-layout">
	<div region="north" border="false" title="过滤条件" collapsed="true"
		style="height: 110px; overflow: hidden;" align="left">
		<form id="searchForm">
			<table class="tableForm datagrid-toolbar"
				style="width: 100%; height: 100%;">
				<tr>
					<th>查询字段需要手工修改</th>
					<td><input name="hotelid" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>创建时间</th>
					<td><input name="ccreatedatetimeStart" class="easyui-datebox"
						editable="false" style="width: 155px;" />至<input
						name="ccreatedatetimeEnd" class="easyui-datebox" editable="false"
						style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>最后修改时间</th>
					<td><input name="cmodifydatetimeStart" class="easyui-datebox"
						editable="false" style="width: 155px;" />至<input
						name="cmodifydatetimeEnd" class="easyui-datebox" editable="false"
						style="width: 155px;" /><a href="javascript:void(0);"
						class="easyui-linkbutton" onclick="_search();">过滤</a><a
						href="javascript:void(0);" class="easyui-linkbutton"
						onclick="cleanSearch();">取消</a></td>
				</tr>
			</table>
		</form>
	</div>

	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>

	<div id="menu" class="easyui-menu" style="width: 120px; display: none;">
		<div onclick="add();" iconCls="icon-add">增加</div>
		<div onclick="del();" iconCls="icon-remove">删除</div>
		<div onclick="edit();" iconCls="icon-edit">编辑</div>
	</div>

	<div id="detectionOrderAddDialog"
		style="display: none; width: 500px; height: 300px;" align="center">
		<form id="detectionOrderAddForm" method="post">
			<table class="tableForm">
				<tr>
					<th>首样质检唯一标识</th>
					<td><input name="actDetectionCode" type="text"
						class="easyui-validatebox" data-options="required:true"
						missingMessage="请填写首样质检唯一标识" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>订单号</th>
					<td><input name="orderNum" type="text"
						class="easyui-validatebox" data-options="" missingMessage="请填写订单号"
						style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>首样结论</th>
					<td><input name="fsResult" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写首样结论" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>首样操作人</th>
					<td><input name="fsName" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写首样操作人" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>首样操作时间</th>
					<td><input name="fsDate" type="text" class="easyui-datebox"
						data-options="" missingMessage="请填写首样操作时间" style="width: 155px;" />
					</td>
				</tr>
				<tr>
					<th>质量合格结论</th>
					<td><input name="qualifiedResilt" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写质量合格结论" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>质量合格操作人</th>
					<td><input name="qualifiedName" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写质量合格操作人" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>质量合格操作时间</th>
					<td><input name="qualifiedDate" type="text"
						class="easyui-datebox" data-options=""
						missingMessage="请填写质量合格操作时间" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>是否有实测信息</th>
					<td><input name="actualDetection" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写是否有实测信息" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>1=有效，0=无效</th>
					<td><input name="activeFlag" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写1=有效，0=无效" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>创建人Id</th>
					<td><input name="createdBy" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写创建人Id" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>创建日期</th>
					<td><input name="created" type="text" class="easyui-datebox"
						data-options="" missingMessage="请填写创建日期" style="width: 155px;" />
					</td>
				</tr>
				<tr>
					<th>修改人Id</th>
					<td><input name="lastUpdBy" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写修改人Id" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>修改日期</th>
					<td><input name="lastUpd" type="text" class="easyui-datebox"
						data-options="" missingMessage="请填写修改日期" style="width: 155px;" />
					</td>
				</tr>
				<tr>
					<th>修改次数</th>
					<td><input name="modificationNum" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写修改次数" style="width: 155px;" /></td>
				</tr>



			</table>
		</form>
	</div>

	<div id="detectionOrderEditDialog"
		style="display: none; width: 500px; height: 300px;" align="center">
		<form id="detectionOrderEditForm" method="post">
			<table class="tableForm">
				<tr>
					<th>首样质检唯一标识</th>
					<td><input name="actDetectionCode" type="text"
						class="easyui-validatebox" data-options="required:true"
						missingMessage="请填写首样质检唯一标识" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>订单号</th>
					<td><input name="orderNum" type="text"
						class="easyui-validatebox" data-options="" missingMessage="请填写订单号"
						style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>首样结论</th>
					<td><input name="fsResult" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写首样结论" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>首样操作人</th>
					<td><input name="fsName" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写首样操作人" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>首样操作时间</th>
					<td><input name="fsDate" type="text" class="easyui-datebox"
						data-options="" missingMessage="请填写首样操作时间" style="width: 155px;" />
					</td>
				</tr>
				<tr>
					<th>质量合格结论</th>
					<td><input name="qualifiedResilt" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写质量合格结论" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>质量合格操作人</th>
					<td><input name="qualifiedName" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写质量合格操作人" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>质量合格操作时间</th>
					<td><input name="qualifiedDate" type="text"
						class="easyui-datebox" data-options=""
						missingMessage="请填写质量合格操作时间" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>是否有实测信息</th>
					<td><input name="actualDetection" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写是否有实测信息" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>1=有效，0=无效</th>
					<td><input name="activeFlag" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写1=有效，0=无效" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>创建人Id</th>
					<td><input name="createdBy" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写创建人Id" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>创建日期</th>
					<td><input name="created" type="text" class="easyui-datebox"
						data-options="" missingMessage="请填写创建日期" style="width: 155px;" />
					</td>
				</tr>
				<tr>
					<th>修改人Id</th>
					<td><input name="lastUpdBy" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写修改人Id" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>修改日期</th>
					<td><input name="lastUpd" type="text" class="easyui-datebox"
						data-options="" missingMessage="请填写修改日期" style="width: 155px;" />
					</td>
				</tr>
				<tr>
					<th>修改次数</th>
					<td><input name="modificationNum" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写修改次数" style="width: 155px;" /></td>
				</tr>
			</table>
		</form>
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
</body>
</html>