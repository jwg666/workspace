<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp" />
<link rel="stylesheet" href="${staticURL}/IM/stylesheets/os/os-style.css">
<link rel="stylesheet" href="${staticURL}/IM/stylesheets/os/work_v2.css">
	
<script type="text/javascript">
	$(function() {
		$("#writeMessage").window({
			width : 700,
			height : 500,
			closed : true,
			shadow : true,
			modal : true,
			title : "发通知"
		});
		$("#showMessage").window({
			width : 700,
			height : 500,
			closed : true,
			shadow : true,
			modal : true,
			title : "信息详情"
		});
		$(".locShowDataList").click(function(){
			$(".locShowDataList").removeClass("fwb");
			$(this).addClass("fwb");
			loadMessage(1);
		});
		$("#messageListMain div.selectIcoBox").live("click",function(){
			$(this).find("i").hide();
			if(isSelectedAll()){
				$(this).find("i.locUnCheck").show();
				unSelectAll();
			}else{
				$(this).find("i.locChecked").show();
				selectAll();
			}
		});
		$("#messageListTable td input:checkbox").live("click",function(){
			var selectBox = $("#messageListMain div.selectIcoBox");
			selectBox.find("i").hide();
			if(isSelectedAll()){
				selectBox.find("i.locChecked").show();
			}else if(hasSelected()){
				selectBox.find("i.locPartial").show();
			}else{
				selectBox.find("i.locUnCheck").show();
			}
		});
		$("#messagesendList td.mailfg i").live("click",function(){
			var messageId = $(this).parent().attr("data");
			$.ajax({
				url : "${dynamicURL}/message/messageAction!loginShow.do",
				data : {id:messageId},
				dataType : 'json',
				success : function(response) {
					if(response.success){
						$("#messagesendList td.mailfg i").removeClass("staron").addClass("staroff");
						if(response.obj.type == 5){
							$(this).removeClass("staroff").addClass("staron")
						}	
					}else{
						$.messager.show({
							title : '提示',
							msg : '请求失败 联系管理员！'
						});
					}
				}
			});
		});
		loadMessage(1);
		<s:if test='id!=null&&id!=""'>
		$("#showMessage").load("${dynamicURL}/message/messageAction!showDesc.do?id=${id}");
		$("#showMessage").window("open");
		</s:if>
	});
	
	function loadMessage(page) {
		var tag = $("#sideLinkUl .fwb a").attr("tag");
		$.messager.progress({
			text : '数据加载中....',
			interval : 100
		});
		$.ajax({
			url : 'messageAction!message'+tag+'List.do',
			data : {
				'page' : page
			},
			dataType : 'html',
			success : function(response) {
				$("#messageListMain").html(response);
				$.messager.progress('close');
			}
		});
	}
	/*
	function showWriteMessage() {
		$("#writeMessage").window({
			title : "发通知"
		});
		$("#sendMessage").text("发送邮件");
		$("#Announcement").css('display',"none");
		$("#writeMessage").window("open");
	}*/
	function showAnnouncement(){
		$("#writeMessage").window({
			title : "发通知"
		});
		$("#sendMessage").text("发通知");
		$("#Announcement").css('display',"");
		$("#writeMessage").window("open");
	}
	function backPage(){
		var pagenumber = parseInt($('#pageNumber').val())-parseInt(1);
		var totalPage = parseInt($('#totalPage').val())
		if(pagenumber<parseInt(0)){
			return;
		}
		loadMessage(pagenumber);
	}
	function nextPage(){
		var pagenumber = parseInt($('#pageNumber').val())+parseInt(1);
		var totalPage = parseInt($('#totalPage').val())
		if(pagenumber>totalPage){
			return;
		}
		loadMessage(pagenumber);
	}
	function ToPageNumber(){
		var toPageNum = parseInt($('#toPageNum').val());
		var totalPage = parseInt($('#totalPage').val());
		if($('#toPageNum').val() ==  ""){
			return;
		}
		if(toPageNum > totalPage){
			loadMessage(totalPage);
		}else{
			loadMessage(toPageNum);
		}
	}
	function del(box){
		var ids="";  
		$("#messageListTable td input:checked").each(function(){  
			if($("input:checked").length>1)
				ids=ids+"ids="+$(this).val()+"&";
			else ids=ids+"ids="+$(this).val();
		})
		$.ajax({
			url : 'messageAction!delete.do?box='+box,
			data : ids,
			dataType : 'json',
			success : function(response) {
				loadMessage(1);
				$.messager.show({
					title : '提示',
					msg : '删除成功！'
				});
			}
		});
	}
	function delgg(){
		var ids="";  
		$("input:checked").each(function(){  
			if($("input:checked").length>1)
				ids=ids+"ids="+$(this).val()+"&";
			else ids=ids+"ids="+$(this).val();
		})
		var tag = $("#sideLinkUl .fwb a").attr("tag");
		var url= 'messageAction!delete'+tag+'.do';
		$.ajax({
			url : url,
			data : ids,
			dataType : 'json',
			success : function(response) {
				if(response.success){
					loadMessage(1);
					$.messager.show({
						title : '提示',
						msg : '删除成功！'
					});
				}else{
					$.messager.show({
						title : '提示',
						msg : '删除失败！'
					});
				}
			}
		});
	}
	function search(){
		var title = $('#searchTitle').val();
		var tag = $("#sideLinkUl .fwb a").attr("tag");
		$.ajax({
			url : 'messageAction!message'+tag+'List.do',
			data : {
				title : title
			},
			dataType : 'html',
			success : function(response) {
				$("#messageListMain").html(response);
			}
		});
	}
	function refresh(){
		loadMessage(1);
	}
	function selectAll(){
		$("#messageListTable td input:checkbox").attr("checked",true);
	}
	function unSelectAll(){
		$("#messageListTable td input:checkbox").attr("checked",false);
	}
	function isSelectedAll(){
		var allsize = $("#messageListTable td input:checkbox").size();
		var checkedSize =  $("#messageListTable td input:checked").size();
		return  allsize>0 && allsize == checkedSize;
	}
	function hasSelected(){
		var allsize = $("#messageListTable td input:checkbox").size();
		var checkedSize =  $("#messageListTable td input:checked").size();
		return  allsize>0 && checkedSize>0 && allsize > checkedSize;
	}
</script>
</head>
<body>
	<div style="top: 0px; left: 0px; width: 100%; height: 100%;">
		<div class="wrap">
			<div style="display: none;" class="wrapmask"></div>
			<div class="wTopbar"></div>
			<div class="side">
				<div class="wTopbar">
					<!-- <span class="toptxt">您好</span> -->
					<a href="javascript:;" class="wIndex">首页</a> | <a
						href="javascript:;" class="wSetting">设置</a> | <a
						href="javascript:;" class="wRule">规则</a> <a href="javascript:;"
						class="wCollection locRecMail"><i class="wCollico"></i>收信</a>

				</div>
				<div class="sideTop" style="padding-top: 25px;height: 55px">
					<button wbtype="mail" type="button" onclick="showAnnouncement()"
						class="btn_write btn_newWb">
						<i class="wIco wWrite"></i>发通知
					</button>
					<!-- <button wbtype="task" type="button" class="wBtn btn_task btn_newWb">发任务</button>
					<button wbtype="activity" type="button" onclick="showAnnouncement()"
						class="wBtn btn_meeting btn_newWb">发公告</button> -->
				</div>
				<div class="sideLinkWrap" style="top:140px">
					<div class="sideLink">
						<ul class="sideLinkUl ui-sortable" id="sideLinkUl">
							<li class="locShowDataList fwb"><a
								href="javascript:void(0);" tag="Inbox" class="showDataList">收件箱</a></li>
							<li class="locShowDataList"><a href="javascript:void(0);"
								tag="Send" class="showDataList">已发送 </a></li>
							<!-- <li class="locShowDataList"><a href="javascript:void(0);"
								tag="Draft" class="showDataList">草稿箱 </a></li> -->
							<li class="sideLine"></li>
						</ul>
						<!-- <ul class="sideLinkUl ui-sortable" id="sideLinkUl">
							<li class="locShowDataList"><a
								href="javascript:void(0);" tag="ggInbox" class="showDataList">[公告]接收</a></li>
							<li class="locShowDataList"><a href="javascript:void(0);"
								tag="ggSend" class="showDataList">[公告]发送 </a></li>
							<li class="sideLine"></li>
						</ul> -->
					</div>
				</div>
			</div>
			<div id="messageListMain" class="main">


			</div>
			<div class="dropmenu">
				<ul>
					<li>编辑</li>
					<li>删除</li>
				</ul>
			</div>
			<!--  -->
			<div id="selectmenu" class="dropmenu">
				<ul>
					<li seltype="all">全部</li>
					<li seltype="none">无</li>
					<li seltype="readed">已读</li>
					<li seltype="unreaded">未读</li>
					<li seltype="starred">已加星标</li>
					<li seltype="unstarred">未加星标</li>
				</ul>
			</div>



			<div class="pagertip">
				<span class="pagertxt">跳转到第</span> <input type="text"
					class="pageript"> <span class="pagertxt">页</span>
				<button type="button">确定</button>
			</div>

		</div>
	</div>
	<div id="writeMessage">
		<jsp:include page="writeMessage.jsp" />
	</div>
	<div id="showMessage">
	</div>
</body>
</html>