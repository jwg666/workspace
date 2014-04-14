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
			queryParams: {definitionKey:'accessCase'},
			title : '律师事务所待办列表',
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
				text : '接收案件',
				iconCls : 'icon-add',
				handler : function() {
					goAccess();
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
		
		datagridyiBan = $('#datagridyiBan').datagrid({
			url : 'legalCaseAction!getyiban.do',
			queryParams: {definitionKey:'accessCase'},
			title : '律师事务所已办列表',
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
			//idField : 'id',
			//sortName : 'id',
			//sortOrder : 'desc',
			columns : [ [ 
			{field:'id',checkbox:true,
						formatter:function(value,row,index){
							return row.id;
						}
					},
			   {field:'applicantname',title:'申请人',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.applicantname;
					}
				},				
			   {field:'agentname',title:'代理人',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.agentname;
					}
				},				
			   {field:'applicantTime',title:'申请日期',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return dateFormatYMD(row.applicantTime);
					}
				},				
			   {field:'createTime',title:'审批时间',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return dateFormatYMD(row.createTime);
					}
				},				
			   {field:'endTime',title:'分配时间',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return dateFormatYMD(row.endTime);
					}
				},				
			   {field:'dpName',title:'被指派的律师事务所',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.dpName;
					}
				}			
			 ] ],
			toolbar : [ {
				text : '查看明细',
				iconCls : 'icon-add',
				handler : function() {
					showDetali();
				}
			}, '-', {
				text : '取消选中',
				iconCls : 'icon-undo',
				handler : function() {
					datagridyiBan.datagrid('unselectAll');
				}
			}, '-' ]
		});
		
	});
	function goAccess(){
		var rows = datagrid.datagrid('getSelections');
		var caseId = rows[0].id;
		if (rows.length == 1) {
			currentappid = parent.window.HROS.window.createTemp({
				title : '律师事务所接收',
				url : '../legal/legalAction!goAccessCase.do?legalCaseQuery.id='+caseId,
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
	
	function showDetali(){
		var rows = datagridyiBan.datagrid('getSelections');
		var caseId = rows[0].caseId;
		if (rows.length == 1) {
			currentappid = parent.window.HROS.window.createTemp({
				title : '指派律师事务所',
				url : '../legal/legalAction!showdetail.do?legalCaseQuery.id='+caseId,
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
</script>
</head>
<body class="easyui-layout">
	
<div id="tabs_id" class="easyui-tabs" data-options="fit:true">
	<div title="待接收">
	<div id="checkSearch" class="easyui-layout" fit="true">
	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>
	</div>
    </div>
    <div title="已接收">
         <div id="checkSearchyiban" class="easyui-layout" fit="true">
			<div region="center" border="false">
				<table id="datagridyiBan"></table>
		    </div>
		 </div>
	</div>
    </div>

	
</body>
</html>