<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<script type="text/javascript" charset="utf-8">	
    var salesItemDatagrid;
    var salesConditionDatagrid;
    var salesPackageDatagrid;
    var salesInterfaceDatagrid;
    var itemLineCode;
    var orderCode;
    
    $(function(){
 		//订单明细数据datagrid
    	salesItemDatagrid =$('#itemDatagrid').datagrid({
			url : '${dynamicURL}/salesOrder/salesOrderItemAction!orderItemDatagrid.do?orderCode='+salesOrdeCode,
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			singleSelect : true,
			fit : true,
			//fitColumns : true,
 			pageSize:6,
			pageList:[6,12,18],
			nowrap : true,
			border : false,
			
   			
   			showFooter: true,
   			frozenColumns : [ [ 
   				{field:'ck',checkbox:true,
   					formatter:function(value,row,index){
   						   return row.orderItemLinecode;
   					}
   				},
   				{field:'orderItemLinecode',title:'行项目号',align:'center',sortable:true,
   					formatter:function(value,row,index){
   						  return row.orderItemLinecode;
   					}
   				},				
   				{field:'prodTname',title:'产品大类',align:'center',sortable:true,
   					formatter:function(value,row,index){
   						 return row.prodTname;
   					}
   			    },				
   				{field:'haierModel',title:'海尔型号',align:'center',sortable:true,
   					formatter:function(value,row,index){
   						 return row.haierModel;
   					}
   				},				
   		        {field:'customerModel',title:'客户型号',align:'center',sortable:true,
   					formatter:function(value,row,index){
   						 return row.customerModel;
   					}
   				},				
   				{field:'affirmNum',title:'特技单号',align:'center',sortable:true,
   					formatter:function(value,row,index){
   						 return row.affirmNum;
   					}
   				},				
   			    {field:'materialCode',title:'物料号',align:'center',sortable:true,
   					formatter:function(value,row,index){
   						 return row.materialCode;
   					}
   				},				
   				{field:'factoryName',title:'结算工厂',align:'center',sortable:true,
   				    formatter:function(value,row,index){
   						return row.factoryName;
   				    }
   				}			
   			]],
			columns : [ [ 
 			   {field:'prodQuantity',title:'数量',align:'center',sortable:true,
 					formatter:function(value,row,index){
 						return row.prodQuantity;
 					}
 				},				
 			   {field:'price',title:'单价',align:'center',sortable:true,
 					formatter:function(value,row,index){
 						return row.price;
 					}
 				},				
 			   {field:'amount',title:'金额',align:'center',sortable:true,
 					formatter:function(value,row,index){
 						return row.amount;
 					}
 				},
 				{field:'custPrice',title:'报关单价',align:'center',sortable:true,
 					formatter:function(value,row,index){
 						return row.custPrice;
 					}
 				},
 				{field:'custAmount',title:'报关总额',align:'center',sortable:true,
 					formatter:function(value,row,index){
 						return row.custAmount;
 					}
 				},
 				{field:'operators',title:'经营主体',align:'center',sortable:true,
 					formatter:function(value,row,index){
 						return row.operators;
 					}
 				},
 				{field:'orderBrand',title:'品牌',align:'center',sortable:true,
 					formatter:function(value,row,index){
 						if(row.orderBrand == null || row.orderBrand == ""){
 							return "-";
 						}else{
 							return row.orderBrand;
 						}
 					}
 				},
 				{field:'typQua',title:'箱型箱量',align:'center',sortable:true,
 					formatter:function(value,row,index){
 						if(row.typQua == null || row.typQua == ""){
 							return "-";
 						}else{
 							return row.typQua;
 						}
 					}
 				},
 				{field:'specialCheck',title:'是否特殊检',align:'center',sortable:true,
 					formatter:function(value,row,index){
 						if(row.specialCheck == "0" || row.specialCheck == "" || row.specialCheck == null){
 							return "-";
 						}
 						if(row.specialCheck == "1"){
 							return "进行特殊检";
 						}
 					}
 				}
 			 ] ]
		});
    	
    	$('#orderTabs').tabs({  
 		    onSelect:function(title,rowIndex){  
 		        /*只有不是物料明细Tab的时候才会动态加载数据*/
 		    	if(rowIndex != 0) {
 		    		//判断物料明细tab是否有选中的数据 
 		       		var $selectItems = $("#itemDatagrid").datagrid('getSelected');
 		    		//此时只是获取到列表第一个数据
 		       		var $pageData = null;
 		       		//如果没有选中数据，则要默认第一个数据
 		    		if(null != $selectItems) {
 		    			$pageData = $selectItems;
 		    		}else{
 		    			$pageData = $("#itemDatagrid").datagrid('getRows')[0];
 		    		}
 		       		itemLineCode = $pageData.orderItemLinecode;
 		       	    orderCode = $pageData.orderCode;
 		       		//条件记录
	    	    	if(title == '<s:text name="order.confirm.conditionTile">条件记录</s:text>') {
	    	    		    salesConditionDatagrid = $('#conditionDatagrid').datagrid({
		    	   			url : '${dynamicURL}/salesOrder/salesOrderConditonAction!combox.do',
		    	   			queryParams : {orderItemLinecode:itemLineCode,orderCode:orderCode},		
		    	   			iconCls : 'icon-save',
		    	   			rownumbers : true,
		    	   			fit : true,
		    	   			fitColumns : true,
		    	   			nowrap : true,
		    	   			border : false,
		    	   			idField : 'rowId',
		    	   			columns : [ [ 
		  		    	   			   {field:'conditionCode',title:'条件记录编码',align:'center',sortable:true,
		  		    	   					formatter:function(value,row,index){
		  		    	   						return row.conditionCode;
		  		    	   					}
		  		    	   				},
		  		    	   			   {field:'conditionName',title:'条件记录名称',align:'center',sortable:true,
		  		    	   					formatter:function(value,row,index){
		  		    	   						return row.conditionName;
		  		    	   					}
		  		    	   				},
		  		    	   			   {field:'conditionRate',title:'条件记录值',align:'center',sortable:true,
		  		    	   					formatter:function(value,row,index){
		  		    	   						return row.conditionRate;
		  		    	   					}
		  		    	   				},
		  		    	   			   {field:'conditionValue',title:'条件记录总额',align:'center',sortable:true,
		  		    	   					formatter:function(value,row,index){
		  		    	   						return row.conditionValue;
		  		    	   					}
		  		    	   				},
		  		    	   			   {field:'currencyName',title:'币种',align:'center',sortable:true,
		  		    	   					formatter:function(value,row,index){
		  		    	   						return row.currencyName;
		  		    	   					}
		  		    	   			   }
		  		    	   	 ] ]
		    	   		});
	    	    	//记录包装	    
	    	    	}else if(title == '<s:text name="order.confirm.packageTitle">包装记录</s:text>'){
	    	    		salesPackageDatagrid = $('#packageDatagrid').datagrid({
	    	    			url : '${dynamicURL}/salesOrder/salesOrderPackageAction!combox.do',
	    	    			iconCls : 'icon-save',
	    	    			queryParams : {orderCode:orderCode},		
	    	    			pagination : true,
	    	    			pagePosition : 'bottom',
	    	    			rownumbers : true,
	    	    			pageSize : 6,
	    	    			pageList : [6,12,18],
	    	    			fit : true,
	    	    			fitColumns : true,
	    	    			nowrap : true,
	    	    			border : false,
	    	    			columns : [ [ 
	    	    			   {field:'packageType',title:'包装类型',align:'center',sortable:true,
	    	    					formatter:function(value,row,index){
	    	    						return row.packageType;
	    	    					}
	    	    				},				
	    	    			   {field:'packageQuantity',title:'包装数量',align:'center',sortable:true,
	    	    					formatter:function(value,row,index){
	    	    						return row.packageQuantity;
	    	    					}
	    	    				},				
	    	    			   {field:'packageWidth',title:'包装宽度',align:'center',sortable:true,
	    	    					formatter:function(value,row,index){
	    	    						return row.packageWidth;
	    	    					}
	    	    				},				
	    	    			   {field:'packageLength',title:'包装深度',align:'center',sortable:true,
	    	    					formatter:function(value,row,index){
	    	    						return row.packageLength;
	    	    					}
	    	    				},				
	    	    			   {field:'packageHigh',title:'包装高度',align:'center',sortable:true,
	    	    					formatter:function(value,row,index){
	    	    						return row.packageHigh;
	    	    					}
	    	    				},				
	    	    			   {field:'packageGrossValue',title:'包装毛重',align:'center',sortable:true,
	    	    					formatter:function(value,row,index){
	    	    						return row.packageGrossValue;
	    	    					}
	    	    				},				
	    	    			   {field:'botSide',title:'侧放规格',align:'center',sortable:true,
	    	    					formatter:function(value,row,index){
	    	    						return row.botSide;
	    	    					}
	    	    				},				
	    	    			   {field:'layNum',title:'堆码层数',align:'center',sortable:true,
	    	    					formatter:function(value,row,index){
	    	    						return row.layNum;
	    	    					}
	    	    				},				
	    	    			   {field:'botOrder',title:'底置优先级',align:'center',sortable:true,
	    	    					formatter:function(value,row,index){
	    	    						return row.botOrder;
	    	    					}
	    	    				}				
	    	    			 ] ]
	    	    		});
	    	    	//接口记录
	    	    	}else if(title == '<s:text name="order.confirm.interfaceTitle">接口记录</s:text>'){
	    	    		salesInterfaceDatagrid = $('#interfaceDatagrid').datagrid({
	    	    			url : '${dynamicURL}/salesOrder/interfaceLogAction!combox.do',
	    	    			queryParams : {orderCode:orderCode},		
	    	    			iconCls : 'icon-save',
	    	    			pagination : true,
	    	    			pagePosition : 'bottom',
	    	    			rownumbers : true,
	    	    			pageSize : 6,
	    	    			pageList : [6,12,18],
	    	    			fit : true,
	    	    			fitColumns : true,
	    	    			nowrap : true,
	    	    			border : false,
	    	    			idField : 'rowId',
	    	    			columns : [ [ 
							   {field:'lastUpd',title:'调用时间',align:'center',sortable:true,
									formatter:function(value,row,index){
										return dateFormatYMD(row.lastUpd);
									}
							   },
	    	    			   {field:'interfaceName',title:'接口名称',align:'center',sortable:true,
	    	    					formatter:function(value,row,index){
	    	    						return row.interfaceName;
	    	    					}
	    	    				},				
	    	    			   {field:'interfaceFlag',title:'接口标识',align:'center',sortable:true,
	    	    					formatter:function(value,row,index){
	    	    						return row.interfaceFlag;
	    	    					}
	    	    				},				
	    	    			   {field:'interfaceMessage',title:'接口返回',align:'center',sortable:true,
	    	    					formatter:function(value,row,index){
	    	    						return row.interfaceMessage;
	    	    					}
	    	    				}			
	    	    			 ] ]
	    	    		});
	    	    	}
 		       }
 		    }  
 		});
    })
	
</script>

<div class="easyui-tabs" id="orderTabs" style="height:300px;" data-options="border:false,plain:true">  
		<div id="tabOrderItem" title="订单明细" style="padding:10px" data-options="fit:true" class="part_zoc">
			<table id="itemDatagrid" class="table2"></table>
		</div>
		
		<div id="tabOrderCondition" title="条件记录" style="padding:10px" class="part_zoc">
			<table id="conditionDatagrid" class="table2"></table>
		</div>
		
        <div  title="包装记录" style="padding:10px" class="part_zoc">
			<table id="packageDatagrid" class="table2"></table>
		</div> 

		<div  title="接口记录" style="padding:10px" class="part_zoc">
			<table id="interfaceDatagrid" class="table2"></table>
		</div>
</div>