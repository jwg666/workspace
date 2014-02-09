<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var orgAddDialog;
	var orgAddForm;
	var cdescAdd;
	var orgEditDialog;
	var orgEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'orgAction!datagrid.action',
			title : '组织信息列表',
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
			   {field:'rowId',title:'ROW_ID',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.rowId;
					}
				},				
			   {field:'parRowId',title:'上级组织ID',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.parRowId;
					}
				},				
			   {field:'orgCode',title:'组织编码',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.orgCode;
					}
				},				
			   {field:'orgName',title:'组织名称',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.orgName;
					}
				},				
			   {field:'levels',title:'组织层次',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.levels;
					}
				},				
			   {field:'orgTypeId',title:'工厂、经营体、权限部门',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.orgTypeId;
					}
				},				
			   {field:'orgDesc',title:'组织简述',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.orgDesc;
					}
				},				
			   {field:'created',title:'创建时间',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.created);
					}
				},				
			   {field:'createdBy',title:'创建用户ID',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.createdBy;
					}
				},				
			   {field:'lastUpdBy',title:'最后修改用户ID',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.lastUpdBy;
					}
				},				
			   {field:'lastUpd',title:'最后修改时间',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.lastUpd);
					}
				},				
			   {field:'modificationNum',title:'修改次数',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.modificationNum;
					}
				},				
			   {field:'deleteFlag',title:'删除标志',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.deleteFlag;
					}
				},				
			   {field:'attrib1',title:'保留属性1',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.attrib1;
					}
				},				
			   {field:'attrib2',title:'保留属性2',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.attrib2;
					}
				},				
			   {field:'attrib3',title:'保留属性3',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.attrib3;
					}
				},				
			   {field:'attrib4',title:'保留属性4',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.attrib4;
					}
				},				
			   {field:'attrib5',title:'保留属性5',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.attrib5;
					}
				},				
			   {field:'attrib6',title:'保留属性6',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.attrib6;
					}
				},				
			   {field:'attrib7',title:'保留属性7',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.attrib7;
					}
				},				
			   {field:'ifDamager',title:'ifDamager',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.ifDamager;
					}
				}				
			 ] ],
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

	});

	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.find('input').val('');
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

	<div id="orgAddDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="orgAddForm" method="post">
			<table class="tableForm">
						<tr>
							<th>ROW_ID</th>
							<td>
								<input name="rowId" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写ROW_ID"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>上级组织ID</th>
							<td>
								<input name="parRowId" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写上级组织ID"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>组织编码</th>
							<td>
								<input name="orgCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写组织编码"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>组织名称</th>
							<td>
								<input name="orgName" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写组织名称"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>组织层次</th>
							<td>
								<input name="levels" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写组织层次"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>工厂、经营体、权限部门</th>
							<td>
								<input name="orgTypeId" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写工厂、经营体、权限部门"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>组织简述</th>
							<td>
								<input name="orgDesc" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写组织简述"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>创建时间</th>
							<td>
								<input name="created" type="text" class="easyui-datebox" data-options="" missingMessage="请填写创建时间"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>创建用户ID</th>
							<td>
								<input name="createdBy" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写创建用户ID"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>最后修改用户ID</th>
							<td>
								<input name="lastUpdBy" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写最后修改用户ID"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>最后修改时间</th>
							<td>
								<input name="lastUpd" type="text" class="easyui-datebox" data-options="" missingMessage="请填写最后修改时间"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>修改次数</th>
							<td>
								<input name="modificationNum" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写修改次数"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>删除标志</th>
							<td>
								<input name="deleteFlag" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写删除标志"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>保留属性1</th>
							<td>
								<input name="attrib1" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写保留属性1"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>保留属性2</th>
							<td>
								<input name="attrib2" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写保留属性2"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>保留属性3</th>
							<td>
								<input name="attrib3" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写保留属性3"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>保留属性4</th>
							<td>
								<input name="attrib4" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写保留属性4"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>保留属性5</th>
							<td>
								<input name="attrib5" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写保留属性5"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>保留属性6</th>
							<td>
								<input name="attrib6" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写保留属性6"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>保留属性7</th>
							<td>
								<input name="attrib7" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写保留属性7"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>ifDamager</th>
							<td>
								<input name="ifDamager" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写ifDamager"  style="width: 155px;"/>						
							</td>
						</tr>
					
					
					
			</table>
		</form>
	</div>

	<div id="orgEditDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="orgEditForm" method="post">
			<table class="tableForm">
						<tr>
						<th>ROW_ID</th>
							<td>
								<input name="rowId" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写ROW_ID"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>上级组织ID</th>
							<td>
								<input name="parRowId" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写上级组织ID"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>组织编码</th>
							<td>
								<input name="orgCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写组织编码"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>组织名称</th>
							<td>
								<input name="orgName" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写组织名称"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>组织层次</th>
							<td>
								<input name="levels" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写组织层次"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>工厂、经营体、权限部门</th>
							<td>
								<input name="orgTypeId" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写工厂、经营体、权限部门"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>组织简述</th>
							<td>
								<input name="orgDesc" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写组织简述"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>创建时间</th>
							<td>
								<input name="created" type="text" class="easyui-datebox" data-options="" missingMessage="请填写创建时间"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>创建用户ID</th>
							<td>
								<input name="createdBy" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写创建用户ID"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>最后修改用户ID</th>
							<td>
								<input name="lastUpdBy" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写最后修改用户ID"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>最后修改时间</th>
							<td>
								<input name="lastUpd" type="text" class="easyui-datebox" data-options="" missingMessage="请填写最后修改时间"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>修改次数</th>
							<td>
								<input name="modificationNum" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写修改次数"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>删除标志</th>
							<td>
								<input name="deleteFlag" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写删除标志"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>保留属性1</th>
							<td>
								<input name="attrib1" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写保留属性1"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>保留属性2</th>
							<td>
								<input name="attrib2" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写保留属性2"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>保留属性3</th>
							<td>
								<input name="attrib3" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写保留属性3"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>保留属性4</th>
							<td>
								<input name="attrib4" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写保留属性4"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>保留属性5</th>
							<td>
								<input name="attrib5" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写保留属性5"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>保留属性6</th>
							<td>
								<input name="attrib6" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写保留属性6"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>保留属性7</th>
							<td>
								<input name="attrib7" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写保留属性7"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>ifDamager</th>
							<td>
								<input name="ifDamager" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写ifDamager"  style="width: 155px;"/>
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