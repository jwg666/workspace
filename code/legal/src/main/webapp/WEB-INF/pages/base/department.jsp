<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var departmentAddDialog;
	var departmentAddForm;
	var cdescAdd;
	var departmentEditDialog;
	var departmentEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'departmentAction!datagrid.do',
			title : '部门列表',
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
			sortName : 'createTime',
			sortOrder : 'desc',
			columns : [ [ 
			{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.id;
						}
					},
			   {field:'id',title:'id',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.id;
					}
				},	
				 {field:'parentId',title:'上级部门',align:'center',sortable:true,
					formatter:function(value,row,index){
						if(row.parent!=null){
							return row.parent.name;
						}else{
							return "无";
						}
						
					}
				},
			   {field:'name',title:'部门名称',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.name;
					}
				},				
			  				
			   {field:'createTime',title:'创建时间',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.createTime);
					}
				},				
			   {field:'createBy',title:'创建人',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.createBy;
					}
				},				
			   {field:'description',title:'描述',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.description;
					}
				},				
			   {field:'officePlace',title:'办公地址',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.officePlace;
					}
				},				
			   {field:'officePhone',title:'办公电话',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.officePhone;
					}
				},				
			   {field:'officer',title:'办公室负责人',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.officer;
					}
				},				
			   {field:'officePage',title:'主页地址',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.officePage;
					}
				},				
			   {field:'fax',title:'传真',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.fax;
					}
				},				
			   {field:'email',title:'email',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.email;
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

		departmentAddForm = $('#departmentAddForm').form({
			url : 'departmentAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					departmentAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		departmentAddDialog = $('#departmentAddDialog').show().dialog({
			title : '添加部门',
			modal : true,
			closed : true,
			maximizable : true,
			resizable:true,
			width:500,
			height:300,
			buttons : [ {
				text : '添加',
				handler : function() {
					departmentAddForm.submit();
				}
			} ]
		});
		
		
		

		departmentEditForm = $('#departmentEditForm').form({
			url : 'departmentAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					departmentEditDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		departmentEditDialog = $('#departmentEditDialog').show().dialog({
			title : '编辑部门信息',
			modal : true,
			closed : true,
			maximizable : true,
			maximizable : true,
			resizable:true,
			width:500,
			height:300,
			buttons : [ {
				text : '编辑',
				handler : function() {
					departmentEditForm.submit();
				}
			} ]
		});


		showCdescDialog = $('#showCdescDialog').show().dialog({
			title : '部门描述',
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
		$("#parentId").combobox({
			url:'departmentAction!combox.do',
			valueField:'id',
			textField:'name'				
		});
		$("#parentId2").combobox({
			url:'departmentAction!combox.do',
			valueField:'id',
			textField:'name'				
		});
		$("#parentId3").combobox({
			url:'departmentAction!combox.do',
			valueField:'id',
			textField:'name'				
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
		departmentAddForm.form("clear");
		$('div.validatebox-tip').remove();
		departmentAddDialog.dialog('open');
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
						url : 'departmentAction!delete.do',
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
				url : 'departmentAction!showDesc.do',
				data : {
					id : rows[0].id
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					departmentEditForm.form("clear");
					departmentEditForm.form('load', response);
					$('div.validatebox-tip').remove();
					departmentEditDialog.dialog('open');
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
			url : 'departmentAction!showDesc.do',
			data : {
				id : row.id
			},
			dataType : 'json',
			cache : false,
			success : function(response) {
				if (response && response.cdesc) {
					showCdescDialog.find('div[name=cdesc]').html(response.cdesc);
					showCdescDialog.dialog('open');
				} else {
					$.messager.alert('提示', '没有Department描述！', 'error');
				}
				$.messager.progress('close');
			}
		});
		datagrid.datagrid('unselectAll');
	}
</script>
</head>
<body class="easyui-layout" zoc>
	<div region="north" border="false" class="zoc" collapsed="false"
		style="height: 100px; overflow: auto;" align="left">
		<form id="searchForm">
			<div class="navhead_zoc">
				<span>部门信息维护</span>
			</div>
			<div class="part_zoc">
				<div class="partnavi_zoc">
					<span>查询与操作：</span>
				</div>
				<div class="oneline">					
					<div class="item25">
						<div class="itemleft100">部门名称：</div>
						<div class="righttext">
						<input type="text" name="name" style="width:100px"/>
						</div>
					</div>
					<div class="item25">
						<div class="itemleft100">上级部门：</div>
						<div class="rightselect_easyui">
							<input type="text" name="parent.parentId"  id="parentId" style="width:120px"/>
						</div>
					</div>
					<div class="item25">
						<div class="itemleft100">地址：</div>
						<div class="righttext">
						<input type="text" name="officePlace" style="width:120px"/>
						</div>
					</div>
					<div class="item25 lastitem" >
						<div class="oprationbutt">
							<input type="button" value="查  询" onclick="_search();" />
							<input type="button" value="重  置" onclick="cleanSearch();" />
						</div>
					</div>
				</div>
			</div>
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

	<div id="departmentAddDialog" style="display: none;" align="center">
		<form id="departmentAddForm" method="post">
			<div class="part_zoc" style="min-width:500px">
				<div class="partnavi_zoc">
					<span>填写部门信息：</span>
				</div>
				<div class="oneline">					
					<div class="item25">
						<div class="itemleft100">部门名称：</div>
						<div class="righttext">
						<input type="text" name="name" style="width:100px"/>
						</div>
					</div>
					<div class="item25 lastitem" >
						<div class="itemleft100">上级部门：</div>
						<div class="rightselect_easyui">
							<input type="text" name="parent.parentId"  id="parentId2" style="width:100px"/>
						</div>
					</div>
					</div>
				<div class="oneline">
					<div class="item25">
						<div class="itemleft100">描述：</div>
						<div class="righttext">
						<input type="text" name="description" style="width:100px"/>
						</div>
					</div>
					<div class="item25 lastitem" >
						<div class="itemleft100">办公地址：</div>
						<div class="righttext">
						<input type="text" name="officePlace" style="width:100px"/>
						</div>
					</div>
				</div>
				<div class="oneline">					
					<div class="item25">
						<div class="itemleft100">办公电话：</div>
						<div class="righttext">
						<input type="text" name="officePhone" style="width:100px"/>
						</div>
					</div>
					<div class="item25 lastitem">
						<div class="itemleft100">负责人：</div>
						<div class="righttext">
							<input type="text" name="officer"   style="width:100px"/>
						</div>
					</div>
					</div>
				<div class="oneline">
					<div class="item25">
						<div class="itemleft100">主页：</div>
						<div class="righttext">
						<input type="text" name="officePage" style="width:100px"/>
						</div>
					</div>
					<div class="item25 lastitem" >
						<div class="itemleft100">传真：</div>
						<div class="righttext">
						<input type="text" name="officePlace" style="width:100px"/>
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item25 lastitem">
						<div class="itemleft100">E-mail：</div>
						<div class="righttext">
							<input type="text" name="email"   style="width:100px"/>
						</div>
					</div>
				</div>
			</div>			
						
		</form>
	</div>

	<div id="departmentEditDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="departmentEditForm" method="post">
		<input name="id" type="hidden" />
			<div class="part_zoc" style="min-width:500px">
				<div class="partnavi_zoc">
					<span>填写部门信息：</span>
				</div>
				<div class="oneline">					
					<div class="item25">
						<div class="itemleft100">部门名称：</div>
						<div class="righttext">
						<input type="text" name="name" style="width:100px"/>
						</div>
					</div>
					<div class="item25 lastitem" >
						<div class="itemleft100">上级部门：</div>
						<div class="rightselect_easyui">
							<input type="text" name="parent.parentId"  id="parentId3" style="width:100px"/>
						</div>
					</div>
					</div>
				<div class="oneline">
					<div class="item25">
						<div class="itemleft100">描述：</div>
						<div class="righttext">
						<input type="text" name="description" style="width:100px"/>
						</div>
					</div>
					<div class="item25 lastitem" >
						<div class="itemleft100">办公地址：</div>
						<div class="righttext">
						<input type="text" name="officePlace" style="width:100px"/>
						</div>
					</div>
				</div>
				<div class="oneline">					
					<div class="item25">
						<div class="itemleft100">办公电话：</div>
						<div class="righttext">
						<input type="text" name="officePhone" style="width:100px"/>
						</div>
					</div>
					<div class="item25 lastitem">
						<div class="itemleft100">负责人：</div>
						<div class="righttext">
							<input type="text" name="officer"   style="width:100px"/>
						</div>
					</div>
					</div>
				<div class="oneline">
					<div class="item25">
						<div class="itemleft100">主页：</div>
						<div class="righttext">
						<input type="text" name="officePage" style="width:100px"/>
						</div>
					</div>
					<div class="item25 lastitem" >
						<div class="itemleft100">传真：</div>
						<div class="righttext">
						<input type="text" name="officePlace" style="width:100px"/>
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item25 lastitem">
						<div class="itemleft100">E-mail：</div>
						<div class="righttext">
							<input type="text" name="email"   style="width:100px"/>
						</div>
					</div>
				</div>
			</div>
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