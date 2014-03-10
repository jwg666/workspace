<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var datagrid;
	var currentappid;
	$(function() {
		datagrid = $('#datagrid').datagrid({
			url : 'legalCaseAction!taskgrid.do',
			queryParams: {definitionKey:'asignLegalOffice'},
			title : '指派律师事务所待办列表',
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
			sortName : 'applicantId',
			sortOrder : 'desc',
			columns : [ [ 
			{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.id;
						}
					},
			   {field:'applicantId',title:'申请人',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.applicantId;
					}
				},				
			   {field:'agentId',title:'代理人',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.agentId;
					}
				},				
			   {field:'description',title:'案件描述',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.description;
					}
				},				
			   {field:'createTime',title:'提交时间',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.createTime);
					}
				},				
			   {field:'caseFrom',title:'案件来源',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.caseFrom;
					}
				},				
			   				
			   {field:'applyTypeId',title:'申请事项',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.applyTypeId;
					}
				},				
			 ] ],
			toolbar : [ {
				text : '办理',
				iconCls : 'icon-add',
				handler : function() {
					goAsign();
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
	});
	function goAsign(){
		var rows = datagrid.datagrid('getSelections');
		var caseId = rows[0].id;
		if (rows.length == 1) {
			currentappid = parent.window.HROS.window.createTemp({
				title : '指派律师事务所',
				url : '../legal/legalAction!goAsignLegalOffice?legalCaseQuery.id='+caseId,
				width : 900,
				height : 500,
				isresize : true,
				isopenmax : true,
				isflash : false,
				customWindow : window
			});
		}else{
			$.messager.alert('提示', '请选择一条提单记录', 'warning');
		}
	}
	function reloaddata(){
		datagrid.datagrid('reload');
	}
</script>
</head>
<body class="easyui-layout">
	
	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>

	
</body>
</html>