<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<jsp:include page="/common/common_js.jsp"></jsp:include>
<link rel="stylesheet" href="${staticURL}/portal/img/ui/iframe.css">
<script type="text/javascript">
var jsonData = {                                                  
		"rows":[    
			{"field0":"全网用户关注指数（百度指数）","field1":"560","field2":"631","field3":"323   ","field4":"659   ","field5":"870    ","field6":"132.02%"},
			{"field0":"minisite平台用户浏览数    ","field1":"/","field2":"/","field3":"217749","field4":"429082","field5":"823647 ","field6":"191.96%"},
			{"field0":"虚网互动活动用户报名      ","field1":"/","field2":"/","field3":"/     ","field4":"782   ","field5":"1622   ","field6":"207.42%"},
			{"field0":"虚网互动活动用户点击      ","field1":"/","field2":"/","field3":"/     ","field4":"550890","field5":"1060696","field6":"192.54%"},
			{"field0":"全网用户关注指数（百度指数）","field1":"560","field2":"631","field3":"323   ","field4":"659   ","field5":"870    ","field6":"132.02%"},
			{"field0":"minisite平台用户浏览数    ","field1":"/","field2":"/","field3":"217749","field4":"429082","field5":"823647 ","field6":"191.96%"},
			{"field0":"虚网互动活动用户报名      ","field1":"/","field2":"/","field3":"/     ","field4":"782   ","field5":"1622   ","field6":"207.42%"},
			{"field0":"虚网互动活动用户点击      ","field1":"/","field2":"/","field3":"/     ","field4":"550890","field5":"1060696","field6":"192.54%"},
			{"field0":"全网用户关注指数（百度指数）","field1":"560","field2":"631","field3":"323   ","field4":"659   ","field5":"870    ","field6":"132.02%"},
			{"field0":"minisite平台用户浏览数    ","field1":"/","field2":"/","field3":"217749","field4":"429082","field5":"823647 ","field6":"191.96%"},
			{"field0":"虚网互动活动用户报名      ","field1":"/","field2":"/","field3":"/     ","field4":"782   ","field5":"1622   ","field6":"207.42%"},
			{"field0":"虚网互动活动用户点击      ","field1":"/","field2":"/","field3":"/     ","field4":"550890","field5":"1060696","field6":"192.54%"},
			{"field0":"全网用户关注指数（百度指数）","field1":"560","field2":"631","field3":"323   ","field4":"659   ","field5":"870    ","field6":"132.02%"},
			{"field0":"minisite平台用户浏览数    ","field1":"/","field2":"/","field3":"217749","field4":"429082","field5":"823647 ","field6":"191.96%"},
			{"field0":"虚网互动活动用户报名      ","field1":"/","field2":"/","field3":"/     ","field4":"782   ","field5":"1622   ","field6":"207.42%"},
			{"field0":"虚网互动活动用户点击      ","field1":"/","field2":"/","field3":"/     ","field4":"550890","field5":"1060696","field6":"192.54%"},
			{"field0":"<a href='./Demo/welcome_iframe3_tab4_open.html'  target='_blank'>互动中获取用户创意抱怨数量</a> ","field1":"/","field2":"/","field3":"/     ","field4":"70    ","field5":"131    ","field6":"187.14%"}
		]                                                          
	}
$(function(){
	$("#datagrid").datagrid('loadData',jsonData);
});
</script>
</head>
<body>			
			<div id="tabs_id" class="easyui-tabs" data-options="fit:true" >
        		<div title="待办任务">
					<!--展开之后的content-part所显示的内容-->
				<table class="table2" cellpadding="0" cellspacing="0">
				<tr>
					<th>订单号</th>
					<th>价格条款</th>
					<th>产品</th>
					<th>出运期</th>
					<th>订单数量</th>
					<th>成交币种</th>
					<th>订单金额</th>
					<th>运费</th>
					<th>保费</th>
					<th>操作</th>
				</tr>
				<tr class="bgc1">
					<td>2003432323</td>
					<td>FOB</td>
					<td>10</td>
					<td>2013-02-11 22:11:35</td>
					<td>2344</td>
					<td>USD</td>
					<td>435200</td>
					<td>32003</td>
					<td>10000</td>
					<td><a href="#">T模式</a></td>
				</tr>
				<tr class="bgc2">
					<td>2003432323</td>
					<td>FOB</td>
					<td>10</td>
					<td>2013-02-11 22:11:35</td>
					<td>2344</td>
					<td>USD</td>
					<td>435200</td>
					<td>32003</td>
					<td>10000</td>
					<td><a href="#">T模式</a></td>
				</tr>
				<tr class="bgc1">
					<td>2003432323</td>
					<td>FOB</td>
					<td>10</td>
					<td>2013-02-11 22:11:35</td>
					<td>2344</td>
					<td>USD</td>
					<td>435200</td>
					<td>32003</td>
					<td>10000</td>
					<td><a href="#">T模式</a></td>
				</tr>
				<tr class="bgc2">
					<td>2003432323</td>
					<td>FOB</td>
					<td>10</td>
					<td>2013-02-11 22:11:35</td>
					<td>2344</td>
					<td>USD</td>
					<td>435200</td>
					<td>32003</td>
					<td>10000</td>
					<td><a href="#">T模式</a></td>
				</tr>
				<tr class="bgc1">
					<td>2003432323</td>
					<td>FOB</td>
					<td>10</td>
					<td>2013-02-11 22:11:35</td>
					<td>2344</td>
					<td>USD</td>
					<td>435200</td>
					<td>32003</td>
					<td>10000</td>
					<td><a href="#">T模式</a></td>
				</tr>
				<tr class="bgc2">
					<td>2003432323</td>
					<td>FOB</td>
					<td>10</td>
					<td>2013-02-11 22:11:35</td>
					<td>2344</td>
					<td>USD</td>
					<td>435200</td>
					<td>32003</td>
					<td>10000</td>
					<td><a href="#">T模式</a></td>
				</tr>
				<tr class="bgc1">
					<td>2003432323</td>
					<td>FOB</td>
					<td>10</td>
					<td>2013-02-11 22:11:35</td>
					<td>2344</td>
					<td>USD</td>
					<td>435200</td>
					<td>32003</td>
					<td>10000</td>
					<td><a href="#">T模式</a></td>
				</tr>
				<tr class="bgc2">
					<td>2003432323</td>
					<td>FOB</td>
					<td>10</td>
					<td>2013-02-11 22:11:35</td>
					<td>2344</td>
					<td>USD</td>
					<td>435200</td>
					<td>32003</td>
					<td>10000</td>
					<td><a href="#">T模式</a></td>
				</tr>
				<tr class="bgc1">
					<td>2003432323</td>
					<td>FOB</td>
					<td>10</td>
					<td>2013-02-11 22:11:35</td>
					<td>2344</td>
					<td>USD</td>
					<td>435200</td>
					<td>32003</td>
					<td>10000</td>
					<td><a href="#">T模式</a></td>
				</tr>
				<tr class="bgc2">
					<td>2003432323</td>
					<td>FOB</td>
					<td>10</td>
					<td>2013-02-11 22:11:35</td>
					<td>2344</td>
					<td>USD</td>
					<td>435200</td>
					<td>32003</td>
					<td>10000</td>
					<td><a href="#">T模式</a></td>
				</tr>
				<tr class="bgc1">
					<td>2003432323</td>
					<td>FOB</td>
					<td>10</td>
					<td>2013-02-11 22:11:35</td>
					<td>2344</td>
					<td>USD</td>
					<td>435200</td>
					<td>32003</td>
					<td>10000</td>
					<td><a href="#">T模式</a></td>
				</tr>
				<tr class="bgc2">
					<td>2003432323</td>
					<td>FOB</td>
					<td>10</td>
					<td>2013-02-11 22:11:35</td>
					<td>2344</td>
					<td>USD</td>
					<td>435200</td>
					<td>32003</td>
					<td>10000</td>
					<td><a href="#">T模式</a></td>
				</tr>
				<tr class="bgc1">
					<td>2003432323</td>
					<td>FOB</td>
					<td>10</td>
					<td>2013-02-11 22:11:35</td>
					<td>2344</td>
					<td>USD</td>
					<td>435200</td>
					<td>32003</td>
					<td>10000</td>
					<td><a href="#">T模式</a></td>
				</tr>
				<tr class="bgc2">
					<td>2003432323</td>
					<td>FOB</td>
					<td>10</td>
					<td>2013-02-11 22:11:35</td>
					<td>2344</td>
					<td>USD</td>
					<td>435200</td>
					<td>32003</td>
					<td>10000</td>
					<td><a href="#">T模式</a></td>
				</tr>
				<tr class="bgc1">
					<td>2003432323</td>
					<td>FOB</td>
					<td>10</td>
					<td>2013-02-11 22:11:35</td>
					<td>2344</td>
					<td>USD</td>
					<td>435200</td>
					<td>32003</td>
					<td>10000</td>
					<td><a href="#">T模式</a></td>
				</tr>
				<tr class="bgc2">
					<td>2003432323</td>
					<td>FOB</td>
					<td>10</td>
					<td>2013-02-11 22:11:35</td>
					<td>2344</td>
					<td>USD</td>
					<td>435200</td>
					<td>32003</td>
					<td>10000</td>
					<td><a href="#">T模式</a></td>
				</tr>
				<tr class="bgc1">
					<td>2003432323</td>
					<td>FOB</td>
					<td>10</td>
					<td>2013-02-11 22:11:35</td>
					<td>2344</td>
					<td>USD</td>
					<td>435200</td>
					<td>32003</td>
					<td>10000</td>
					<td><a href="#">T模式</a></td>
				</tr>
				<tr class="bgc2">
					<td>2003432323</td>
					<td>FOB</td>
					<td>10</td>
					<td>2013-02-11 22:11:35</td>
					<td>2344</td>
					<td>USD</td>
					<td>435200</td>
					<td>32003</td>
					<td>10000</td>
					<td><a href="#">T模式</a></td>
				</tr>
				<tr class="bgc1">
					<td>2003432323</td>
					<td>FOB</td>
					<td>10</td>
					<td>2013-02-11 22:11:35</td>
					<td>2344</td>
					<td>USD</td>
					<td>435200</td>
					<td>32003</td>
					<td>10000</td>
					<td><a href="#">T模式</a></td>
				</tr>
				<tr class="bgc2">
					<td>2003432323</td>
					<td>FOB</td>
					<td>10</td>
					<td>2013-02-11 22:11:35</td>
					<td>2344</td>
					<td>USD</td>
					<td>435200</td>
					<td>32003</td>
					<td>10000</td>
					<td><a href="#">T模式</a></td>
				</tr>
				<tr class="bgc1">
					<td>2003432323</td>
					<td>FOB</td>
					<td>10</td>
					<td>2013-02-11 22:11:35</td>
					<td>2344</td>
					<td>USD</td>
					<td>435200</td>
					<td>32003</td>
					<td>10000</td>
					<td><a href="#">T模式</a></td>
				</tr>
				<tr class="bgc2">
					<td>2003432323</td>
					<td>FOB</td>
					<td>10</td>
					<td>2013-02-11 22:11:35</td>
					<td>2344</td>
					<td>USD</td>
					<td>435200</td>
					<td>32003</td>
					<td>10000</td>
					<td><a href="#">T模式</a></td>
				</tr>
			</table>
				</div>
        		<div title="全部任务">
        		
					<table class="easyui-datagrid" id="datagrid" data-options="singleSelect:true,collapsible:false,fit:true,fitColumns:true,striped: true">
						<thead>
							<tr>
								<th data-options="field:'field0',width:180,align:'left'">虚网营销指标</th>
								<th data-options="field:'field1',width:60,align:'center'">2012年Q4</th>
								<th data-options="field:'field2',width:60,align:'center'">2013年1月</th>
								<th data-options="field:'field3',width:60,align:'center'">2013年2月</th>
								<th data-options="field:'field4',width:60,align:'center'">2013年3月</th>
								<th data-options="field:'field5',width:60,align:'center'">2013年4月</th>
								<th data-options="field:'field6',width:60,align:'center'">月度环比</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		
		
		
		<!-- 以下js不要动 -->
		<script type="text/javascript">
			/* 让iframe支持桌面滑动切屏 */
			$(function(){
				window.parent.$(document).bind("swipeleft",window.parent.HROS.navbar.switchLeft);
				window.parent.$(document).bind("swiperight",window.parent.HROS.navbar.switchRight);
			})
		</script>
</body>
</html>
