<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
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
			url : 'wlWorkAction!datagrid.do',
			title : 'VI_WL_WORK列表',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 20,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			nowrap : true,
			border : false,
			columns : [ [ 
				   {field:'bookCode',title:'订舱号',align:'left',
			  			formatter:function(value,row,index){
			  				return row.bookCode;
			  			}
			  		},				
				   {field:'orderCode',title:'订单号',align:'left',
			  			formatter:function(value,row,index){
			  				return row.orderCode;
			  			}
			  		},				
				   {field:'prodTcode',title:'产品组编码',align:'left',
			  			formatter:function(value,row,index){
			  				return row.prodTcode;
			  			}
			  		},				
				   {field:'prodType',title:'产品组名称',align:'left',
			  			formatter:function(value,row,index){
			  				return row.prodType;
			  			}
			  		},				
				   {field:'orderExecManager',title:'订单执行经理编码',align:'left',
			  			formatter:function(value,row,index){
			  				return row.orderExecManager;
			  			}
			  		},				
				   {field:'execManagerName',title:'订单执行经理',align:'left',
			  			formatter:function(value,row,index){
			  				return row.execManagerName;
			  			}
			  		},				
				   {field:'orderTransManager',title:'出口订舱经理编码',align:'left',
			  			formatter:function(value,row,index){
			  				return row.orderTransManager;
			  			}
			  		},				
				   {field:'transManagerName',title:'出口订舱经理',align:'left',
			  			formatter:function(value,row,index){
			  				return row.transManagerName;
			  			}
			  		},				
				   {field:'orderShipDate',title:'出运期',align:'left',
			  			formatter:function(value,row,index){
			  				return dateFormatYMD(row.orderShipDate);
			  			}
			  		},				
				   {field:'bookDate',title:'订舱时间',align:'left',
			  			formatter:function(value,row,index){
			  				return dateFormatYMD(row.bookDate);
			  			}
			  		},				
				   {field:'paperDate',title:'出下货纸时间',align:'left',
			  			formatter:function(value,row,index){
			  				return dateFormatYMD(row.paperDate);
			  			}
			  		},				
				   {field:'actualShipDate',title:'实际出运时间',align:'left',
			  			formatter:function(value,row,index){
			  				return dateFormatYMD(row.actualShipDate);
			  			}
			  		},				
				   {field:'xxXl',title:'箱型箱量',align:'left',
			  			formatter:function(value,row,index){
			  				return row.xxXl;
			  			}
			  		},				
				   {field:'xxXl20c',title:'20尺',align:'left',
			  			formatter:function(value,row,index){
			  				return row.xxXl20c;
			  			}
			  		},				
				   {field:'xxXl40c',title:'40尺',align:'left',
			  			formatter:function(value,row,index){
			  				return row.xxXl40c;
			  			}
			  		},				
				   {field:'xxXl40h',title:'40尺超高',align:'left',
			  			formatter:function(value,row,index){
			  				return row.xxXl40h;
			  			}
			  		},				
				   {field:'goodsCount',title:'件数',align:'left',
			  			formatter:function(value,row,index){
			  				return row.goodsCount;
			  			}
			  		},				
				   {field:'goodsGrossWeight',title:'毛总',align:'left',
			  			formatter:function(value,row,index){
			  				return row.goodsGrossWeight;
			  			}
			  		},				
				   {field:'goodsMesurement',title:'体积',align:'left',
			  			formatter:function(value,row,index){
			  				return row.goodsMesurement;
			  			}
			  		},				
				   {field:'orderDealType',title:'成交方式',align:'left',
			  			formatter:function(value,row,index){
			  				return row.orderDealType;
			  			}
			  		},				
				   {field:'vendorCode',title:'船公司编码',align:'left',
			  			formatter:function(value,row,index){
			  				return row.vendorCode;
			  			}
			  		},				
				   {field:'shipName',title:'船公司',align:'left',
			  			formatter:function(value,row,index){
			  				return row.shipName;
			  			}
			  		},				
				   {field:'shiptotalmoney',title:'运费',align:'left',
			  			formatter:function(value,row,index){
			  				return row.shiptotalmoney;
			  			}
			  		},				
				   {field:'bookAgent',title:'货代编码',align:'left',
			  			formatter:function(value,row,index){
			  				return row.bookAgent;
			  			}
			  		},				
				   {field:'agentName',title:'货代名称',align:'left',
			  			formatter:function(value,row,index){
			  				return row.agentName;
			  			}
			  		},				
				   {field:'portStartCode',title:'始发港编码',align:'left',
			  			formatter:function(value,row,index){
			  				return row.portStartCode;
			  			}
			  		},				
				   {field:'itemNameCn',title:'始发港名称',align:'left',
			  			formatter:function(value,row,index){
			  				return row.itemNameCn;
			  			}
			  		},				
				   {field:'portEndCode',title:'目的港编码',align:'left',
			  			formatter:function(value,row,index){
			  				return row.portEndCode;
			  			}
			  		},				
				   {field:'portName',title:'目的港名称',align:'left',
			  			formatter:function(value,row,index){
			  				return row.portName;
			  			}
			  		},				
				   {field:'countryCode',title:'国家编码',align:'left',
			  			formatter:function(value,row,index){
			  				return row.countryCode;
			  			}
			  		},				
				   {field:'countruName',title:'国家名称',align:'left',
			  			formatter:function(value,row,index){
			  				return row.countruName;
			  			}
			  		},				
				   {field:'hangxian',title:'航线',align:'left',
			  			formatter:function(value,row,index){
			  				return row.hangxian;
			  			}
			  		},				
				   {field:'billNum',title:'提单号',align:'left',
			  			formatter:function(value,row,index){
			  				return row.billNum;
			  			}
			  		},				
				   {field:'vessel',title:'船名/航次',align:'left',
			  			formatter:function(value,row,index){
			  				return row.vessel;
			  			}
			  		},				
				   {field:'range',title:'航程',align:'left',
			  			formatter:function(value,row,index){
			  				return row.range;
			  			}
			  		},				
				   {field:'station',title:'场站',align:'left',
			  			formatter:function(value,row,index){
			  				return row.station;
			  			}
			  		},				
				   {field:'custCompany',title:'报关公司编码',align:'left',
			  			formatter:function(value,row,index){
			  				return row.custCompany;
			  			}
			  		},				
				   {field:'custCompanyName',title:'报关公司',align:'left',
			  			formatter:function(value,row,index){
			  				return row.custCompanyName;
			  			}
			  		},				
				   {field:'custCode',title:'报关单号',align:'left',
			  			formatter:function(value,row,index){
			  				return row.custCode;
			  			}
			  		},				
				   {field:'custDate',title:'报关时间',align:'left',
			  			formatter:function(value,row,index){
			  				return dateFormatYMD(row.custDate);
			  			}
			  		},				
				   {field:'custAmount',title:'报关总额',align:'left',
			  			formatter:function(value,row,index){
			  				return row.custAmount;
			  			}
			  		},				
				   {field:'currency',title:'币种',align:'left',
			  			formatter:function(value,row,index){
			  				return row.currency;
			  			}
			  		},				
				   {field:'bussinessType',title:'贸易方式',align:'left',
			  			formatter:function(value,row,index){
			  				return row.bussinessType;
			  			}
			  		},				
				   {field:'bz',title:'备注',align:'left',
						formatter:function(value,row,index){
							return row.bz;
						}
					}				
			 ] ]
		});

	});

	function _search() {
		datagrid.datagrid("unselectAll");
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid("unselectAll");
		datagrid.datagrid('load', {});
		searchForm.form('clear');
	}
	function formatter(value,row,index){
		if(value!=null && value.length>50){
			var div = $("<div><p></p></div>");
			var inner = div.find("p");
			inner.html(value.substring(0,50));
			inner.attr('title',value);
			return div.html();
		}
		return value;
	}
</script>
</head>
<body class="easyui-layout">
	<div region="north" class="zoc" border="false" title="过滤条件" collapsed="true"  style="height: 90px;overflow: hidden;" align="left">
		<form id="searchForm">
			<div class="partnavi_zoc"><span>查询与操作：</span></div>
	            <div class="oneline">
	            <div class="item25">
	                    <div class="itemleft60">订单号：</div>
	                    <div class="righttext">
	                    	 <input name="orderCode" type="text"/>
	                    </div>
	                </div>
	                <div class="item25">
	                    <div class="itemleft60">订舱号：</div>
	                    <div class="righttext">
	                    	 <input name="bookCode" type="text"/>
	                    </div>
	                </div>
	                <div class="item33 lastitem">
				   		<div class="oprationbutt">
	                       <input type="button" onclick="_search()" value="过滤" />
	                       <input type="button" onclick="cleanSearch()" value="重置" />
		              	</div>
	                </div>
	             </div>
		</form>
	</div>
	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>
</body>
</html>