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
    	//订单明细datagrid
    	salesItemDatagrid =$('#itemDatagrid').datagrid({
 			url : '${dynamicURL}/salesOrder/salesOrderItemAction!orderItemDatagrid.do?',
 			queryParams : {orderCode:salesOrdeCode},
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			fit : true,
			//fitColumns : true,
 			pageSize:6,
			pageList:[6,12,18],
			nowrap : true,
			border : false,
			idField : 'orderItemLinecode',
			showFooter: true,
			columns : [ [ 
 			{field:'ck',checkbox:true,
 						formatter:function(value,row,index){
 							return row.orderItemLinecode;
 						}
 					},
 			   {field:'orderItemLinecode',title:'行项目号',align:'center',width:100,
 					formatter:function(value,row,index){
 						return row.orderItemLinecode;
 					}
 				},				
 			   {field:'prodTname',title:'产品大类',align:'center',width:100,
 					formatter:function(value,row,index){
 						return row.prodTname;
 					}
 				},				
 			   {field:'haierModel',title:'海尔型号',align:'center',width:100,
 					formatter:function(value,row,index){
 						return row.haierModel;
 					}
 				},				
 			   {field:'customerModel',title:'客户型号',align:'center',width:100,
 					formatter:function(value,row,index){
 						return row.customerModel;
 					}
 				},				
 			   {field:'affirmNum',title:'特技单号',align:'center',width:200,
 					formatter:function(value,row,index){
 						return row.affirmNum;
 					}
 				},				
 			   {field:'materialCode',title:'物料号',align:'center',width:100,
 					formatter:function(value,row,index){
 						return row.materialCode;
 					}
 				},				
 			   {field:'factoryName',title:'生产工厂',align:'center',width:300,
 					formatter:function(value,row,index){
 						return row.factoryName;
 					}
 				},				
 			   {field:'prodQuantity',title:'数量',align:'center',width:100,
 					formatter:function(value,row,index){
 						return row.prodQuantity;
 					},
				    editor:'numberbox'
 				},				
 			   {field:'price',title:'单价',align:'center',width:100,
 					formatter:function(value,row,index){
 						return row.price;
 					},
				    editor:{
  					    type:'numberbox',
  						options:{
  							precision:3
  						}
  	                }
 				},				
 			   {field:'amount',title:'金额',align:'center',width:100,
 					formatter:function(value,row,index){
 						return row.amount;
 					}
 				},
 				{field:'custPrice',title:'报关单价',align:'center',width:100,
 					formatter:function(value,row,index){
 						return row.custPrice;
 					},
				    editor:{
  					    type:'numberbox',
  						options:{
  							precision:3
  						}
  	                }
 				},
 				{field:'custAmount',title:'报关总额',align:'center',width:100,
 					formatter:function(value,row,index){
 						return row.custAmount;
 					}
 				},
 				{field:'fobPrice',title:'FOB单价',align:'center',width:100,
 					formatter:function(value,row,index){
 						return row.fobPrice;
 					},
				    editor:{
  					    type:'numberbox',
  						options:{
  							precision:3
  						}
  	                }
 				},
 				{field:'fobAmount',title:'FOB总额',align:'center',width:100,
 					formatter:function(value,row,index){
 						return row.fobAmount;
 					}
 				},
 				{field:'orderBrand',title:'品牌',align:'center',width:100,
 					formatter:function(value,row,index){
 						if(row.orderBrand == null || row.orderBrand == ""){
 							return "-";
 						}else{
 							return row.orderBrand;
 						}
 					}
 				},
 				{field:'typQua',title:'箱型箱量',align:'center',width:100,
 					formatter:function(value,row,index){
 						if(row.typQua == null || row.typQua == ""){
 							return "-";
 						}else{
 							return row.typQua;
 						}
 					}
 				},
 				{field:'specialCheck',title:'是否特殊检',align:'center',width:100,
 					formatter:function(value,row,index){
 						if(row.specialCheck == "0" || row.specialCheck == "" || row.specialCheck == null){
 							return "-";
 						}
 						if(row.specialCheck == "1"){
 							return "进行特殊检";
 						}
 					}
 				}
 			 ] ],
		     onLoadSuccess:function(){
		    	 tabData();
	    	 }
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
	    	    	if(title == '<s:text name="order.confirm.packageTitle">包装记录</s:text>') {
	    	    		    salesConditionDatagrid = $('#conditionDatagrid').datagrid({
		    	   			url : '${dynamicURL}/salesOrder/salesOrderConditonAction!combox.do',
		    	   			queryParams : {orderCode:orderCode},		
		    	   			iconCls : 'icon-save',
		    	   			rownumbers : true,
		    	   			fit : true,
		    	   			fitColumns : true,
		    	   			nowrap : true,
		    	   			border : false,
		    	   			singleSelect: true,
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
		  		    	   					},
		  		    						editor:{
		  		    							type:'numberbox',
		  		    							options:{
		  		    								precision:2
		  		    							}
		  		    	                    }
		  		    	   				},
		  		    	   			   {field:'conditionValue',title:'条件记录总额',align:'center',sortable:true,
		  		    	   					formatter:function(value,row,index){
		  		    	   						return row.conditionValue;
		  		    	   					},
		  		    						editor:{
		  		    							type:'numberbox',
		  		    							options:{
		  		    								precision:2
		  		    							}
		  		    	                    }
		  		    	   				},
		  		    	   			   {field:'currencyName',title:'币种',align:'center',sortable:true,
		  		    	   					formatter:function(value,row,index){
		  		    	   						return row.currencyName;
		  		    	   					}
		  		    	   			   }
		  		    	   	 ] ],
		  		    	   toolbar : [{
		  					   text : '填写',
		  					   iconCls : 'icon-edit',
		  					   handler : function(){
		  					   	   editData();
		  					   }
		  				   },'-',{
		  				       text : '保存',
		  	                   iconCls : 'icon-save',
		  	                   handler : function(){
		  	                       save();
		  	                   }
		  				   }]/* ,
		  				   //批量修改
		  				   onDblClickRow : function(rowIndex) {
		  					   var rows = salesConditionDatagrid.datagrid('getSelections');
		  					   if(rows[0].conditionCode == "ZF00" || rows[0].conditionCode == "ZF02" ||rows[0].conditionCode == "ZF04" || rows[0].conditionCode == "ZF06"){
		  						   if (lastIndex != rowIndex) {
			  					       $('#conditionDatagrid').datagrid('endEdit', lastIndex);
			  						   $('#conditionDatagrid').datagrid('beginEdit', rowIndex);
			  						   var editor_target = $('#conditionDatagrid').datagrid('getEditor',{index:rowIndex,field:'conditionValue'}).target;
			  						   editor_target.attr("disabled",true);
			  					    }
			  					   if ($('#conditionDatagrid').datagrid('getRows').length == 1) {
			  						   $('#conditionDatagrid').datagrid('beginEdit', rowIndex);
			  					   }
			  					   lastIndex = rowIndex;
		  					   }else if(rows[0].conditionCode == "ZK09" || rows[0].conditionCode == "ZF09"){
		  						   if (lastIndex != rowIndex) {
			  					       $('#conditionDatagrid').datagrid('endEdit', lastIndex);
			  						   $('#conditionDatagrid').datagrid('beginEdit', rowIndex);
			  						   var editor_target = $('#conditionDatagrid').datagrid('getEditor',{index:rowIndex,field:'conditionRate'}).target;
			  						   editor_target.attr("disabled",true);
			  					    }
			  					   if ($('#conditionDatagrid').datagrid('getRows').length == 1) {
			  						   $('#conditionDatagrid').datagrid('beginEdit', rowIndex);
			  					   }
			  					   lastIndex = rowIndex;
		  					   }
		  				    }  */
		    	   	    });
	    	    	//记录包装	    
	    	    	}else if(title == '<s:text name="order.confirm.interfaceTitle">包装记录</s:text>'){
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
	    	    			pageList : [ 6,12,18 ],
	    	    			fit : true,
	    	    			fitColumns : true,
	    	    			nowrap : true,
	    	    			border : false,
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
    //订单条件记录
    function tabData(){
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
    	//itemLineCode = $pageData.orderItemLinecode;
    	 $('#conditionDatagrid').datagrid({
	   			url : '${dynamicURL}/salesOrder/salesOrderConditonAction!datagrid.do',
	   			queryParams : {orderCode:salesOrdeCode},		
	   			iconCls : 'icon-save',
	   			fit : true,
	   			fitColumns : true,
	   			nowrap : true,
	   			border : false,
	   			singleSelect: true,
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
	    	   					},
	    						editor:{
	    							type:'numberbox',
	    							options:{
	    								precision:2
	    							}
	    	                    }
	    	   				},
	    	   			   {field:'conditionValue',title:'条件记录总额',align:'center',sortable:true,
	    	   					formatter:function(value,row,index){
	    	   						return row.conditionValue;
	    	   					},
	    						editor:{
	    							type:'numberbox',
	    							options:{
	    								precision:2
	    							}
	    	                    }
	    	   				},
	    	   			   {field:'currencyName',title:'币种',align:'center',sortable:true,
	    	   					formatter:function(value,row,index){
	    	   						return row.currencyName;
	    	   					}
	    	   			   }
	    	   	 ] ],
		    	 toolbar : [{
  					 text : '填写',
  					 iconCls : 'icon-edit',
  					 handler : function(){
  					   	editData();
  					 }
  				   },'-',{
  				      text : '保存',
  	                  iconCls : 'icon-save',
  	                  handler : function(){
  	                     save();
  	                  }
  				}]
	   	    });
    }
    //填写可编辑列的数据
	function editData(){
    	var rows = $('#conditionDatagrid').datagrid('getSelections');
		var editRow = $('#conditionDatagrid').datagrid('getRowIndex',rows[0]);
		if(rows.length != 0){
			if (lastIndex != editRow) {
				 if(rows[0].conditionCode == "ZF00" || rows[0].conditionCode == "ZF02" ||rows[0].conditionCode == "ZF04" || rows[0].conditionCode == "ZF06" ||rows[0].conditionCode == "ZF30"){
					   $('#conditionDatagrid').datagrid('endEdit', lastIndex);
					   $('#conditionDatagrid').datagrid('beginEdit', editRow);
					   var editor_target = $('#conditionDatagrid').datagrid('getEditor',{index:editRow,field:'conditionValue'}).target;
					   editor_target.attr("disabled",true);
					   lastIndex = editRow;
				  }else if(rows[0].conditionCode == "ZK09" || rows[0].conditionCode == "ZF09"){
					   $('#conditionDatagrid').datagrid('endEdit', lastIndex);
					   $('#conditionDatagrid').datagrid('beginEdit', editRow);
					   var editor_target = $('#conditionDatagrid').datagrid('getEditor',{index:editRow,field:'conditionRate'}).target;
					   editor_target.attr("disabled",true);
					   lastIndex = editRow;
				  }
			}
		}else{
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="order.confirm.writeDataInfo">请选择数据进行填写！</s:text>','info');
		}
		lastIndex = -1;
    }
    //保存数据
    function save(){
    	endEdit();
    	//判断物料明细tab是否有选中的数据 
    	var selectItems = $("#itemDatagrid").datagrid('getSelected');
 		//此时只是获取到列表第一个数据
    	var pageData = null;
    	//如果没有选中数据，则要默认第一个数据
 		if(null != selectItems) {
 			pageData = selectItems;
 		}else{
 			pageData = $("#itemDatagrid").datagrid('getRows')[0];
 		}
 		var itemLineCode = pageData.orderItemLinecode;
    	var orderCode = pageData.orderCode;
    	//获取填写的数据
    	var updated = $('#conditionDatagrid').datagrid('getChanges');
    	if(updated.length){
    		//格式化数组为json形式
        	var jsonStr = JSON.stringify(updated);
        	//获取船公司code
        	var vendorCode = $('#vendorCode').combobox('getValue');
        	//获取运输方式code
        	var shipment = $('#orderShipment').combobox('getValue');
        	//获取出运期
        	var orderShipDate = $('#orderShipDate').datebox('getValue');
        	//获取始发港code
        	var portStartCode = $('#portStartCode').combobox('getValue');
        	//获取目的港code
        	var portEndCode = $('#portEndCode').val();
        	//获取成交方式
	    	var orderDealType = $('#orderDealType').combogrid('getValue');
        	if(orderShipDate == "" || orderShipDate == null){
        		$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="order.confirm.shipdateNotNull">出运时间不能为空！</s:text>','info');
        	}else if(vendorCode == "" || vendorCode == null){
        		$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="order.confirm.selectVendor">请选择运输公司！</s:text>','info');
        	}else if(shipment == "" || shipment == null){
        		$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="order.confirm.selectShipment">请选择运输方式！</s:text>','info');
        	//假如成交方式不是FOB,海空联运不是FT03时存储数据	
        	}else if(orderShipment != 'FT03'){
        		$.messager.progress({
        			text : '<s:text name="the.data.load">数据加载中....</s:text>',
        			interval : 100
        		});
        		$.ajax({
            		url:'${dynamicURL}/salesOrder/salesOrderAction!updateOrderConditionData.do',
            		dataType:'json',
            		data:{
            			jsonStr : jsonStr,
            			orderCode : orderCode,
            			vendorCode : vendorCode,
            			orderShipDate : orderShipDate,
            			portStartCode : portStartCode,
            			portEndCode : portEndCode,
            			orderLineCode : itemLineCode,
            			orderShipment : shipment,
            			orderDealType : orderDealType
            		},
            		success:function(data){
            			$('#itemDatagrid').datagrid('reload');
            			lastIndex = -1;
            			$.messager.progress('close');
            		}
            	});
        	}
    	}else{
    		$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="order.confirm.NoDataChange">没有修改数据，请检查！</s:text>','info');
    	}
    	
    }
    //结束条件编辑方法
	function endEdit(){
	     var rowsSelect = $('#conditionDatagrid').datagrid('getRows');
	     for ( var i = 0; i < rowsSelect.length; i++) {
	         $('#conditionDatagrid').datagrid('endEdit', i);
	     }
	}
    //结束明细编辑方法
	function endItemEdit(){
	     var rowsSelect = $('#itemDatagrid').datagrid('getRows');
	     for ( var i = 0; i < rowsSelect.length; i++) {
	         $('#itemDatagrid').datagrid('endEdit', i);
	     }
	}
</script>

<div class="easyui-tabs" id="orderTabs" data-options="border:false,plain:true,fit:true">  
		<div id="tabOrderItem" title="订单明细"  class="part_zoc">
			<table id="itemDatagrid" ></table>
		</div>
		
		<div id="tabOrderCondition" title="条件记录" class="part_zoc">
			<table id="conditionDatagrid" ></table>
		</div>

		<div  title="包装记录" style="padding:10px" class="part_zoc">
			<table id="packageDatagrid" ></table>
		</div>
		
		<div  title="接口记录" style="padding:10px" class="part_zoc">
			<table id="interfaceDatagrid" ></table>
		</div>
</div>