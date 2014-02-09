<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript">
function _search() {
	if($("#orderCode").val()==null||$("#orderCode").val()==''){
		$.messager.alert('提示', '订单号不能为空！', 'error');
		return;
	}
	$.messager.progress({
		text : '后台获取中....',
		interval : 100
	});
	$.ajax({		
  	     url:"${dynamicURL}/salesOrder/salesOrderAction!getSalesOrderFromHope.action",
  	     data:{
  	    	    orderCode:$('#orderCode').val()  	    	   
  	    	  },
  	     type:'post',
  	     dataType:'json',
  	     success:function(data){
	   		if(data.success){
	   			$.messager.show({
					title : '成功',
					msg : data.msg
				});
	   			showPanorama(data.obj.orderCode,data.obj.orderType);
	   		}else{
	   			$.messager.show({
					title : '失败',
					msg : data.msg
				});
	   		}
	   		$.messager.progress('close');
  	     }
	})
}
function cleanSearch() {	
	$('#searchForm').find('input[type=text]').val('');
}

//跳转到订单全景图页面
function showPanorama(id,orderType) {
	var url = '${dynamicURL}/salesOrder/salesOrderAction!goSalesOrderDetail.action?orderCode=' + id + '&orderType=' + orderType;
/* 	$('#iframe').attr('src', url);
	dialog = $('#iframeDialog').show().dialog({
		title : '订单全景图',
		modal : true,
		closed : true,
		minimizable : true,
		maximizable : true,
		maximized : true
	});
	dialog.dialog('open'); */
	parent.window.HROS.window.createTemp({
		title:"订单确认-订单号:"+id,
		url:url,
		width:800,height:400,isresize:false,isopenmax:true,isflash:false,customWindow:window});
}
function reloaddata(){
	top.window.showTaskCount();
}
</script>
</head>
<body>
	<div class="zoc" >
		<form id="searchForm">
			<div class="navhead_zoc">
				<span>从HOPE获取订单</span>
			</div>
			<div class="part_zoc">
				<div class="partnavi_zoc">
					<span>输入订单号：</span>
				</div>
				<div class="oneline">
					<div class="item25">
						<div class="itemleft60">订单编号：</div>
						<div class="righttext">
							<input id="orderCode" name="orderCode"  type="text" style="width:125px" class="orderAutoComple"
								 />
						</div>
					</div>
					
				</div>
				<div class="item100">
			        <div class="oprationbutt">
				        <input type="button" value="获取" onclick="_search();"/>
				        <input type="button" value="重  置"  onclick="cleanSearch();"/>
			       </div>
		        </div>
			</div>
		</form>
	</div>
<div id="iframeDialog"
		style="display: none; overflow: auto; width: 800px; height: 500px;">
		<iframe name="iframe" id="iframe" src="#" scrolling="auto"
			frameborder="0" style="width: 100%; height: 100%;"> </iframe>
	</div>

</body>
</html>