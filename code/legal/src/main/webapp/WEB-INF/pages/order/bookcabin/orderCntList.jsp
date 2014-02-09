<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
</head>
<body>
<script type="text/javascript">
    var cntGrid;
    var editIdx = undefined;
    var columns = null;
    $(document).ready(function(){
    	if("${orderShipment}" == "01"){
    		columns = [ [  
	            { field : 'containerType', title : '箱型', width:60,
	            	editor:{
	            		type:'combobox',
	            		options:{
	            			required : true,
	            			editable : false,
	            			panelHeight : 88,
	            			textField : 'cntType',
	            			valueField : 'cntType',
	            			url : '${dynamicURL}/basic/sysCntAction!combox.do'
	            		}
	            }}, 
	            { field : 'containerQuantity', title : '箱量', width:60, 
	            	editor:{
	            		type:'validatebox',
	            		options:{
	            			required: true,
	            			validType:"number['请输入数字']"
	            		}
	            }}
	        ] ]
    	}else if("${orderShipment}" == "02"){
    		columns = [ [ 
	            { field : 'containerType', title : '运费单价', width:60,
	            	editor:{
	            		type:'validatebox',
	            		options:{
	            			required: true,
	            			validType:"number['请输入数字']"
	            		}
	            }}, 
	            { field : 'containerQuantity', title : '订单毛重', width:60, 
	            	editor:{
	            		type:'validatebox',
	            		options:{
	            			required: true,
	            			validType:"number['请输入数字']"
	            		}
	            }}
	        ] ]
    	}
    	cntGrid = $('#orderCntGrid').datagrid({
    		url : "${dynamicURL}/bookorder/bookOrderCntAction!listAll.do",
    		queryParams : {"bookCode":${bookCode}},
			iconCls : 'icon-save',
			fit : true,
			nowrap : true,
			border : false,
			showFooter: true,
			fitColumns : true,
			singleSelect : true,
            onLoadSuccess: function(){
            	$($('#orderCntGrid').datagrid("getRows")).each(function(i,row){
            		$('#orderCntGrid').datagrid('beginEdit', i);
            	});
            },
			frozenColumns : [[
  	            { field : 'bookCode', title : '订单编号', width:120}, 
	            { field : 'orderCode', title : '订单号', width:120,
	            	editor:{
	            		type:'combobox',
	            		options:{
	            			required : true,
	            			panelHeight : 88,
	            			editable : false,
	            			textField : 'orderCode',
	            			valueField : 'orderCode',
	            			url : '${dynamicURL}/bookorder/bookOrderCntAction!findOrderCodesByBookCode.do?bookCode=' + ${bookCode}
	            		}
	            }}
			]],
			columns : columns,
			toolbar: [{
				iconCls : 'icon-add',
				text : '添加',
				handler : function(){
					cntGrid.datagrid("insertRow",{
						index:0,
						row:{ "bookCode":$("#bookCode").val() }
					});
					cntGrid.datagrid('selectRow', 0).datagrid('beginEdit', 0);
				}
			},'-',{
				iconCls: 'icon-remove',
				text : '删除',
				handler: function(){
					var row = cntGrid.datagrid("getSelected");
					if( row != null ){
						var index = cntGrid.datagrid("getRowIndex",row);
						cntGrid.datagrid("deleteRow",index);
						editIdx = parseInt(index) == editIdx ? undefined : editIdx;
					}
				}
			},'-',{
				iconCls: 'icon-save',
				text : '保存',
				handler: function(){
					if( endEdit() ){
						var rowData = cntGrid.datagrid("getRows");
						if( rowData.length > 0 ){
							$.messager.progress({text:"系统处理中，请稍等...",interval:200});
							$.ajax({
								url : '${dynamicURL}/bookorder/bookOrderCntAction!updateCnt.do',
								data : {"bookOrderCnt":JSON.stringify(rowData),"orderShipment" : "${orderShipment}"},
								dataType : 'json',
								success : function(data){
									$("#actContainer").val(data.obj);
									win_oc.panel("destroy");
									$.messager.progress("close");
								}
							});
						}
					}
				}
			},'-'],
			onHeaderContextMenu : function(e,field){}
		});
    	
	});
    
    function endEdit(){
		var rlt = true;
		$(cntGrid.datagrid("getRows")).each(function(i,row){
			if (cntGrid.datagrid('validateRow', i)){
				cntGrid.datagrid('endEdit', i);
			} else {
				rlt = false;
			}
    	});
		return rlt;
	}
</script>
 <table id="orderCntGrid"></table>
 <input id="bookCode" type="hidden" value="${bookCode }"/>
</body>
</html>
