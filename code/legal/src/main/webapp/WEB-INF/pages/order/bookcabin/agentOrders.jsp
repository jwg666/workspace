<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var searchForm;
	var datagrid;
	var win_vendor;
	var vendor_datagrid;
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
			rowStyler: function(index,row){
				if ( row.stockNotification != null ){
					return 'color : #9400D3;';
				}
			},
			onCheck: function(index,row){
				if( expandIdx != -1 ){
					$('#ddv-'+expandIdx).datagrid("uncheckAll");
				}
			},
    		onBeforeLoad : function(){
    			expandIdx = -1;
    		},
    		detailFormatter : function(index,row){
    			return '<div><table id="ddv-' + index + '"></table></div>';
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
    					{field:'bookCode',title:'订舱子编码',width:108},		
    					{field:'belongOrder',title:'关联订单',width:80},	
    					{field:'goodsAmount',title:'数量',width:60,align:"right"},	
    					{field:'goodsCount',title:'件数',width:60,align:"right"},		
    					{field:'goodsGrossWeight',title:'毛重',width:60,align:"right"},		
    					{field:'goodsMesurement',title:'体积',width:60,align:"right"},
			     		{ field : 'h20', title : '20C',width:27}, 
			     		{ field : 'h40', title : '40C',width:27}, 
			     		{ field : 'nh40', title : '40H',width:27}, 
			     		{ field : 'h45', title : '45C',width:27}
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
    		},
		    onLoadSuccess : function(data){
		    	var view = $(this).data().datagrid.dc.view;
    			$(data.rows).each(function(i,obj){
    				if( obj.subCount <= 1 || obj.subCount == null ){
    					view.find("[datagrid-row-index='"+i+"']").find('[field="_expander"]').find("span").removeClass();
    				}
    			});
		    }
		});

	    $('#tabs').tabs({  
	        border:false, 
	        fit : true,
	        onSelect:function(title,index){ 
 				datagrid.datagrid({data:[]});
	        	if( index == 0 ){
		            datagrid.datagrid({
		            	pageNumber : 1,
		            	singleSelect : false,
		            	url : '${dynamicURL}/bookorder/cabinAgentAction!datagrid.do',
		     			toolbar : [ 
		     			    { iconCls : 'icon-save',  text : '订舱分配',  handler : toCabinAgent },'-',
		     			    { iconCls : 'icon-redo',  text : '订舱退回',  handler : redoCabin },'-',
		     			    { iconCls: 'icon-save', text: '箱单发票', handler: goPackingList },'-',
		     			    { iconCls: 'icon-save', text: '报关发票', handler: goDeclApply },'-',
		     			    { iconCls: 'icon-save', text: '查看订舱单', handler: cabinPaper },'-' 
		     			],
		     			columns : [ [ 
     		 			    { field : 'ck', checkbox : true },
     		 			    { field : 'bookCode', title : '订舱编号',width:90}, 
     		 			    { field : 'belongOrder', title : '关联订单',width:80},
     		 			    { field : 'spZor', title : '整机订单号',width:80},
     		 			    { field : 'orderExecManager', title : '订单经理', width:60}, 
		     			    { field : 'countryName', title : '国家',width:80},
		     			 	{ field : 'created', title : '申请时间',width:80,formatter:function(value,row,index){
		    					return dateFormatYMD(row.created);
		    				}},
		     			    { field : 'bookShipDate', title : '申请船期',width:80,
		    					formatter : function(value,row,index){
		    					    return dateFormatYMD(value);
		    			    }},
		   		     		{ field : 'portStartName', title : '始发港',width:60},
				     		{ field : 'portEndName', title : '目的港',width:80},
				     		{ field : 'orderShipmentName', title : '运输方式',width:60},
				     		{ field : 'orderShipment', hidden : true},
				     		{ field : 'orderDealName', title : '成交方式',width:60},
		   		     		{ field : 'vendorName', title : '船公司',width:120},
				     		{ field : 'h20', title : '20C',width:27}, 
				     		{ field : 'h40', title : '40C',width:27}, 
				     		{ field : 'nh40', title : '40H',width:27}, 
				     		{ field : 'h45', title : '45C',width:27}, 
				     		{ field : 'stockNotification', title : '入货通知单',width:60,
				     			formatter : function(value,row,index){
				     				if( row.stockNotification == null ){
				     					return "未上传";
				     				}else{
				     					return "<a href='javascript:downloadFile("+row.stockNotification+")'>下载</a>"
				     				}
				     			}
				     		}
		   		     	] ]
		            });
	        	}else if( index == 1 ){
		            datagrid.datagrid({
		            	pageNumber : 1,
		            	singleSelect : true,
		            	url : '${dynamicURL}/bookorder/cabinAgentAction!datagridHis.do',
		     			toolbar : [ 
		     			    { iconCls : 'icon-redo', text : '货代变更', handler : turnCabinAgent },'-',
		     			    { iconCls : 'icon-save', text : '查看订舱信息', handler : showCabin },'-',
		     			    { iconCls: 'icon-save', text: '箱单发票', handler: goPackingList },'-',
		     			    { iconCls: 'icon-save', text: '报关发票', handler: goDeclApply },'-',
		     			    { iconCls: 'icon-save', text: '查看订舱单', handler: cabinPaper },'-' 
		     			],
		     			columns : [ [
   		 			        { field : 'ck', checkbox : true },
   		 			        { field : 'bookCode', title : '订舱编号',width:108}, 
   		 			        { field : 'belongOrder', title : '关联订单',width:80},
     		 			    { field : 'spZor', title : '整机订单号',width:80},
   		 			        { field : 'orderExecManager', title : '订单经理', width:60}, 
		     			    { field : 'countryName', title : '国家',width:80}, 
		     			    { field : 'created', title : '申请时间',width:80,
		    					formatter : function(value,row,index){
		    						return dateFormatYMD(value);
		    			    }},
		     			    { field : 'bookShipDate', title : '申请船期',width:80,
		    					formatter : function(value,row,index){
		    						return dateFormatYMD(value);
		    			    }},
		     			    { field : 'portStartName', title : '始发港',width:60},
		     			    { field : 'portEndName', title : '目的港',width:80},
		     			    { field : 'orderShipmentName', title : '运输方式',width:60},
				     		{ field : 'orderDealName', title : '成交方式',width:60},
		   		     		{ field : 'vendorName', title : '船公司',width:80},
		   		     	    { field : 'bookAgent', title : '货代公司',width:80}, 
				     		{ field : 'h20', title : '20C',width:27}, 
				     		{ field : 'h40', title : '40C',width:27}, 
				     		{ field : 'nh40', title : '40H',width:27}, 
				     		{ field : 'h45', title : '45C',width:27}, 
		     			    { field : 'agentConfirm', title : '货代确认',width:60},
		     			    { field : 'inputPager', title : '下货纸录入',width:60},
		     			    { field : 'pagerConfirm', title : '下货纸确认',width:60}, 
				     	    { field : 'stockNotification', title : '入货通知单',width:60,
				     			formatter : function(value,row,index){
				     				if( row.stockNotification == null ){
				     					return "未上传";
				     				}else{
				     					return "<a href='javascript:downloadFile("+row.stockNotification+")'>下载</a>"
				     				}
				     			}
				     	    }
		     		    ] ]
		            });
	        	}else if( index == 2 ){
	        		 datagrid.datagrid({
			            	pageNumber : 1,
			            	singleSelect : false,
			            	url : '${dynamicURL}/bookorder/cabinAgentAction!datagridCabinRedoTask.do',
			     			toolbar : [ 
			     			    { iconCls: 'icon-save', text: '查看订舱单', handler: cabinPaper },'-' 
			     			],
			     			columns : [ [ 
	     		 			    { field : 'ck', checkbox : true },
	     		 			    { field : 'bookCode', title : '订舱编号',width:90}, 
	     		 			    { field : 'belongOrder', title : '关联订单',width:80},
	     		 			    { field : 'spZor', title : '整机订单号',width:80},
	     		 			    { field : 'orderExecManager', title : '订单经理', width:60}, 
			     			    { field : 'countryName', title : '国家',width:80},
			     			 	{ field : 'created', title : '申请时间',width:80,formatter:function(value,row,index){
			    					return dateFormatYMD(row.created);
			    				}},
			     			    { field : 'bookShipDate', title : '申请船期',width:80,
			    					formatter : function(value,row,index){
			    					    return dateFormatYMD(value);
			    			    }},
			   		     		{ field : 'portStartName', title : '始发港',width:60},
					     		{ field : 'portEndName', title : '目的港',width:80},
					     		{ field : 'orderShipmentName', title : '运输方式',width:60},
					     		{ field : 'orderShipment', hidden : true},
					     		{ field : 'orderDealName', title : '成交方式',width:60},
			   		     		{ field : 'vendorName', title : '船公司',width:120},
					     		{ field : 'h20', title : '20C',width:27}, 
					     		{ field : 'h40', title : '40C',width:27}, 
					     		{ field : 'nh40', title : '40H',width:27}, 
					     		{ field : 'h45', title : '45C',width:27}, 
					     		{ field : 'stockNotification', title : '入货通知单',width:60,
					     			formatter : function(value,row,index){
					     				if( row.stockNotification == null ){
					     					return "未上传";
					     				}else{
					     					return "<a href='javascript:downloadFile("+row.stockNotification+")'>下载</a>"
					     				}
					     			}
					     		}
			   		     	] ]
			            });
	        	}
	        }
	    });  

		$('#vendorCode').combogrid({
			editable:false,
			tipPosition:'left',
			url:'${dynamicURL}/basic/vendorAction!datagrid.action?vendorType=0',
			idField:'vendorCode',  
			textField:'vendorNameCn',
			panelWidth : 500,
			panelHeight : 240,
			pagination : true,
			toolbar : '#vendorGrid',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			columns : [ [ {
				field : 'vendorCode',
				title : '船公司编码',
				width : 20
			},{
				field : 'vendorNameCn',
				title : '船公司名称',
				width : 20
			}  ] ]
		});
		
		win_vendor = $("#win_vendor").dialog({
			title:'请选择货代公司<font color="red">双击行选择货代</font>',
			modal:true,
			width:500,
			height:280,
			closed : true
		});
		vendor_datagrid = $('#agent').datagrid({
			url:'${dynamicURL}/basic/vendorAction!datagrid.action?vendorType=3',
			panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			toolbar : '#_VENDOR',
			singleSelect : true,
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			columns : [ [ 
			    { field : 'vendorCode', title : '货代公司编码', width : 20 },
			    { field : 'vendorNameCn', title : '货代公司名称', width : 20 }
			] ],
			onDblClickRow : checkVendor
		});

	    $('#paymentMethod').combobox({  
            url:'${dynamicURL}/basic/sysLovAction!combox.do?itemType=1',
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
		    textField:'portName',
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
				field : 'portName',
				title : '目的港名称',
				width : 20
			}  ] ]
		});

		$('#searchForm').find("input").keydown(function(e){
			if(e.keyCode==13){
				_search(); //处理事件
			}
		}); 
	});

	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.find(".righttext").find('input').val('');
	}
	
	function toCabinAgent() {
		if( datagrid.datagrid("getSelections").length == 0 ){
			$.messager.alert('提示','请选择一条或多条主舱信息!');
			return;
		}else if( datagrid.datagrid("getSelections").length == 1 ){
			var params = "bookCode=" + datagrid.datagrid("getSelected").bookCode;
			parent.window.HROS.window.createTemp({
				title:"订舱分配",
				url:"${dynamicURL}/bookorder/cabinAgentAction!toCabinAgent.do?" + params,
				width:800,height:400,isresize:false,isopenmax:true,isflash:false,customWindow : window});
		}else{
			var bookCodes = "";
			var orderShipment = "";
			$(datagrid.datagrid("getSelections")).each(function(i,row){
				bookCodes += "codes="+row.bookCode+"&";
				if( orderShipment == "" ){
					orderShipment = row.orderShipment;
				}else{
					if( orderShipment != row.orderShipment ){
						$.messager.alert("系统提示","所选订舱运输方式不一致，不允许此操作！");
						return;
					}
				}
			});
			$("body").append("<div id='win_cast'></div>");
			var win_cast = $("#win_cast").dialog({
				title: '货代快速分配',
				width: 480,
				height: 140,
				closed: false,
				cache: false,
				href: "${dynamicURL}/bookorder/cabinAgentAction!toShortCutPage.do?orderShipment=" + orderShipment,
				modal: true,
				onClose: function(){
					$(this).panel("destroy");
				},
				buttons:[{
					text:'Save',
					iconCls : 'icon-save',
					handler:function(){
						if($("#win_cast").find("form").form("validate")){
							var params = $("#win_cast").find("form").serialize();
							$.messager.progress({text:'系统处理中，请稍等...',interval:200});
							$.ajax({
								url : "${dynamicURL}/bookorder/cabinAgentAction!cabinAgent.do?" + bookCodes + "&" + params,
								type : 'post',
								data : {'transConfirm' : true},
								dataType : 'json',
								success : function(data){
									$.messager.progress("close");
									if(data.success){
										$.messager.show({ title:"系统提示",msg:"订舱货代分配成功！"});
										datagrid.datagrid("reload");
										top.window.showTaskCount();
									}else{
										$.messager.alert("系统提示","有订舱需补录入货通知单，暂不允许此操作！");
									}
								}
							});
							
							$("#win_cast").panel("destroy");
							
						}
					}
				}]
			});
		}
	}
	
	function redoCabin(){
		if( datagrid.datagrid("getSelections").length == 0 ){
			$.messager.alert('提示','请选择一条或多条主订舱信息!');
			return;
		}
		var params = "";
		var bssid = "";
		$(datagrid.datagrid("getSelections")).each(function(i,row){
			params += "codes="+row.bookCode+"&";
			bssid += row.belongOrder + ",";
		});
		
		WinRedo.callback = function(){
			$.ajax({
				url : "${dynamicURL}/bookorder/cabinAgentAction!cabinAgent.do",
				type : 'post',
				data : params + '&transConfirm=false',
				dataType : 'json',
				success : function(data){
					$.messager.progress("close");
					if(data.success){
						datagrid.datagrid("reload");
						top.window.showTaskCount();
					}else{
						$.messager.alert("系统提示","订舱需补录入伙通知单,不允许此操作!");
					}
				}
			});
		
		}

		WinRedo.openWin(bssid,"boonAgent","bookCabinConfirm");
	}
	
	function checkVendor(){
		var bookCodes = "";
		$(datagrid.datagrid("getSelections")).each(function(i,row){
			bookCodes += "codes="+row.bookCode+"&";
		});
		var vendorCode = vendor_datagrid.datagrid("getSelected").vendorCode;
		if( vendorCode != null ){
			$.messager.progress({text:'系统处理中，请稍等...',interval:200});
			$.ajax({
				url : "${dynamicURL}/bookorder/cabinAgentAction!updateAssignerByBookCode.do?" + bookCodes,
				type : 'post',
				data : {"vcode" : vendorCode,'transConfirm' : true},
				dataType : 'json',
				success : function(data){
					$.messager.progress("close");
					if(data.success){
						$.messager.show({ title:"系统提示",msg:"货代变更成功！"});
						datagrid.datagrid("reload");
						top.window.showTaskCount();
					}else{
						$.messager.alert("系统提示","货代已确认，不允许此操作！");
					}
				}
			});
			win_vendor.window("close");
		}else{
			$.messager.alert('提示','请选择货代公司!');
		}
		
	}
	
	function showCabin(){
		if( datagrid.datagrid("getSelected") == null ){
			$.messager.alert('提示','请选择一条或多条主订舱信息!');
			return;
		}else{
			var param = "bookCode=" + datagrid.datagrid("getSelected").bookCode;
			parent.window.HROS.window.createTemp({
				title:"订舱信息查看",
				url:"${dynamicURL}/bookorder/cabinAgentAction!showOrderCabin.do?" + param,
				width:800,height:400,isresize:false,isopenmax:true,isflash:false,customWindow : window});
		}
	}
	
	function turnCabinAgent(){
		if( datagrid.datagrid("getSelections").length  == 0 ){
			$.messager.alert('提示','请选择一条或多条主订舱信息!');
		}else{
			win_vendor.window("open");
		}
	}
	
	//刷新代办和已完成代办
	function reloaddata() {
		datagrid.datagrid('reload');
		top.window.showTaskCount();
	}	
	
	
	//模糊查询船公司下拉列表
	function _VENDORMY() {
		vendor_datagrid.datagrid("load",{
			vendorNameCn:$('#_VENDORNAME').val(),
			vendorCode:$('#_VENDORCODE').val()
		});
	}
	//重置查询船公司信息输入框
	function _VENDORMYCLEAN() {
		$('#_VENDORCODE').val("");
		$('#_VENDORNAME').val("");
		vendor_datagrid.datagrid("load",{});
	}
	
	

	//模糊查询船公司下拉列表
	function searchVendor() {
		var _CCNCODE = $('#code').val();
		var _CCNTEMP = $('#name').val();
		$('#vendorCode').combogrid({
			url : '${dynamicURL}/basic/vendorAction!datagrid.action?vendorType=0&vendorNameCn=' + _CCNTEMP+'&vendorCode='+_CCNCODE
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询船公司信息输入框
	function cleanVendor() {
		$('#code').val("");
		$('#name').val("");
		$('#vendorCode').combogrid({
			url : '${dynamicURL}/basic/vendorAction!datagrid.action?vendorType=0'
		});
	}
	
	function downloadFile(id){
		window.location.href = "${dynamicURL}/basic/fileUploadAction/downloadFile.do?fileId=" + id;
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
</script>
</head>
<body>
    <div class="easyui-layout" data-options="fit:true"> 
        <div region="north" border="false" collapsed="false"  style="height: 29px;overflow: hidden;" align="left">
            <div id="tabs">  
                 <div title="订舱分配待办"></div>
                 <div title="订舱分配已办"></div>
                 <div title="订舱分配退回"></div>
            </div>
        </div>
        <div region="center" border="false"> 
            <div class="easyui-layout" data-options="fit:true">
	           <div region="north" border="true" title="过滤条件" collapsed="true" style="height: 80px; overflow: hidden;" align="left">
                   <form id="searchForm">
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
						       <div class="itemleft60">运输方式:</div>
						       <div class="righttext">
							       <input id="orderShipment" name="orderShipmentName" />
						       </div>
					       </div>
					       <div class="item25">
						       <div class="itemleft60">出运日期:</div>
						       <div class="righttext">
							       <input id="orderShipDate" name="bookShipDate" class="easyui-datebox" editable="false"/>
						       </div>
					       </div>
				       </div>
				       <div class="oneline">
					       <div class="item25">
						       <div class="itemleft60">船 公 司:</div>
						       <div class="righttext">
							       <input id="vendorCode" name="vendorCode" />
						       </div>
					       </div>
				       	   <div class="item33">
				               <div class="oprationbutt">
				                   <input type="button" value="查  询" onclick="_search();"/>
				                   <input type="button" value="重  置"  onclick="cleanSearch();"/>
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
	
	<div id="win_vendor" >
	    <table id="agent"></table>
	</div>
	
	 <!-- 船公司下拉选信息 -->
	<div id="_VENDOR">
		<div class="oneline">
		     <div class="item25">
				<div class="itemleft100">货代公司编号：</div>
				<div class="righttext">
					<input class="short50" id="_VENDORCODE" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft100">货代公司名称：</div>
				<div class="righttext">
					<input class="short50" id="_VENDORNAME" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询" onclick="_VENDORMY()" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置" onclick="_VENDORMYCLEAN()" />
				</div>
			</div>
		</div>
	</div>
	
	
	
	<!-- 船公司下拉选信息 -->
	<div id="vendorGrid">
		<div class="oneline">
		     <div class="item25">
				<div class="itemleft100">船公司编号：</div>
				<div class="righttext">
					<input class="short50" id="code" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft100">船公司名称：</div>
				<div class="righttext">
					<input class="short50" id="name" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询" onclick="searchVendor()" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置" onclick="cleanVendor()" />
				</div>
			</div>
		</div>
	</div>
</body>
</html>