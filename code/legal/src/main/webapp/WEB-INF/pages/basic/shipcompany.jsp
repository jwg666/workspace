<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var shipcompanyAddDialog;
	var shipcompanyAddForm;
	var cdescAdd;
	var shipcompanyEditDialog;
	var shipcompanyEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'shipcompanyAction!datagrid.do',
			title : 'CD_SHIPCOMPANY列表',
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
			   {field:'rowId',title:'ROW_ID',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.rowId;
					}
				},				
			   {field:'companyCode',title:'编码',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.companyCode;
					}
				},				
			   {field:'companyName',title:'船公司名称',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.companyName;
					}
				},				
			   {field:'englishName',title:'英文名称',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.englishName;
					}
				},				
			   {field:'activeFlag',title:'有效标志',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.activeFlag;
					}
				},				
			   {field:'bank',title:'开户银行',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.bank;
					}
				},				
			   {field:'account',title:'开户银行账户',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.account;
					}
				},				
			   {field:'createdBy',title:'创建人Id',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.createdBy;
					}
				},				
			   {field:'created',title:'创建日期',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.created);
					}
				},				
			   {field:'lastUpd',title:'修改日期',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.lastUpd);
					}
				},				
			   {field:'lastUpdBy',title:'修改人Id',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.lastUpdBy;
					}
				},				
			   {field:'modificationNum',title:'修改次数',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.modificationNum;
					}
				},				
			   {field:'ifDamager',title:'ifDamager',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.ifDamager;
					}
				},				
			   {field:'companyType',title:'公司类型(0,海1,空2,其它)',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.companyType;
					}
				},				
			   {field:'sapCode',title:'SAP对应编号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.sapCode;
					}
				},				
			   {field:'nvocscac',title:'ISF 接口文件字段   发AMS时所用的SCAC 根据HORIS系统订舱单显示船公司而定 1.阳明海运    均显示为YMLU 2.MAERSK    均显示为MAEU 3.COSCO      均显示为COSU',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.nvocscac;
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

		shipcompanyAddForm = $('#shipcompanyAddForm').form({
			url : 'shipcompanyAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					shipcompanyAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		shipcompanyAddDialog = $('#shipcompanyAddDialog').show().dialog({
			title : '添加CD_SHIPCOMPANY',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '添加',
				handler : function() {
					shipcompanyAddForm.submit();
				}
			} ]
		});
		
		
		

		shipcompanyEditForm = $('#shipcompanyEditForm').form({
			url : 'shipcompanyAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					shipcompanyEditDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		shipcompanyEditDialog = $('#shipcompanyEditDialog').show().dialog({
			title : '编辑CD_SHIPCOMPANY',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '编辑',
				handler : function() {
					shipcompanyEditForm.submit();
				}
			} ]
		});


		showCdescDialog = $('#showCdescDialog').show().dialog({
			title : 'CD_SHIPCOMPANY描述',
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
		shipcompanyAddForm.find('input,textarea').val('');
		$('div.validatebox-tip').remove();
		shipcompanyAddDialog.dialog('open');
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
						url : 'shipcompanyAction!delete.do',
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
				url : 'shipcompanyAction!showDesc.do',
				data : {
					rowId : rows[0].rowId
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					shipcompanyEditForm.find('input,textarea').val('');
					shipcompanyEditForm.form('load', response);
					$('div.validatebox-tip').remove();
					shipcompanyEditDialog.dialog('open');
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
			url : 'shipcompanyAction!showDesc.do',
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
					$.messager.alert('提示', '没有CD_SHIPCOMPANY描述！', 'error');
				}
				$.messager.progress('close');
			}
		});
		datagrid.datagrid('unselectAll');
	}
</script>
</head>
<body class="easyui-layout">
	<div region="north" border="false" title="过滤条件" collapsed="true"  style="height: 130px;overflow: hidden;" align="left">
		<form id="searchForm">
			<table class="tableForm datagrid-toolbar" style="width: 100%;height: 100%;">
				<tr>
					<th>编码</th>
					<td><input name="companyCode" style="width:155px;" /></td>
				</tr>
				<tr>
					<th>船公司名称</th>
					<td><input name="companyName" style="width:155px;" /></td>
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

	<div id="shipcompanyAddDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="shipcompanyAddForm" method="post">
			<table class="tableForm">
						<tr>
							<th>ROW_ID</th>
							<td>
								<input name="rowId" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写ROW_ID"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>编码</th>
							<td>
								<input name="companyCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写编码"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>船公司名称</th>
							<td>
								<input name="companyName" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写船公司名称"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>英文名称</th>
							<td>
								<input name="englishName" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写英文名称"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>有效标志</th>
							<td>
								<input name="activeFlag" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写有效标志"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>开户银行</th>
							<td>
								<input name="bank" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写开户银行"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>开户银行账户</th>
							<td>
								<input name="account" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写开户银行账户"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>创建人Id</th>
							<td>
								<input name="createdBy" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写创建人Id"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>创建日期</th>
							<td>
								<input name="created" type="text" class="easyui-datebox" data-options="" missingMessage="请填写创建日期"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>修改日期</th>
							<td>
								<input name="lastUpd" type="text" class="easyui-datebox" data-options="" missingMessage="请填写修改日期"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>修改人Id</th>
							<td>
								<input name="lastUpdBy" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写修改人Id"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>修改次数</th>
							<td>
								<input name="modificationNum" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写修改次数"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>ifDamager</th>
							<td>
								<input name="ifDamager" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写ifDamager"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>公司类型(0,海1,空2,其它)</th>
							<td>
								<input name="companyType" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写公司类型(0,海1,空2,其它)"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>SAP对应编号</th>
							<td>
								<input name="sapCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写SAP对应编号"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>ISF 接口文件字段   发AMS时所用的SCAC 根据HORIS系统订舱单显示船公司而定 1.阳明海运    均显示为YMLU 2.MAERSK    均显示为MAEU 3.COSCO      均显示为COSU</th>
							<td>
								<input name="nvocscac" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写ISF 接口文件字段   发AMS时所用的SCAC 根据HORIS系统订舱单显示船公司而定 1.阳明海运    均显示为YMLU 2.MAERSK    均显示为MAEU 3.COSCO      均显示为COSU"  style="width: 155px;"/>						
							</td>
						</tr>
					
					
					
			</table>
		</form>
	</div>

	<div id="shipcompanyEditDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="shipcompanyEditForm" method="post">
			<table class="tableForm">
						<tr>
						<th>ROW_ID</th>
							<td>
								<input name="rowId" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写ROW_ID"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>编码</th>
							<td>
								<input name="companyCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写编码"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>船公司名称</th>
							<td>
								<input name="companyName" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写船公司名称"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>英文名称</th>
							<td>
								<input name="englishName" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写英文名称"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>有效标志</th>
							<td>
								<input name="activeFlag" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写有效标志"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>开户银行</th>
							<td>
								<input name="bank" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写开户银行"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>开户银行账户</th>
							<td>
								<input name="account" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写开户银行账户"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>创建人Id</th>
							<td>
								<input name="createdBy" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写创建人Id"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>创建日期</th>
							<td>
								<input name="created" type="text" class="easyui-datebox" data-options="" missingMessage="请填写创建日期"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>修改日期</th>
							<td>
								<input name="lastUpd" type="text" class="easyui-datebox" data-options="" missingMessage="请填写修改日期"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>修改人Id</th>
							<td>
								<input name="lastUpdBy" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写修改人Id"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>修改次数</th>
							<td>
								<input name="modificationNum" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写修改次数"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>ifDamager</th>
							<td>
								<input name="ifDamager" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写ifDamager"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>公司类型(0,海1,空2,其它)</th>
							<td>
								<input name="companyType" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写公司类型(0,海1,空2,其它)"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>SAP对应编号</th>
							<td>
								<input name="sapCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写SAP对应编号"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>ISF 接口文件字段   发AMS时所用的SCAC 根据HORIS系统订舱单显示船公司而定 1.阳明海运    均显示为YMLU 2.MAERSK    均显示为MAEU 3.COSCO      均显示为COSU</th>
							<td>
								<input name="nvocscac" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写ISF 接口文件字段   发AMS时所用的SCAC 根据HORIS系统订舱单显示船公司而定 1.阳明海运    均显示为YMLU 2.MAERSK    均显示为MAEU 3.COSCO      均显示为COSU"  style="width: 155px;"/>
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