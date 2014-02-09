<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var employeeAddDialog;
	var employeeAddForm;
	var cdescAdd;
	var employeeEditDialog;
	var employeeEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'employeeAction!datagrid.action',
			title : '员工基本信息列表',
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
			idField : 'empCode',
			
			columns : [ [ 
			   {field:'empCode',title:'部门编码',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.empCode;
					}
				},				
			   {field:'departmentId',title:'部门Id',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.departmentId;
					}
				},				
			   {field:'name',title:'名称',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.name;
					}
				},				
			   {field:'englishName',title:'englishName',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.englishName;
					}
				},				
			   {field:'sex',title:'员工性别',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.sex;
					}
				},				
			   {field:'birthday',title:'员工生日',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.birthday);
					}
				},				
			   {field:'tel',title:'员工固话号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.tel;
					}
				},				
			   {field:'fax',title:'员工传真号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.fax;
					}
				},				
			   {field:'email',title:'员工Email',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.email;
					}
				},				
			   {field:'address',title:'员工地址',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.address;
					}
				},				
			   {field:'comments',title:'员工备注',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.comments;
					}
				},				
			   {field:'activeFlag',title:'有效标志',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.activeFlag;
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
			   {field:'lastUpdBy',title:'修改人Id',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.lastUpdBy;
					}
				},				
			   {field:'lastUpd',title:'修改日期',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.lastUpd);
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
			   {field:'empCode',title:'员工编码',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.empCode;
					}
				},				
			   {field:'nameAb',title:'英文名',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.nameAb;
					}
				},				
			   {field:'temp1Num',title:'temp1Num',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.temp1Num;
					}
				},				
			   {field:'temp2Num',title:'temp2Num',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.temp2Num;
					}
				},				
			   {field:'temp1Char',title:'temp1Char',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.temp1Char;
					}
				},				
			   {field:'temp4Char',title:'temp4Char',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.temp4Char;
					}
				},				
			   {field:'temp3Char',title:'temp3Char',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.temp3Char;
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


		employeeAddDialog = $('#employeeAddDialog').show().dialog({
			title : '添加员工基本信息',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '添加',
				handler : function() {
					employeeAddForm.submit();
				}
			} ]
		});
		
		
		


		employeeEditDialog = $('#employeeEditDialog').show().dialog({
			title : '编辑员工基本信息',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '编辑',
				handler : function() {
					employeeEditForm.submit();
				}
			} ]
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

	<div id="employeeAddDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="employeeAddForm" method="post">
			<table class="tableForm">
						<tr>
							<th>部门Id</th>
							<td>
								<input name="departmentId" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写部门Id"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>名称</th>
							<td>
								<input name="name" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写名称"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>englishName</th>
							<td>
								<input name="englishName" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写englishName"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>员工性别</th>
							<td>
								<input name="sex" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写员工性别"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>员工生日</th>
							<td>
								<input name="birthday" type="text" class="easyui-datebox" data-options="" missingMessage="请填写员工生日"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>员工固话号</th>
							<td>
								<input name="tel" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写员工固话号"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>员工传真号</th>
							<td>
								<input name="fax" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写员工传真号"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>员工Email</th>
							<td>
								<input name="email" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写员工Email"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>员工地址</th>
							<td>
								<input name="address" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写员工地址"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>员工备注</th>
							<td>
								<input name="comments" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写员工备注"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>有效标志</th>
							<td>
								<input name="activeFlag" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写有效标志"  style="width: 155px;"/>						
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
							<th>修改人Id</th>
							<td>
								<input name="lastUpdBy" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写修改人Id"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>修改日期</th>
							<td>
								<input name="lastUpd" type="text" class="easyui-datebox" data-options="" missingMessage="请填写修改日期"  style="width: 155px;"/>						
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
							<th>员工编码</th>
							<td>
								<input name="empCode" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写员工编码"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>英文名</th>
							<td>
								<input name="nameAb" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写英文名"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>temp1Num</th>
							<td>
								<input name="temp1Num" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写temp1Num"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>temp2Num</th>
							<td>
								<input name="temp2Num" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写temp2Num"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>temp1Char</th>
							<td>
								<input name="temp1Char" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写temp1Char"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>temp4Char</th>
							<td>
								<input name="temp4Char" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写temp4Char"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>temp3Char</th>
							<td>
								<input name="temp3Char" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写temp3Char"  style="width: 155px;"/>						
							</td>
						</tr>
					
						<tr>
							<th>CD_DEPARTMENT</th>
							<td>
							<input name="department.DEPARTMENT_ID" class="department"/>
							</td>
						</tr>
					
					
			</table>
		</form>
	</div>

	<div id="employeeEditDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="employeeEditForm" method="post">
			<table class="tableForm">
						<tr>
						<th>部门Id</th>
							<td>
								<input name="departmentId" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写部门Id"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>名称</th>
							<td>
								<input name="name" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写名称"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>englishName</th>
							<td>
								<input name="englishName" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写englishName"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>员工性别</th>
							<td>
								<input name="sex" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写员工性别"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>员工生日</th>
							<td>
								<input name="birthday" type="text" class="easyui-datebox" data-options="" missingMessage="请填写员工生日"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>员工固话号</th>
							<td>
								<input name="tel" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写员工固话号"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>员工传真号</th>
							<td>
								<input name="fax" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写员工传真号"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>员工Email</th>
							<td>
								<input name="email" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写员工Email"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>员工地址</th>
							<td>
								<input name="address" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写员工地址"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>员工备注</th>
							<td>
								<input name="comments" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写员工备注"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>有效标志</th>
							<td>
								<input name="activeFlag" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写有效标志"  style="width: 155px;"/>
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
						<th>修改人Id</th>
							<td>
								<input name="lastUpdBy" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写修改人Id"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>修改日期</th>
							<td>
								<input name="lastUpd" type="text" class="easyui-datebox" data-options="" missingMessage="请填写修改日期"  style="width: 155px;"/>
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
						<th>员工编码</th>
							<td>
								<input name="empCode" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写员工编码"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>英文名</th>
							<td>
								<input name="nameAb" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写英文名"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>temp1Num</th>
							<td>
								<input name="temp1Num" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写temp1Num"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>temp2Num</th>
							<td>
								<input name="temp2Num" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写temp2Num"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>temp1Char</th>
							<td>
								<input name="temp1Char" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写temp1Char"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>temp4Char</th>
							<td>
								<input name="temp4Char" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写temp4Char"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>temp3Char</th>
							<td>
								<input name="temp3Char" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写temp3Char"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>CD_DEPARTMENT</th>
							<td>
							<input name="department.DEPARTMENT_ID" class="department"/>
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