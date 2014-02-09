<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>流程跟踪图</title>

<script type="text/javascript" src="${staticURL}/scripts/jquery-1.7.2.js"></script>
<script type="text/javascript"
	src="${staticURL}/scripts/util.js"></script>

<link
	href="${staticURL}/qtip/jquery.qtip.css"
	rel="stylesheet" />
<script type="text/javascript"
	src="${staticURL}/powerFloat/jquery-powerFloat.js"></script>
<script type="text/javascript"
	src="${staticURL}/qtip/jquery.qtip.js"></script>
	<script type="text/javascript" src="${staticURL}/easyui3.4/jquery.easyui.min.js"></script>
<link
	href="${staticURL}/powerFloat/powerFloat.css"
	rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="${staticURL}/easyui3.4/themes/gray/easyui.css">
<link rel="stylesheet" type="text/css" href="${staticURL}/easyui3.2/themes/icon.css">	
<link href="${staticURL}/style/demo/css/demo.css" rel="stylesheet" />
<style type="text/css">
body {
	font-size: 12px;
	margin: -2px 0px 0px 0px; 
	padding:0px;
}
div.panel-body{
	margin: 2px 5px 0 5px;
}



ul.legendContainer {
	position: relative;
	top: 10px;
	left: 10px;
}

ul.legendContainer li {
	list-style: none;
	font-size: 14px;
	display: inline-block;
	font-weight: bold;
}

ul.legendContainer li .legend {
	width: 14px;
	height: 14px;
	border: 1px solid black;
	margin-right: 5px;
	margin-top: 2px;
	float: left;
}

.table-task {
	margin: 0 auto;
	width: 240px;
	border-collapse: collapse;
}

.table-task th {
	text-align: right;
	padding-right: 6px;
	color: #000;
	height: 32px;
	border: solid 1px #A8CFEB;
	font-weight: bold;
	text-align: right;
	font-size: 13px;
	font-weight: bold;
	padding-right: 5px;
	background-color: #edf6fc;
	padding-right: 5px;
	border: 1px solid #8dc2e3;
}

.table-task td {
	border: solid 1px #A8CFEB;
	padding-left: 6px;
	text-align: left;
}
</style>

<script type="text/javascript">
	var processInstanceId = "${processInstanceId}";
	var isStatusLoaded = false;
	var _height = 510;
	//状态数据
	var aryResult = null;
	//hjx add ifram自适应高度

	$(function() {
		
		var url="${dynamicURL}/workflow/processAction!loadImageByPid.do?processInstanceId=${processInstanceId}"
		var imgWidth;
		var imgHeight;
		$("<img/>").attr("src", url).load(function(){ 
			 imgWidth = this.width;
			 imgHeight = this.height;
			 $("#divTaskContainer").attr("style","margin:0 auto;  position: relative;background:url('"+url+"') no-repeat;width:"+imgWidth+"px;height:"+imgHeight+"px;");
			});

		
		
		
		
		$.each(
						$("div.flowNode"),
						function() {
							if ($(this).attr('type') == 'userTask'
									|| $(this).attr('type') == 'multiUserTask') {
								$(this).css('cursor', 'pointer');
								var nodeId = $(this).attr('id');
							 	var url = "${dynamicURL}/workflow/processAction!loadTaskDetail.do?processInstanceId="
										+ processInstanceId
										+ "&taskKey="
										+ nodeId;
								$(this).powerFloat({
									eventType : "click",
									target : url,
									errmsg:'暂无详情信息',
									targetMode : "ajax"
								}); 
							}
						});
		loadStatus();
	});


	//初始化qtip
	function eventHandler() {
		$("div.flowNode").each(function() {
			if (!isStatusLoaded) {
				loadStatus();
				return;
			}
			var obj = $(this);
			var taskId = obj.attr("id");
			var html = getTableHtml(taskId);
			if (!html)
				return;
			$(this).qtip({
				content : {
					text : html,
					title : {
						text : '任务执行情况'
					}
				},
				position : {
					at : 'center',
					target : 'event',
					adjust : {
						x : -15,
						y : -15
					},
					viewport : $(window)
				},
				show : {
					effect : function(offset) {
						$(this).slideDown(200);
					}
				},
				hide : {
					//event : 'mouseleave',
					fixed : true
				},
				style : {
					classes : 'ui-tooltip-light ui-tooltip-shadow'
				}
			});
		});
	}

	//加载流程状态数据。
	function loadStatus() {
				$.ajax({
				url : '${dynamicURL}/workflow/processAction!trace.do?processInstanceId=${processInstanceId}',
			dataType : 'json',
			success : function(result) {
				aryResult = result;
				
				isStatusLoaded = true;
				eventHandler();
			}
		});
	}

	//构建显示的html
	function getTableHtml(taskId) {
		var p = getNode(taskId);
		if (p == null)
			return false;
		var sb = new StringBuffer();
		var exeFullname = p.exeFullname;
		var taskName = p.taskName;
		var startTime = p.startTimeStr;
		var endTime = p.endTimeStr;
		var durTime = p.durTimeStr;
		var height=180;
		if(!endTime){
			height=210;
		}
		var html = [ '<div style="height:'+height+'px;width:240px;overflow:hidden">' ];
		

			sb.append('<table class="table-task"   cellpadding="0" cellspacing="0" border="0">');

			sb.append('<tr><th width="30%">任务名: </th>');
			sb.append('<td >' + taskName + '</td></tr>');

			sb.append('<tr><th width="30%">执行人: </th>');
			sb.append('<td >' + exeFullname + '</td></tr>');

			sb.append('<tr><th width="30%">开始时间: </th>');
			sb.append('<td >' + startTime + '</td></tr>');

			sb.append('<tr><th width="30%">结束时间: </th>');
			sb.append('<td >' + endTime + '</td></tr>');

			sb.append('<tr><th width="30%">时长: </th>');
			sb.append('<td  >' + durTime + '</td></tr>');
			
			if(!endTime){
			sb.append('<tr><th width="30%">催办: </th>');
			sb.append('<td  > <a style="cursor: pointer" onclick="sendReminders(\''+p.taskKey+'\')" herf="javascript:void(0)"><input  style="cursor: pointer" class="myButton" type="button" value="催 办"></a> ' + '' + '</td></tr>');
			}
			

			sb.append("</table><br>");
			html.push(sb.toString());
		
		html.push('</div>');
		return html.join('');
	}

	//从返回的结果中返回状态数据。
	function getNode(taskId) {
		if (aryResult == null)
			return null;
		for ( var i = 0; i < aryResult.length; i++) {
			var node = aryResult[i];
			var taskKey = node.taskKey;
			if (taskId == taskKey) {
				return node;
			}
		}
		return null;
	}
	
	function sendReminders(taskKey){
		$.ajax({
			url : '${dynamicURL}/workflow/processAction!sendReminders.do',
		dataType : 'json',
		data:{
			"processInstanceId":'${processInstanceId}',
			"taskKey":taskKey
			},
		success : function(result) {
				$.messager.alert(result.success?'成功':"失败",result.msg);
		}
	});
	}
</script>
</head>
<body>
	<div  >
		<div  >
			<ul class="legendContainer">
				<li><div style="background-color: gray;" class="legend"></div>未执行</li>
				<li><div style="background-color: #00FF00;" class="legend"></div>已执行</li>
				<li><div style="background-color: red;" class="legend"></div>当前节点</li>
				<li style="padding-left:350px;font-size: 20px">
				${processDefinitionName}
				<div style="float:right;margin-top:4%; color: red;font-size: 10px">(<b>状态：</b>${state})</div>
				</li>
			</ul>
			
			<div style="padding-top: 10px; background-color: white;">
				<div style="margin-bottom: 5px;">

				</div>
				<div id="divTaskContainer"   >
					<s:iterator value="activitiList" var="activity">
						<div class="flowNode" id="${activity.id}"
							style="position: absolute; z-index: 10; left: ${activity.x}px; top: ${activity.y}px; width: ${activity.width}px; height: ${activity.height}px; cursor: pointer;"
							title="${activity.properties['name']}"
							type="${activity.properties['type']}"></div>
					</s:iterator>
				</div>
			</div>
		</div>
	</div>


</body>
</html>