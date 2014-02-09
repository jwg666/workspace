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
	var vdndorDialog;
	var vendorForm;
	$(function() {
		//报关行
		$('#custCompany').combogrid({
			url : '${dynamicURL}/basic/vendorAction!datagrid2.do',
			idField : 'vendorCode',
			textField : 'vendorNameCn',
			panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_VENDER',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			required:true,
			columns : [ [ {
				field : 'vendorCode',
				title : '报关行编号',
				width : 10
			}, {
				field : 'vendorNameCn',
				title : '报关行名称',
				width : 10
			} ] ]
		});
		vdndorDialog = $('#vdndorDialog').show().dialog({
			title : '请选择报关行',
			modal : true,
			closed : true,
			height:200,
			weight:150,
			maximizable : true,
			buttons : [ {
				text : '提交',
				handler : function() {
					vendorForm.submit();
				}
			} ]
		});
		vendorForm = $('#vendorForm').form({
			url : '${dynamicURL}/custorder/custOrderAction!addCustCompanys.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.alert('提示',json.msg,'info',function(){
						//代办刷新
						refreshTask();
						vdndorDialog.dialog('close');
					});
				} else {
					$.messager.alert('提示',json.msg,'error');
				}
			}
		});
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'custOrderAction!checkTask.do?definitionKey=packageBillAssign',
			title : '',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			pageList : [ 15, 20, 30, 40 ],
			fit : true,
			fitColumns : false,
			nowrap : true,
			border : false,
			//idField : 'orderCode',
			
			
			frozenColumns:[ [ 
			 				{field:'ck',checkbox:true,
								formatter:function(value,row,index){
									return row.taskId;
								}
							},
				{field:'bookCode',title:'<s:text name="order.bookcabin.bookCode">订舱号</s:text>',align:'center',sortable:true,width:130,
					formatter:function(value,row,index){
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
				}
			] ],
			toolbar : [ 
						{
							text : '报关分配',
							iconCls : 'icon-save',
							handler : function() {
								distribute5();
							}
						}, '-',
						{
							text : '批量报关分配',
							iconCls : 'icon-save',
							handler : function() {
								distribute6();
							}
						}
						],
			columns : [ [ 
			   {field:'operators',title:'<s:text name="global.order.operators">经营主体</s:text>',align:'center',sortable:true,width:250,
					formatter:function(value,row,index){
						return row.operators;
					}
				},
				{field:'orgName',title:'<s:text name="global.order.salesOrgCode">销售组织</s:text>',align:'center',sortable:true,width:80,
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
				{field:'countryName',title:'<s:text name="global.order.countryName">出口国家</s:text>',align:'center',sortable:true,width:60,
					formatter:function(value,row,index){
						return row.countryName;
					}
				},
				{field:'checkCode',title:'商检编号',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.checkCode;
					}
				}
				,
				{field:'fileName1',title:'报关明细',align:'center',sortable:true,width:200,
					formatter:function(value,row,index){
						return row.fileName1;
					}
				}
				 ,
				{field:'custDetail',title:'报关明细下载',align:'center',sortable:true,width:40,
					formatter:function(value,row,index){
						if(row.custDetail!=null&&row.custDetail!=''){							
						    return '<a href="${dynamicURL}/basic/fileUploadAction/downloadFile.do?fileId='+row.custDetail+'" target="_blank" >下载 </a>';
						}else{
							return row.custDetail;
						}
					}
				} 
				,
				{field:'fileName2',title:'换证凭条',align:'center',sortable:true,width:200,
					formatter:function(value,row,index){
						return row.fileName2;
					}
				} ,
				{field:'changeProof',title:'换证凭条下载',align:'center',sortable:true,width:40,
					formatter:function(value,row,index){
						if(row.changeProof!=null&&row.changeProof!=''){							
						    return '<a href="${dynamicURL}/basic/fileUploadAction/downloadFile.do?fileId='+row.changeProof+'" target="_blank" >下载 </a>';
						}else{
							return row.changeProof;
						}
					}
				} 
				,
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
			onDblClickRow : function(rowIndex, rowData) {
				if (editRow != undefined) {
					datagrid.datagrid('endEdit', editRow);
				}
				datagrid.datagrid('beginEdit', rowIndex);
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
			}
		});
		
		//查询已完成代办
	    searchHistoryForm = $('#searchHistoryForm').form();
	    historydatagrid = $('#historydatagrid').datagrid({
			url : 'custOrderAction!histroyTask.do?definitionKey=packageBillAssign',
			title : '',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			pageList : [ 15, 20, 30, 40 ],
			fit : true,
			fitColumns : false,
			nowrap : true,
			border : false,
			//idField : 'custCode',
			
			columns : [ [				
					{field:'declarationApply',title:'报关状态',align:'center',sortable:true,width:80,
						formatter:function(value,row,index){
							//return row.declarationApply;
							if(row.declarationApply==null){
								return '尚未开始';
							}else if(row.declarationApply=='start'){
								return '报关开始';
							}else if(row.declarationApply=='end'){
								return '报关结束';
							}else{
								return row.declarationApply;
							}
						}
					},				
					{field:'declarationEnd',title:'结关状态',align:'center',sortable:true,width:80,
						formatter:function(value,row,index){
							//return row.declarationEnd;
							if(row.declarationEnd==null){
								return '尚未开始';
							}else if(row.declarationEnd=='start'){
								return '结关开始';
							}else if(row.declarationEnd=='end'){
								return '报关结束';
							}else{
								return row.declarationEnd;
							}
						}
					},
			   {field:'operators',title:'<s:text name="global.order.operators">经营主体</s:text>',align:'center',sortable:true,width:250,
					formatter:function(value,row,index){
						return row.operators;
					}
				},
				{field:'orgName',title:'<s:text name="global.order.salesOrgCode">销售组织</s:text>',align:'center',sortable:true,width:80,
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
				{field:'countryName',title:'<s:text name="global.order.countryName">出口国家</s:text>',align:'center',sortable:true,width:60,
					formatter:function(value,row,index){
						return row.countryName;
					}
				},
				{field:'checkCode',title:'商检编号',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.checkCode;
					}
				}
				,
				{field:'fileName1',title:'报关明细',align:'center',sortable:true,width:200,
					formatter:function(value,row,index){
						return row.fileName1;
					}
				}
				 ,
				{field:'custDetail',title:'报关明细下载',align:'center',sortable:true,width:40,
					formatter:function(value,row,index){
						if(row.custDetail!=null&&row.custDetail!=''){							
						    return '<a href="${dynamicURL}/basic/fileUploadAction/downloadFile.do?fileId='+row.custDetail+'" target="_blank" >下载 </a>';
						}else{
							return row.custDetail;
						}
					}
				} 
				,
				{field:'fileName2',title:'换证凭条',align:'center',sortable:true,width:200,
					formatter:function(value,row,index){
						return row.fileName2;
					}
				} ,
				{field:'changeProof',title:'换证凭条下载',align:'center',sortable:true,width:40,
					formatter:function(value,row,index){
						if(row.changeProof!=null&&row.changeProof!=''){							
						    return '<a href="${dynamicURL}/basic/fileUploadAction/downloadFile.do?fileId='+row.changeProof+'" target="_blank" >下载 </a>';
						}else{
							return row.changeProof;
						}
					}
				} , {
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
							text : '重新选择报关行',
							iconCls : 'icon-edit',
							handler : function() {
								exChangeBGH();
							}
						}, '-',
						],
			frozenColumns:[ [ 
				{field:'ck',checkbox:true,
					formatter:function(value,row,index){
						return row.custCode;
					}
				},
				{field:'bookCode',title:'<s:text name="order.bookcabin.bookCode">订舱号</s:text>',align:'center',sortable:true,width:130,
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
				{field:'orderCode',title:'<s:text name="global.order.number">订单编号</s:text>',align:'center',sortable:true,width:110,
					formatter:function(value,row,index){
						return row.orderCode;
					}
				},				
				{field:'deptName',title:'<s:text name="global.order.factoryCode">生产工厂</s:text>',align:'center',sortable:true,width:200,
					formatter:function(value,row,index){
						return row.deptName;
					}
				}
				,				
				{field:'vendorNameCn',title:'报关行',align:'center',sortable:true,width:150,
					formatter:function(value,row,index){
						return row.vendorNameCn;
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
	//物流储运经理重新给同一订舱号下的订单分配报关行,并校验是否可以重新校验
	function exChangeBGH(){
		var rows=$('#historydatagrid').datagrid('getSelections');
		if(rows==null||rows.length<1){
			$.messager.alert('提示','请至少选中一条数据','warring');
			return;
		}else{
			
			if(rows.length>=2){
				for(var i=0;i<rows.length;i++){
					if((rows[0].bookCode!=rows[i].bookCode)||(rows[0].mergeCustFlag!=rows[i].mergeCustFlag)){
						$.messager.alert('提示','请确保选中的项有同一订舱号','warring');
						return;
					}
				}
			}
			var rowbookcode;
			if(rows[0].mergeCustFlag!=null&&rows[0].mergeCustFlag!=''){
				rowbookcode=rows[0].bookCode+':'+rows[0].mergeCustFlag;
			}else{
				rowbookcode=rows[0].bookCode;
			}
			var bookCode =rowbookcode;
			$.ajax({
				url:'${dynamicURL}/custorder/custOrderAction!ifCanreFenPei.action',
			    data:{
			    	bookCode:bookCode
			    },
			    dataType:'json',
			    success:function(json){
			    	if(json.success){
			    		parent.window.HROS.window.createTemp({
			    			title:'报关分配详细页面',
			    			url:"${dynamicURL}/custorder/custOrderAction!goRePackageBillDetail.do?bookCode="+bookCode,
			    			width:800,height:400,isresize:false,isopenmax:true,isflash:false,customWindow:window});
			    	}else{
			    		$.messager.alert('警告',json.msg,'error');
			    	}
			    }
			});
		}
	}
	//打开箱单分配明细页面
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
						$.messager.alert('提示','请确保选中的为相同合并报关的订单','warring');
						return;
					}
				}
			}
			parent.window.HROS.window.createTemp({
				title:rows[0].name,
				url:"${dynamicURL}/custorder/custOrderAction!openPackageBillDetail.do?taskId="+rows[0].taskId,
				width:800,height:400,isresize:false,isopenmax:true,isflash:false,customWindow:window});
		}
	}
	//批量分配报关行
	function distribute6(){
		var rows=$('#datagrid').datagrid('getSelections');
		if(rows!=null&&rows.length>0){
			var bookCode='';
			for(var i=0;i<rows.length;i++){
				if(i==0){
					bookCode=rows[i].bookCode+'-'+rows[i].mergeCustFlag;
				}else{
					bookCode=bookCode+','+rows[i].bookCode+'-'+rows[i].mergeCustFlag;
				}
			}
			$('#bookcodeId').val(bookCode);
			vdndorDialog.dialog('open');
		}else{
			$.messager.alert('提示','请至少选择一条数据','warring');
		}
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
	
	function distribute(rowIndex){
		var obj=$("#datagrid").datagrid("getData").rows[rowIndex];
		parent.window.HROS.window.createTemp({
			title:obj.name,
			url:"${dynamicURL}/custorder/custOrderAction!openPackageBillDetail.do?taskId="+obj.taskId,
			width:800,height:400,isresize:false,isopenmax:true,isflash:false,customWindow:window});
	}
	function distribute1(bookCode){
		//var obj=$("#datagrid").datagrid("getData").rows[rowIndex];
		parent.window.HROS.window.createTemp({
			title:'报关分配详细页面',
			url:"${dynamicURL}/custorder/custOrderAction!gotoShowDetail.do?bookCode="+bookCode,
			width:800,height:400,isresize:false,isopenmax:true,isflash:false,customWindow:window});
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
	//刷新待办列表
	function refreshTask(){
		datagrid.datagrid('load');
		historydatagrid.datagrid('load');
		top.window.showTaskCount();
	}
	function VENDOR_PORTMY(inputId, selectId) {
		var _CCNTEMP = $('#' + inputId).val()
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/basic/vendorAction!datagrid2.do?vendorNameCn=' + _CCNTEMP
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
</script>
</head>
	<div id="tabs_id" class="easyui-tabs" data-options="fit:true" >
		<div title="报关分配待办">
			<!--展开之后的content-part所显示的内容-->
			<div id="checkSearch" class="easyui-layout" fit="true">
				<div class="zoc" region="north" border="false" collapsible="true"
					collapsed="true" style="height:60px; overflow: hidden;">
					<form id="searchForm">
			      		<div class="partnavi_zoc"><span><s:text name="global.info.queriesAndoperations">查询与操作</s:text>：</span></div>
			            <div class="oneline">
			                <div class="item25">
			                    <div class="itemleft60"><s:text name="order.bookcabin.bookCode">订舱号</s:text>：</div>
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
		<div title="报关分配已办">
			<!--展开之后的content-part所显示的内容-->
			<div id="HistorySearch" class="easyui-layout" fit="true">
				<div class="zoc" region="north" border="false" collapsible="true"
					collapsed="true" style="height:60px; overflow: hidden;">
					<form id="searchHistoryForm">
						<div class="partnavi_zoc"><span><s:text name="global.info.queriesAndoperations">查询与操作</s:text>：</span></div>
			            <div class="oneline">
			                <div class="item25">
			                    <div class="itemleft60"><s:text name="order.bookcabin.bookCode">订舱号</s:text>：</div>
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
	<div id="vdndorDialog" style="display: none;width: 500px;height: 300px;" align="center">
		  <form id="vendorForm" method="post">
		  <div class="oneline">
	            	<div class="item25 lastitem">
	                    <div class="itemleft60"><s:text name="order.custorder.custCompany">报关行</s:text>：</div>
	                    <div  class="righttext">
	                    <input id="custCompany" name="custCompany" class="short60" />
	                     <input id="bookcodeId" type="hidden" name="bookCode" class="short60" /> 
						<!-- <font color="red">*</font> -->
	                    </div>
	                </div>
	       </div>
	       </form>
	</div>
	<div id="_VENDER">
		<div class="oneline">
			<div class="item25">
			    <!-- <div class="itemleft60">报关行编码：</div>
				<div class="righttext">
					<input class="short50" id="VENDOR_" type="text" />
				</div> -->
				<div class="itemleft60">报关行名称：</div>
				<div class="righttext">
					<input class="short50" id="VENDOR_PORTINPUT" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="righttext">
					<input type="button" value="查询"
						onclick="VENDOR_PORTMY('VENDOR_PORTINPUT','custCompany')" />
				</div>
			</div>
		</div>
	</div>
</body>
</html>