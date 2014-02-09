<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var editRow = undefined;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'materialCompleteAction!datagrid.do',
			title : '套机物料表列表',
			queryParams:{
				completeMaterialCode:'${completeMaterialCode}'
			},
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
			idField : 'completeCode',
			
			frozenColumns:[ [
					{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.completeCode;
						}
					},
					{field:'completeCode',title:'唯一标识',align:'center',sortable:true,hidden:true,
					formatter:function(value,row,index){
						return row.completeCode;
					}
					},				
					{field:'completeMaterialCode',title:'套机物料号',align:'center',sortable:true,width:110,
					formatter:function(value,row,index){
						return row.completeMaterialCode;
					} ,
					editor : {
						type : 'singlecombogrid',
						options : {
							url : '${dynamicURL}/basic/materialAction!materialDate.action',
							idField : 'materialCode',
							textField : 'materialCode',
							panelWidth : 500,
							panelHeight : 220,
							toolbar : '#_MATERIALADIN',
							pagination : true,
							pagePosition : 'bottom',
							rownumbers : true,
							pageSize : 5,
							pageList : [ 5, 10 ],
							fit : true,
							fitColumns : true,
							nowrap : true,
							border : false,
							//required:true,
							columns : [ [ {
								field : 'materialCode',
								title : '物料号',
								width : 10
							}, {
								field : 'prodType',
								title : '产品大类',
								width : 10
							} ] ] 
						}
					} 
					},				
					{field:'subMaterialCode',title:'分机物料号',align:'center',sortable:true,width:110,
					formatter:function(value,row,index){
						return row.subMaterialCode;
					},
					editor : {
						type : 'singlecombogrid',
						options : {
							url : '${dynamicURL}/basic/materialAction!materialDate.action',
							idField : 'materialCode',
							textField : 'materialCode',
							panelWidth : 500,
							panelHeight : 220,
							toolbar : '#_MATERIALADINDETAIL',
							pagination : true,
							pagePosition : 'bottom',
							rownumbers : true,
							pageSize : 5,
							pageList : [ 5, 10 ],
							fit : true,
							fitColumns : true,
							nowrap : true,
							border : false,
							//required:true,
							columns : [ [ {
								field : 'materialCode',
								title : '物料号',
								width : 10
							}, {
								field : 'prodType',
								title : '产品大类',
								width : 10
							} ] ] 
						}
					} 
					},				
					{field:'subMaterialDesc',title:'分机物料描述',align:'center',sortable:true,width:120,
					formatter:function(value,row,index){
						return row.subMaterialDesc;
					},
					editor : {
						type : 'validatebox',
						options : {}
					}
					},				
					{field:'completeQuotiety',title:'成套系数',align:'center',sortable:true,width:70,
					formatter:function(value,row,index){
						return row.completeQuotiety;
					},
					editor : {
						type : 'validatebox',
						options : {}
					}
					},				
					{field:'tracFlag',title:'是否需要下线',align:'center',sortable:true,width:70,
					formatter:function(value,row,index){
						if(row.tracFlag=='0') {
							return '否';
						}
						if(row.tracFlag=='1') {
							return '是';
						}
					},
					editor : {
						type:'combobox',
						editable: false,
						options:{
							valueField:'value',  
					        textField:'label',
					        panelHeight: 50,
							data: [{
								label: '是',
								value: '1'
							},{
								label: '否',
								value: '0'
							}]
						}
					}
					},				
					{field:'activeFlag',title:'内外机标识',align:'center',sortable:true,width:70,
					formatter:function(value,row,index){
						if(row.activeFlag=='1') {
							return '内机';
						}
						if(row.activeFlag=='2') {
							return '外机';
						}
						if(row.activeFlag=='3') {
							return '其它';
						}
					},
					editor : {
						type:'combobox',
						editable: false,
						options:{
							valueField:'value',  
					        textField:'label',
					        panelHeight: 50,
							data: [{
								label: '内机',
								value: '1'
							},{
								label: '外机',
								value: '2'
							},{
								label: '其它',
								value: '3'
							}]
						}
					}
					}
			                 ]],
			columns : [ [ 
			{field:'width',title:'物料宽',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						if(row.width!=null&&row.width!=''){
							return Number(row.width).toFixed(2); 
						}else{
							return row.width;
						}
						
					}
				},{field:'length',title:'物料长',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						if(row.length!=null&&row.length!=''){
							return Number(row.length).toFixed(2); 
						}else{
							return row.length;
						}
					}
				},{field:'height',title:'物料高',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						if(row.height!=null&&row.height!=''){
							return Number(row.height).toFixed(2); 
						}else{
							return row.height;
						}
					}
				},{field:'netWeight',title:'物料净重',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						if(row.netWeight!=null&&row.netWeight!=''){
							return Number(row.netWeight).toFixed(2); 
						}else{
							return row.netWeight;
						}
					}
				},{field:'grossWeight',title:'物料毛重',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						if(row.grossWeight!=null&&row.grossWeight!=''){
							return Number(row.grossWeight).toFixed(2); 
						}else{
							return row.grossWeight;
						}
					}
				},	
			   {field:'createdBy',title:'创建人',align:'center',sortable:true,width:120,
					formatter:function(value,row,index){
						return row.createdBy;
					}
				},				
			   {field:'created',title:'创建日期',align:'center',sortable:true,width:120,
					formatter:function(value,row,index){
						return dateFormatYMD(row.created);
					}
				},				
			   {field:'lastUpdBy',title:'修改人',align:'center',sortable:true,width:120,
					formatter:function(value,row,index){
						return row.lastUpdBy;
					}
				},				
			   {field:'lastUpd',title:'修改日期',align:'center',sortable:true,width:120,
					formatter:function(value,row,index){
						return dateFormatYMD(row.lastUpd);
					}
				},				
			   {field:'modificationNum',title:'修改次数',align:'center',sortable:true,width:120,hidden:true,
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
				text : '保存',
				iconCls : 'icon-edit',
				handler : function() {
					save();
				}
			}, '-', {
				text : '取消',
				iconCls : 'icon-undo',
				handler : function() {
					datagrid.datagrid('unselectAll');
					datagrid.datagrid('rejectChanges');
					editRow = undefined;
				}
			}, '-' ],
			onDblClickRow : function(rowIndex, rowData) { 
				//alert(rowIndex);
				datagrid.datagrid('beginEdit', rowIndex);
				if (editRow != undefined) {
					datagrid.datagrid('endEdit', editRow);
				}
				editRow = rowIndex;
				datagrid.datagrid('unselectAll');
				datagrid.datagrid('selectRow', rowIndex);
			},
			onRowContextMenu : function(e, rowIndex, rowData) {
				e.preventDefault();
				$(this).datagrid('unselectAll');
				$(this).datagrid('selectRow', rowIndex);
				$('#menu').menu('show', {
					left : e.pageX,
					top : e.pageY
				});
			},onLoadSuccess:function(data){
				editRow = undefined;
			}
		});

	});
	function save(){
		datagrid.datagrid('endEdit', editRow);
		var rows = datagrid.datagrid('getChanges');
		var jsonStr = JSON.stringify(rows);
		$.ajax({
			url:'materialCompleteAction!add.do',
			type:"post",
			data : {listmater : jsonStr},
			dataType:'json',
			success : function(json) {
				if(json.sucess){
					datagrid.datagrid('load');
					$.messager.show({
						title : '提示',
						msg : '保存成功！'
					});
					datagrid.datagrid('unselectAll');
				}else{
					$.messager.show({
						title:'提示',
						msg:json.msg
					});
				}
			}
		});
	}
	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.form('clear');
	}
	function add() {
		var editRow1 = datagrid.datagrid('getRows').length;
		var row = {};
		$('#datagrid').datagrid('appendRow', row);
		$('#datagrid').datagrid('selectRow', editRow1);
		$('#datagrid').datagrid('beginEdit', editRow1);

		if (editRow != undefined) {
			//alert(editRow);
			$('#datagrid').datagrid('endEdit', editRow);
			$('#datagrid').datagrid('unselectAll');
		}
		editRow=editRow1;
		//alert(editRow);
	}
	function del() {
		var rows = datagrid.datagrid('getSelections');
		var ids = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if(i!=rows.length-1)
							ids=ids+"ids="+rows[i].completeCode+"&";
						else ids=ids+"ids="+rows[i].completeCode;
					}
					$.ajax({
						url : 'materialCompleteAction!delete.do',
						data : ids,
						dataType : 'json',
						success : function(response) {
							if(response.success){
								$.messager.show({
									title : '提示',
									msg : '删除成功！'
								});
								datagrid.datagrid('load');
								datagrid.datagrid('unselectAll');
							}else{
								$.messager.show({
									title:'提示',
									msg:response.msg
								});
							}
							
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
		if(rows.length == 1) {
			editRow = datagrid.datagrid('getRowIndex', rows[0]);
			datagrid.datagrid('beginEdit', editRow);
		}
		else {
			$.messager.alert('提示', '请选择一项要编辑的记录！', 'error');
		}
	}
	function _MATERIALDATA(material,haierprod,field){
		var ed = datagrid.datagrid('getEditor', {index:editRow,field:field});
		var materialdatagrid = $(ed.target);
		var material=$('#'+material).val();
		var haierprod=$('#'+haierprod).val();
		materialdatagrid
		.combogrid(
				{
					url : '${dynamicURL}/basic/materialAction!materialDate.action?materialCode='+material+'&prodType='+haierprod
				});
	}
</script>
</head>
<body class="easyui-layout">
	<div region="north" border="false" class="zoc" title="" collapsed="false"  style="height: 57px;overflow: hidden;" align="left">
		<form id="searchForm">
			<div class="partnavi_zoc"><span>查询与操作：</span></div>
			<div class="oneline">
				<div class="item33">
					<div class="itemleft80">套机物料号：</div>
					<div class="rightselect_easyui">
						<input type="text" name="completeMaterialCode">
					</div>
				</div>
				<div class="item33">
					<div class="itemleft80">分机物料号：</div>
					<div class="rightselect_easyui">
						<input type="text" name="subMaterialCode">
					</div>
				</div>
				<div class="item33 lastitem">
					<div class="oprationbutt">
						<input type="button" onclick="_search()" value="查询" />
						<input type="button" onclick="cleanSearch()" value="取消" />
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
   <div id="_MATERIALADIN">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">物料编号：</div>
				<div class="righttext">
					<input class="short60" id="_MATERCODEIDADMIN" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">产品大类：</div>
				<div class="righttext">
					<input class="short60" id="_MATERIALHAIMAIN" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="righttext">
					<input type="button" value="查询"
						onclick="_MATERIALDATA('_MATERCODEIDADMIN','_MATERIALHAIMAIN','completeMaterialCode')" />
				</div>
			</div>
		</div>
	</div>
   <div id="_MATERIALADINDETAIL">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">物料编号：</div>
				<div class="righttext">
					<input class="short60" id="_MATERCODEIDADMINDETAIL" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">产品大类：</div>
				<div class="righttext">
					<input class="short60" id="_MATERIALHAIMAINDETAIL" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="righttext">
					<input type="button" value="查询"
						onclick="_MATERIALDATA('_MATERCODEIDADMINDETAIL','_MATERIALHAIMAINDETAIL','subMaterialCode')" />
				</div>
			</div>
		</div>
	</div>
</body>
</html>