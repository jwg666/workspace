<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var datagrid;
	var datagridyiBan;
	var currentappid;
	$(function() {
		datagrid = $('#datagrid').datagrid({
			url : 'legalCaseAction!taskgrid.do',
			queryParams: {definitionKey:'caseApprove'},
			title : '案件审核待办列表',
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
					goApprove();
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
			queryParams: {definitionKey:'caseApprove'},
			title : '案件审核已办列表',
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
				}			
			 ] ],
			toolbar : [ {
				text : '查看明细',
				iconCls : 'icon-add',
				handler : function() {
					chakan();
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
 	function reloaddata(){
		datagrid.datagrid('reload');
	} 
	function goApprove(){
		var rows = datagrid.datagrid('getSelections');
		var caseId = rows[0].id;
		if (rows.length == 1) {
			currentappid = parent.window.HROS.window.createTemp({
				appid:currentappid,
				title : '案件审核',
				url : '../legal/legalApproveAction!taskDetail?caseId='+caseId,
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
	function chakan(){
		var rows = datagridyiBan.datagrid('getSelections');
		var id = rows[0].id;
		if (rows.length == 1) {
			currentappid = parent.window.HROS.window.createTemp({
				appid:currentappid,
				title : '案件审核',
				url : '../legal/legalApproveAction!taskDetailWanCheng?id='+id,
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
	<div id="tabs_id" class="easyui-tabs" data-options="fit:true">
	<div title="待审核">
	    <div id="checkSearch" class="easyui-layout" fit="true">
			<div region="center" border="false">
				<table id="datagrid"></table>
		    </div>
		</div>
    </div>
    <div title="已审核">
         <div id="checkSearchyiban" class="easyui-layout" fit="true">
			<div region="center" border="false">
				<table id="datagridyiBan"></table>
		    </div>
		 </div>
	</div>
    </div>
	
</body>
</html>