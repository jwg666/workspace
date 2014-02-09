<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var dialog;
	var win_mdmDataLoad;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
	    
	    $('#countryId').combobox({
	    	url:'${dynamicURL}/basic/countryAction!combox.action',  
	        valueField:'countryCode',  
	        textField:'name' 
	    });
	    $('#deptcodeId').combobox({
	    	url:'${dynamicURL}/security/departmentAction!combox.action?deptType=1',  
	        valueField:'deptCode',  
	        textField:'deptNameCn' 
	    });
	    
		datagrid = $('#datagrid').datagrid({
			url : '${dynamicURL}/basic/customerAction!datagrid1.do',
			title : '客户主数据列表',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			//fitColumns : true,
			nowrap : true,
			border : false,
			//singleSelect：true,
			//idField : 'customerId',
			
			columns : [ [ 
			{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.customerId;
						}
					},
			   {field:'customerId',title:'客户编码',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.customerId;
					}
				},
			   {field:'name',title:'客户名称',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.name;
					}
				},				
			   {field:'deptCode',title:'经营体',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.deptCode;
					}
				},
			   {field:'countryId',title:'国家',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.countryId;
					}
				},				
			   {field:'activeFlag',title:'有效标识',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						if(row.activeFlag==null){
							return '状态为空';
						}else if(row.activeFlag=='0'){
							return '无效';
						}else if(row.activeFlag=='1'){
							return '有效';
						}else{
						    return '状态无法识别';
						}
					}
				}			
			 ] ],
			toolbar : [ {
				text : '显示详细',
				iconCls : 'icon-add',
				handler : function() {
					showextends1();
				}
			},'-',{
				text : 'MDM取数',
				iconCls : 'icon-add',
				handler : openWinmdmDataLoad
			}, '-'/* ,{
				text : '增加',
				iconCls : 'icon-add',
				handler : function() {
					add();
				}
			}, '-', {
				text : '删除',
				iconCls : 'icon-remove',
				handler : function() {
					del();
				}
			}, '-', {
				text : '修改',
				iconCls : 'icon-edit',
				handler : function() {
					edit();
				}
			}, '-', {
				text : '取消选中',
				iconCls : 'icon-undo',
				handler : function() {
					datagrid.datagrid('unselectAll');
				}
			} */ ] ,
			onDblClickRow : function( rowIndex, rowData) {
				showextends2(rowData.customerId,rowData.name)
			} 
		  });
		
		win_mdmDataLoad = $("#WIN_MdmDataLoad").show().dialog({
			title : 'MDM数据抓取',
			modal : true,
			closed : true,
			width : 300,
			height : 180,
			buttons : [ {
				text : '确定',
				iconCls : 'icon-save',
				handler : loadMdmData
			}]
		});
	});
	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.form('clear');
	}
	function showextends1(){
		var rows = datagrid.datagrid('getSelections');
		if(rows!=null&&rows.length==1){
			var url='${dynamicURL}/basic/customerAction!gocustomerExcends.do?customerId='+rows[0].customerId+'&name='+rows[0].name;
			dialog=$('#iframeDialog').show().dialog({
				title : '客户'+rows[0].name+'的补充信息',
				modal : true,
				closed : true,
				minimizable : true,
				maximizable : true,
				width:800,
				height:200
			});
			$('#iframe').attr('src',url);
			dialog.dialog("open");
		}else{
			$.messager.alert('警告','请选择一条数据','warring');
		}
	}
	function showextends2(customerId,name){
		var url='${dynamicURL}/basic/customerAction!gocustomerExcends.do?customerId='+customerId+'&name='+name;
		dialog=$('#iframeDialog').show().dialog({
			title : '客户'+name+'的补充信息',
			modal : true,
			closed : true,
			minimizable : true,
			maximizable : true,
			width:800,
			height:200
		});
		$('#iframe').attr('src',url);
		dialog.dialog("open");
	}
	function openWinmdmDataLoad(){
		win_mdmDataLoad.panel("open");
	}
	
	function loadMdmData(){
		if($("#mdmDataLoadForm").form("validate")){
			$.messager.progress({text:"数据抓取中，请稍等..."});
			$("#mdmDataLoadForm").form("submit",{
				url : "${dynamicURL}/basic/customerAction!loadMdmData.do",
				success : function(data){
					$.messager.progress("close");
					$("#mdmDataLoadForm").form("clear");
					win_mdmDataLoad.panel("close");
					datagrid.datagrid("reload");
				}
			});
		}
	}
</script>
</head>
<body class="easyui-layout">
				<div class="zoc" region="north" border="false" collapsible="true"
					title="查询" collapsed="false" style="height: 90px; overflow: hidden;">
		<form id="searchForm">			
			<div class="oneline">
				<div class="item25">
					<div class="itemleft80">客户编码:</div>
					<div class="righttext_easyui">
						<s:textfield name="customerId" type="text" cssClass="short50">
						</s:textfield>
					</div>
				</div>
				<div class="item25">
					<div class="itemleft80">客户名称:</div>
					<div class="righttext_easyui">
						<s:textfield name="name" type="text" cssClass="short50">
						</s:textfield>
					</div>
				</div>
				<div class="item25">
					<div class="itemleft80">国家:</div>
					<div class="righttext_easyui">
						<input name="countryId" id="countryId" type="text" class="short50" />
					</div>
				</div>
				<div class="item25">
					<div class="itemleft80">经营体:</div>
					<div class="righttext_easyui">
						<s:textfield name="deptCode" id="deptcodeId" type="text" cssClass=" short50">
						</s:textfield>
					</div>
				</div>
			</div>
		<div class="oneline">	
		        <div class="item25">
		            <div class="itemleft80">是否有效:</div>
		            <div class="righttext_easyui">
		                <input class="easyui-combobox short50" name="activeFlag" type="text" data-options="
		                 valueField: 'label',
		                 textField: 'value',
		                 data: [{
			             label: '0',
			             value: '无效'
		                 },{
			             label: '1',
			             value: '有效'
		                 }]" />
		            </div>
		        </div>
			   <div class="item25">
					<div class="oprationbutt">
						<input type="button" onclick="_search();" value="查  询" /> <input
							type="button" onclick="cleanSearch();" value="重置" />
					</div>
				</div>
			</div>
		</form>
	</div>
	
	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>
	
	<div id="iframeDialog" >
	<iframe name="iframe" id="iframe" src="#"  scrolling="auto" frameborder="0" style="width:100%;height:99%;">
    </iframe>
    </div>
    
    <div id="WIN_MdmDataLoad" style="display: none;">
        <form id="mdmDataLoadForm" method="post">
            <div style="height: 32px; margin-top:20px;">
                <span style="padding:10px;">客户编号:</span><input name="customerId" type="text" style="width:149px;" class="easyui-validatebox" data-options="required:true"/>
			</div>
<!--             <div style="height: 32px;"> -->
<!--                 <span style="padding:10px;">开始时间:</span><input name="lastUpd" class="easyui-datebox" editable="false"/> -->
<!-- 			</div> -->
        </form>
    </div>
</body>
</html>