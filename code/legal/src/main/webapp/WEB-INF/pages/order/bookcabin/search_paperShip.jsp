<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<title>下货纸审核待办事项</title>
<script type="text/javascript">
var shipPaperGrid;
var searchForm;
$(function(){
	searchForm = $('#searchForm').form();
	shipPaperGrid = $('#shipPaperGrid').datagrid({
		url : '${dynamicURL}/bookorder/shipPaperAction!datagrid.do',
		fit : true,
		fitColumns : false,
		pagination:true,
		pageSize : 15,
		singleSelect : true,
		pageList : [ 15, 30, 45, 60, 75, 90 ],
		nowrap : true,
		border : false,
		rowStyler: function(index,row){
			if ( row.stockNotification != null ){
				return 'color : #9400D3;';
			}
		},
		onDblClickRow : function(index, row) {
		 	parent.window.HROS.window.createTemp({
		 	title:"订单执行确认-订舱号:"+row.bookCode,
		 	url:"${dynamicURL}/bookorder/shipPaperAction!goPaperCheck.do?rowId="+row.rowId+"&bookCode="+row.bookCode+"&showButtonFlag=1",
		 	width:800,height:400,isresize:false,isopenmax:true,isflash:false});
		},
		toolbar: [{
			iconCls: 'icon-save',
			text: '查看下货纸',
			handler: showShipPaper
 		},'-',{
 			iconCls: 'icon-save',
 			text: '查看订舱单',
 			handler: cabinPaper
 		},'-'],
		frozenColumns : [[
		   {field : 'ck',checkbox : true},
		   {field:'bookCode',title:'订舱号',width:120},	
		   {field:'belongOrder',title:'关联订单',width:80},	
		   {field:'bookAgentName',title:'订舱货代',width:100},				
		   {field:'shipPaperCode',title:'下货纸号',width:80}
		]],
		columns : [ [
		   {field:'shipperMan',title:'发货人',width:100},				
		   {field:'receiveMan',title:'收货人',width:100},				
		   {field:'notifyMan',title:'通知人',width:100},				
		   {field:'prePaid',title:'预付',width:60},				
		   {field:'arrivePaid',title:'到付',width:60},
  		   { field:'vessel',title:'船名 航次',width:100,formatter: function(value,row,index){
  			   return row.vessel + " " + row.voyno;
  		   }},  
  		   { field:'goodsCount',title:'件数',width:60,align:"right" },  
  		   { field:'goodsWeight',title:'重量',width:60,align:"right" },  
  		   { field:'goodsSize',title:'体积',width:60,align:"right" }, 				
		   {field:'shipSay',title:'箱型箱量',width:100},	
// 		   {field:'receivePlace',title:'收货地点',width:100},
		   {field:'shipUploadPort',title:'装货港',width:80},				
		   {field:'shipDownPort',title:'卸货港',width:80},				
// 		   {field:'shipSendPort',title:'发货港',width:100},
		   {field:'shipDestination',title:'目的地',width:80},	
		   {field:'station',title:'场站',width:100},				
		   {field:'bookShipDate',title:'船期',width:80,
				formatter:function(value,row,index){
					return dateFormatYMD(row.bookShipDate);
				}
			},				
		   {field:'endPortDate',title:'截港日期',width:80,
				formatter:function(value,row,index){
					return dateFormatYMD(row.endPortDate);
				}
			},				
		   {field:'endCustomDate',title:'截关日期',width:80,
				formatter:function(value,row,index){
					return dateFormatYMD(row.endCustomDate);
				}
			},				
		   {field:'upPackageDate',title:'放箱时间',width:80,
				formatter:function(value,row,index){
					return dateFormatYMD(row.upPackageDate);
				}
			},				
		   {field:'auditDate',title:'下货纸确认时间',width:80,
				formatter:function(value,row,index){
					return dateFormatYMD(row.auditDate);
				}
			},				
		   {field:'contactsMan',title:'联系人',width:80},				
		   {field:'contactsPhone',title:'联系电话',width:80},
		   {field : 'attachmentFile', title : '下货纸附件',width:80,
				formatter : function(value, row, index) {
					if(row.attachmentFile!=null){
						return "<a href='javascript:downloadFile("+row.attachmentFile+")'>下载</a>";
					}else{
						return "未上传";
					}
				}
		   }, 
    	   { field : 'stockNotification', title : '入货通知单',width:80,
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
	$('#searchForm').find("input").keydown(function(e){
		if(e.keyCode==13){
			search(); //处理事件
		}
	});

    $('[name="prodType"]').combobox({
    	url:'${dynamicURL}/basic/prodTypeAction!combox0.action',   
        valueField:'prodTypeCode',   
        textField:'prodType'
    });
	
})

function search(){
	shipPaperGrid.datagrid('load', sy.serializeObject(searchForm));
}
function clean(){
	searchForm.form('clear');
	shipPaperGrid.datagrid('load', {});
}
function downloadFile(fileId){
	window.location.href="${dynamicURL}/basic/fileUploadAction/downloadFile.do?fileId="+fileId;
	return false;
}
function showShipPaper(){
	if( shipPaperGrid.datagrid("getSelections").length == 0 ){
		$.messager.alert('提示','请选择要查看的订单!');
	}else{
		var row = shipPaperGrid.datagrid("getSelected");
	 	parent.window.HROS.window.createTemp({
		 	title:"订单执行确认-订舱号:"+row.bookCode,
		 	url:"${dynamicURL}/bookorder/shipPaperAction!goPaperCheck.do?rowId="+row.rowId+"&bookCode="+row.bookCode+"&showButtonFlag=1",
		 	width:800,height:400,isresize:false,isopenmax:true,isflash:false});
	}
// 	var params = "bookCode="+shipPaperGrid.datagrid("getSelected").bookCode;
// 	parent.window.HROS.window.createTemp({
// 		title:"订单订舱查看",
// 		url:"${dynamicURL}/bookorder/cabinAgentAction!showOrderCabin.do?" + params,
// 		width:800,height:400,isresize:false,isopenmax:true,isflash:false,customWindow : window});
}

function cabinPaper(){
	if( shipPaperGrid.datagrid("getSelections").length == 0 ){
		$.messager.alert('提示','请选择要查看的订舱!');
		return;
	}
    var params = "bookCode="+shipPaperGrid.datagrid("getSelected").bookCode;
	parent.window.HROS.window.createTemp({
		title:"订舱单查看",
		url:"${dynamicURL}/bookorder/cabinBookAction!cabinPaper.do?"+params,
		width:800,height:400,isresize:false,isopenmax:true,isflash:false,customWindow : window});
}
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">
		<div title="过滤条件" region="north" collapsed="true" style="height: 100px; overflow: hidden;">
			<form id="searchForm">
				<div class="oneline">
					<div class="item25">
						<div class="itemleft60">订舱编码：</div>
						<div class="righttext">
							<input name="bookCode" />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft60">关联订单：</div>
						<div class="righttext">
							<input name="belongOrder" />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft60">下货纸编码：</div>
						<div class="righttext">
							<input name="shipPaperCode" />
						</div>
					</div>
					<div class="item50">
						<div class="itemleft60">确认时间：</div>
						<div class="righttext">
							<input name="startDate" class="easyui-datebox" editable="false"/>
							<input name="endDate" class="easyui-datebox" editable="false"/>
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item25">
						<div class="itemleft60">产品组：</div>
						<div class="righttext">
							<input name="prodType" />
						</div>
					</div>
					<div class="item50">
						<div class="itemleft60">出运时间：</div>
						<div class="righttext">
							<input name="startShipDate" class="easyui-datebox" editable="false"/>
							<input name="endShipDate" class="easyui-datebox" editable="false"/>
						</div>
					</div>
					<div class="item25">
						<div class="oprationbutt">
							<input type="button" onclick="search()" value="过滤" /> 
							<input type="button" onclick="clean()" value="取消" />
						</div>
					</div>
				</div>
			</form>
		</div>
		<div region="center" border="false">
			<table id="shipPaperGrid"></table>
		</div>
	</div>
</body>
</html>