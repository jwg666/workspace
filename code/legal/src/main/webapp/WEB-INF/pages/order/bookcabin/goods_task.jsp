<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>下货纸录入</title>
<jsp:include page="/common/common_js.jsp" />
<style type="text/css" >
		/* start 订单纸 */
		.order-form { text-align:left;}
		.order-form .main-order-form { font-family:arial; color:#333; /* background:#f5f5f5; */ }
		.order-form .main-order-form h1 { padding:10px 0; font-family:arial,微软雅黑; font-size:18px; font-weight:bold; background:#fff;}
		.order-form .main-order-form table { border-collapse:collapse;}
		.order-form .main-order-form table.table-p1 { margin-bottom:20px;}
		.order-form .main-order-form table.table-p1 td { line-height:16px; border: 1px solid #B5B6B7;}
		.order-form .main-order-form table.table-p1 td.t-title { padding:3px 5px 3px 10px; font-size:14px; font-weight:bold; color:#FFFF; background:#DBDBDB;}
		.order-form .main-order-form table.table-p1 td.t-content { padding:5px 5px 5px 5px; font-size:12px;font-weight:bold;background:#fff;}
		.order-form .main-order-form table.table-p1 td.bignumber { font-size:14px;}
		.order-form .main-order-form table.table-p1 td.wrap-tablehead { background:#f2f2f2;}
		table.tablehead { margin-top:-1px; margin-right:-1px;text-align:left; background:#fff;}
		textarea{width: 90%;height: 55px}
		input[readonly='readonly'],textarea[readonly='readonly']{
			background-color: rgb(235,235,228);
			border-width: 1px;
			border-color: #D3D3D3;
		}
		/* end 订单纸 */
</style>
<script type="text/javascript">
//form表单
var enterGoodsForm ;
//订舱明细 datagrid
var datagrid_bookOrderItem;
var uploadFileDialog;//上传附件Dialog
//行编辑标记
var editIndex = undefined;
$(function() {
	//时间校验框
	$.extend($.fn.validatebox.defaults.rules, {
        dateFmWithCompare: {
        	validator: function(value,param){
        		checkShipDate(value);
        		///^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)\s+([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9]$/
        		return /^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)$/.test(value);
        	},
        	message: ( '{0}'== null || {}) ? '日期格式不符 yyyy-MM-dd': '{0}'
        },
        dateFmWithoutTime: {
        	validator: function(value,param){
        		///^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)\s+([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9]$/
        		return /^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)$/.test(value);
        	},
        	message: ( '{0}'== null || {}) ? '日期格式不符 yyyy-MM-dd': '{0}'
        }
    });
	// 订舱明细
	datagrid_bookOrderItem= $('#datagrid_bookOrderItem').datagrid({
		url : 'shipPaperItemAction!findPaperItem.do?bookCode=${bookCode}', 
		iconCls : 'icon-save',
		pagePosition : 'bottom',
		pageSize : 10,
		pageList : [ 10, 20, 30, 40 ],
		fit : true,
		fitColumns : true,
		nowrap : true,
		border : false,
		idField : 'bookItemCode',
		onClickRow:onClickRow,
		showFooter:true,
		loadFilter: function(data){
			if (data.footer){
				data.footer[0].orderCode = "<a href='javascript:void(0)' style='text-decoration:underline;' onclick='endEditing()'>结束编辑</a>";
			}
			return data;
		},
		columns : [ [ 
		 	{field:'rowId',title:'xx',width:80,hidden:true},
		    {field:'orderCode',title:'订单号',align:'center', width:100},
		    {field:'haierModel',title:'海尔型号',align:'center', width:100},
			{field:'goodsMark',title:'唛头',align:'center',width:100,editor:'text'},
			{field:'goodsCount',title:'件数',align:'center',width:100,editor:'text'},	
		    {field:'goodsPacageName',title:'货描',align:'center',width:100,editor:'text'},	
		   			
		    {field:'goodsGrossWeight',title:'毛重(KG)',align:'center',width:100, 
			   editor:{
				   type:'numberbox',
				   options:{precision:3}
		    }},				
		    {field:'goodsSize',title:'体积(M³)',align:'center',sortable:false,width:100,
				editor:{
					type:'numberbox',
					options:{precision:3}
		    }}							
		 ] ],
         onLoadSuccess:function(data){
        	 if(data && data.rows){
        		 var orderList = [];
                 for(var i=0,l=data.rows.length;i<l;i++){
                     orderList.push(data.rows[i].orderCode);
                 }
                 loadRelativeInfo(orderList.join(","));
             }
         }
	});
	
	//初始化form 表单
	enterGoodsForm = $('#enterGoodsForm').form({
		url : '${dynamicURL}/bookorder/shipPaperAction!saveOrUpdate.do',
		success:function(data) {
			$.messager.progress("close");
			$.messager.show({ title : '提示', msg : '保存成功！' });
			closeCur();
		}
	});
	
	//预订单
	$("#shipDestination").on("change",function(){
		var old = $("#shipDestinationOld").val();
		if(old!=""){
			if($(this).val()!=old){
				$(this).css({background:"red"})
			}else{
				$(this).css({background:"none"})
			}
		}
	});
	
 	$.messager.progress({ text : '数据加载中....', interval : 100 });
	$.ajax({
 		url : '${dynamicURL}/bookorder/shipPaperAction!getByBookCode.do',
 		data : { "bookCode" : "${bookCode}"}, 
 		dataType : 'json',
 		success : function(response) {
 			$.messager.progress('close');
 			//加载历史记录
 			if(response.rowId && response.rowId.length>0){
	 			$.ajax({
	 		 		url : '${dynamicURL}/bookorder/shipPaperAction!selectListShipPaperBak.do',
	 		 		data : { "rowId":response.rowId }, 
	 		 		dataType : 'json',
	 		 		success : function(list) {
	 		 			if(list!=null && list.length>0){
	 		 				$("#historyRecord a").text("查看下货纸历史记录("+list.length+")");
	 		 				$("#historyRecord a").attr("rowId",list[0].rowId);
	 		 			}
	 		 		}
	 		 	});
 			}
	        $("#enterGoodsForm").form('clear');
			$("#enterGoodsForm").form('load', response);
			if(response.attachmentFile!=null){
				$("#attachmentFileName").html("<a href='${dynamicURL}/basic/fileUploadAction/downloadFile.do?fileId="+response.attachmentFile+"'>下载</a>");
			}
			$("td.orderExecremark textarea")
			if(response.orderExecremark!=null && response.orderExecremark!=""){
			    $("td.orderExecremark").show()
				$("#oprationbuttDiv").attr("colspan","7");
			}
 		}
 	});
	
	$("[name='shipperMan'],[name='receiveMan']").validatebox({ 
    	required: true,
		validType: 'length[0,255]'  
	});
	$("[name='notifyMan']").validatebox({ 
    	required: true,
		validType: 'length[0,400]'  
	});
	
});



function endEditing(){  
    if (editIndex == undefined){return true}  
    if ($('#datagrid_bookOrderItem').datagrid('validateRow', editIndex)){  
        $('#datagrid_bookOrderItem').datagrid('endEdit', editIndex);  
        editIndex = undefined;  
        var rows = $('#datagrid_bookOrderItem').datagrid('getRows');
        var goodsCount=0;
        var goodsGrossWeight=0;
        var goodsMesurement=0;
        if(rows.length > 0){
        	for ( var i = 0; i < rows.length; i++) {
        		goodsCount=goodsCount+Number(rows[i].goodsCount);
        		goodsGrossWeight=goodsGrossWeight+Number(rows[i].goodsGrossWeight);
        		goodsMesurement=goodsMesurement+Number(rows[i].goodsMesurement);
    		}
        }
        $('#datagrid_bookOrderItem').datagrid('reloadFooter',
        		[{orderCode:"<a href='javascript:void(0)' style='text-decoration:underline;' onclick='endEditing()'>结束编辑</a>",goodsCount: goodsCount, goodsGrossWeight: goodsGrossWeight,goodsMesurement:goodsMesurement}]);
        return true;  
    } else {  
        return false;  
    }  
}  
function onClickRow(index){  
    if (editIndex != index){  
        if (endEditing()){  
            $('#datagrid_bookOrderItem').datagrid('selectRow', index)  
                    .datagrid('beginEdit', index);  
            editIndex = index;  
            $('#datagrid_bookOrderItem').datagrid('unselectAll');
        } else {  
            $('#datagrid_bookOrderItem').datagrid('selectRow', editIndex);        
        }  
    }  
}  

//上传信用证副本
function uploadCredit(){
	//var uploadFileId=$("#order_managerConf_div").find("input[name='uploadFileId']").val();
	var uploadFileId=$("#attachmentFile").val();
	if(uploadFileId!=null&&uploadFileId!=''){
		$.messager.confirm('请确认', '附件已经上传，您确定要上传新的附件？', function(r) {
			if (r) {
				openUploadFileDialog();
			}
		});
	}else{
		openUploadFileDialog();
	}
}
function openUploadFileDialog(){
	var upLoadFileForm;
	uploadFileDialog = $('#uploadFileDialog').show().dialog({
    	title : '上传附件',
    	modal : true,
    	closed : true,
    	collapsible : true,
    	buttons : [{
    		text : '上传',
    		handler : function() {
				 var fileName = $("#FileTemplet").val();
				if ('' === fileName || null == fileName) {
					$.messager.alert('提示','请选择文件','info');
					return;
				} else {
					upLoadFileForm.submit();
				}
			}
    	}]
    });
	upLoadFileForm = $('#upLoadFileForm').form({
		url:'${dynamicURL}/basic/fileUploadAction/uplaodFile.do',
		success:function(data) {
			var json = $.parseJSON(data);
			var obj = json.obj;
			if (json && json.success) {
				var fileId=obj.id;
				//$("#order_managerConf_div").find("input[name='uploadFileId']").val(fileId);
				$("#attachmentFile").val(fileId);
				$("#attachmentFileName").text(obj.fileName);
				//var lcNum=$("#order_basic_div").find("input[name='lcNum']").val();
				$.messager.progress('close');
            	$.messager.show({
					title : '成功',
					msg : '上传成功'
				});
            	uploadFileDialog.dialog('close');
			} else {
				$.messager.progress('close');
				$.messager.show({
					title : '失败',
					msg : '上传失败'
				});
			}
		}
	});
	uploadFileDialog.dialog('open');
}
function checkShipDate(val){
	var bookShipDate = $("#orderBookShipDate").val();
	if(bookShipDate!=''){
		if(val!=bookShipDate){
			$("#bookShipDate").css({color:"red"}).attr("title","与订单出运期日期不一致！");
		}else{
			$("#bookShipDate").css({color:"rgb(0, 0, 0)"}).attr("title","");;
		}
	}
}


//整机加载样机订舱下货纸信息 样机加载整机订舱下货纸信息
function loadRelativeInfo(orderCodes){
  $.ajax({
      url : '${dynamicURL}/bookorder/shipPaperAction!findAttachOrOrderPaperInfo.action',
      data : {
          orderCodes:orderCodes
      },
      dataType : 'json',
      success : function(data) {
          if(data.success && data.obj){
              var show = false;
              var trs = ""
              for(var i=0,l=data.obj.length;i<l;i++){
                  var map =data.obj[i];
                  trs = trs + "<tr><td>"+(map.ORDERCODE!=null?map.ORDERCODE:"")+"</td><td>"
                     +(map.ATTACHCODE!=null?map.ATTACHCODE:"")
                     +"</td><td><a href='javascript:void(0)' onclick='openBookInfo(this)'>"+(map.BOOKCODE!=null?map.BOOKCODE:"")
                     +"</a></td><td><a href='javascript:void(0)' onclick='openPaperInfo(this)'>"+(map.SHIPPAPERID!=null?map.SHIPPAPERID:"")
                     +"</a></td><td>"+(map.GOODSCOUNT!=null?map.GOODSCOUNT:"")
                     +"</td><td>"+(map.GOODSGROSSWEIGHT!=null?map.GOODSGROSSWEIGHT:"")
                     +"</td><td>"+(map.GOODSSIZE!=null?map.GOODSSIZE:"")
                     +"</td></tr>";
                  if(map.BOOKCODE){
                      show = true;
                  }
              }
              $("#attachInfo").append(trs);
              if(show){
                  $("#attachInfo").show();
              }
          }
      }
 })
}
function openBookInfo(it){
	var bookCode = $(it).text();
	if(bookCode && $.trim(bookCode).length>0){
	    var app = {"appid":"bookCode-"+$.trim(bookCode),"folderId":0,"height":400,"icon":"917","isflash":0,"isopenmax":1,"isresize":1,"issetbar":1,"type":"app","url":"","width":900};
	    var  name = "订舱信息-订舱号："+$.trim(bookCode);
	    var url = "${dynamicURL}/bookorder/cabinAgentAction!showOrderCabin.do?bookCode="+$.trim(bookCode);
	    app = $.extend(app,{title:name,url:url});
	    parent.HROS.window.createTemp(app);
	}
}
function openPaperInfo(it){
	var bookCode = $(it).parent().prev().text();
    if(bookCode && $.trim(bookCode).length>0){
        var app = {"appid":"bookCode-"+$.trim(bookCode),"folderId":0,"height":400,"icon":"917","isflash":0,"isopenmax":1,"isresize":1,"issetbar":1,"type":"app","url":"","width":900};
        var  name = "下货纸信息-订舱号："+$.trim(bookCode);
        var url = "${dynamicURL}/bookorder/shipPaperAction!goPaperCheck.do?showButtonFlag=2&bookCode="+$.trim(bookCode);
        app = $.extend(app,{title:name,url:url});
        parent.HROS.window.createTemp(app);
    }
}
function printPreview(){
	$("textarea").each(function(){
		$(this).text($(this).val());
	});
	var printBody = $("body").clone();
	printBody = gridToTable(printBody);
	printBody.find(".printTable").width("100%");
	printBody.find("#datagridTr").height("auto");
	printBody.find("textarea").css("border",'none');
	printBody.find("textarea").each(function(){
        var div = $("<div></div>")
        div.text($(this).val());
        $(this).parent().html(div.html());
    });
	printBody.find("#oprationbuttDiv").remove();
	printBody.find("div.main").width(1080);
	
	lodopPrintFullWidth(printBody);
}

function viewHistory(it){
	var rowId = $(it).attr("rowId");
	var app = {"appid":"shippaperhistory-"+rowId,"folderId":0,"height":400,"icon":"917","isflash":0,"isopenmax":1,"isresize":1,"issetbar":1,"type":"app","url":"","width":900};
	var  name = "查看下货纸历史记录-订舱号："+$("#bookCode").val();
	var url = "${dynamicURL}/bookorder/shipPaperAction!showShipPaperBak?rowId="+rowId;
	app = $.extend(app,{title:name,url:url});
	//app.imgsrc = HROS.CONFIG.downloadImage+app['icon'];
	parent.HROS.window.createTemp(app);
}

function save(){
	  endEditing();
	  var updateRows = datagrid_bookOrderItem.datagrid("getRows");
	  var jsonStr = JSON.stringify(updateRows);
	  $("#paperItem").val(jsonStr);
	  if(enterGoodsForm.form('validate')){
		  $.messager.progress({text:'系统处理中，请稍等...',interval:200});
		  enterGoodsForm.submit();
	  }
}

function closeCur(){
	window.parent.HROS.window.close(currentappid);
	customWindow.refreshTask();
}
</script>
</head>

<!-- 单价字段空着  暂不确定   箱号那列要做成一个可编辑的datagrid  数据查询的是订舱明细表ACT_BOOK_ORDER_ITEM 数据要保存的下货纸明细表 ACT_SHIP_PAPER_ITEM -->
<body>
	<div class="main" style="min-width: 1030px">
	  <div style="border:solid 1px #666;padding:10px;margin:2px;background:#fff;"> 
	    <form id="enterGoodsForm" method="post">
		<s:hidden name="bookCode" id="bookCode"/>
		<s:hidden name="rowId" id="rowId"/>
		<s:hidden name="paperItem" id="paperItem" />
		<s:hidden name="subCount"/>
	    <!--start 表单-->
	    <div class="order-form">
	      <div class="main-order-form">
	        <h1 style="width:200px;display:inline-block;">下货纸信息</h1> <span style="float: right;" id="historyRecord"><a href="javascript:void(0)" onclick='viewHistory(this)'></a></span>
	        <table style="width:100%;border:0;cellpadding:0;cellspacing:0" class="table-p1" >
	          <tr>
	            <td colspan="2" class="t-title">shipper(发货人)</td>
	            <td rowspan="10" colspan="2" align="left" valign="top" class="wrap-tablehead">
	            	<table style="width:99%;border:0;cellspacing:0;cellpadding:0;display: inline-table;margin-left: 2px;"  class="tablehead" >
	                <tr>
	                  <td colspan="4" class="t-title">D/R No.(编号) </td>
	                </tr>
	                <tr>
	                  <td colspan="4" class="t-content bignumber">
	                     <textarea name="shipPaperCode" rows="3" cols="50" style="resize:none;" class="easyui-validatebox" data-options="validType:'length[0,36]'" required="required"></textarea>
	                  </td>
	                </tr>
	                <tr>
	                  <td class="t-title">备注 </td>
	                  <td colspan="3" class="t-content">
	                    <textarea name="remark" rows="3" cols="50" style="resize:none;" class="easyui-validatebox" data-options="validType:'length[0,500]'" ></textarea>
	                  </td>
	                </tr>
	                <tr>
	                  <td class="t-title">场站: </td>
	                  <td class="t-content">
	                    <input name="station" type="text" class="easyui-validatebox" data-options="validType:'length[0,30]'" required="required" />
	                  </td>
	                  <td class="t-title">截港时间： </td>
	                  <td class="t-content">
	                    <input name="endPortDate" type="text" class="easyui-validatebox" data-options="validType:'dateFm',required:true"/>
	                  </td>
	                </tr>
	                <tr>
	                 <td class="t-title">场站联系人: </td>
	                  <td class="t-content">
	                    <input name="contactsMan" type="text" class="easyui-validatebox" data-options="validType:'length[0,255]'" />
	                  </td>
	                 
	                  <td class="t-title">截单时间： </td>
	                  <td class="t-content">
	                    <input name="endCustomDate" type="text" class="easyui-validatebox" data-options="validType:'dateFm',required:true"/>
	                  </td>
	                </tr>
	                <tr>
	                   <td width="16%" class="t-title">场站电话: </td>
	                  <td width="30%" class="t-content">
	                     <input name="contactsPhone" type="text" class="easyui-numberbox" data-options="validType:'length[0,40]'"/>
	                  </td>
	                  <td class="t-title">放箱时间： </td>
	                  <td class="t-content">
	                    <input name="upPackageDate" type="text"  class="easyui-validatebox" data-options="validType:'dateFm',required:true"/>
	                  </td>
	                </tr>
	                <tr>
	                  <td class="t-title">订单出运期: </td>
	                  <td class="t-content">
	                  		<input id="orderBookShipDate" name="orderBookShipDate" type="text" readonly="readonly"  />
	                  </td>
	                  <td class="t-title">船期: </td>
	                  <td class="t-content">
	                     <input name="bookShipDate" id="bookShipDate" type="text" class="easyui-validatebox" data-options="validType:'dateFmWithCompare',required:true" />
	                  </td>
	                </tr>
	                <tr>
	                  <td class="t-title">船公司: </td>
	                  <td class="t-content">
	                  		<input type="text" name="vendorName" readonly="readonly" />
	                  </td>
	                  <td class="t-title">货代名称: </td>
	                  <td class="t-content">
	                  	<input type="text" name="bookAgentName" readonly="readonly" />
	                  </td>
	                </tr>
	                <tr>
	                  <td class="t-title">预计抵达时间(ETA): </td>
	                  <td class="t-content" >
	                     <input name="planArrivalDate"  type="text"  class="easyui-validatebox" data-options="validType:'dateFmWithoutTime'"/>
	                  </td>
	                  <td class="t-title"  >货代联系人-电话: </td>
	                  <td class="t-content"  >
	                     <input name="bookAgentMan"  type="text" class="easyui-validatebox" data-options="validType:'length[0,255]'"  />
	                  </td>
	                </tr>
	               </table>
	            
	            </td>
	          <tr>
	            <td colspan="2" class="t-content">
	              <s:textarea name="shipperMan" id="shipperMan" rows="3" cols="70" cssStyle="resize:none;"></s:textarea>
	            </td>
	          </tr>
	          <tr>
	            <td colspan="2" class="t-title">Consignee(收货人) </td>
	          </tr>
	          <tr>
	            <td colspan="2" class="t-content">
	              <textarea name="receiveMan" id="receiveMan" rows="3" cols="70" style="resize:none;"></textarea>
	            </td>
	          </tr>
	          <tr>
	            <td colspan="2" class="t-title">Notify Party(通知人)</td>
	          </tr>
	          <tr>
	            <td colspan="2" class="t-content">
	              	<textarea name="notifyMan" id="notifyMan" rows="3" cols="70" style="resize:none;"></textarea>
	            </td>
	          </tr>
	          <tr>
	            <td class="t-title">pre-carriage by(前程运输) </td>
	            <td class="t-title">Place of Receipt(收货地点) </td>
	          </tr>
	          <tr>
	            <td class="t-content">
	              <input name="preCarriage" type="text" class="easyui-validatebox" data-options="validType:'length[0,255]'" />
	            </td>
	            <td class="t-content">
	              <input name="receivePlace" type="text" class="easyui-validatebox" data-options="validType:'length[0,1000]'"/>
	            </td>
	          </tr>
	          <tr>
	            <td class="t-title">Ocean Vessel(船名)</td>
	            <td class="t-title">Voy.No (航次)</td>
	          </tr>
	          <tr>
	            <td class="t-content">
	              <input name="vessel" type="text" class="easyui-validatebox"  data-options="validType:'length[0,100]'" required="required" />
	            </td>
	            <td class="t-content">
	              <input name="voyno" type="text" class="easyui-validatebox"  data-options="validType:'length[0,100]'" required="required" />
	            </td>
	          </tr>
	          <tr>
	          	<td colspan="4">
	          		<table width="100%">
	          			<tr>
				            <td class="t-title">Port of Loading(装货港)</td>
				            <td class="t-title">Port of Discharge(卸货港) </td>
				            <td class="t-title">Place of Delivery(发货港) </td>
				            <td class="t-title">Final Destination For the Merchant's Reference(目的地) </td>
				            <td class="t-title">中转港 </td>
				          </tr>
				          <tr>
				           <td width="20%" class="t-content">
				            	<input type="text" name="shipUploadPort" class="easyui-validatebox" data-options="validType:'length[0,40]'" />
				            </td>
				            <td width="20%" class="t-content">
				             <input type="text" name="shipDownPort" class="easyui-validatebox" data-options="validType:'length[0,40]'" /> 
				            </td>
				            <td width="20%" class="t-content">
				              <input name="shipSendPort" type="text" class="easyui-validatebox" data-options="validType:'length[0,40]'" />
				            </td>
				            <td width="20%" class="t-content">
				            	<input type="hidden" name="shipDestination" id="shipDestinationOld" disabled="disabled" />
				            	<input type="text" name="shipDestination" id="shipDestination" class="easyui-validatebox" data-options="validType:'length[0,255]'"  />
				            </td>
				            <td width="20%" class="t-content">
				              <input name="transshipmentPort" type="text" class="easyui-validatebox" data-options="validType:'length[0,255]'" />
				            </td>
				          </tr>
	          		
	          		</table>
	          	</td>
	          </tr>
	        </table>
	        <table style="width:100%;border:0;cellspacing:0;cellpadding:0" class="table-p1">
	          <tr>
	            <td  colspan="7" style="height:200px" id="datagridTr">
					<table id="datagrid_bookOrderItem"></table>
				</td>
	          </tr>
	          <tr>
	            <td colspan="2" class="t-title">TOTAL NUMBER OF CONTAINERS ORPACKAGES(IN WORDS)集装箱数或件数合计(大写): </td>
	            <td colspan="2" class="t-content">
	            	<input name="shipSay" class="easyui-validatebox" data-options="validType:'length[0,200]'" />
	            </td>
	            <td class="t-title">订单执行经理: </td>
	            <td colspan="2" class="t-content">
	            	<input type="text" name="orderExecName" readonly="readonly" /> 
	            </td>
	          </tr>
	          <tr style="display: none">
	            <td colspan="2" class="t-title">FREIGHT &amp; CHARGES(运费与附加费) </td>
	            <td class="t-title">Revenue Tons(运费吨) </td>
	            <td width="15%" class="t-title">Rate(运费率) </td>
<!-- 	            <td width="15%" class="t-title">Per(单价) </td> -->
	            <td class="t-title">Prepaid(预付) </td>
	            <td class="t-title">Collect(到付) </td>
	          </tr>
	          <tr style="display: none">
	            <td colspan="2" class="t-content">
	              <input name="shipFee" type="text" class="easyui-numberbox" data-options="max:99999999999999,precision:4" />
	            </td>
	            <td class="t-content">
	              <input name="shipTons" type="text" class="easyui-numberbox" data-options="max:99999999999999,precision:4" />
	            </td>
	            <td class="t-content">
	              <input name="shipRate" type="text" class="easyui-numberbox" data-options="max:99999999999999,precision:4"/>
	            </td>
<!-- 	            <td class="t-content"> -->
<!-- 	              <input name="goodsPrice" type="text" class="easyui-numberbox" data-options="max:99999999999999,precision:0" /> -->
<!-- 	            </td> -->
	            <td class="t-content">
	              <input name="prePaid" type="text" class="easyui-numberbox" data-options="max:99999999999999,precision:4" />
	            </td>
	            <td class="t-content">
	              <input name="arrivePaid" type="text" class="easyui-numberbox" data-options="max:99999999999999,precision:4" />
	            </td>
	          </tr>
	        </table>
            <table id="attachInfo" style="width:100%;border:0;cellpadding:0;cellspacing:0;margin-bottom: 2px;display: none"  class="table-p1" >
                     <tr>
                         <td  class="t-title">订单号 </td>
                         <td  class="t-title">备件订单号</td>
                         <td  class="t-title">订舱号 </td>
                         <td  class="t-title">下货纸号 </td>
                         <td  class="t-title">件数 </td>
                         <td  class="t-title">毛重 </td>
                         <td  class="t-title">体积</td>
                     </tr>
               </table>
	        <table style="width:100%;border:0;cellpadding:0;cellspacing:0;margin-bottom: 2px"  class="table-p1">
			  <tr style="display: none">
			    <td width="7%" class="t-title">Ex Rate:(兑换率) </td>
			    <td width="20%" class="t-title">Prepaid at(预付地点) </td>
			    <td width="11%" class="t-content">
			      <input name="prePaidPlace" type="text" class="easyui-validatebox" data-options="validType:'length[0,255]'"  />
			    </td>
			    <td width="20%" class="t-title">Payable at Destination (到付地点) </td>
			    <td width="11%" class="t-content">
			      <input name="prePay" type="text" class="easyui-validatebox" data-options="validType:'length[0,255]'"  />
			    </td>
			    <td width="20%" class="t-title">Place of Issue(签发地) :</td>
			    <td width="11%" class="t-content">
			      <input name="signPlace" type="text" class="easyui-validatebox" data-options="validType:'length[0,255]'"  />
			    </td>
			  </tr>
			
			  <tr style="display: none">
			    <td  class="t-content">
			      <input name="expchangeRate" type="text" class="easyui-numberbox" data-options="max:99999999999999,precision:4" />
			    </td>
			    <td class="t-title">Total Prepaid(预付总额) </td>
			    <td class="t-content">
			      <input name="prePaidAmoumy" type="text" class="easyui-numberbox" data-options="max:99999999999999,precision:4" />
			    </td>
			    <td class="t-title">No. of Original B(s)/L (正本提单份数) </td>
			    <td class="t-content">
			      <input name="getOrderPaperNum" type="text" class="easyui-numberbox" data-options="max:99999999999999,precision:0" />
			    </td>
			    <td class="t-title">Service Type: </td>
			    <td class="t-content">
			      <input name="serviceType" type="text" class="easyui-validatebox" data-options="validType:'length[0,255]'" />
			    </td>
			  </tr>
			  <tr>
				  	<td class="t-title">订舱说明：</td>
				  	<td colspan="3" class="t-content">
				  		<textarea name="bookComments" style="resize:none;" readonly='readonly'></textarea>
				  	</td>
				  	<td class="t-title">提单用货物描述：</td>
				  	<td colspan="2" class="t-content">
				  		<textarea name="bookGetComments" style="resize:none;" readonly='readonly'></textarea>
				  	</td>
			  </tr>
			  <tr>
			    <td class="t-title orderExecremark" style="display: none">订单经理备注：</td>
			  	<td colspan="3" class="t-content orderExecremark" style="display: none">
			  		<textarea name="orderExecremark" readonly="readonly"></textarea>
			  	</td>
			  	<td colspan="7" id="oprationbuttDiv" >
			  		<div class="oneline" >
				      	<div class="item25 lastitem" style="width: 120px" >
						    <div class="oprationbutt" style="text-align: left;width: 100px">
								<input type="hidden" name="attachmentFile" id="attachmentFile"/>
							  	<input type="button" value="上传附件" onclick="uploadCredit();return false;" />
						    </div>
					    </div>
                        <label>附件 ：</label><span id="attachmentFileName"></span>
			  		</div>
			  		<div class="oneline">
				      	<div class="item50 lastitem" >
						    <div class="oprationbutt" style="text-align: left;">
								<input type="button" value="保  存" onclick="save()" /> 
								<input type="button" value="打印" onclick="printPreview()" /> 
							</div>
						</div>
					</div>
			  	</td>
			  
			  </tr>
	    </table>
	 </div>
	</div>
	<!--end 表单--> 
	    
	    </form>
	  </div>
	</div>
	
	<!-- 下货纸录入上传附件Dialog -->
	<div id="uploadFileDialog" style="display: none;width: 400px;height: 100px;" align="center">
		<form id="upLoadFileForm" method="post" enctype="multipart/form-data">
		    <table class="tableForm">
				<tr>
					<th>上传入货通知/回箱单:</th>
					<td>
					    <s:file id="FileTemplet" name="upload"></s:file>
					</td>
				</tr>
			</table>
		</form>
	</div>
	
</body>
</html>

