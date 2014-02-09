<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

</head>
<body>
<style type="text/css">
#shortCutForm input{
  height: 16px;
}
#shortCutForm tr{
  height: 24px;
}
.grayBg{
  background-color: #f2f1f1;
}
</style>
<form id="shortCutForm">
	<table height="200" style="padding-left: 5px;">
		<tbody>
			<tr>
				<td width="100px">编号</td>
				<td>
				   <input name="shipPaperCode" value="${shipPaperCode}" class="easyui-validatebox" data-options="validType:'length[0,255]',required:true">
				   <input type="hidden" name="rowId" value="${rowId}">
				   <input type="hidden" name="subCount" value="${subCount}">
				   <input type="hidden" name="bookCode" value="${bookCode}">
				</td>
				<td style="width:80px; text-align: right;">订单经理</td>
				<td colspan="3"><input class="grayBg" readonly="readonly" name="orderExecName" value="${orderExecName}"></td>
			</tr>
			<tr>
				<td>发货人</td>
				<td colspan="3"><input style="width:390px" name="shipperMan" value="${shipperMan}" class="easyui-validatebox" data-options="validType:'length[0,255]',required:true"></td>
			</tr>
			<tr>
				<td height="19">收货人</td>
				<td colspan="3"><input style="width:390px" name="receiveMan" value="${receiveMan}" class="easyui-validatebox" data-options="validType:'length[0,255]',required:true"></td>
			</tr>
			<tr>
				<td>通知人</td>
				<td colspan="3"><input style="width:390px" name="notifyMan" value="${notifyMan}" class="easyui-validatebox" data-options="validType:'length[0,400]',required:true"></td>
			</tr>
			<tr>
				<td>船公司</td>
				<td><input class="grayBg" readonly="readonly" name="vendorName" value="${vendorName}" class="easyui-validatebox" data-options="validType:'length[0,255]',required:true"></td>
				<td style="width:80px; text-align: right;">货代名称</td>
				<td><input class="grayBg" readonly="readonly" name="bookAgentName" value="${bookAgentName}" class="easyui-validatebox" data-options="validType:'length[0,255]',required:true"></td>
			</tr>
			<tr>
				<td>订单出运期</td>
				<td><input class="grayBg" readonly="readonly" name="orderBookShipDate" value="${orderBookShipDateStr}" class="easyui-validatebox" data-options="validType:'dateFm',required:true"></td>
				<td style="width:80px; text-align: right;">船期</td>
				<td><input name="bookShipDate" value="${bookShipDateStr}" class="easyui-validatebox" data-options="validType:'dateFm',required:true"></td>
			</tr>
			<tr>
				<td>船名/航次</td>
				<td>
				<input name="vessel" value="${vessel}" class="easyui-validatebox" data-options="validType:'length[0,255]',required:true,missingMessage:'请输入船名'" style="width:69px;">
				<input name="voyno" value="${voyno}" class="easyui-validatebox" data-options="validType:'length[0,255]',required:true,missingMessage:'请输入航次'" style="width:69px;">
				</td>
				<td style="width:80px; text-align: right;">场站</td>
				<td><input name="station" value="${station}" class="easyui-validatebox" data-options="validType:'length[0,255]',required:true"></td>
			</tr>
			<tr>
				<td>预计抵达时间</td>
				<td><input name="planArrivalDate" value="${planArrivalDateStr}" class="easyui-validatebox" data-options="validType:'dateFm'"></td>
				<td style="width:80px; text-align: right;">截港时间</td>
				<td><input name="endPortDate" value="${endPortDateStr}" class="easyui-validatebox" data-options="validType:'dateFm',required:true"></td>
			</tr>
			<tr>
				<td>截单时间</td>
				<td><input name="endCustomDate" value="${endCustomDateStr}" class="easyui-validatebox" data-options="validType:'dateFm',required:true"></td>
				<td style="width:80px; text-align: right;">放箱时间</td>
				<td><input name="upPackageDate" value="${upPackageDateStr}" class="easyui-validatebox" data-options="validType:'dateFm',required:true"></td>
			</tr>
			<tr>
				<td>装货港</td>
				<td><input name="shipUploadPort" value="${shipUploadPort}" class="easyui-validatebox" data-options="validType:'length[0,255]',required:true"></td>
				<td style="width:80px; text-align: right;">卸货港</td>
				<td><input name="shipDownPort" value="${shipDownPort}" class="easyui-validatebox" data-options="validType:'length[0,255]',required:true"></td>
			</tr>
			<tr>
				<td>目的地</td>
				<td><input name="shipDestination" value="${shipDestination}" class="easyui-validatebox" data-options="validType:'length[0,255]',required:true"></td>
				<td style="width:80px; text-align: right;">箱型箱量</td>
				<td><input name="shipSay" value="${shipSay}" class="easyui-validatebox" data-options="validType:'length[0,128]',required:true"></td>
			</tr>
		</tbody>
	</table>
</form>
</body>
</html>