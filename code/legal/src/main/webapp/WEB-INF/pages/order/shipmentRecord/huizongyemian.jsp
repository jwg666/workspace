<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
//刷新页面1和页面2
function fshua1and2(){
	window.frames["frame1"]._search();
	window.frames["frame2"]._search();
}
//刷新页面1和页面4
function fshua1and4(){
	window.frames["frame1"]._search();
	window.frames["frame4"]._search();
}
//刷新页面2和页面4
function fshua2and4(){
	window.frames["frame2"]._search();
	window.frames["frame4"]._search();
}
//刷新页面2和页面3
function fshua2and3(){
	window.frames["frame2"]._search();
	window.frames["frame3"]._search();
}
//刷新页面1，页面2和页面4
function fshua1and2and4(){
	window.frames["frame1"]._search();
	window.frames["frame2"]._search();
	window.frames["frame4"]._search();
}
function fshua2and3and4(){
	window.frames["frame3"]._search();
	window.frames["frame2"]._search();
	window.frames["frame4"]._search();
}
function fshua1and4(){
	window.frames["frame1"]._search();
	window.frames["frame4"]._search();
}
</script>
</head>
<body>
    <div id="tabs_id" class="easyui-tabs" data-options="fit:true">
		<div title="出运未备案">
			<!--展开之后的content-part所显示的内容-->
			<div id="checkSearch" class="easyui-layout" fit="true">
			    <iframe id="frame1"  src="${dynamicURL}/shipmentRecord/shipmentRecordAction!goShipmentRecord.action" style="width:100%;height:100%;"></iframe>
	        </div>
	    </div>
	    <div title="出运正在办理">
			<!--展开之后的content-part所显示的内容-->
			<div id="checkSearch" class="easyui-layout" fit="true">
			    <iframe  id="frame2" src="${dynamicURL}/shipmentRecord/shipmentRecordAction!goDealingRecord.action" style="width:100%;height:100%;"></iframe>
	        </div>
	    </div>
	    <div title="出运已备案">
			<!--展开之后的content-part所显示的内容-->
			<div id="checkSearch" class="easyui-layout" fit="true">
			    <iframe id="frame3"  src="${dynamicURL}/shipmentRecord/shipmentRecordAction!goshipmentRecordThree.action" style="width:100%;height:100%;"></iframe>
	        </div>
	    </div>
	    <div title="出运异常">
			<!--展开之后的content-part所显示的内容-->
			<div id="checkSearch" class="easyui-layout" fit="true">
			    <iframe id="frame4"  src="${dynamicURL}/shipmentRecord/shipmentRecordAction!goExceptionRecord.action" style="width:100%;height:100%;"></iframe>
	        </div>
	    </div>
	</div>
</body>
</html>