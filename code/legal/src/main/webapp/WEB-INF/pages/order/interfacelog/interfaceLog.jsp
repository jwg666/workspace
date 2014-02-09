<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
var searchForm; 
var datagrid;
	function dateFormatYMDHMS(date) {
		if (date != null && date.length > 0) {
			date = date.replace("T", " ");
		}
		return date;
	}
	$(function() {	
		$('#itemDatagrid').datagrid({
			url : '${dynamicURL}/salesOrder/salesOrderAction!shipListDatagrid.do',
			title : '待发货过账订单信息列表',
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
			idField : 'orderCode',
			
			frozenColumns : [ [
			{
				field:'ck',
				checkbox:true,
				formatter:function(value,row,index){
					return row.orderCode;
				}
			},
			{
				field : 'orderCode',
				title : '订单号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.orderCode;
				}
			},
			
			{
				field : 'contractCode',
				title : '合同编号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.contractCode;
				}
			},
			{
				field : 'orderShipDate',
				title : '出运期',
				align :'center',
				sortable : true,
				formatter : function(value, row, index){
					return dateFormatYMD(row.orderShipDate);
				}
			},
			{
				field : 'orderCustomDate',
				title : '要求到货期',
				align :'center',
				sortable : true,
				formatter : function(value, row, index){
					return dateFormatYMD(row.orderCustomDate);
				}
			},
			
						
			 ] ],
			toolbar : [{
				 text : '手工发货过账',
				 iconCls : 'icon-add',
				 handler : function(){
				   	var getCheckData = $('#itemDatagrid').datagrid('getChecked');
				   	if(getCheckData.length){
				   		//var jsonString = JSON.stringify(getCheckData);
				   		var ids = [];
				   		for(var i=0,l=getCheckData.length;i<l;i++){
				   			ids.push(getCheckData[i].orderCode);
				   		}
				   		$.messager.progress({
							text : '<s:text name="the.data.load" >数据传输中</s:text>....',
							interval : 100
						});
						// 手工发货过账
						//alert(jsonString);
				   		$.ajax({
				   		   type: "POST",
				   		   url: "${dynamicURL}/salesOrder/salesOrderAction!shipHgvs.do",
				   		   data: {
				   				ids:ids
				   		   },
				   		   traditional:true,
				   		   dataType:'json',
				   		   success: function(msg){
				   			$.messager.progress('close');
				   			$.messager.alert('提示',"发货过账运行结果:"+msg.msg,'info');
				   			$('#itemDatagrid').datagrid('reload');
				   		   }
				   		 });
				   		
				   	}else{
				   	    $.messager.alert('提示',"请您选择一条数据",'info');
				   	}
				 }
		  },'-',{
			  text : '全部进行发货过账',
			  iconCls : 'icon-add',
			  handler : function(){
				  $.messager.progress({
						text : '<s:text name="the.data.load" >数据传输中</s:text>....',
						interval : 100
					});
					//FIXME 手工发货过账
					//alert(jsonString);
			   		$.ajax({
			   		   type: "POST",
			   		   url: "${dynamicURL}/salesOrder/salesOrderAction!shipAllHgvs.do",			   		   
			   		   traditional:true,
			   		   dataType:'json',
			   		   success: function(msg){
			   			$.messager.progress('close');
			   			$.messager.alert('提示',"发货过账运行结果:"+msg.msg,'info');
			   			$('#itemDatagrid').datagrid('reload');
			   		   }
			   		 });
			  }
		  }],
		
		});
		
		//接口记录
	    	
	    		datagrid = $('#logDatagrid').datagrid({
	    			url : 'interfaceLogAction!datagrid.do?interfaceCode=EAI_HROIS_SHIP_HGVS',
	    			title : '发货过账记录表',
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
   			         	{
   							field:'ck',
   							checkbox:true,
   							formatter:function(value,row,index){
   								return row.orderCode;
   							}
   						},
	    			   {field:'orderCode',title:'订单编号',align:'center',width:100,
	    					formatter:function(value,row,index){
	    						return row.orderCode;
	    					}
	    				},		
	    			   {field:'mainCode',title:'备货单号',align:'center',width:100,
	    					formatter:function(value,row,index){
	    						return row.mainCode;
	    					}
	    				},	
	    			   {field:'interfaceName',title:'接口名称',align:'center',width:100,
	    					formatter:function(value,row,index){
	    						return row.interfaceName;
	    					}
	    				},				
	    			   {field:'interfaceFlag',title:'运行结果',align:'center',width:100,
	    					formatter:function(value,row,index){
	    						if(row.interfaceFlag=='T'){
	    							return '成功';
	    						}else{
	    							return '失败';
	    						}
	    						return row.interfaceFlag;
	    					}
	    				},				
	    			   {field:'interfaceMessage',title:'结果信息',align:'center',width:100,
	    					formatter:function(value,row,index){
	    						return row.interfaceMessage;
	    					}
	    				},				
	    			   {field:'lastUpd',title:'调用时间',align:'center',width:100,
	    					formatter:function(value,row,index){
	    						return dateFormatYMDHMS(row.lastUpd);
	    					}
	    				}				
	    			 ] ],	
	    			 toolbar : ['-',{
	    				 text : '<font color="#FF0000">选择订单，点我重新过账</font>',
	    				 iconCls : 'icon-undo',
	    				 handler : function(){
	    				   	var getCheckData = $('#logDatagrid').datagrid('getChecked');
	    				   	if(getCheckData.length){
	    				   		//var jsonString = JSON.stringify(getCheckData);
	    				   		var ids = [];
	    				   		var status;
	    				   		for(var i=0,l=getCheckData.length;i<l;i++){
	    				   			alert(getCheckData[i]);
	    				   			status = getCheckData[i].interfaceFlag;
	    				   			if('T'==status){
	    				   				ids.push(getCheckData[i].orderCode);
	    				   			}else{
	    				   				$.messager.alert('提示','订单'+getCheckData[i].orderCode+'已经过账成功，不允许重新过账','warn');
	    				   			}
	    				   			
	    				   		}
	    				   		$.messager.progress({
	    							text : '<s:text name="the.data.load" >数据传输中</s:text>....',
	    							interval : 100
	    						});
	    					
	    				   		$.ajax({
	    				   		   type: "POST",
	    				   		   url: "${dynamicURL}/salesOrder/interfaceLogAction!redoShipHgvs.do",
	    				   		   data: {
	    				   				ids:ids
	    				   		   },
	    				   		   traditional:true,
	    				   		   dataType:'json',
	    				   		   success: function(msg){
	    				   			$.messager.progress('close');
	    				   			$.messager.alert('提示',"发货过账运行结果:"+msg.msg,'info');
	    				   			$('#itemDatagrid').datagrid('reload');
	    				   		   }
	    				   		 });
	    				   		
	    				   	}else{
	    				   	    $.messager.alert('提示',"请您选择一条数据",'info');
	    				   	}
	    				 }
	    		  },'-'],
	    		});
	
	});
   
	function _search() {
		searchForm = $("#searchForm"); 
		$('#logDatagrid').datagrid('load', sy.serializeObject(searchForm));
	}
	function _itemSearch() {
		searchForm = $("#itemForm"); 
		$('#itemDatagrid').datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanItemSearch() {
		searchForm = $("#itemForm"); 
		$('#itemDatagrid').datagrid('load', {});
		$("#orderCode").val('');
	}
	function cleanSearch() {
		searchForm = $("#searchForm"); 
		datagrid.datagrid('load', {});
		$("#orderCode").val('');
	}
	
	
</script>
</head>
<body >		
	<div class="easyui-tabs" id="orderTabs"	data-options="border:false,plain:true,fit:true">	
		<div title="待发货过账列表" >
		<div id="tabOrderItem"  class="easyui-layout" data-options="fit:true">
			<div class="zoc" region="north" border="false" collapsed="false" style="height: 80px; overflow: hidden;" >
				<form id="itemForm">
					<div class="partnavi_zoc">
						<span>待发货过账订单查询：</span>
					</div>					
					<div class="oneline">
						<div class="item33">
							<div class="itemleft">订单号:</div>
							<div class="righttext">
								<input name="orderCode" type="text" style="width: 130px;" />
							</div>
						</div>
						<div class="item33 lastitem">
							<div class="oprationbutt">
								<input type="button" onclick="_itemSearch();"
									value="<s:text name='global.form.select' >查询</s:text>" />
									<input type="button" onclick="cleanItemSearch();"
									value="<s:text name='global.form.clear' >清空</s:text>" />
							</div>
						</div>
					</div>
				</form>
			</div>
			<div region="center"  border="false" collapsed="false" >
					<table id="itemDatagrid"></table>
			</div>
		</div>
		</div>
		<!-- ----------------------------------------------------------- -->
		<div title="发货过账记录" >
		<div id="tabLog"  class="easyui-layout" data-options="fit:true">
			<div class="zoc" region="north" border="false" collapsed="false" style="height: 80px; overflow: hidden;" >
				<form id="searchForm">
					<div class="partnavi_zoc">
						<span>发货过账接口信息查询：</span>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft">开始日期:</div>
							<div class="righttext">
								<input type="text" name="searchStartDate" class="easyui-datebox"
									editable="false" />
							</div>
						</div>
						<div class="item33 lastitem">
							<div class="itemleft">结束日期:</div>
							<div class="righttext">
								<input type="text" name="searchEndDate" class="easyui-datebox"
									editable="false" />
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft">订单号:</div>
							<div class="righttext">
								<input name="orderCode" type="text" style="width: 130px;" />
							</div>
						</div>
						<div class="item33 lastitem" >
							<div class="oprationbutt">
								<input type="button" onclick="_search();"
									value="<s:text name='global.form.select' >查询</s:text>" />
									<input type="button" onclick="cleanSearch();"
									value="<s:text name='global.form.clear' >清空</s:text>" />
							</div>
						</div>
					</div>
				</form>
			</div>
			<div region="center"  border="false" collapsed="false" >
					<table id="logDatagrid"></table>
			</div>
		</div>
		</div>
	</div>
</body>
</html>