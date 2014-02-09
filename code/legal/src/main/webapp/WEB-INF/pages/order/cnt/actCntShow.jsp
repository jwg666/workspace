<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid,datagrid2;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : "${dynamicURL}/actCnt/actCntAction!datagridShow.do",
			title : '装箱跟踪主表',
			height : 150,
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			pageSize : 10,
			pageList : [ 10, 15, 20 ],
			fit : true,
			nowrap : true,
			idField : 'loadingPlanCode',
			border : false,
			fitColumns : true,
			columns : [ [ 
					{field:'ck',checkbox:true,width:10},
					{field:'loadingPlanCode',title:'装箱预编号',width:200,formatter: function(value,row,index){
						return row.loadingPlanCode + 
						"&nbsp;<font color='red'><a href='javascript:startPload(\""+row.loadingPlanCode+"\")'>查看装箱图</a></font>";
					}},
					{field:'budgetQuantity',title:'预算数量',width:60},
					{field:'scanQuantity',title:'扫描数量',width:60},
					{field:'loadingBoxCode',title:'集装箱号',width:60},
					{field:'packingType',title:'装箱类型',width:100},
					{field:'backCntDate',title:'回箱时间',width:100,
						formatter : function(value,row,index){
							return value;
					}},
					{field:'backContainFlag',title:'回箱单状态',width:90,
						formatter : function(value,row,index){
							if(row.backContainFlag == "1"){
								return "已打印";
							}else{
								return "";
							}
					}},
					{field:'cntId',title:'箱型',width:60},
			 		{field:'cntVolumeRate',title:'装箱容积率',width:90,formatter: function(value,row,index){
			 			return (Math.round(row.cntVolumeRate * 10000) / 100.00 + "%"); 
					}},
			 		{field:'loadingFlag',title:'装箱标识',width:100},
			 		{field:'factoryName',title:'工厂',width:100},
			 		{field:'countryName',title:'国家',width:100},
			 		{field:'orderExecManager',title:'订单经理',width:100},
			 		{field:'belongOrder',title:'关联订单',width:120}
			 ] ],
			toolbar : [ 
			    { text : '发送工厂', handler : sendPackingFactory }, '-', 
			    { text : '装箱获取', handler : getPackingFromFactory }, '-',
			    { text : '查看装箱图', handler : startPload }, '-',
			{
				text : '拆箱',
				handler : function (){
					devan();
				}
			}, '-',
			 { 
				text : '回箱单', handler : backPackage }, '-',],
			onClickRow : function(rowIndex, row){
				datagrid2.datagrid({
					url : "${dynamicURL}/actCnt/actCntItemAction!listAll.do",
					queryParams : {
						actCntCode:row.loadingPlanCode
					}
				});
			},
			onDblClickRow : function(rowIndex, row){
				var row = datagrid.datagrid("getSelected");
				startPload(row.loadingPlanCode);
			}
		});

		
		datagrid2 = $('#datagrid2').datagrid({
			title : '装箱跟踪明细表',
			iconCls : 'icon-save',
			fit : true,
			nowrap : true,
			border : false,
			fitColumns : true,
			
			columns : [ [ 
			        {field:'orderNum',title:'订单号',width:80},
			        {field:'orderItemCode',title:'订单行项目号',width:80},	
			        {field:'materialSetCode',title:'物料编码',width:80},
			        {field:'materialPartsCode',title:'物料分机编码',width:80},
			        {field:'haierModel',title:'海尔型号',width:80},
			        {field:'customerModel',title:'客户型号',width:80},
			        {field:'affirmNum',title:'特技单号',width:120},
			        {field:'budgetQuantity',title:'本箱数量',width:80},
			        {field:'scanQuantity',title:'已扫数量',width:60},
			        {field:'containerQuantity',title:'装箱容积率',width:80,formatter: function(value,row,index){
			 			return (Math.round(row.containerQuantity * 10000) / 100.00 + "%"); 
					}}, 
			        {field:'statusCode',title:'订舱状态',width:80}, 
			        {field:'factoryName',title:'生产工厂',width:100}, 
			        {field:'serverName',title:'服务器名称',width:160}						
			 ] ]
		});
	});
	
	function sendPackingFactory(){
		var rows = datagrid.datagrid("getSelections");
		if( rows == null || rows.length == 0 ){
			$.messager.alert("系统提示","请选择一条数据！");
		}else{
			var params = "";
			$(rows).each(function(i,row){
				params += "ids=" + row.loadingPlanCode+"&";
			});
			$.messager.progress({text:'装箱数据发送中...',interval:200});
			$.ajax({
				url:"${dynamicURL}/actCnt/actCntItemAction!sendPackingFactory.action",
				type:'post',
				data:params,
				dataType:'json',
				success:function(data){
					$.messager.progress("close");
					if(data.success){
						datagrid.datagrid("reload");
					}else{
						$.messager.alert("发送失败",data.msg);
					}
				}
			});
		}
	}
	function getPackingFromFactory(){
		var rows = datagrid.datagrid("getSelections");
		if( rows == null || rows.length == 0 ){
			$.messager.alert("系统提示","请选择一条数据！");
		}else{
			var params = "";
			$(rows).each(function(i,row){
				params += "ids=" + row.loadingPlanCode+"&";
			});
			$.messager.progress({text:'装箱数据获取中...',interval:200});
			$.ajax({
				url:"${dynamicURL}/actCnt/actCntItemAction!getPackingFromFactory.action",
				type:'post',
				data: params,
				dataType:'json',
				success:function(data){
					$.messager.progress("close");
					if(data.success){
						datagrid.datagrid("reload");
						datagrid2.datagrid("reload");
					}else{
						$.messager.alert("提示",data.msg);
					}
				}
			});
		}
	}
	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.find('input[type!="button"]').val('');
	}
	

    function plugin0(){
        return document.getElementById('plugin0');
    }
    function addEvent(obj, name, func){
        if (obj.attachEvent) {
            obj.attachEvent("on"+name, func);
        } else {
            obj.addEventListener(name, func, false); 
        }
    }        

	function startPload(){
		var row = datagrid.datagrid("getSelected");
		if(row == null){
			$.messager.alert("系统提示","请选择一条数据！");
		}else{
			var valEnvType = '${envType}';
			addEvent(plugin0(), 'pstart', function(){});
			if(valEnvType == "TEST"){
				valEnvType = "0";
			}else{
				valEnvType = "1";
			}
			try{
				plugin0().pstart(row.loadingPlanCode,valEnvType);
			}catch(error){
				$.messager.alert('提示', '请您去HROIS登录页面下载新版本的网页版本装箱软件!');
			}
		}
	}
	
	function devan(){
		$.messager.progress({
			text : '数据加载中....',
			interval : 100
		});
		var k = 0;
		var result = "";
		var para = "";
		var rows = datagrid.datagrid('getChecked');
		if(rows.length == 0){
			$.messager.progress('close');
			$.messager.alert("系统提示","请选择要拆箱数据！");
		}else{
			for(var m = 0;m < rows.length; m++){
				para = para + rows[m].loadingPlanCode + ",";
				$.ajax({
					url : "${dynamicURL}/actCnt/actCntItemAction!listAll.do",
					type:'post',
					data:{'actCntCode':rows[m].loadingPlanCode},
					dataType:'json',
					async : false,
					success:function(data){
						if(data.length > 0){
							for(var n = 0; n < data.length; n++){
								//扫描数量为0 的情况没有算    packageType
								if((null == data[n].scanQuantity && null == data[n].statusCode && data[n].packageType != 3) || (null == data[n].scanQuantity && "start" == data[n].statusCode && data[n].packageType != 3) || ("0" == data[n].scanQuantity && null == data[n].statusCode && data[n].packageType != 3) || ("0" == data[n].scanQuantity && "start" == data[n].statusCode && data[n].packageType != 3)){
									//允许拆箱的
									
								}else{
									//不允许拆箱
									k++;
								}
							}
						}
					}
				});
				if(k > 0){
					result = result + rows[m].loadingPlanCode  + "," ;
				}
			}
			if(k > 0){
				$.ajax({
					url : "${dynamicURL}/actCnt/actCntItemAction!devanBoxFlag.do",
					type:'post',
					data:{ para : para},
					dataType:'json',
					async : false,
					success:function(data){
						datagrid.datagrid('reload');
					}
				});
				$.messager.progress('close');
				$.messager.alert("拆箱失败 ! ","箱号:"+ result + "已经订舱或者扫描数量大于0,请重新确认数据!");
			}else{
				$.ajax({
					url : "${dynamicURL}/actCnt/actCntItemAction!devanBox.do",
					type:'post',
					data:{ para : para},
					dataType:'json',
					async : false,
					success:function(data){
						$.messager.alert("提示",data.msg);
						datagrid.datagrid('reload');
					}
				});
				$.messager.progress('close');
			}
		}
	}
	function backPackage(){
		var rowslength = datagrid.datagrid('getChecked')
		var rows = datagrid.datagrid('getSelected');
		if(rowslength.length == 1){
			var temoInex;
			$.ajax({
				url : "${dynamicURL}/actCnt/actCntAction!endShipPaper.do",
				type:'post',
				data:{ loadingPlanCode : rows.loadingPlanCode},
				dataType:'json',
				async : false,
				success:function(res){
					temoInex = res.obj;
				}
			});
			if(temoInex == 1){
				$.messager.alert("系统提示","请先结束下货纸确认在执行回箱单操作!","error");
			}else{
		 		actCntAppid = parent.window.HROS.window.createTemp({
					title:"海尔出口装箱理货单",
					url:"${dynamicURL}/actCnt/actCntAction!printBackPackage.do?ocode="+rows.loadingPlanCode,
					width:800,height:400,isresize:true,isopenmax:true,isflash:false,customWindow : window
				});
			}
		}else{
			$.messager.alert('提示', '请选择一条操作数据!');
		}
		
	}
</script>
</head>
<body class="easyui-layout">
	<div region="north" title="装箱跟踪" collapsed=true style="height: 80px; overflow: auto;" align="left">
		<form id="searchForm" method="post">
			<div class="oneline">
				<div class="item33">
					<div class="itemleft">装箱预编号 ：</div>
					<div class="righttext">
						<input id="loadingPlanCode" name="loadingPlanCode" style="width: 160px;" />
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">关联订单 ：</div>
					<div class="righttext">
						<input id="belongOrder" name="belongOrder" style="width: 160px;" />
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">集装箱号 ：</div>
					<div class="righttext">
						<input id="loadingBoxCode" name="loadingBoxCode" style="width: 160px;" />
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">装箱标识 ：</div>
					<div class="righttext">
						<select id="loadingFlag" name ="loadingFlag">
							<option value="2"></option>
							<option value="">未发送</option>
							<option value="0">已发送</option>
							<option value="1">装箱完毕</option>
						</select>
<!-- 						<input id="loadingFlag" name="loadingFlag" style="width: 160px;" /> -->
					</div>
				</div>
			</div>
			<div>
				<div class="item33">
					<div class="itemleft">回箱单状态 ：</div>
					<div class="righttext">
						<select id="backContainFlag" name ="backContainFlag">
							<option value=""></option>
							<option value="1">已打印</option>
						</select>
<!-- 						<input id="loadingFlag" name="loadingFlag" style="width: 160px;" /> -->
					</div>
				</div>
				<div class="item33">
					<div class="righttext">
						<input type="button" value="查  询" onclick="_search();" />
						<input type="button" value="取消" onclick="cleanSearch();" />
					</div>
				</div>
				<div class="item33">
					<div class="righttext">
					</div>
			    </div>
			</div>
		</form>
	</div>
	<div region="center" border="true" style="height: 100px;">
		<table id="datagrid"></table>
	</div>
	<div region="south" border="true" split=true style="height:180px;">
		<table id="datagrid2"></table>
	</div>
    <object id="plugin0" type="application/x-pload" style="width:0;height:0" >
        <param name="onload" value="pluginLoaded" />
    </object>
</body>
</html>