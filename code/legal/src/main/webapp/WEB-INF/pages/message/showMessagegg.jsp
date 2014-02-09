<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="p" uri="/pagination-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript">
//总数
var total;
//第几页
var page;
//当前页的行数
var rows1;
//共多少页
var pages;
var iframeDialog;
$(window).load(function(){
	setTimeout(function(){
		refresh(1,3);
		iframeDialog = $('#iframeDialog').show().dialog({
			title : '公告消息',
			modal : true,
			closed : true,
			maximizable : true,
			width:400,
			heigth:300
		});
	});
});
function refresh(page1,rows2){
	page=page1;
	rows1=rows2;
	$.ajax({
		url:'${dynamicURL}/message/messageAction!showMyMessage.action',
		type:'post',
		data:{
			page:page,
			rows:rows1
		},
		dataType:'json',
		success:function(data){
			var rows=data.rows;
			if(rows!=null&&rows.length>0){
				var trs='<tbody><tr><th>标题</th><th>发送人</th></tr></tbody>'
				for(var i=0;i<rows.length;i++){
					var row=rows[i];
					var td='<td><a href="#" onclick="showcontent(\''+row.messageId+'\');return false;">'+row.title+'</a></td><td>'+row.sender+'</td>';
					trs=trs+'<tr>'+td+'</tr>';
				}
				$("#tableId").html(trs);
			}
			total=data.total;
			if(total!=null){
				var totalstr='总'+total+'条记录'
				$('#totalId').html(totalstr);
			}
			var pagestr='第'+page+'页';
			$('#pageId').html(pagestr);
			pages=getpages(total,rows1);
			var pagesstr='共'+pages+'页';
			$('#pagesId').html(pagesstr);
			//resize iframe height 
			if(dockappid != undefined){
				var h = $("html").height();
				parent.window.$('#'+dockappid).height(h);
			}
		}
	});
}
//根据总数和每页行数查询页数
function getpages(total,rows){
	var pages=Math.ceil(parseInt(total)/(rows));
	return pages;
}
//上一页
function gobefore(){
	var pagenum=parseInt(page);
	var rows1num=parseInt(rows1);
	if(pagenum==1||pagenum==0){
		return;
	}else{
		var pagenumm=pagenum-1;
		refresh(pagenumm,rows1num);
	}
}
//下一页
function gonext(){
	var pagenum=parseInt(page);
	var pagesnum=parseInt(pages);
	var rows1num=parseInt(rows1);
	if(pagenum<pagesnum){
		var pagenumm=pagenum+1;
		refresh(pagenumm,rows1num)
	}else{
		return;
	}
}
//改变每页的大小
function changerows1(){
	var select1=document.getElementById('sel01').value;
	rows1=select1;
	var rows1num=parseInt(rows1);
	//获得修改行数后，最多能够分得页数
	var zhanshi= getpages(total,rows1);
	//获得当前处于的页数
	var pagenum=parseInt(page);
	//如果改后的总页数小于当前页数，查询修改后的最后一页
	if(zhanshi<pagenum){
		refresh(zhanshi,rows1num);
	}else{
		refresh(pagenum,rows1num)
	}
}
function showcontent(messageId){
	//var url='${dynamicURL}/message/messageAction!showMessageContent.do?stateId='+stateId;
	var url='${dynamicURL}/message/messageAction!goMessage.do?id='+messageId;
	parent.window.HROS.window.createTemp({
		title:"系统公告",
		url:url,
		width:1000,height:600,isresize:true,isopenmax:false,isflash:false});
}
</script>
<style type="">
.table2 th {
    height: 23px;
}
.table2 tr td {
    height: 23px;
}
table.table2 {
    margin-top: 0px;
}
</style>
</head>
<body>
	<div class="zoc">
		<div id="errorMsg" style="color: red; text-align: center;"></div>
		<div class="part_zoc" style="min-width: 200px;padding: 0;margin: 0">
			<table id="tableId" cellspacing="0" cellpadding="0" class="table2">
				<tbody>
					<tr>
						<th>标题</th>
						<th>发送人</th>
					</tr>
				</tbody>
				<%-- <s:iterator value="pager.records" var="task" status="status">
					<tr <s:if test="#status.odd"> class="bgc1"</s:if>
						<s:if test="#status.even"> class="bgc2"</s:if>>
						<td> <a href="javascript:void(0)"  onclick="taskDetail('${task['title']}','${task['url']}')">${task['title']}</a></td>
						<td>${task['dueDate']}</td>
						<td><a href="javascript:void(0)"  onclick="taskDetail('${task['title']}','${task['url']}')">办理</a></td>
					</tr>
				</s:iterator> --%>
				
			</table>
			<s:form action="reminderWidget!findReminderList"
				namespace="/deskgadget" method="get" id="findReminderList">
			</s:form>
			<dd class="dd-fd">
				<input id='_page_size_' type="hidden" value="${pager.pageSize}">
				<div class="page">
				<span id="pageId">第1页</span>
				    <%-- <span >
				                      每页
				        <select id="sel01"  onchange="changerows1()">
                          <option value="5">5</option>
                          <option value="10">10</option>
                          <option value="15">15</option>
                        </select>行
				    </span> --%>
					<span id="totalId">&nbsp;总0条记录&nbsp;</span>
					<span id="pagesId">共1页&nbsp;</span>
						<a href="#" onclick="gobefore();">上一页</a>
						<a href="#" onclick="gonext();">下一页</a>
				</div>
				
			</dd>
		</div>

	</div>
	
	<div id="iframeDialog" style="display: none;overflow: auto;width: 600px;height: 400px;">
	    
    </div>
</body>
</html>