<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;

	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'legalCaseAction!datagrid.do',
			title : '案件列表',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			fitColumns : true,
			nowrap : false,
			border : false,
			idField : 'id',
			sortName : 'id',
			sortOrder : 'desc',
			frozenColumns:[[
				{field:'ck',checkbox:true,
					formatter:function(value,row,index){
						return row.id;
					}
				},
				{field:'id',title:'id',align:'center',sortable:true,
				formatter:function(value,row,index){
					return row.id;
				}
				},				

			]],
			columns : [[ 
							
			   {field:'申请人',title:'申请人',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.agentId;
					}
				},				
			   {field:'案件信息',title:'案件信息',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.createTime);
					}
				},				


			 ]],
			toolbar : [ {
				text : '会见犯罪嫌疑人、被告人公函',
				iconCls : 'icon-add',
				handler : function() {

				}
			}, '-', {
                text : '指派通知书',
                iconCls : 'icon-add',
                handler : function() {

                }
            },'-', {
				text : '司法鉴定指派通知书',
				iconCls : 'icon-add',
				handler : function() {

				}
			}, '-', {
				text : '给予法律援助决定书',
				iconCls : 'icon-add',
				handler : function() {

				}
			}, '-',  {
                text : '民事法律援助公函',
                iconCls : 'icon-add',
                handler : function() {

                }
            }, '-', {
                text : '刑事法律援助公函',
                iconCls : 'icon-add',
                handler : function() {

                }
            }, '-', {
                text : '终止法律援助公函',
                iconCls : 'icon-add',
                handler : function() {

                }
            }, '-',{
				text : '取消选中',
				iconCls : 'icon-undo',
				handler : function() {
					datagrid.datagrid('unselectAll');
				}
			}, '-' ],
			onRowContextMenu : function(e, rowIndex, rowData) {
				e.preventDefault();
				$(this).datagrid('unselectAll');
				$(this).datagrid('selectRow', rowIndex);
				$('#menu').menu('show', {
					left : e.pageX,
					top : e.pageY
				});
			}
		});


	});

	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.find('input').val('');
	}

</script>
</head>
<body class="easyui-layout">
<div region="north" split="true" style="height:10px;"  collapsed="false" border="false">
    <div class="part_zoc" style="margin:0px 0px 0px 0px;" >
        <div class="partnavi_zoc">
            <span>案件搜索</span>
        </div>
        <div class="oneline">
            <div class="item33">
                <div class="itemleft">关键字: </div>
                <div class="righttext">
                    <input name="keywords" type="text" style="width: 130px;"/>
                </div>
            </div>
        </div>
    </div>
</div>
	
	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>



</body>
</html>