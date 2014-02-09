<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<title>下货纸审核</title>
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
		textarea{width: 90%;;height: 55px}
		input[readonly='readonly'],textarea[readonly='readonly']{
			background-color: rgb(235,235,228);
			border-width: 1px;
			border-color: #D3D3D3;
		}
	/* end 订单纸 */
</style>
<script type="text/javascript">
var datagrid_bookOrderItem;
$(function(){
	//加载历史记录
	 $.ajax({
 		url : '${dynamicURL}/bookorder/shipPaperAction!selectListShipPaperBak.do',
 		data : { "rowId":'${rowId}' }, 
 		dataType : 'json',
 		success : function(list) {
 			if(list!=null && list.length>0){
 				var options = "";
 				for(var i=0,l=list.length;i<l;i++){
 					options = options + "<option value='"+ list[i].rowId +"'>"+list[i].bakDate + "</option>";
 				}
 				$("#historyRecord select").html(options);
 				$("#historyRecord select").on("change",function(){
 					loadData($(this).val());
 				})
 			}
 		}
 	}); 
	
 	//下货纸明细表中的shipPaperRowId 就是下货纸表中的rowId
	datagrid_bookOrderItem= $('#datagrid_bookOrderItem').datagrid({
		url : 'shipPaperItemAction!findPaperItemBak.do', 
		queryParams: {
			'shipPaperRowId': '---'
		},
		fit : true,
		fitColumns : true,
		nowrap : true,
		border : false,
		onSelect:false,
		idField : 'bookItemCode',
		showFooter:true,
		columns : [ [ 
		  	{ field:'orderCode',title:'订单号',align:'center',sortable:true },
		    { field:'haierModel',title:'海尔型号',align:'center', width:100},
			{ field:'goodsMark',title:'唛头',align:'center', width:100 },
			{ field:'goodsCount',title:'件数',align:'center',width:100 },	
		    { field:'goodsPacageName',title:'货描',align:'center',width:100 },		
		    { field:'goodsGrossWeight',title:'毛重',align:'center',width:100,
				formatter:function(value,row,index){
					return Number(row.goodsGrossWeight).toFixed(2);
			}},				
		    { field:'goodsSize',title:'体积',align:'center',width:100,formatter:function(value,row,index){
                    return Number(value).toFixed(3);
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
	loadData("${rowId}");
})

function loadData(shipPaperId){
	$.messager.progress({
		text : '数据加载中....',
		interval : 100
	});
	$.ajax({
 		url : '${dynamicURL}/bookorder/shipPaperAction!getShipPaperBak.do',
 		data : { "rowId":shipPaperId }, 
 		dataType : 'json',
 		success : function(response) {
 			$.messager.progress('close');
 			$("#enterGoodsForm").form('clear');
 			$("#enterGoodsForm").form('load', response);
 			//校验提醒
 			var shipDestinationInput =$("#enterGoodsForm").find("input[name='shipDestination']"); 
 			if(response.portEndName!='' && response.portEndName != shipDestinationInput.val()){
 				shipDestinationInput.css({background:"red"});
 			} 
 			var bookShipDateInput =$("#bookShipDateId");
 			if(response.orderBookShipDate!=null){
 				if(response.orderBookShipDate == bookShipDateInput.datetimebox("getText")){
 					confirmFlag = true;
 				}else{
 					bookShipDateInput.next("span").find("input").css({background:"red"});
 				}
 			} 
 			//页面不可编辑
 			$("#enterGoodsForm").find('input[type!="button"],textarea').attr("readonly", "readonly");
 			//日期空间处理
 			$("#enterGoodsForm").find('input.easyui-datetimebox').datetimebox("disable");
 		}
 	});
	datagrid_bookOrderItem.datagrid("load",{'shipPaperRowId': shipPaperId});
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
	printBody.find("#historyRecord").hide();
	lodopPrintFullWidth(printBody);
}
</script>
</head>
<body>
	<div id="task_good_div">
	    <!-- 单价字段空着  暂不确定   箱号那列要做成一个可编辑的datagrid  数据查询的是订舱明细表ACT_BOOK_ORDER_ITEM 数据要保存的下货纸明细表 ACT_SHIP_PAPER_ITEM -->
	  	<div class="main"  style="min-width: 1030px">
		  <div style="border:solid 1px #666;padding:10px;margin:2px;background:#fff;"> 
		    <form id="enterGoodsForm" method="post">
		    <s:hidden name="taskIds" id="taskIds"/>
			<s:hidden name="bookCode" id="bookCode" />
			<s:hidden name="rowId" />
			<!--  校验用的数据  -->
			<input type="hidden" name="portEndName" id="portEndNameId" readonly="readonly" />
			<!--  校验用的数据  end-->
		    <!--start 表单-->
		    <div class="order-form">
		      <div class="main-order-form">
		        <h1 style="width:200px;display:inline-block;">下货纸信息</h1> <span style="float: right;" id="historyRecord">选择历史记录：<select name="rowId"></select></span>
		        <table style="width:100%;border:0;cellpadding:0;cellspacing:0" class="table-p1" >
		          <tr>
		            <td colspan="2" class="t-title">shipper(发货人)</td>
		            <td rowspan="10" colspan="2" align="left" valign="top" class="wrap-tablehead">
		               <table style="width:99%;border:0;cellspacing:0;cellpadding:0;display: inline-table;margin-left: 2px;"  class="tablehead">
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
		                    <input name="station" type="text" required="required" />
		                  </td>
		                  <td class="t-title">截港时间： </td>
		                  <td class="t-content">
		                    <input name="endPortDate"  type="text"  class="easyui-datetimebox" data-options="showSeconds:false" required="required" editable="false"/>
		                  </td>
		                </tr>
		                 <tr>
		                 <td class="t-title">场站联系人: </td>
		                  <td class="t-content">
		                     <input name="contactsMan"  type="text"  editable="false"/>
		                  </td>
		                 
		                  <td class="t-title">截单时间： </td>
		                  <td class="t-content">
		                    <input name="endCustomDate" type="text"  class="easyui-datetimebox" data-options="showSeconds:false" required="required" editable="false"/>
		                  </td>
		                </tr>
		                <tr>
		                   <td width="16%" class="t-title">场站电话: </td>
		                  <td width="30%" class="t-content">
		                     <input name="contactsPhone" type="text" class="easyui-numberbox" data-options="validType:'length[0,40]'"/>
		                  </td>
		                  <td class="t-title">放箱时间： </td>
		                  <td class="t-content">
		                    <input name="upPackageDate" type="text"  class="easyui-datetimebox" data-options="showSeconds:false" required="required" editable="false"/>
		                  </td>
		                </tr>
		                <tr>
		                  <!--  校验用的数据  -->
		                  <td class="t-title">订单出运期: </td>
		                  <td class="t-content">
		                  		<input type="text" name="orderBookShipDate" id="bookShipDateHide" readonly="readonly" />
		                  </td>
		                  <td class="t-title">船期: </td>
		                  <td class="t-content">
		                     <input name="bookShipDate" id="bookShipDateId"   type="text"  class="easyui-datebox"   required="required" disabled="disabled"/>
		                  </td>
		                </tr>
		                <tr>
		                  <td class="t-title">船公司: </td>
		                  <td class="t-content">
		                  		<input name="vendorName" type="text" readonly="readonly" />
		                  </td>
		                  <td class="t-title">货代名称: </td>
		                  <td class="t-content">
		                 	 <input name="bookAgentName" type="text" readonly="readonly" />
		                  </td>
		                </tr>
		                <tr>
		                  <td class="t-title">预计抵达时间(ETA): </td>
		                  <td class="t-content">
		                     <input name="planArrivalDate"  type="text"  class="easyui-datebox" disabled='disabled' />
		                  </td>
		                  <td class="t-title"  >货代联系人-电话: </td>
		                  <td class="t-content" >
		                     <input name="bookAgentMan"  type="text" class="easyui-validatebox" data-options="validType:'length[0,255]'"  />
		                  </td>
		                </tr>
		               </table></td>
		          </tr>
		          <tr>
		            <td colspan="2" class="t-content">
		              <textarea name="shipperMan" id="shipperMan" rows="3" cols="70" style="resize:none;"></textarea>
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
		          	<td colspan="4" >
		          		<table width="100%">
		          			<tr>
					            <td class="t-title">Port of Loading(装货港)</td>
					            <td class="t-title">Port of Discharge(卸货港) </td>
					            <td class="t-title">Place of Delivery(交货地点) </td>
					            <td class="t-title">Final Destination For the Merchant's Reference(目的地) </td>
					            <td class="t-title">中转港 </td>
					          </tr>
					          <tr>
					          	<td  width="20%" class="t-content">
					              <input name="shipUploadPort" id="shipUploadPort" type="text" class="easyui-validatebox" data-options="validType:'length[0,40]'" />
					            </td>
					            <td width="20%" class="t-content">
					              <input name="shipDownPort" id="shipDownPort" type="text" class="easyui-validatebox" data-options="validType:'length[0,40]'" />
					            </td>
					            <td width="20%" class="t-content">
					              <input name="shipSendPort" type="text" class="easyui-validatebox" data-options="validType:'length[0,40]'" />
					            </td>
					            <td width="20%" class="t-content">
					              <input name="shipDestination" type="text" class="easyui-validatebox" data-options="validType:'length[0,255]'" />
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
		              <input name="shipSay" type="text" class="easyui-validatebox" data-options="validType:'length[0,200]'" />
		            </td>
		             <td class="t-title">订单执行经理: </td>
		            <td colspan="2" class="t-content">
		            	<input name="orderExecName" type="text" class="easyui-validatebox" data-options="validType:'length[0,200]'" />
		            </td>
		          </tr>
		          <tr  style="display: none">
		            <td colspan="2" class="t-title">FREIGHT &amp; CHARGES(运费与附加费) </td>
		            <td class="t-title">Revenue Tons(运费吨) </td>
		            <td width="15%" class="t-title">Rate(运费率) </td>
	<!-- 	            <td width="15%" class="t-title">Per(单价) </td> -->
		            <td class="t-title">Prepaid(预付) </td>
		            <td class="t-title">Collect(到付) </td>
		          </tr>
		          <tr  style="display: none">
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
                      <tr class='title' >
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
				  <tr  style="display: none">
				    <td  class="t-title">Ex Rate:(兑换率) </td>
				    <td class="t-title">Prepaid at(预付地点) </td>
				    <td  class="t-content">
				      <input name="prePaidPlace" type="text" class="easyui-validatebox" data-options="validType:'length[0,255]'"  />
				    </td>
				    <td  class="t-title">Payable at Destination (到付地点) </td>
				    <td  class="t-content">
				      <input name="prePay" type="text" class="easyui-validatebox" data-options="validType:'length[0,255]'"  />
				    </td>
				    <td  class="t-title">Place of Issue(签发地) :</td>
				    <td  class="t-content">
				      <input name="signPlace" type="text" class="easyui-validatebox" data-options="validType:'length[0,255]'"  />
				    </td>
				  </tr>
				
				  <tr  style="display: none">
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
				  		<textarea name="bookComments" style="resize:none;" readonly='readonly' ></textarea>
				  	</td>
				  	<td class="t-title">提单用货物描述：</td>
				  	<td colspan="2" class="t-content">
				  		<textarea name="bookGetComments" style="resize:none;" readonly='readonly'></textarea>
				  	</td>
				  </tr>
			      <tr>
				  	<td class="t-title">订单经理备注：</td>
				  	<td colspan="3" class="t-content">
				  		<textarea name="orderExecremark" style="resize:none;"></textarea>
				  	</td>
				  	<td colspan="3" >
				  		<div class="oneline" style="border: none" id="oprationbuttDiv">
					        <div class="item66 lastitem" >
								<div class="oprationbutt" align="center">
								  <div class="oprationbutt">
									<input type="button" class="print" value="打印" onclick="printPreview()" /> 
								  </div>
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
	  
	  
	</div>
</body>
</html>