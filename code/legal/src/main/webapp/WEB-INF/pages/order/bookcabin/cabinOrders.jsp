<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script src="${staticURL}/scripts/ajaxfileupload_.js"></script>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var params;
	var winPort,winPortGrid;
    var expandIdx = -1;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
	    
	    datagrid = $('#datagrid').datagrid({
			iconCls : 'icon-save',
			view: detailview,
			pagination : true,
			pagePosition : 'bottom',
			pageSize : 15,
			pageList : [ 15, 30, 45, 60, 75, 90 ],
			fit : true,
			fitColumns : true,
			nowrap : true,
			border : false,
			onCheck: function(index,row){
				if( expandIdx != -1 ){
					$('#ddv-'+expandIdx).datagrid("uncheckAll");
				}
			},
    		detailFormatter : function(index,row){
    			return '<div><table id="ddv-' + index + '"></table></div>';
    		},
    		onBeforeLoad : function(){
    			expandIdx = -1;
    		},
    		onExpandRow: function(index,row){
    			if(index != expandIdx){
    				datagrid.datagrid('collapseRow',expandIdx);
        			expandIdx = index;
    			}
    			 
    			$('#ddv-'+index).datagrid({
    				url:'${dynamicURL}/bookorder/hdconfirmAction!findSubCabinByBookCode.do?bookCode='+row.bookCode,
    				fitColumns:true,
    				border : false,
    				singleSelect : true,
    				height:'auto',
    				columns:[[
    				    {field:'ck',checkbox:true},
    					{field:'bookCode',title:'订舱子编码',width:155},		
    					{field:'belongOrder',title:'关联订单',width:130},	
    					{field:'goodsAmount',title:'数量',width:60,align:"right"},	
    					{field:'goodsCount',title:'件数',width:60,align:"right"},		
    					{field:'goodsGrossWeight',title:'毛重',width:60,align:"right"},		
    					{field:'goodsMesurement',title:'体积',width:60,align:"right"},
			     		{field : 'h20', title : '20C',width:27}, 
			     		{field : 'h40', title : '40C',width:27}, 
			     		{field : 'nh40', title : '40H',width:27}, 
			     		{field : 'h45', title : '45C',width:27}
     				]],
    				onLoadSuccess:function(){
    				 	setTimeout(function(){
    				 		datagrid.datagrid('fixDetailRowHeight',index);
    				 	},0);
    				},
    				onCheck: function(index,row){
    					datagrid.datagrid("uncheckAll");
    				}
    			});
    			datagrid.datagrid('fixDetailRowHeight',index);
    		}
		});
	   
	    $('#tabs').tabs({  
	        border:false, 
	        fit : true,
	        onSelect:function(title,index){
	        	datagrid.datagrid({data:[]});
	        	if( index == "0" ){
	        		$("#searchForm1").show();
	        		$("#searchForm2").hide();
	        		datagrid.datagrid({
		            	pageNumber : 1,
		            	singleSelect : false,
		            	url : '${dynamicURL}/salesOrder/salesOrderAction!datagridForCabin.do',
		            	columns : [ [ 
               		    	{ field:'ck',checkbox:true},
              		    	{ field : 'orderCode', title : '订单编号',width:100},
              		    	{ field : 'orderTypeName', title : '订单类型',width:80}, 
              		    	{ field : 'customerName', title : '客户名称',width:180},
		    				{ field : 'portStartName', title : '始发港',width:60}, 
		    				{ field : 'portEndName', title : '目的港',width:120}, 
		    				{ field : 'orderDealName', title : '成交方式',width:60},
		    				{ field : 'orderShipmentName', title : '运输方式',width:60}, 
	                       	{ field : 'countryname', title : '国家',width:100},
		    				{ field : 'vendorName', title : '运输公司',width:100}, 
		    				{ field : 'orderShipDate', title : '出运日期',width:80,
		    					formatter : function(value,row,index){
		    					    return value.substr(0,10);
		    				}}, 
				     		{ field : 'h20', title : '20C',width:27}, 
				     		{ field : 'h40', title : '40C',width:27}, 
				     		{ field : 'nh40', title : '40H',width:27}, 
				     		{ field : 'h45', title : '45H',width:27}
		    			] ],
		     			toolbar: [{
		     				iconCls: 'icon-save', text: '申请订舱', handler: toCabinBook },'-'
		     			],
        			    onLoadSuccess : function(data){
        			    	var view = $(this).data().datagrid.dc.view;
        	    			$(data.rows).each(function(i,obj){
        	    				if( obj.subCount <= 1 || obj.subCount == null ){
        	    					view.find("[datagrid-row-index='"+i+"']").find('[field="_expander"]').find("span").removeClass();
        	    				}
        	    			});
        			    }
		            });
	        	}else if( index == "1" ){
	        		$("#searchForm1").hide();
	        		$("#searchForm2").show();
	        		datagrid.datagrid({
		            	pageNumber : 1,
		            	singleSelect : true,
                        url : '${dynamicURL}/bookorder/cabinBookAction!datagridCabinHis.do',
             			columns : [ [ 
                           { field : 'ck', checkbox : true },
                           { field : 'bookCode', title : '订舱编号',width:100}, 
                           { field : 'belongOrder', title : '关联订单',width:80},
                           { field : 'customerName', title : '客户名称',width:180},
          		   		   { field : 'portStartName', title : '始发港',width:60} , 
        		   		   { field : 'portEndName', title : '目的港',width:120} , 
        		   		   { field : 'orderShipmentName', title : '运输方式',width:60} ,
        		   		   { field : 'orderShipment', hidden : true} ,
                       	   { field : 'countryName', title : '国家',width:100},
		   		     	   { field : 'created', title : '订舱时间',width:100,
		    					formatter : function(value,row,index){
		    					    return dateFormatYMD(value);
		    			   }},
		   		     	   { field : 'paymentMethod', title : '付款方式',width:80} ,
				     	   { field : 'h20', title : '20C',width:27}, 
				     	   { field : 'h40', title : '40C',width:27}, 
				     	   { field : 'nh40', title : '40H',width:27}, 
				     	   { field : 'h45', title : '45H',width:27},
		   		     	   { field : 'stockNotification', title : '入货通知单',width:60,
		   		     		   formatter : function(value,row,index){
		   		     			   if( row.stockNotification == null ){
		   		     				   return "未上传";
		   		     			   }else{
		   		     				   return "<a href='javascript:downloadFile("+row.stockNotification+")'>下载</a>"
		   		     			   }
		   				       }
		   				   }
		   		     	] ],
		     			toolbar: [
		     			   { iconCls: 'icon-save', text: '查看订舱信息', handler: showOrderCabin },'-',
		     			   { iconCls: 'icon-save', text: '箱单发票', handler: goPackingList },'-',
		     			   { iconCls: 'icon-save', text: '报关发票', handler: goDeclApply },'-',
		     			   { iconCls: 'icon-save', text: '查看订舱单', handler: cabinPaper },'-',
// 		     			   { iconCls: 'icon-save', text: '目的港变更', handler: winPortOpen },'-',
		     			   { iconCls: 'icon-save', text: '上传入货通知单', handler : uploadAdvoice },'-',
// 		     			   { iconCls: 'icon-save', text: '船公司变更', handler: winVendorOpen },'-',
		     			   { iconCls: 'icon-save', text: '订舱修改', handler: editCabin },'-',
		     			   { iconCls: 'icon-save', text: '删除订舱', handler: delBookCabin },'-'
        			    ],
        			    onLoadSuccess : function(data){
        			    	var view = $(this).data().datagrid.dc.view;
        	    			$(data.rows).each(function(i,obj){
        	    				if( obj.subCount <= 1 || obj.subCount == null ){
        	    					view.find("[datagrid-row-index='"+i+"']").find('[field="_expander"]').find("span").removeClass();
        	    				}
        	    			});
        			    }
		            });
	        	}else if( index == 2 ){
	        		$("#searchForm1").hide();
	        		$("#searchForm2").show();
	        		datagrid.datagrid({
		            	pageNumber : 1,
		            	singleSelect : true,
                        url : '${dynamicURL}/bookorder/cabinAgentAction!datagridCabinRedoTask.do',
             			columns : [ [ 
                           { field : 'ck', checkbox : true },
                           { field : 'bookCode', title : '订舱编号',width:100}, 
                           { field : 'belongOrder', title : '关联订单',width:80},
                           { field : 'customerName', title : '客户名称',width:180},
          		   		   { field : 'portStartName', title : '始发港',width:60} , 
        		   		   { field : 'portEndName', title : '目的港',width:120} , 
        		   		   { field : 'orderShipmentName', title : '运输方式',width:60} ,
        		   		   { field : 'orderShipment', hidden : true} ,
                       	   { field : 'countryName', title : '国家',width:100},
		   		     	   { field : 'created', title : '订舱时间',width:100,
		    					formatter : function(value,row,index){
		    					    return dateFormatYMD(value);
		    			   }},
		   		     	   { field : 'paymentMethod', title : '付款方式',width:80} ,
				     	   { field : 'h20', title : '20C',width:27}, 
				     	   { field : 'h40', title : '40C',width:27}, 
				     	   { field : 'nh40', title : '40H',width:27}, 
				     	   { field : 'h45', title : '45H',width:27},
		   		     	   { field : 'stockNotification', title : '入货通知单',width:60,
		   		     		   formatter : function(value,row,index){
		   		     			   if( row.stockNotification == null ){
		   		     				   return "未上传";
		   		     			   }else{
		   		     				   return "<a href='javascript:downloadFile("+row.stockNotification+")'>下载</a>"
		   		     			   }
		   				       }
		   				   }
		   		     	] ],
		     			toolbar: [
		     			   { iconCls: 'icon-save', text: '修改订舱', handler: editCabin },'-',
		     			   { iconCls: 'icon-save', text: '删除订舱', handler: delBookCabin },'-',
		     			   { iconCls: 'icon-save', text: '查看退回原因', handler: showRedo },'-',
// 		     			   { iconCls: 'icon-save', text: '目的港变更', handler: winPortOpen },'-',
// 		     			   { iconCls: 'icon-save', text: '船公司变更', handler: winVendorOpen },'-',
        			    ],
        			    onLoadSuccess : function(data){
        			    	var view = $(this).data().datagrid.dc.view;
        	    			$(data.rows).each(function(i,obj){
        	    				if( obj.subCount <= 1 || obj.subCount == null ){
        	    					view.find("[datagrid-row-index='"+i+"']").find('[field="_expander"]').find("span").removeClass();
        	    				}
        	    			});
        			    }
		            });
	        	}
	        }  
	    });  
	    
	    $('#orderType').combobox({  
            url:'${dynamicURL}/basic/sysLovAction!combox.do?itemType=0',
	        valueField:'itemCode',
	        textField:'itemNameCn',
	        editable:false,
	        panelHeight:140
	    }); 
	    $('#orderDealType').combobox({  
            url:'${dynamicURL}/basic/sysLovAction!combox.do?itemType=2',
	        valueField:'itemCode',
	        textField:'itemNameCn',
	        editable:false,
	        panelHeight:140
	    }); 
	    $('#orderShipment').combobox({  
            url:'${dynamicURL}/basic/sysLovAction!combox.do?itemType=7',
	        valueField:'itemCode',
	        textField:'itemNameCn',
	        editable:false,
	        panelHeight:90
	    }); 
		$('#portEndCode').combogrid({
		    url:'${dynamicURL}/basic/portAction!datagrid.action',
			idField:'portCode',  
		    textField:'englishName',
			panelWidth : 500,
			panelHeight : 240,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_PORTEND',
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			columns : [ [ {
				field : 'portCode',
				title : '目的港编码',
				width : 20
			},{
				field : 'englishName',
				title : '目的港名称',
				width : 20
			}  ] ]
		}); 

		//加载国家信息
		$('#country').combogrid({
			url:'${dynamicURL}/basic/countryAction!datagrid.do',
			textField : 'alias',
			idField : 'countryCode',
			panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_COUNTRY',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			columns : [ [ {
				field : 'countryCode',
				title : '国家编码',
				width : 20
			},{
				field : 'alias',
				title : '国家名称',
				width : 20
			}  ] ]
		});
		
		$('#paymentMethod').combobox({  
	            url:'${dynamicURL}/basic/sysLovAction!combox.do?itemType=1',
		        valueField:'itemCode',
		        textField:'itemNameCn',
		        editable:false,
		        panelHeight:140
		}); 

		$("#win_upload").dialog({
			title:'上传入货通知单',
			modal:true,
			width:180,
			height:90,
			closed : true
		});
		
		new AjaxUpload('uploadFile', {
		     action: '${dynamicURL}/basic/fileUploadAction/uplaodFile.do',
		     name:'upload',
		     data: {remarks:'appicon'},
		     responseType:'json',
			 onSubmit : function(file , ext){
	             //Allow only images. You should add security check on the server-side.
				 if (ext == null || /^(exe|bat)$/.test(ext)){
					 $.messager.alert("系统警告",'非法文件禁止上传！');
					 return false;				
				 }
				 $.messager.progress({text:'入货通知单上传中...',interval:200});
			 },
			 onComplete : function(file,data){
				 var bookCode = datagrid.datagrid("getSelected").bookCode;
				 $.ajax({
					 url : "${dynamicURL}/bookorder/cabinBookAction!updateStockNotification.do",
					 type : "post",
					 data : {
						 "bookCode" : bookCode,
						 "stockNotification" : data.obj.id
					 },success : function(){
						 $("#win_upload").dialog("close");
						 $.messager.progress("close");
						 $.messager.show({title : "系统提示",msg : "订舱入货通知单更新成功！"});
						 datagrid.datagrid("reload");
					 }
				 });
			}
	 	});
	});

	function _search(id) {
		datagrid.datagrid('load', sy.serializeObject($(id).form()));
	}
	function cleanSearch(id) {
		datagrid.datagrid('load', {});
		$(id).form().find(".righttext").find('input').val('');
	}
	
	function toCabinBook(){
		if( datagrid.datagrid("getSelections").length == 0 ){
			$.messager.alert('提示','请选择订单信息!');
			return;
		}
		$.messager.progress({text:'订舱信息初始化，订单数据校验中...',interval:200});
		params = "";
		$(datagrid.datagrid("getSelections")).each(function(i,row){
			params += 'codes=' + row.orderCode + "&";
		});
		
		$.ajax({
			url:"${dynamicURL}/bookorder/cabinBookAction!ordersMerge.do",
			data : params,
		    type:'post',
		    dataType:'json',
		    success:function(data){
		    	$.messager.progress("close");
		    	if(data.success){
		    		parent.window.HROS.window.createTemp({
		    			title:"订舱申请",
		    			url:"${dynamicURL}/bookorder/cabinBookAction!toCabinBook.do?"+params,
		    			width:800,height:400,isresize:false,isopenmax:true,isflash:false,customWindow : window});
		    	}else{
					$("body").append("<div id='winOrderMerge'><table id='orderMergeGrid'></table></div>");
					$("#orderMergeGrid").datagrid({
						fit : true,
						pagination : false,
						data : data.obj,
					    columns : [[
							 {field:'ORDER_CODE',title:'订单号',width:80 },
							 { field:'ORDER_TRANS_MANAGER_NAME',title:'出运经理',width:80,
								 styler : function(value,row,index){
									 return styler(value,data.obj[0].ORDER_TRANS_MANAGER_NAME);
							 }},
							 { field:'SALE_ORG_NAME',title:'销售组织',width:80,
								 styler : function(value,row,index){
									 return styler(value,data.obj[0].SALE_ORG_NAME);
							 }},
							 { field:'COUNTRY_NAME',title:'国家',width:80,
								 styler : function(value,row,index){
									 return styler(value,data.obj[0].COUNTRY_NAME);
							 }},
							 {field:'ORDER_SOLD_TO_NAME',title:'客户',width:150,
								 styler : function(value,row,index){
									 return styler(value,data.obj[0].ORDER_SOLD_TO_NAME);
							 }},
							 { field:'ORDER_SHIP_TO_NAME',title:'收货人',width:150,
								 styler : function(value,row,index){
									 return styler(value,data.obj[0].ORDER_SHIP_TO_NAME);
							 }},
							 { field:'PORT_START_NAME',title:'始发港',width:80,
								 styler : function(value,row,index){
									 return styler(value,data.obj[0].PORT_START_NAME);
							 }},
							 { field:'PORT_END_NAME',title:'目的港',width:120,
								 styler : function(value,row,index){
									 return styler(value,data.obj[0].PORT_END_NAME);
							 }},
							 { field:'ORDER_SHIP_DATE',title:'出运期',width:80,
								 styler : function(value,row,index){
									 return styler(value,data.obj[0].ORDER_SHIP_DATE);
							 }},
							 { field:'ORDER_SHIPMENT_NAME',title:'运输方式',width:80,
								 styler : function(value,row,index){
									 return styler(value,data.obj[0].ORDER_SHIPMENT_NAME);
							 }},
							 { field:'VENDOR_NAME',title:'运输公司',width:80,
								 styler : function(value,row,index){
									 return styler(value,data.obj[0].VENDOR_NAME);
							 }},
							 { field:'OPERATORS',title:'经营主体',width:150,
								 styler : function(value,row,index){
									 return styler(value,data.obj[0].OPERATORS);
							 }},
							 { field:'单证经理',title:'DOC_MANAGER_NAME',width:80,
								 styler : function(value,row,index){
									 return styler(value,data.obj[0].DOC_MANAGER_NAME);
							 }}
					    ]]
					});
					$("#winOrderMerge").dialog({
						title : '选中订单不能合并订舱',
						width : 500,
						height : 280,
						modal : true,
						closed : false
					});
		    	}
		    }
		});
	}
	function showOrderCabin(){
		if( datagrid.datagrid("getSelected") == null ){
			$.messager.alert('系统提示', '请选择一条主订舱信息！');
		}else{
			var bookCode = datagrid.datagrid("getSelected").bookCode;
			parent.window.HROS.window.createTemp({
				title:"订单订舱查看",
				url:"${dynamicURL}/bookorder/cabinAgentAction!showOrderCabin.do?bookCode=" + bookCode,
				width:800,height:400,isresize:false,isopenmax:true,isflash:false,customWindow : window});
		}
	}
	
	function cabinPaper(){
		if( ( datagrid.datagrid("getSelected") == null && ( expandIdx != -1 && $('#ddv-'+expandIdx).datagrid("getSelected") == null ) ) || ( datagrid.datagrid("getSelected") == null && expandIdx == -1 )){
			$.messager.alert('系统提示', '请选择一条订舱记录！');
		}else{
			var bookCode = datagrid.datagrid("getSelected") == null ? $('#ddv-'+expandIdx).datagrid("getSelected").bookCode : datagrid.datagrid("getSelected").bookCode;
			parent.window.HROS.window.createTemp({
				title:"订舱单查看",
				url:"${dynamicURL}/bookorder/cabinBookAction!cabinPaper.do?bookCode="+bookCode,
				width:800,height:400,isresize:false,isopenmax:true,isflash:false,customWindow : window});
		}
	}
	
	//刷新代办和已完成代办
	function reloaddata() {
		datagrid.datagrid('reload');
		top.window.showTaskCount();
	}
	
	//模糊查询目的港下拉列表
	function _PORTMY() {
		var _CCNCODE = $('#_PORTCODEINPUT').val();
		var _CCNTEMP = $('#_PORTINPUT').val();
		$('#portEndCode').combogrid({
			url : '${dynamicURL}/basic/portAction!datagrid.do?englishName=' + _CCNTEMP+'&portCode='+_CCNCODE
		});
	}
	//重置查询目的港信息输入框
	function _PORTMYCLEAN() {
		$('#_PORTCODEINPUT').val("");
		$('#_PORTINPUT').val("");
		$('#portEndCode').combogrid({
			url : '${dynamicURL}/basic/portAction!datagrid.do'
		});
	}
	
	//模糊查询国家下拉列表
	function searchCountry() {
		$('#country').combogrid({
			url: "${dynamicURL}/basic/countryAction!datagrid.do?name=" + $("#alias").val() + "&countryCode=" + $("#countryCode").val()
		});
	}
	//重置查询国家信息输入框
	function cleanCountry() {
		$("#alias").val("");
		$("#countryCode").val("");
		$('#country').combogrid({
			url: "${dynamicURL}/basic/countryAction!datagrid.do"
		});
	}
	
	function　goPackingList(){
		if( ( datagrid.datagrid("getSelected") == null && ( expandIdx != -1 && $('#ddv-'+expandIdx).datagrid("getSelected") == null ) ) || ( datagrid.datagrid("getSelected") == null && expandIdx == -1 )){
			$.messager.alert('系统提示', '请选择一条订舱记录！');
		}else{
			var bookCode = datagrid.datagrid("getSelected") == null ? $('#ddv-'+expandIdx).datagrid("getSelected").bookCode : datagrid.datagrid("getSelected").bookCode;
			parent.window.HROS.window.createTemp({
				title:"箱单发票",
				url:"${dynamicURL}/bookorder/packingListAction!goPackingListByBookOrder.do?bookCode="+bookCode,
				width:800,height:400,isresize:false,isopenmax:true,isflash:false,customWindow : window});
		}
	}
	
	function goDeclApply(){
		if( ( datagrid.datagrid("getSelected") == null && ( expandIdx != -1 && $('#ddv-'+expandIdx).datagrid("getSelected") == null ) ) || ( datagrid.datagrid("getSelected") == null && expandIdx == -1 )){
			$.messager.alert('系统提示', '请选择一条订舱记录！');
		}else{
			var bookCode = datagrid.datagrid("getSelected") == null ? $('#ddv-'+expandIdx).datagrid("getSelected").bookCode : datagrid.datagrid("getSelected").bookCode;
			parent.window.HROS.window.createTemp({
				title:"报关发票",
				url:"${dynamicURL}/custorder/custOrderAction!goCustInvoiceByBookOrder.do?bookCode="+bookCode,
				width:800,height:400,isresize:false,isopenmax:true,isflash:false,customWindow : window});
		}
	}
	
	function styler(value,defData){
		return value != defData ? {style:'background-color : #EEEE00'} : null;
	}
	
	function editCabin(){
		if( datagrid.datagrid("getSelected") == null ){
			$.messager.alert('系统提示', '请选择一条主订舱信息！');
		}else{
			var bookCode = datagrid.datagrid("getSelected").bookCode;
			$.messager.progress({text:'数据校验中，请稍等...',interval:200});
			$.ajax({
				url : "${dynamicURL}/bookorder/cabinBookAction!checkOrderAgent.do",
				type : "post",
				data : { "bookCode":bookCode},
				dataType : "json",
				success : function(data){
					$.messager.progress("close");
					if(data.success){
			    		parent.window.HROS.window.createTemp({
			    			title:"订舱修改",
			    			url:"${dynamicURL}/bookorder/cabinBookAction!toEditCabin.do?bookCode=" + bookCode,
			    			width:800,height:400,isresize:false,isopenmax:true,isflash:false,customWindow : window});
					}else{
						$.messager.alert('系统提示', '订舱已分配货代，不允许此操作!');
					}
				}
			});
		}
	}
	
	function delBookCabin(){
		if( datagrid.datagrid("getSelected") == null ){
			$.messager.alert('系统提示', '请选择一条主订舱信息！');
		}else{
			var bookCode = datagrid.datagrid("getSelected").bookCode;
			$.messager.progress({text:'系统处理中，请稍等...',interval:200});
			$.ajax({
				url : '${dynamicURL}/bookorder/cabinBookAction!delBookCabin.do',
				data : { "bookCode":bookCode},
				type : "post",
				dataType : "json",
				success : function(data){
					$.messager.progress("close");
					if( data.success ){
						$.messager.show({ title : "系统提示", msg : "订舱删除成功!" });
						datagrid.datagrid("reload");
					}else{
						$.messager.alert("系统提示","订舱已分配货代，不允许此操作!");
					}
				}
			});
		}
	}
	
	function downloadFile(id){
		window.location.href = "${dynamicURL}/basic/fileUploadAction/downloadFile.do?fileId=" + id;
	}
	
	function uploadAdvoice(){
		if( datagrid.datagrid("getSelected") == null ){
			$.messager.alert('系统提示', '请选择一条主订舱信息！');
		}else{
			var bookCode = datagrid.datagrid("getSelected").bookCode;
			$.messager.progress({text:'订舱信息校验中，请稍等...',interval:200});
			$.ajax({
				url : "${dynamicURL}/bookorder/cabinBookAction!checkOrderAgent.do",
				type : "post",
				data : { "bookCode":bookCode},
				dataType : "json",
				success : function(data){
					$.messager.progress("close");
					if(data.success){
						$("#win_upload").dialog("open");
					}else{
						$.messager.alert('系统提示', '订舱已分配货代，不允许此操作!');
					}
				}
			});
		}
	}
	
	function showRedo(){
		if( datagrid.datagrid("getSelected") == null ){
			$.messager.alert('系统提示', '请选择一条主订舱信息！');
		}else{
			var bookCode = datagrid.datagrid("getSelected").bookCode;
			$.ajax({
				url : '${dynamicURL}/workflow/transitionRecordAction!findByBookCode.do',
				data : { "bookCode" : bookCode },
				type : "post",
				dataType : "json",
				success : function(data){
					var content = "";
					$(data).each(function(idx,obj){
						content += (idx + 1) + "、从【" + obj.sourceName + "】退到【" + obj.destName + "】<br>";
						content += "&nbsp;&nbsp;&nbsp;原因：" + obj.comments+"<br>";
						content += "&nbsp;&nbsp;&nbsp;时间：" + obj.transitionTime + "<br>";
					});
					$("body").append("<div id='winShowRedo'></div>");
					$("#winShowRedo").dialog({
						title: '订舱订单回退记录',
						width: 400,
						height: 180,
						closed: false,
						modal: true,
						content : content,
						onClose : function(){
							$("#winShowRedo").panel("destory");
						}
					});
				}
			});
		}
	}
</script>
</head>
<body>
    <div class="easyui-layout" data-options="fit:true"> 
        <div region="north" border="false" collapsed="false"  style="height: 29px;overflow: hidden;" align="left">
            <div id="tabs">  
                 <div title="订舱申请待办"></div>
                 <div title="订舱申请已办"></div>
                 <div title="订舱申请退回"></div>
            </div>
        </div>
        <div region="center" border="false"> 
            <div class="easyui-layout" data-options="fit:true">
                 <div region="north" border="true" title="过滤条件" collapsed="true"  style="height: 110px;overflow: hidden;" align="left">
                   <form id="searchForm1">
				       <div class="oneline">
					       <div class="item25">
						       <div class="itemleft60">订单编号:</div>
						       <div class="righttext">
							       <input id="orderCode" name="orderCode" type="text" style="width:149px;"/>
						       </div>
					       </div>
					       <div class="item25">
						       <div class="itemleft60">订单类型:</div>
						       <div class="righttext">
							       <input id="orderType" name="orderType"  class="short50" />
						       </div>
					       </div>
					       <div class="item25">
						       <div class="itemleft60">成交方式:</div>
						       <div class="righttext">
						           <input id="orderDealType" name="orderDealType"/>
						       </div>
					       </div>
				           <div class="item25">
						       <div class="itemleft60">运输方式:</div>
						       <div class="righttext">
							       <input id="orderShipment" name="orderShipment" />
						       </div>
					       </div>
					       <div class="item25">
						       <div class="itemleft60">目 的 港:</div>
						       <div class="righttext">
							       <input id="portEndCode" name="portEndCode" type="text" />
						       </div>
					       </div>
				       </div>
				       <div class="oneline">
					       <div class="item25">
						       <div class="itemleft60">出运日期:</div>
						       <div class="righttext">
							       <input id="orderShipDate" name="orderShipDate" class="easyui-datebox" editable="false"/>
						       </div>
					       </div>
					       <div class="item25">
				               <div class="oprationbutt" >
					               <input type="button" value="查  询" onclick="_search('#searchForm1');"/>
					               <input type="button" value="重  置"  onclick="cleanSearch('#searchForm1');"/>
				               </div>
			               </div>
				       </div>
		           </form>
		           <form id="searchForm2">
		               <div class="oneline">
					       <div class="item25">
						       <div class="itemleft60">订舱编码:</div>
						       <div class="righttext">
							       <input id="bookCode" name="bookCode" type="text" style="width:149px;"/>
						       </div>
					       </div>
					       <div class="item25">
						       <div class="itemleft60">关联订单:</div>
						       <div class="righttext">
							       <input id="belongOrder" name="belongOrder" type="text" style="width:149px;"/>
						       </div>
					       </div>
					       <div class="item25">
						       <div class="itemleft60">付款方式:</div>
						       <div class="righttext">
							       <input id="paymentMethod" name="paymentMethod"  class="short50" />
						       </div>
					       </div>
					       <div class="item25">
						       <div class="itemleft60">国家:</div>
						       <div class="righttext">
							       <input id="country" name="countryName" />
						       </div>
					       </div>
				       </div>
				       <div class="oneline">
					       <div class="item25">
						       <div class="itemleft60">出运日期:</div>
						       <div class="righttext">
							       <input id="orderShipDate" name="bookShipDate" class="easyui-datebox" editable="false"/>
						       </div>
					       </div>
					       <div class="item25">
					           <div class="oprationbutt">
				                   <input type="button" value="查  询" onclick="_search('#searchForm2');"/>
				                   <input type="button" value="重  置"  onclick="cleanSearch('#searchForm2');"/>
			                   </div>
					       </div>
				       </div>
		           </form>
	            </div>
	            <div region="center" border="false">
		            <table id="datagrid"></table>
	            </div> 
            </div>
        </div>
     </div>
                

	<!-- 目的港下拉选信息 -->
	<div id="_PORTEND">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft100">目的港编号：</div>
				<div class="righttext">
					<input class="short50" id="_PORTCODEINPUT" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft100">目的港名称：</div>
				<div class="righttext">
					<input class="short50" id="_PORTINPUT" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询" onclick="_PORTMY()" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置" onclick="_PORTMYCLEAN()" />
				</div>
			</div>
		</div>
	</div>
	
	<!-- 国家下拉选 -->
	<div id="_COUNTRY">
		<div class="oneline">
		    <div class="item25">
				<div class="itemleft60">国家编号：</div>
				<div class="righttext">
					<input class="short50" id="countryCode" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">国家名：</div>
				<div class="righttext">
					<input class="short60" id="alias" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="searchCountry()" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="cleanCountry()" />
				</div>
			</div>
		</div>
	</div>
	<div id="win_upload">
		<div id="uploadFile" style="width: 160px; text-align: center; line-height: 45px;">点击选择文件</div>
	</div>
</body>
</html>