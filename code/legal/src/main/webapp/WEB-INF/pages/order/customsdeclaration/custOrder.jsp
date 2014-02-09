<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var editRow = undefined;
	var uploadExcelDialog;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'custOrderAction!checkTask.do?definitionKey=declarationApply',
			title : '',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			fitColumns : false,
			nowrap : true,
			border : false,
			//idField : 'orderCode',
			
			frozenColumns:[ [ 
					 {field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.orderCode;
						}
					}, 
					{field:'bookCode',title:'订舱号',align:'center',sortable:true,width:140,
						formatter:function(value,row,index){
							//return row.bookCode;
							var img;
							var rowbookcode;
							if(row.mergeCustFlag!=null&&row.mergeCustFlag!=''){
								rowbookcode=row.bookCode+'-'+row.mergeCustFlag;
							}else{
								rowbookcode=row.bookCode;
							}
							if(row.assignee&&row.assignee!='null'){
							img="<img width='16px' height='16px' title='<s:text name='global.info.mytask'>个人任务</s:text>' src='${staticURL}/easyui3.2/themes/icons/user.png' />&nbsp;"
							}else{
							img="<img width='16px' height='16px' title='<s:text name='global.info.grouptask'>未认领的组任务</s:text>' src='${staticURL}/easyui3.2/themes/icons/group.png' />&nbsp;"
							}
							return "<a href='javascript:void(0)' style='color:blue' onclick='distribute("+index+")'>"+img+rowbookcode+"</a>";
						}
					},
					{field:'orderCode',title:'<s:text name="global.order.number">订单编号</s:text>',align:'center',sortable:true,width:110,
						formatter:function(value,row,index){
							return row.orderCode;
						}
					},{
						field : 'planfinishdate',
						title : '计划完成时间',
						align : 'center',
						width : 100,
						formatter : function(value, row, index) {
							return dateFormatYMD(row.planfinishdate);
						}
					},				
					{field:'deptName',title:'<s:text name="global.order.factoryCode">生产工厂</s:text>',align:'center',sortable:true,width:200,
						formatter:function(value,row,index){
							return row.deptName;
						}
					},	
			] ],
			columns : [ [ 
				   {field:'operators',title:'<s:text name="global.order.operators">经营主体</s:text>',align:'center',sortable:true,width:250,
						formatter:function(value,row,index){
							return row.operators;
						}
					},
					{field:'orgName',title:'<s:text name="global.order.salesOrgCode">销售组织</s:text>',align:'center',sortable:true,width:100,
						formatter:function(value,row,index){
							return row.orgName;
						}
					},
					{field:'areaName',title:'<s:text name="global.order.saleArea">市场区域</s:text>',align:'center',sortable:true,width:80,
						formatter:function(value,row,index){
							return row.areaName;
						}
					},
					{field:'customerName',title:'<s:text name="global.order.customerName">客户</s:text>',align:'center',sortable:true,width:180,
						formatter:function(value,row,index){
							return row.customerName;
						}
					},
					{field:'countryName',title:'<s:text name="global.order.countryName">出口国家</s:text>',align:'center',sortable:true,width:80,
						formatter:function(value,row,index){
							return row.countryName;
						}
					},
					{field:'procInstId',title:'流程id',align:'center',sortable:true,width:90,hidden:true,
						formatter:function(value,row,index){
							return row.procInstId;
						}
					},
					{field:'taskId',title:'任务id',align:'center',sortable:true,width:90,hidden:true,
						formatter:function(value,row,index){
							return row.taskId;
						}
					}, {
						field : 'trace',
						title : '<s:text name="global.order.trace">流程追踪</s:text>',
						align : 'center',
						width : 80,
						formatter : function(value, row, index) {
							return "<a href='javascript:void(0)' style='color:blue' onclick='traceImg("+index+")'><s:text name='global.order.trace'>流程追踪</s:text></a>";
						}
					}
				 ] ],
			toolbar : [ 
			 {
				text : '<s:text name="page.statistics.export">导出</s:text>',
				iconCls : 'icon-edit',
				handler : function() {
					exceloutput();
				}
			}, '-',{
				text : '<s:text name="page.statistics.upload">导入</s:text>',
				iconCls : 'icon-edit',
				handler : function() {
					upload();
				}
			} , '-',
			{
				text : '报关',
				iconCls : 'icon-save',
				handler : function() {
					distribute5();
				}
			}, '-',{
				text : '显示报关发票',
				iconCls : 'icon-edit',
				handler : function() {
					showInvoice();
				}
			}, '-',{
				text : '显示箱单发票',
				iconCls : 'icon-edit',
				handler : function() {
					showInvoicepackage();
				}
			} ],
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
		 	searchHistoryForm = $('#searchHistoryForm').form();
		    historydatagrid = $('#historydatagrid').datagrid({
				url : 'custOrderAction!histroyTask.do?definitionKey=declarationApply',
				title : '',
				iconCls : 'icon-save',
				pagination : true,
				pagePosition : 'bottom',
				rownumbers : true,
				pageSize : 10,
				pageList : [ 10, 20, 30, 40 ],
				fit : true,
				fitColumns : false,
				nowrap : true,
				border : false,
				//idField : 'custCode',
				columns : [ [ 
					{field:'orgName',title:'<s:text name="global.order.salesOrgCode">销售组织</s:text>',align:'center',sortable:true,width:100,
						formatter:function(value,row,index){
							return row.orgName;
						}
					},
					{field:'areaName',title:'<s:text name="global.order.saleArea">市场区域</s:text>',align:'center',sortable:true,width:250,
						formatter:function(value,row,index){
							return row.areaName;
						}
					},
					{field:'customerName',title:'<s:text name="global.order.customerName">客户</s:text>',align:'center',sortable:true,width:180,
						formatter:function(value,row,index){
							return row.customerName;
						}
					},
					{field:'countryName',title:'<s:text name="global.order.countryName">出口国家</s:text>',align:'center',sortable:true,width:80,
						formatter:function(value,row,index){
							return row.countryName;
						}
					},
					{field:'custNum',title:'<s:text name="order.custorder.custNum">报关单号</s:text>',align:'center',sortable:true,width:120,
						formatter:function(value,row,index){
							return row.custNum;
						}
					},
					{field:'custDate',title:'<s:text name="order.custorder.custDate">报关时间</s:text>',align:'center',sortable:true,width:80,
						formatter:function(value,row,index){
							return dateFormatYMD(row.custDate);
						}
					},
				   {field:'custCompany',title:'<s:text name="order.custorder.custCompany">报关行</s:text>',align:'center',sortable:true,width:80,
						formatter:function(value,row,index){
							return row.custCompany;
						}
					}, {
						field : 'trace',
						title : '<s:text name="global.order.trace">流程追踪</s:text>',
						align : 'center',
						width : 80,
						formatter : function(value, row, index) {
							return "<a href='javascript:void(0)' style='color:blue' onclick='traceImg1("+index+")'><s:text name='global.order.trace'>流程追踪</s:text></a>";
						}
					}
				 ] ],
				 toolbar : [ 
							{
								text : '显示报关发票',
								iconCls : 'icon-edit',
								handler : function() {
									showInvoice1();
								}
							}, '-',
							{
								text : '显示箱单发票',
								iconCls : 'icon-edit',
								handler : function() {
									showInvoicepackage1();
								}
							}, '-',
							],
				 frozenColumns:[ [
					{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.custCode;
						}
					},
					{field:'bookCode',title:'订舱号',align:'center',sortable:true,width:120,
						formatter:function(value,row,index){
							var rowbookcode;
							if(row.mergeCustFlag!=null&&row.mergeCustFlag!=''){
								rowbookcode=row.bookCode+'-'+row.mergeCustFlag;
							}else{
								rowbookcode=row.bookCode;
							}
							var rowbookcode1;
							if(row.mergeCustFlag!=null&&row.mergeCustFlag!=''){
								rowbookcode1=row.bookCode+':'+row.mergeCustFlag;
							}else{
								rowbookcode1=row.bookCode;
							}
							return "<a href='javascript:void(0)' style='color:blue' onclick='distribute1(\""+rowbookcode1+"\")'>"+rowbookcode+"</a>";
						}
					},
					{field:'orderCode',title:'<s:text name="global.order.number">订单编号</s:text>',align:'center',sortable:true,width:80,
						formatter:function(value,row,index){
							return row.orderCode;
						}
					},				
					{field:'deptName',title:'<s:text name="global.order.factoryCode">生产工厂</s:text>',align:'center',sortable:true,width:200,
						formatter:function(value,row,index){
							return row.deptName;
						}
					},				
					{field:'operators',title:'<s:text name="global.order.operators">经营主体</s:text>',align:'center',sortable:true,width:250,
						formatter:function(value,row,index){
							return row.operators;
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
	
	function distribute(rowIndex){
		var obj=$("#datagrid").datagrid("getData").rows[rowIndex];
		parent.window.HROS.window.createTemp({
			title:obj.name,
			url:"${dynamicURL}/custorder/custOrderAction!openDetail.do?taskId="+obj.taskId,
			width:800,height:400,isresize:false,isopenmax:true,isflash:false,customWindow:window});
	}
	function distribute5(){
		var rows=$('#datagrid').datagrid('getSelections');
		if(rows==null||rows.length<1){
			$.messager.alert('提示','请至少选中一条数据','warring');
			return;
		}else{
			if(rows.length>=2){
				for(var i=0;i<rows.length;i++){
					var bookCode0=rows[0].bookCode+':'+rows[0].mergeCustFlag;
					var bookCodei=rows[i].bookCode+':'+rows[i].mergeCustFlag;
					if(bookCode0!=bookCodei){
						$.messager.alert('提示','请确保选中的项有同一订舱号','warring');
						return;
					}
				}
			}
			parent.window.HROS.window.createTemp({
				title:rows[0].name,
				url:"${dynamicURL}/custorder/custOrderAction!openDetail.do?taskId="+rows[0].taskId,
				width:800,height:400,isresize:false,isopenmax:true,isflash:false,customWindow:window});
		}
	}
	function distribute1(bookCode){
		//var obj=$("#datagrid").datagrid("getData").rows[rowIndex];
		parent.window.HROS.window.createTemp({
			title:'报关详细页面',
			url:"${dynamicURL}/custorder/custOrderAction!gotoShowDetail.do?bookCode="+bookCode,
			width:800,height:400,isresize:false,isopenmax:true,isflash:false,customWindow:window});
	}
	//展现订单的报关发票
	function showInvoice(){
		var rows=$("#datagrid").datagrid("getSelections");
		if(rows==null||rows.length==0){
			$.messager.alert('提示','请选中一条数据','warring');
			return;
		}
		if(rows.length>1){
			$.messager.alert('提示','只能选择一条数据','warring');
			return;
		}
		var row=rows[0];
		parent.window.HROS.window.createTemp({
			title:'报关发票',
			url:"${dynamicURL}/custorder/custOrderAction!goCustInvoice.do?orderCode="+row.orderCode,
			width:800,height:400,isresize:false,isopenmax:true,isflash:false,customWindow:window});
	}
	//展现订单的报关发票
	function showInvoice1(){
		var rows=$("#historydatagrid").datagrid("getSelections");
		if(rows==null||rows.length==0){
			$.messager.alert('提示','请选中一条数据','warring');
			return;
		}
		if(rows.length>1){
			$.messager.alert('提示','只能选择一条数据','warring');
			return;
		}
		var row=rows[0];
		parent.window.HROS.window.createTemp({
			title:'报关发票',
			url:"${dynamicURL}/custorder/custOrderAction!goCustInvoice.do?orderCode="+row.orderCode,
			width:800,height:400,isresize:false,isopenmax:true,isflash:false,customWindow:window});
	}
	//展现订单的箱单发票
	function showInvoicepackage(){
		var rows=$("#datagrid").datagrid("getSelections");
		if(rows==null||rows.length==0){
			$.messager.alert('提示','请选中一条数据','warring');
			return;
		}
		if(rows.length>1){
			$.messager.alert('提示','只能选择一条数据','warring');
			return;
		}
		$.ajax({
			url:"${dynamicURL}/custorder/custOrderAction!haveorderType.do",
			data:{
				orderCode:rows[0].orderCode
			},
			dataType:'json',
			success:function(json){
				if(json.success){
					parent.window.HROS.window.createTemp({
						title:'箱单发票',
						url:"${dynamicURL}/bookorder/packingListAction!goPackingList.do?orderCode="+rows[0].orderCode+"&orderType="+json.obj,
						width:800,height:400,isresize:false,isopenmax:true,isflash:false,customWindow:window});
				}else{
					$.messager.alert('提示',json.msg,'warring');
				}
			}
		});
	}
	function showInvoicepackage1(){
		var rows=$("#historydatagrid").datagrid("getSelections");
		if(rows==null||rows.length==0){
			$.messager.alert('提示','请选中一条数据','warring');
			return;
		}
		if(rows.length>1){
			$.messager.alert('提示','只能选择一条数据','warring');
			return;
		}
		$.ajax({
			url:"${dynamicURL}/custorder/custOrderAction!haveorderType.do",
			data:{
				orderCode:rows[0].orderCode
			},
			dataType:'json',
			success:function(json){
				if(json.success){
					parent.window.HROS.window.createTemp({
						title:'箱单发票',
						url:"${dynamicURL}/bookorder/packingListAction!goPackingList.do?orderCode="+rows[0].orderCode+"&orderType="+json.obj,
						width:800,height:400,isresize:false,isopenmax:true,isflash:false,customWindow:window});
				}else{
					$.messager.alert('提示',json.msg,'warring');
				}
			}
		});
	}
	function traceImg(rowIndex){
			var obj=$("#datagrid").datagrid("getData").rows[rowIndex];
			parent.window.HROS.window.createTemp({
				title:obj.name+"-<s:text name='global.order.number'>订单号</s:text>:"+obj.orderCode+"-<s:text name='global.order.process'>流程图</s:text>",
				url:"${dynamicURL}/workflow/processAction!goTrace.do?processInstanceId="+obj.procInstId,
				width:800,height:400,isresize:false,isopenmax:true,isflash:false});
	}
	function traceImg1(rowIndex){
		var obj=$("#historydatagrid").datagrid("getData").rows[rowIndex];
		//alert(obj.orderCode);
		parent.window.HROS.window.createTemp({
			title:"<s:text name='global.order.number'>订单号</s:text>:"+obj.orderCode+"-<s:text name='global.order.process'>流程图</s:text>",
			url:"${dynamicURL}/workflow/processAction!goTrace.do?processInstanceId="+obj.procInstId,
			width:800,height:400,isresize:false,isopenmax:true,isflash:false});
	}
	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.form('clear');
	}
	function hiddenSearchForm(){
		$("#checkSearch").layout("collapse","north");
	}
	function historySearch(){
		historydatagrid.datagrid('load', sy.serializeObject(searchHistoryForm));
	}
	function historyClean(){
		historydatagrid.datagrid('load', {});
		searchHistoryForm.form('clear');
	}
	function hiddenHistorySearch(){
		$("#HistorySearch").layout("collapse","north");
	}
	function exceloutput(){
		$("#searchForm").attr("action", "custOrderAction!exceloutput.action");
		$("#searchForm").submit();
	}
	function upload() {
		var upLoadExcelForm;
		uploadExcelDialog = $('#uploadExcelDialog').show().dialog({
	    	title : '<s:text name="page.statistics.upload">导入</s:text>',
	    	modal : true,
	    	closed : true,
	    	collapsible : true,
	    	buttons : [{
		    		text : '<s:text name="page.statistics.upload">导入</s:text>',
		    		handler : function() {
						upLoadExcelForm.submit();
					}
	    	}]
	    });
		//加载导入excel方法
		upLoadExcelForm = $('#upLoadExcelForm').form({
			url:'custOrderAction!upload.action',
			success:function(data) {
				var json = $.parseJSON(data);
				var obj = json.obj;
				if (json && json.success) {
					$.messager.progress('close');
					$.messager.show({
						title : '<s:text name="global.info.success">成功</s:text>',
						msg : json.msg
					});
					datagrid.datagrid('load');
					uploadExcelDialog.dialog('close');
				} else {
					$.messager.progress('close');
					$.messager.show({
						title : '<s:text name="global.info.fail">失败</s:text>',
						msg : json.msg
					});
				}
			}
		});
		uploadExcelDialog.dialog('open');
	}
	function quickApply(){
		var rows = datagrid.datagrid('getSelections');
		var ids = "";
		var taskIds = "";
		if (rows.length > 0) {
			$.messager.confirm('<s:text name="global.info.please.confirm">请确认</s:text>', '<s:text name="global.info.want.applytask.selected">您要申领当前任务</s:text>您要申领当前任务？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if (i != rows.length - 1) {
							ids = ids + "ids=" + rows[i].orderCode + "&";
							taskIds = taskIds + "taskIds=" + rows[i].taskId
									+ "&";
						} else {
							ids = ids + "ids=" + rows[i].orderCode;
							taskIds = taskIds + "taskIds=" + rows[i].taskId;
						}
					}
					$.ajax({
						url : 'custOrderAction!apply.do',
						data : ids + "&" + taskIds,
						dataType : 'json',
						type : "post",
						success : function(response) {
							datagrid.datagrid('load');
							datagrid.datagrid('unselectAll');
							$.messager.show({
								title : '<s:text name="global.form.prompt">提示</s:text>',
								msg : response.msg
							});
						}
					});
				}
			});
		} else {
			$.messager.alert('<s:text name="global.form.prompt">提示</s:text>', '<s:text name="global.info.select.applytask">请选择要申领的任务</s:text>！', 'error');
		}
	}
	//刷新任务列表
	function refreshTask(){
		datagrid.datagrid('load');
		historydatagrid.datagrid('load');
		top.window.showTaskCount();
	}
</script>
</head>
<body>
	<div id="tabs_id" class="easyui-tabs" data-options="fit:true" >
		<div title="报关代办">
			<!--展开之后的content-part所显示的内容-->
			<div id="checkSearch" class="easyui-layout" fit="true">
				<div class="zoc" region="north" border="false" collapsible="true"
					collapsed="true" style="height:60px; overflow: hidden;">
					<form id="searchForm">
						<div class="partnavi_zoc"><span><s:text name="global.info.queriesAndoperations">查询与操作</s:text>：</span></div>
			            <div class="oneline">
			                <div class="item25">
			                    <div class="itemleft60">订舱号：</div>
			                    <div class="righttext_easyui">
			                    	<div class="righttext">
			                    		 <input name="bookCode" type="text"/>
			                    	</div>
								</div>
			                </div>
			                <div class="item33">
			                    <div class="itemleft"><s:text name="global.order.number">订单编号</s:text>：</div>
			                    <div class="righttext">
			                    	 <input name="orderCode" type="text" class="orderAutoComple"/>
			                    	 <input type="hidden" name="taskIds">
			                    </div>
			                </div>
			               
			                <div class="item33 lastitem">
			                 	<div class="oprationbutt">
			                        <input type="button" onclick="_search()" value="<s:text name="global.form.filter">过滤</s:text>" />
			                        <input type="button" onclick="cleanSearch()" value="<s:text name="global.form.cancel">取消</s:text>" />
			                        <input type="button" onclick="hiddenSearchForm()" value="<s:text name="pcm.distributor.state_hidden">隐藏</s:text>" />
			                    </div>
			                </div>
			             </div>
			        </form>
				</div>
				<div region="center" border="false">
					<table id="datagrid" ></table>
				</div>
			</div>
		</div>
		<div title="报关已完成">
			<!--展开之后的content-part所显示的内容-->
			<div id="HistorySearch" class="easyui-layout" fit="true">
				<div class="zoc" region="north" border="false" collapsible="true"
					collapsed="true" style="height:60px; overflow: hidden;">
					<form id="searchHistoryForm">
						<div class="partnavi_zoc"><span><s:text name="global.info.queriesAndoperations">查询与操作</s:text>：</span></div>
			            <div class="oneline">
			                <div class="item25">
			                    <div class="itemleft60">订舱号：</div>
			                    <div class="righttext_easyui">
			                    	<div class="righttext">
			                    		<input name="bookCode" type="text">
			                    	</div>
								</div>
			                </div>
			                <div class="item33">
			                    <div class="itemleft"><s:text name="global.order.number">订单编号</s:text>：</div>
			                    <div class="righttext"><input name="orderCode" class="orderAutoComple"/></div>
			                </div>
			             	<div class="item33 lastitem">
			                    <div class="oprationbutt">
			                        <input type="button" onclick="historySearch()" value="<s:text name="global.form.filter">过滤</s:text>" />
			                        <input type="button" onclick="historyClean()" value="<s:text name="global.form.cancel">取消</s:text>" />
			                        <input type="button" onclick="hiddenHistorySearch()" value="<s:text name="pcm.distributor.state_hidden">隐藏</s:text>" />
			                    </div>
			             	</div>
			             </div>
					</form>
				</div>
				<div region="center" border="false">
					<table id="historydatagrid" ></table>
				</div>
			</div>
		</div>
	</div>
	<div id="uploadExcelDialog" style="display: none;width: 400px;height: 120px;" align="center">
		<form id="upLoadExcelForm" method="post" enctype="multipart/form-data">
		    <table >
				<tr>
					<th><s:text name="page.statistics.upload">导入</s:text>:</th>
					<td>
					    <s:file id="excleFile" name="excleFile"></s:file>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>