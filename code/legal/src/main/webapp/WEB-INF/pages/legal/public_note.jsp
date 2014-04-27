<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>

<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;

	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'legalCaseAction!querydatagrid.do',
			title : '案件列表',
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
			sortName : 'id',
			sortOrder : 'desc',
			frozenColumns:[[
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
				}			
			   				

			]],
			columns : [[ 
							
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


			 ]],
			toolbar : [ {
				text : '会见犯罪嫌疑人、被告人公函',
				iconCls : 'icon-add',
				handler : function() {
					dayin1();
				}
			}, '-', {
                text : '指派通知书',
                iconCls : 'icon-add',
                handler : function() {
                	dayin2();
                }
            },'-', {
				text : '司法鉴定指派通知书',
				iconCls : 'icon-add',
				handler : function() {
					dayin3();
				}
			}, '-', {
				text : '给予法律援助决定书',
				iconCls : 'icon-add',
				handler : function() {
					dayin4();
				}
			}, '-',  {
                text : '民事法律援助公函',
                iconCls : 'icon-add',
                handler : function() {
                	dayin5();
                }
            }, '-', {
                text : '刑事法律援助公函',
                iconCls : 'icon-add',
                handler : function() {
                	dayin6();
                }
            }, '-', {
                text : '终止法律援助公函',
                iconCls : 'icon-add',
                handler : function() {
                	dayin7();
                }
            }, '-',{
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
	//会见犯罪嫌疑人、被告人公函
    function dayin1(){
    	var rows = datagrid.datagrid('getSelections');
		var caseId = rows[0].caseId;
		if (rows.length == 1) {
			currentappid = parent.window.HROS.window.createTemp({
				title : '会见犯罪嫌疑人，被告人公函',
				url : '../legal/legalAction!dayin1.do?legalCaseQuery.id='+caseId,
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
  //会见犯罪嫌疑人、被告人公函
    function dayin2(){
    	var rows = datagrid.datagrid('getSelections');
		var caseId = rows[0].caseId;
		if (rows.length == 1) {
			currentappid = parent.window.HROS.window.createTemp({
				title : '会见犯罪嫌疑人，被告人公函',
				url : '../legal/legalAction!dayin2.do?legalCaseQuery.id='+caseId,
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
    function dayin3(){
    	var rows = datagrid.datagrid('getSelections');
		var caseId = rows[0].caseId;
		if (rows.length == 1) {
			currentappid = parent.window.HROS.window.createTemp({
				title : '会见犯罪嫌疑人，被告人公函',
				url : '../legal/legalAction!dayin3.do?legalCaseQuery.id='+caseId,
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
    function dayin4(){
    	var rows = datagrid.datagrid('getSelections');
		var caseId = rows[0].caseId;
		if (rows.length == 1) {
			currentappid = parent.window.HROS.window.createTemp({
				title : '会见犯罪嫌疑人，被告人公函',
				url : '../legal/legalAction!dayin4.do?legalCaseQuery.id='+caseId,
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
    function dayin5(){
    	var rows = datagrid.datagrid('getSelections');
		var caseId = rows[0].caseId;
		if (rows.length == 1) {
			currentappid = parent.window.HROS.window.createTemp({
				title : '会见犯罪嫌疑人，被告人公函',
				url : '../legal/legalAction!dayin5.do?legalCaseQuery.id='+caseId,
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
    function dayin6(){
    	var rows = datagrid.datagrid('getSelections');
		var caseId = rows[0].caseId;
		if (rows.length == 1) {
			currentappid = parent.window.HROS.window.createTemp({
				title : '会见犯罪嫌疑人，被告人公函',
				url : '../legal/legalAction!dayin6.do?legalCaseQuery.id='+caseId,
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
    function dayin7(){
    	var rows = datagrid.datagrid('getSelections');
		var caseId = rows[0].caseId;
		if (rows.length == 1) {
			currentappid = parent.window.HROS.window.createTemp({
				title : '会见犯罪嫌疑人，被告人公函',
				url : '../legal/legalAction!dayin7.do?legalCaseQuery.id='+caseId,
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
<div region="north" split="true" style="height:10px;"  collapsed="false" border="false">
    <div class="part_zoc" style="margin:0px 0px 0px 0px;" >
        <div class="partnavi_zoc">
            <span>案件搜索</span>
        </div>
        <div class="oneline">
            <div class="item33">
                <div class="itemleft">关键字: </div>
                <div class="righttext">
                    <input name="keywords" type="text" style="width: 130px;"/>
                </div>
            </div>
        </div>
    </div>
</div>
	
	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>



</body>
</html>