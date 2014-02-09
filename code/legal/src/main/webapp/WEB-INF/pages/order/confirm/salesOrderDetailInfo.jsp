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
 		//物料数据datagrid
    	salesItemDatagrid =$('#itemDatagrid').datagrid({
			url : 'salesOrderItemAction!orderItemDatagrid.do?orderCode='+salesOrdeCode,
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			singleSelect : true,
			fit : true,
			//fitColumns : true,
 			pageSize:5,
			pageList:[5,10,15],
			nowrap : true,
			border : false,
			idField : 'orderItemLinecode',
			showFooter: true,
			frozenColumns : [ [ 
			    {field:'ck',checkbox:true,
			 		formatter:function(value,row,index){
			 			return row.orderItemLinecode;
			 		}
			 	},
			 	{field:'orderItemLinecode',title:'<s:text name="contract.detail.contractLineItem">行项目号</s:text>',align:'center',sortable:true,
			 		formatter:function(value,row,index){
			 			return row.orderItemLinecode;
			 		}
			 	},				
			 	{field:'prodTname',title:'<s:text name="global.order.prodtype">产品大类</s:text>',align:'center',sortable:true,
			 		formatter:function(value,row,index){
			 			return row.prodTname;
			 		}
			 	},				
			 	{field:'haierModel',title:'<s:text name="specialschema.haierModel">海尔型号</s:text>',align:'center',sortable:true,
			 		formatter:function(value,row,index){
			 			return row.haierModel;
			 		}
			 	},				
			 	{field:'customerModel',title:'<s:text name="specialschema.oemType">客户型号</s:text>',align:'center',sortable:true,
			 		formatter:function(value,row,index){
			 			return row.customerModel;
			 		}
			 	},				
			 	{field:'affirmNum',title:'<s:text name="specialschema.affirmNum">特技单号</s:text>',align:'center',sortable:true,
			 		formatter:function(value,row,index){
			 			return row.affirmNum;
			 		}
			 	},				
			 	{field:'materialCode',title:'<s:text name="contract.detail.materialCode">物料号</s:text>',align:'center',sortable:true,
			 		formatter:function(value,row,index){
			 			return row.materialCode;
			 		}
			 	},				
			 	{field:'factoryName',title:'<s:text name="orderConfirm.accountFactory">结算工厂</s:text>',align:'center',sortable:true,
			 		formatter:function(value,row,index){
			 			if(row.factoryName == null || row.factoryName == ""){
			 				return "-";
			 			}else{
			 				return row.factoryName;
			 			}
			 		}
			    }			
			]],
			columns : [ [ 
 			   {field:'prodQuantity',title:'<s:text name="pcm.form.count">数量</s:text>',align:'center',sortable:true,
 					formatter:function(value,row,index){
 						return row.prodQuantity;
 					}
 				},				
 			   {field:'price',title:'<s:text name="order.custorder.price">单价</s:text>',align:'center',sortable:true,
 					formatter:function(value,row,index){
 						return row.price;
 					}
 				},				
 			   {field:'amount',title:'<s:text name="credit.lettercredit.amount">金额</s:text>',align:'center',sortable:true,
 					formatter:function(value,row,index){
 						return row.amount;
 					}
 				},
 				{field:'custPrice',title:'<s:text name="order.custorder.custprice">报关单价</s:text>',align:'center',sortable:true,
 					formatter:function(value,row,index){
 						return row.custPrice;
 					}
 				},
 				{field:'custAmount',title:'<s:text name="order.custorder.custtotal">报关总额</s:text>',align:'center',sortable:true,
 					formatter:function(value,row,index){
 						return row.custAmount;
 					}
 				},
 				{field:'weigths',title:'<s:text name="order.comprehensive.sumGrossWeight">总毛重</s:text>',align:'center',sortable:true,
 					formatter:function(value,row,index){
 						if(row.weigths == null || row.weigths == ""){
 							return '-';
 						}else{
 							return row.weigths;
 						}
 					}
 				},
 				{field:'netWeights',title:'<s:text name="order.comprehensive.sumNetWeight">总净重</s:text>',align:'center',sortable:true,
 					formatter:function(value,row,index){
 						if(row.netWeights == null || row.netWeights == ""){
 							return '-';
 						}else{
 							return row.netWeights;
 						}
 					}	
 				},
 				{field:'volumns',title:'<s:text name="order.comprehensive.sumVolumn">总体积</s:text>',align:'center',sortable:true,
 					formatter:function(value,row,index){
 						if(row.volumns == null || row.volumns == ""){
 							return '-';
 						}else{
 							return row.volumns;
 						}
 					}
 				},
  			   {field:'unit',title:'<s:text name="global.unit">单位</s:text>',align:'center',sortable:true,
  					formatter:function(value,row,index){
  						if(row.unit == null || row.unit == ""){
  							return '-';
  						}else{
  							return row.unit;
  						}
  					}
  			   },
 				{field:'operators',title:'<s:text name="global.order.operators">经营主体</s:text>',align:'center',sortable:true,
 					formatter:function(value,row,index){
 						if(row.operators == null || row.operators == ""){
 							return "-";
 						}else{
 							return row.operators;
 						}
 					}
 				},
 				{field:'orderBrand',title:'<s:text name="global.brand">品牌</s:text>',align:'center',sortable:true,
 					formatter:function(value,row,index){
 						if(row.orderBrand == null || row.orderBrand ==""){
 							return "-";
 						}else{
 							return row.orderBrand;
 						}
 					}
 				},
 				{field:'typQua',title:'<s:text name="specialschema.contrainerType">箱型箱量</s:text>',align:'center',sortable:true,
 					formatter:function(value,row,index){
 						if(row.typQua == null || row.typQua == ""){
 							return "-";
 						}else{
 							return row.typQua;
 						}
 					}
 				},
 				{field:'specialCheck',title:'<s:text name="order.confirm.specialCheck">是否特殊检</s:text>',align:'center',sortable:true,
 					formatter:function(value,row,index){
 						if(row.specialCheck == "0" || row.specialCheck == "" || row.specialCheck == null){
 							return "-";
 						}
 						if(row.specialCheck == "1"){
 							return "<s:text name='order.confirm.mustSpecialCheck'>进行特殊检</s:text>";
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
		    	   			url : 'salesOrderConditonAction!datagrid.do',
		    	   			queryParams : {orderItemLinecode:itemLineCode,orderCode:orderCode},		
		    	   			iconCls : 'icon-save',
		    	   			rownumbers : true,
		    	   			fit : true,
		    	   			fitColumns : true,
		    	   			nowrap : true,
		    	   			border : false,
		    	   			columns : [ [ 
		  		    	   			   {field:'conditionCode',title:'<s:text name="contract.detail.conditionCode">条件记录编码</s:text>',align:'center',sortable:true,
		  		    	   					formatter:function(value,row,index){
		  		    	   						return row.conditionCode;
		  		    	   					}
		  		    	   				},
		  		    	   			   {field:'conditionName',title:'<s:text name="contract.detail.conditionName">条件记录名称</s:text>',align:'center',sortable:true,
		  		    	   					formatter:function(value,row,index){
		  		    	   						return row.conditionName;
		  		    	   					}
		  		    	   				},
		  		    	   			   {field:'conditionRate',title:'<s:text name="contract.detail.conditionValue">条件记录值</s:text>',align:'center',sortable:true,
		  		    	   					formatter:function(value,row,index){
		  		    	   						return row.conditionRate;
		  		    	   					}
		  		    	   				},
		  		    	   			   {field:'conditionValue',title:'<s:text name="contract.detail.conditionAmount">条件记录总值</s:text>',align:'center',sortable:true,
		  		    	   					formatter:function(value,row,index){
		  		    	   						return row.conditionValue;
		  		    	   					}
		  		    	   				},
		  		    	   			   {field:'currencyName',title:'<s:text name="global.order.ecurrency">币种</s:text>',align:'center',sortable:true,
		  		    	   					formatter:function(value,row,index){
		  		    	   						return row.currencyName;
		  		    	   					}
		  		    	   			   }
		  		    	   	 ] ]
		    	   		});
	    	    	//接口记录
	    	    	}else if(title == '<s:text name="order.confirm.interfaceTitle">接口记录</s:text>'){
	    	    		salesInterfaceDatagrid = $('#interfaceDatagrid').datagrid({
	    	    			url : 'interfaceLogAction!combox.do',
	    	    			queryParams : {orderCode:orderCode},		
	    	    			iconCls : 'icon-save',
// 	    	    			pagination : true,
// 	    	    			pagePosition : 'bottom',
	    	    			rownumbers : true,
// 	    	    			pageSize : 10,
// 	    	    			pageList : [ 10, 20, 30, 40 ],
	    	    			fit : true,
	    	    			fitColumns : true,
	    	    			nowrap : true,
	    	    			border : false,
	    	    			columns : [ [ 
							   {field:'lastUpd',title:'<s:text name="global.lastUpd">调用时间</s:text>',align:'center',sortable:true,
									formatter:function(value,row,index){
										return dateFormatYMD(row.lastUpd);
									}
							   },
	    	    			   {field:'interfaceName',title:'<s:text name="global.interfaceName">接口名称</s:text>',align:'center',sortable:true,
	    	    					formatter:function(value,row,index){
	    	    						return row.interfaceName;
	    	    					}
	    	    				},				
	    	    			   {field:'interfaceFlag',title:'接口标识',align:'center',sortable:true,
	    	    					formatter:function(value,row,index){
	    	    						return row.interfaceFlag;
	    	    					}
	    	    				},				
	    	    			   {field:'interfaceMessage',title:'<s:text name="global.interfaceMessage">接口返回</s:text>',align:'center',sortable:true,
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

<div class="easyui-tabs" id="orderTabs" data-options="border:false,plain:true,fit:true">  
		<div id="tabOrderItem" title="订单明细"  class="part_zoc">
			<table id="itemDatagrid" ></table>
		</div>
		
		<div id="tabOrderCondition" title="条件记录" class="part_zoc">
			<table id="conditionDatagrid" ></table>
		</div>

		<div  title="接口记录" style="padding:10px" class="part_zoc">
			<table id="interfaceDatagrid" ></table>
		</div>
</div>