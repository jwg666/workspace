<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javascript" charset="utf-8">
    var cabinGrid;
    var searchForm;
    var expandIdx = -1;
	$(function() {
		//查询列表	
	    searchForm = $('#searchForm').form();
		cabinGrid = $("#cabinGrid").datagrid({
			fit : true,
			fitColumns : true,
			pagination:true,
			view: detailview,
			pageSize : 15,
			pageList : [ 15, 30, 45, 60, 75, 90 ],
			nowrap : true,
			border : false,
			rowStyler: function(index,row){
				if ( row.stockNotification != null ){
					return 'color : #9400D3;';
				}
			},
			onDblClickRow : function(index,row){
				var param = "bookCode=" + row.bookCode;
				parent.window.HROS.window.createTemp({
					title:"订舱信息查看",
					url:"${dynamicURL}/bookorder/cabinAgentAction!showOrderCabin.do?" + param,
					width:800,height:400,isresize:false,isopenmax:true,isflash:false,customWindow : window});
			} ,
			columns : [ [ 
			   {field:'ck',checkbox:true},
			   {field:'bookCode',title:'订舱编号',width:100},	
			   {field:'orderTransManager',title:'订舱经理',width:60},		
			   {field:'belongOrder',title:'关联订单',width:100},				
			   {field:'orderShipDate',title:'出运时间',width:80,formatter:function(value,row,index){
			    	return dateFormatYMD(row.orderShipDate);
			   }},				
			   {field:'orderCustomDate',title:'要求到货时间',width:90,formatter:function(value,row,index){
					return dateFormatYMD(row.orderCustomDate);
			   }},
			   {field:'countryName',title:'国家',width:80},
			   {field:'shipmentName',title:'出运方式',width:60},
			   {field:'portStartCode',title:'始发港',width:60},				
			   {field:'portEndCode',title:'目的港',width:150},				
			   {field:'goodsGrossWeight',title:'毛重',width:60},				
			   {field:'goodsMesurement',title:'体积',width:60},				
			   {field:'goodsShipPrice',title:'运费',width:60},		
	     	   { field : 'h20', title : '20C',width:27}, 
	     	   { field : 'h40', title : '40C',width:27}, 
	     	   { field : 'nh40', title : '40H',width:27}, 
	     	   { field : 'h45', title : '45C',width:27}, 				
			   {field:'stockNotification',title:'入货通知单',width:80,
				   formatter : function(value,row,index){
	     				if( row.stockNotification == null ){
	     					return "未上传";
	     				}else{
	     					return "<a href='javascript:downloadFile("+row.stockNotification+")'>下载</a>"
	     				}
				   }
			   }        
             ] ],
    		 onBeforeLoad : function(){
    			 expandIdx = -1;
    		 },
			 onCheck: function(index,row){
				 if( expandIdx != -1 ){
					 $('#ddv-'+expandIdx).datagrid("uncheckAll");
				 }
			 },
    		 detailFormatter : function(index,row){
    			 return '<div><table id="ddv-' + index + '"></table></div>';
    		 },
    		 onExpandRow: function(index,row){
    			 if(index != expandIdx){
        			 cabinGrid.datagrid('collapseRow',expandIdx);
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
    				 		cabinGrid.datagrid('fixDetailRowHeight',index);
    				 	 },0);
    				 },
    				 onCheck: function(index,row){
    					 cabinGrid.datagrid("uncheckAll");
    				 }
    			 });
    			 cabinGrid.datagrid('fixDetailRowHeight',index);
    		 },
             onLoadSuccess: function(data){
             	var view = $(this).data().datagrid.dc.view;
             	$(data.rows).each(function(i,obj){
             		if( obj.subCount <= 1 ){
             			view.find("[datagrid-row-index='"+i+"']").find('[field="_expander"]').find("span").removeClass();
             		}
             	});
             }
		});
		
		$('#tabs').tabs({  
	        border:false, 
	        fit : true,
	        onSelect:function(title,index){
        		cabinGrid.datagrid({data:[]});
	        	if( index == "0" ){
	        		cabinGrid.datagrid({
		            	pageNumber : 1,
	        			singleSelect : false,
	        			url : '${dynamicURL}/bookorder/hdconfirmAction!checkHdTask.do',
	                    toolbar : [ 
	                      { text : '接单', iconCls : 'icon-ok', handler : accept }, '-', 
	                      { text : '拒绝', iconCls : 'icon-cancel', handler : refuse }, '-',
	                      { text : '查看订舱单', iconCls : 'icon-save', handler : showCabinPaper },'-',
	                      { text : '查看订舱信息', iconCls : 'icon-save', handler : showCabin },'-'
	                    ]
	        		});
	        	}else if( index == "1" ){
	        		cabinGrid.datagrid({
		            	pageNumber : 1,
	        			singleSelect : true,
	        			url : '${dynamicURL}/bookorder/hdconfirmAction!histroyHdTask.do',
	                    toolbar : [ 
	                      { text : '查看订舱单', iconCls : 'icon-save', handler : showCabinPaper },'-',
	                      { text : '查看订舱信息', iconCls : 'icon-save', handler : showCabin },'-'
	                    ]
	        		});
	        	}
	        }  
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
		

		$('#searchForm').find("input").keydown(function(e){
			if(e.keyCode==13){
				_search(); //处理事件
			}
		});
	});
	
	function accept(){
		if( cabinGrid.datagrid('getSelections').length == 0 ){
			$.messager.alert('系统提示', '请选择一条或多条主订舱信息！');
			return ;
		}
		var params = "";
		$(cabinGrid.datagrid('getSelections')).each(function(i,row){
			params += "codes=" + row.bookCode + "&";
		});
		$.messager.progress({text:'系统处理中，请稍等...',interval:200});
		$.ajax({
			url : '${dynamicURL}/bookorder/hdconfirmAction!accept.do',
			data : params,
			dataType : 'json',
			type : "post",
			success : function(response) {
				$.messager.progress("close");
				cabinGrid.datagrid('load');
				cabinGrid.datagrid('unselectAll');
				top.window.showTaskCount();
			}
		});
	}
	
	function refuse(){
		if( cabinGrid.datagrid('getSelections').length == 0 ){
			$.messager.alert('系统提示', '请选择一条或多条主订舱信息！');
			return;
		}
		var params = "";
		var bssid = "";
		$(cabinGrid.datagrid('getSelections')).each(function(i,row){
			params += "codes=" + row.bookCode + "&";
			bssid += row.belongOrder+",";
		});
		WinRedo.callback = function(){
			$.messager.progress({text:'系统处理中，请稍等...',interval:200});
			$.ajax({
				url : '${dynamicURL}/bookorder/hdconfirmAction!refuse.do',
				data : params,
				dataType : 'json',
				type : "post",
				success : function(response) {
					$.messager.progress("close");
					cabinGrid.datagrid('load');
					cabinGrid.datagrid('unselectAll');
					top.window.showTaskCount();
		 		}
		 	});
		}
		WinRedo.openWin(bssid,"agentsConfirm","boonAgent");
	}

	function _search() {
		cabinGrid.datagrid('load', sy.serializeObject(searchForm));
	}
	
	function cleanSearch() {
		cabinGrid.datagrid('load', {});
		searchForm.find(".righttext").find('input').val('');
	}

	function showCabin(){
		if( cabinGrid.datagrid("getSelected") == null ){
			$.messager.alert('系统提示', '请选择一条主订舱信息！');
		}else{
			var bookCode = cabinGrid.datagrid("getSelected").bookCode;
			parent.window.HROS.window.createTemp({
				title:"订舱信息查看",
				url:"${dynamicURL}/bookorder/cabinAgentAction!showOrderCabin.do?bookCode=" + bookCode,
				width:800,height:400,isresize:false,isopenmax:true,isflash:false,customWindow : window});
		}
	}
	
	function showCabinPaper(){
		if( ( cabinGrid.datagrid("getSelected") == null && ( expandIdx != -1 && $('#ddv-'+expandIdx).datagrid("getSelected") == null ) ) || ( cabinGrid.datagrid("getSelected") == null && expandIdx == -1 )){
			$.messager.alert('系统提示', '请选择一条订舱记录！');
		}else{
	        var bookCode = cabinGrid.datagrid("getSelected") == null ? $('#ddv-'+expandIdx).datagrid("getSelected").bookCode : cabinGrid.datagrid("getSelected").bookCode;
			parent.window.HROS.window.createTemp({
				title:"订舱单查看",
				url:"${dynamicURL}/bookorder/cabinBookAction!cabinPaper.do?bookCode="+bookCode,
				width:800,height:400,isresize:false,isopenmax:true,isflash:false,customWindow : window});
		}
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

	function downloadFile(id){
		window.location.href = "${dynamicURL}/basic/fileUploadAction/downloadFile.do?fileId=" + id;
	}
</script>
</head>
<body>
     <div class="easyui-layout" data-options="fit:true"> 
        <div region="north" border="false" collapsed="false"  style="height: 29px;overflow: hidden;" align="left">
            <div id="tabs">  
                 <div title="货代确认待办"></div>
                 <div title="货代确认已办"></div>
            </div>
        </div>
        <div region="center" border="false"> 
            <div class="easyui-layout" data-options="fit:true">
                 <div region="north" border="true" title="过滤条件" collapsed="true"  style="height: 80px;overflow: hidden;" align="left">
                   <form id="searchForm">
				       <div class="oneline">
					       <div class="item25">
						       <div class="itemleft60">订舱编码:</div>
						       <div class="righttext">
							       <input name="bookCode" type="text" style="width:149px;"/>
						       </div>
					       </div>
					       <div class="item25">
						       <div class="itemleft60">关联订单:</div>
						       <div class="righttext">
							       <input name="belongOrder" type="text" style="width:149px;"/>
						       </div>
					       </div>
					       <div class="item25">
						       <div class="itemleft60">出运日期:</div>
						       <div class="righttext">
							       <input name="orderShipDate" class="easyui-datebox" editable="false"/>
						       </div>
					       </div>
					       <div class="item25">
						       <div class="itemleft60">目的港:</div>
						       <div class="righttext">
						           <input id="portEndCode" name="portEndCode"/>
						       </div>
					       </div>
					       <div class="item25">
						       <div class="itemleft60">订舱经理:</div>
						       <div class="righttext">
						           <input name="orderTransManager"/>
						       </div>
					       </div>
				       </div>
				       <div class="item100">
			               <div class="oprationbutt">
				               <input type="button" value="查  询" onclick="_search();"/>
				               <input type="button" value="重  置"  onclick="cleanSearch();"/>
			               </div>
		               </div>
		           </form>
	            </div>
	            <div region="center" border="false">
		            <table id="cabinGrid"></table>
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
</body>
</html>