<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>应用市场</title>
<link rel="stylesheet" href="${staticURL}/portal/img/ui/sys1.css">
<link rel="stylesheet" href="${staticURL}/zTree/css/zTreeStyle/zTreeStyle.css">
<link rel="stylesheet" type="text/css" href="${staticURL}/easyui3.2/themes/icon.css">
<link rel="stylesheet" type="text/css" href="${staticURL}/easyui3.4/themes/gray/easyui.css">

<script type="text/javascript" src="${staticURL}/easyui3.2/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="${staticURL}/zTree/js/jquery.ztree.all-3.1.min.js"></script>
<script type="text/javascript" src="${staticURL}/easyui3.4/jquery.easyui.min.js"></script>

<script type="text/javascript">
function removeApp(){
	var row = $("#dg").datagrid("getSelected");
	var tbid = row.app.tbid ;
	window.parent.HROS.app.remove(tbid, function(){
		window.parent.HROS.app.get();
		$('#dg').datagrid('reload');
	});
}

function openApp(){
	var row = $("#dg").datagrid("getSelected");
	var tbid = row.app.tbid ;
	window.parent.HROS.window.create(tbid);
}

function createApp(){
	var row = $("#dg").datagrid("getSelected");
	var id = row.resource.id;
	window.parent.HROS.app.add(id, function(){
		window.parent.HROS.app.get();
    	$('#dg').datagrid('reload');
	});
}

function zTreeOnClick(event, treeId, treeNode) {
	$('#dg').datagrid('load',{
    	'ac' : 'getList',
    	'id':treeNode.id
	});
}

var setting = {
		data: {
			simpleData: {
				enable: true,
				pIdKey: "parentId",
			},
			key: {
				title:"description"
			}
		},
		edit: {
			enable: true,
			showRemoveBtn: false,
			showRenameBtn: false
		},
		callback : {
			onClick: zTreeOnClick
		}
	};
var zNodes = ${appmarketLeftTree};
$(document).ready(function(){
	$.fn.zTree.init($("#tree"), setting, zNodes);
	$('#dg').datagrid({ 
      	  fit: true,
      	  border: false,
          url: 'appmarket.do',
          autoRowHeight: true,
          fitColumns: true,
          singleSelect: true,
          queryParams : {
          	'ac' : 'getList',
          	'id' : '-1'
          },
          columns:[[
              {field:'name',title:"应用列表",width:330,height:32,formatter:function(value,row,index){
      					var val = '<div style="height:36px;line-height:36px;width:99%;"><div style="float:left">';
      					var icon = row.app?row.app.icon:row.resource.iconUrl;
      					var name = row.app?row.app.name:row.resource.name;
      					icon = icon || "2067"
						val += "<img style='vertical-align:middle; margin-right:5px;width:22px;height:22px;' src='"+ parent.window.HROS.CONFIG.downloadImage + icon+"' />";
      					val += name;
   					    val += "</div>";
  						val +="<div style='float:right;height:36px;line-height:36px;'>";
      					if(row.app){
       					    val += "<a class='btn-run-s' style='margin-top:6px;float: left;height: 25px;width: 25px;' href='javascript:openApp();' title='打开应用'></a>";
      						val += "<a class='btn-remove-s' style='margin-top:6px;float: left;height: 25px;width: 25px;' href='javascript:removeApp();' title='删除应用'></a>";
      					}else{ 
      						val += "<a class='btn-add-s' style='margin-top:6px;float: left;height: 25px;width: 25px;' href='javascript:createApp();' title='添加应用'></a>";
      					}
      					val += '</div></div>';
      					return val;
      			}}
          ]]
    }); 
});
</script>
</head>
<body class="easyui-layout" fit="true">
   <div data-options="region:'west'" title="应用导航" style="width:245px;">
      <div id="appmarketLeftMenu" style="height:100%; width: 100%; overflow-x:hidden; overflow-y:auto;">
         <ul id="tree" class="ztree"></ul>
      </div>
   </div>
   <div data-options="region:'center'" >
	   <table id="dg"></table>  
   </div>
</body>
</html>

