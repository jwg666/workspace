<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var cdSaleOrgAddDialog;
	var cdSaleOrgAddForm;
	var cdescAdd;
	var cdSaleOrgEditDialog;
	var cdSaleOrgEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
	    //加载组织类型的下拉框
	   /*  $('#salesorgtype').combobox({   
	    	    url:'../basic/sysLovAction!combox.action?itemType=6',
                	data:[{
	    	    	itemType : '6'
	    	    }], 
	            valueField:'itemCode',   
	    	    textField:'itemName'  
	    	});  */ 

		datagrid = $('#datagrid').datagrid({
			url : 'saleOrgAction!haveDataGrid.do',
			title : '销售组织列表',
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
			//idField : 'id',
			
			columns : [ [ 
			{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.saleOrgCode;
						}
					},				
			   {field:'saleOrgCode',title:'销售组织编码',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.saleOrgCode;
					}
				}, 			
			   {field:'saleOrgName',title:'中文名称',align:'center',sortable:true,width:5,
					formatter:function(value,row,index){
						return row.saleOrgName;
					}
				},				
			   {field:'saleOrgEnName',title:'英文名称',align:'center',sortable:true,width:5,
					formatter:function(value,row,index){
						return row.saleOrgEnName;
					}
				},				
			   {field:'activeFlag',title:'有效标志',align:'center',sortable:true,width:4,
					formatter:function(value,row,index){
						if(row.activeFlag==1){
							return '有效';
						}else if(row.activeFlag==0){
							return '无效';
						}else{
							return '状态无法识别';
						}
						return row.activeFlag;
					}
				},				
			    {field:'createdBy',title:'创建人',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.createdBy;
					}
				},	 		
			   {field:'created',title:'创建日期',align:'center',sortable:true,width:6,
					formatter:function(value,row,index){
						return dateFormatYMD(row.created);
					}
				},				
			   {field:'lastUpd',title:'修改日期',align:'center',sortable:true,width:6,
					formatter:function(value,row,index){
						return dateFormatYMD(row.lastUpd);
					}
				} ,				
			   {field:'lastUpdBy',title:'修改人',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.lastUpdBy;
					}
				} ,				
			   {field:'modificationNum',title:'修改次数',align:'center',sortable:true,width:2,
					formatter:function(value,row,index){
						return row.modificationNum;
					}
				}				
			 ] ],
			 /*toolbar : [  {
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
			}, '-' ], */
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

		cdSaleOrgAddForm = $('#cdSaleOrgAddForm').form({
			url : 'saleOrgAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					cdSaleOrgAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		cdSaleOrgAddDialog = $('#cdSaleOrgAddDialog').show().dialog({
			title : '添加CD_SALE_ORG',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '添加',
				handler : function() {
					cdSaleOrgAddForm.submit();
				}
			} ]
		});
		
		
		

		cdSaleOrgEditForm = $('#cdSaleOrgEditForm').form({
			url : 'saleOrgAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					cdSaleOrgEditDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		cdSaleOrgEditDialog = $('#cdSaleOrgEditDialog').show().dialog({
			title : '编辑CD_SALE_ORG',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '编辑',
				handler : function() {
					cdSaleOrgEditForm.submit();
				}
			} ]
		});


		showCdescDialog = $('#showCdescDialog').show().dialog({
			title : 'CD_SALE_ORG描述',
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
		searchForm.form('clear');
	}
	function add() {
		cdSaleOrgAddForm.find('input,textarea').val('');
		$('div.validatebox-tip').remove();
		cdSaleOrgAddDialog.dialog('open');
	}
	function del() {
		var rows = datagrid.datagrid('getSelections');
		var ids = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if(i!=rows.length-1)
							ids=ids+"ids="+rows[i].saleOrgCode+"&";
						else ids=ids+"ids="+rows[i].saleOrgCode;
					}
					$.ajax({
						url : 'saleOrgAction!delete.do',
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
				url : 'saleOrgAction!showDesc.do',
				data : {
					id : rows[0].id
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					cdSaleOrgEditForm.find('input,textarea').val('');
					cdSaleOrgEditForm.form('load', response);
					$('div.validatebox-tip').remove();
					cdSaleOrgEditDialog.dialog('open');
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
			url : 'saleOrgAction!showDesc.do',
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
					$.messager.alert('提示', '没有CD_SALE_ORG描述！', 'error');
				}
				$.messager.progress('close');
			}
		});
		datagrid.datagrid('unselectAll');
	}
</script>
</head>
<body class="easyui-layout zoc">
	<div region="north" border="false" class="zoc" collapsed="false"  style="height: 140px;width : 100%;overflow: auto;" align="left">
		<form id="searchForm">
		<div class="navhead_zoc"><span>销售组织信息查询</span></div>
		<div class="part_zoc" region="north">
				<div class="oneline">
				    <!-- <div class="item25">
					    <div class="itemleft80">组织类型</div>
					<div class="righttext">
					    <input id="salesorgtype"  type="text" class="short50" name="salesOrgType"  />
					</div>
					</div> -->
					<div class="item25">
					    <div class="itemleft80">销售组织中文名称</div>
					    <div class="righttext">
					        <input name="saleOrgName" type="text" class="short50" />
					    </div>
					</div>
					<div class="item25">
					    <div class="itemleft80">销售组织英文名称</div>
					    <div class="righttext">
					        <input name="saleOrgEnName"  type="text" class="short50"/>
					    </div>
					</div>
					<div class="item25">
					<div class="oprationbutt">
					<input type="button" onclick="_search();" value="查询">
					<input type="button" onclick="cleanSearch();" value="重置">
					</div>
				</div>
				</div>

				<div class="oneline">
				    <div class="item25">
				    
					       <div class="itemleft80">创建时间从</div>
					       <div class="righttext">
					            <input name="fromCreated" class="easyui-datebox short50" type="text" editable="false"  />
					           
					       </div>
					       </div>
					        <div class="item25">
					       <div class="itemleft80">至</div>
					       <div class="righttext">
					             <input name="toCreated" class="easyui-datebox short50" type="text" editable="false"  />
					           
					       </div>
					  </div>     
				    <div class="item25">
				    
					       <div class="itemleft80">创建时间从</div>
					       <div class="righttext">
					           <input name="fromLastUpd" class="easyui-datebox short50" type="text" editable="false"  />
					           
					       </div>
					       </div>
					        <div class="item25">
					       <div class="itemleft80">至</div>
					       <div class="righttext">
					              <input name="toLastUpd" class="easyui-datebox short50" type="text" editable="false"  />
					           
					       </div>
					  </div>     
				</div>
			</div>
		</form>
	</div>
	
	<div region="center" border="false" class="part_zoc">
		<table id="datagrid"></table>
	</div>
	<div id="cdSaleOrgAddDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="cdSaleOrgAddForm" method="post">
			<table class="tableForm">
						<tr>
							<th>SAP对应编号</th>
							<td>
							<input name="sapCode" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写SAP对应编号"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>销售组织编码</th>
							<td>
							<input name="saleOrgCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写销售组织编码"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>中文名称</th>
							<td>
							<input name="saleOrgName" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写中文名称"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>有效标志</th>
							<td>
							<input name="saleOrgEnName" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写有效标志"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>activeFlag</th>
							<td>
							<input name="activeFlag" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写activeFlag"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>创建人</th>
							<td>
							<input name="createdBy" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写创建人"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>创建日期</th>
							<td>
							<input name="created" type="text" class="easyui-datebox" data-options="required:true" missingMessage="请填写创建日期"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>修改日期</th>
							<td>
							<input name="lastUpd" type="text" class="easyui-datebox" data-options="required:true" missingMessage="请填写修改日期"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>修改人</th>
							<td>
							<input name="lastUpdBy" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写修改人"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>modificationNum</th>
							<td>
							<input name="modificationNum" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写modificationNum"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>ifDamager</th>
							<td>
							<input name="ifDamager" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写ifDamager"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>组织类型</th>
							<td>
							<input name="salesOrgType" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写组织类型"  style="width: 155px;"/>
							</td>
						</tr>
					
					
					
			</table>
		</form>
	</div>

	<div id="cdSaleOrgEditDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="cdSaleOrgEditForm" method="post">
			<table class="tableForm">
						<tr>
						<th>SAP对应编号</th>
							<td>
<input name="sapCode" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写SAP对应编号"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>销售组织编码</th>
							<td>
							<input name="saleOrgCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写销售组织编码"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>中文名称</th>
							<td>
<input name="saleOrgName" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写中文名称"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>有效标志</th>
							<td>
<input name="saleOrgEnName" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写有效标志"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>activeFlag</th>
							<td>
<input name="activeFlag" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写activeFlag"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>创建人</th>
							<td>
<input name="createdBy" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写创建人"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>创建日期</th>
							<td>
<input name="created" type="text" class="easyui-datebox" data-options="required:true" missingMessage="请填写创建日期"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>修改日期</th>
							<td>
<input name="lastUpd" type="text" class="easyui-datebox" data-options="required:true" missingMessage="请填写修改日期"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>修改人</th>
							<td>
<input name="lastUpdBy" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写修改人"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>modificationNum</th>
							<td>
<input name="modificationNum" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写modificationNum"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>ifDamager</th>
							<td>
<input name="ifDamager" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写ifDamager"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>组织类型</th>
							<td>
<input name="salesOrgType" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写组织类型"  style="width: 155px;"/>
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