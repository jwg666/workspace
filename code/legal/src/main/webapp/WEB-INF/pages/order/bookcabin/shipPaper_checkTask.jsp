<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<title>下货纸审核待办事项</title>
<script type="text/javascript">
var datagrid;
var searchForm;
var winPort;
var winPortGrid;
var expandIdx = -1;
$(function(){
	searchForm = $('#searchForm').form();
	datagrid = $('#datagrid').datagrid({
		fit : true,
		view: detailview,
		pagination:true,
		pageList:[15,30,45,60,75,90],
		nowrap : true,
		border : false,
		singleSelect : true,
		rowStyler: function(index,row){
			if ( row.stockNotification != null ){
				return 'color : #9400D3;';
			}
		},
		columns : [ [ 
		   { field:'ck',checkbox:true },
		   { field:'bookCode',title:'订舱号',width:110 },	
		   { field:'belongOrder',title:'关联订单',width:100 },
		   { field:'shipPaperCode',title:'下货纸号',width:100 }, 
		   
		   { field:'vessel',title:'船名 航次',width:100,formatter: function(value,row,index){
			   return row.vessel + " " + row.voyno;
		   }},  
		   { field:'goodsCount',title:'件数',width:60,align:"right" },  
		   { field:'goodsWeight',title:'重量',width:60,align:"right" },  
		   { field:'goodsSize',title:'体积',width:60,align:"right" }, 
		   { field:'shipSay',title:'箱型箱量',width:100 },  
		   
		   { field:'shipperMan',title:'发货人',width:160 },				
		   { field:'receiveMan',title:'收货人',width:160 },				
		   { field:'notifyMan',title:'通知人',width:160 },				
		   { field:'receivePlace',title:'收货地点',width:100 },
		   { field:'shipUploadPort',title:'装货港',width:100 },				
		   { field:'shipDownPort',title:'卸货港',width:100 },				
		   { field:'shipSendPort',title:'发货港',width:100 },
		   { field:'shipDestination',title:'目的地',width:100 },	
		   { field:'station',title:'场站',width:100 },				
		   { field:'bookShipDate',title:'船期',width:80,
				formatter:function(value,row,index){
					return dateFormatYMD(row.bookShipDate);
				}
			},				
		   { field:'endPortDate',title:'截港日期',width:80,
				formatter:function(value,row,index){
					return dateFormatYMD(row.endPortDate);
				}
			},				
		   { field:'endCustomDate',title:'截关日期',width:80,
				formatter:function(value,row,index){
					return dateFormatYMD(row.endCustomDate);
				}
			},				
		   { field:'upPackageDate',title:'放箱时间',width:80,
				formatter:function(value,row,index){
					return dateFormatYMD(row.upPackageDate);
				}
			},				
		   { field:'contactsMan',title:'联系人',width:100 },				
		   { field:'contactsPhone',title:'联系电话',width:80,
				formatter:function(value,row,index){
					return row.contactsPhone;
				}
			} ,
			{ field : 'attachmentFile', title : '下货纸附件', align : 'center', width:80,
				formatter : function(value, row, index) {
					if(row.attachmentFile!=null){
						return "<a href='javascript:downloadFile("+row.attachmentFile+")'>下载</a>";
					}else{
						return "未上传";
					}
				}
			}, 
     		{ field : 'stockNotification', title : '入货通知单',width:80,
     			formatter : function(value,row,index){
     				if( row.stockNotification == null ){
     					return "未上传";
     				}else{
     					return "<a href='javascript:downloadFile("+row.stockNotification+")'>下载</a>"
     				}
     			}
     		}	
		] ],
		 onBeforeLoad : function(){
			 expandIdx = -1;
		 },
		onCheck: function(index,row){
			if( expandIdx ){
				$('#ddv-'+expandIdx).datagrid("uncheckAll");
			}
		},
		detailFormatter : function(index,row){
			return '<div><table id="ddv-' + index + '"></table></div>';
		},
		onExpandRow: function(index,row){
			 if(index != expandIdx){
				 datagrid.datagrid('collapseRow',expandIdx);
    			 expandIdx = index;
			 }
			 
			 $('#ddv-'+index).datagrid({
				fitColumns : true,
				url:'${dynamicURL}/bookorder/hdconfirmAction!findSubCabinByBookCode.do?bookCode='+row.bookCode,
				border : false,
				singleSelect : true,
				height:'auto',
				//下货纸 auditFlag == 0 表示 待审核 显示背景为绿色
				rowStyler: function(index,row){
			        if (row.auditFlag=='0'){
			            return 'background-color:rgb(89, 231, 89)'; 
			        }
			    },
				columns:[[
				    {field:'ck',checkbox:true},
					{field:'bookCode',title:'订舱子编码',width:155},		
					{field:'belongOrder',title:'关联订单',width:130},	
					{field:'goodsAmount',title:'数量',width:60,align:"right"},	
					{field:'goodsCount',title:'件数',width:60,align:"right"},		
					{field:'goodsGrossWeight',title:'毛重',width:60,align:"right"},		
					{field:'goodsMesurement',title:'体积',width:60,align:"right"},	
		     		{field : 'h20', title : '20C',width:27}, 
		     		{field : 'h40', title : '40C',width:27}, 
		     		{field : 'nh40', title : '40H',width:27}, 
		     		{field : 'h45', title : '45C',width:27}
 				]],
				onLoadSuccess:function(){
				 	setTimeout(function(){
				 		datagrid.datagrid('fixDetailRowHeight',index);
				 	},0);
				},
				onCheck: function(index,row){
					datagrid.datagrid("uncheckAll");
				}
			});
			datagrid.datagrid('fixDetailRowHeight',index);
		},
		onLoadSuccess: function(data){
			var view = $(this).data().datagrid.dc.view;
			$(data.rows).each(function(i,obj){
				if( obj.subCount <= 1 ){
					 view.find("[datagrid-row-index='"+i+"']").find('[field="_expander"]').find("span").removeClass();
				}
			});
		}
	});
	
	$('#tabs').tabs({  
        border:false, 
        fit : true,
        onSelect:function(title,index){
        	datagrid.datagrid({data:[]});
        	if( index == "0" ){
        		datagrid.datagrid({
	            	pageNumber : 1,
        			url : '${dynamicURL}/bookorder/shipPaperAction!checkTask.do',
        			toolbar : [  
        				{ text : '审核', iconCls : 'icon-check', handler : quickCheck },'-'
        			]
        		});
        	}else if( index == "1" ){
        		datagrid.datagrid({
	            	pageNumber : 1,
        			url : '${dynamicURL}/bookorder/shipPaperAction!histroyCheckTask.do',
       	 		    toolbar : [  
        			    { text : '查看下货纸', iconCls : 'icon-check', handler : openDetail },'-'
        		    ]
        		});
        	}
        }  
    }); 
	$('#searchForm').find("input").keydown(function(e){
		if(e.keyCode==13){
			_search(); //处理事件
		}
	});
	
})

function openDetail(){
	if( ( datagrid.datagrid("getSelected") == null && ( expandIdx != -1 && $('#ddv-'+expandIdx).datagrid("getSelected") == null ) ) || ( datagrid.datagrid("getSelected") == null && expandIdx == -1 )){
		$.messager.alert('系统提示', '请选择一条记录！');
	}else{
		var bookCode = datagrid.datagrid("getSelected") == null ? $('#ddv-'+expandIdx).datagrid("getSelected").bookCode : datagrid.datagrid("getSelected").bookCode;
     	parent.window.HROS.window.createTemp({ title:"订单执行确认-订舱号:"+bookCode,
     	    url:"${dynamicURL}/bookorder/shipPaperAction!goPaperCheck.do?bookCode="+bookCode+"&showButtonFlag=2",
     	    width:800,height:400,isresize:false,isopenmax:true,isflash:false,customWindow:window});
    }
	
}
function quickCheck(){
	if( ( datagrid.datagrid("getSelected") == null && ( expandIdx != -1 && $('#ddv-'+expandIdx).datagrid("getSelected") == null ) ) || ( datagrid.datagrid("getSelected") == null && expandIdx == -1 )){
		$.messager.alert('系统提示', '请选择一条记录！');
	}else{
		var bookCode = datagrid.datagrid("getSelected") == null ? $('#ddv-'+expandIdx).datagrid("getSelected").bookCode : datagrid.datagrid("getSelected").bookCode;
		parent.window.HROS.window.createTemp({
			title:"订单执行确认-订舱号:"+bookCode,
			url:"${dynamicURL}/bookorder/shipPaperAction!goPaperCheck.do?bookCode="+bookCode+"&showButtonFlag=0",
			width:800,height:400,isresize:false,isopenmax:true,isflash:false,customWindow:window});
	}
}

function _search(){
	datagrid.datagrid('load', sy.serializeObject(searchForm));
}

function cleanSearch(){
	datagrid.datagrid('load',{});
	searchForm.form('clear');
}

function refreshTask(msg){
	if( msg != null && msg != "" ){
		$.messager.show({ title : '提示', msg : msg });
	}else{
		$.messager.show({ title : '提示', msg : "处理成功！" });
	}
	datagrid.datagrid('load');
	parent.window.showTaskCount();
}

function downloadFile(fileId){
	window.location.href="${dynamicURL}/basic/fileUploadAction/downloadFile.do?fileId="+fileId;
	return false;
}
</script>
</head>
<body>
     <div class="easyui-layout" data-options="fit:true"> 
        <div region="north" border="false" collapsed="false"  style="height: 29px;overflow: hidden;" align="left">
            <div id="tabs">  
                 <div title="下货纸确认待办"></div>
                 <div title="下货纸确认已办"></div>
            </div>
        </div>
        <div region="center" border="false"> 
            <div class="easyui-layout" data-options="fit:true">
                 <div region="north" border="true" title="过滤条件" collapsed="true"  style="height: 80px;overflow: hidden;" align="left">
					<form id="searchForm">
					    <div class="oneline">
						    <div class="item33">
							    <div class="itemleft">订舱编码：</div>
			                    <div class="righttext"><input name="bookCode" /></div>
						    </div>
						    <div class="item33">
							    <div class="itemleft">关联订单：</div>
			                    <div class="righttext"><input name="belongOrder" /></div>
						    </div>
						    <div class="item33 lastitem">
				           	    <div class="oprationbutt">
				                    <input type="button" onclick="_search()" value="过滤" />
				                    <input type="button" onclick="cleanSearch()" value="取消" />
				                </div>         
				            </div>
					    </div>
					</form>
	            </div>
	            <div region="center" border="false">
		            <table id="datagrid"></table>
	            </div> 
            </div>
        </div>
     </div>
</body>
</html>