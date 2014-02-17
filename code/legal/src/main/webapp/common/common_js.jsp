<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<title>法律援助综合信息平台</title>
<script type="text/javascript" src="${staticURL}/easyui3.2/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="${staticURL}/easyui3.4/jquery.easyui.min.js?v=${jsCssVersion}"></script>
<script type="text/javascript" src="${staticURL}/easyui3.2/jquery.edatagrid.js?v=${jsCssVersion}"></script>
<script type="text/javascript" src="${staticURL}/easyui3.2/MyValidater.js"></script>
<script type="text/javascript" src="${staticURL}/scripts/ajaxfileupload.js?v=${jsCssVersion}"></script>
<link rel="stylesheet" type="text/css" href="${staticURL}/easyui3.4/themes/gray/easyui.css">
<link rel="stylesheet" type="text/css" href="${staticURL}/easyui3.4/themes/icon.css">
<script type="text/javascript" src="${staticURL}/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${staticURL}/easyui3.4/datagrid-detailview.js?v=${jsCssVersion}"></script>
<script type="text/javascript" src="${staticURL}/scripts/common.js?v=${jsCssVersion}"></script>
<script type="text/javascript" src="${staticURL}/scripts/syUtil.js?v=${jsCssVersion}"></script>
<script type="text/javascript" src="${staticURL}/scripts/moment.js"></script>
<script type="text/javascript" src="${staticURL}/scripts/json2.js"></script>
<script type="text/javascript" src="${staticURL}/zeroClipboard/jquery.zclip.js"></script>
<script type="text/javascript" src="${staticURL}/easyui3.4/locale/easyui-lang-${locale}.js"></script>
<script type="text/javascript" src="${staticURL}/LODOP/LodopFuncs.js?v=${jsCssVersion}"></script>
<script type="text/javascript">
var staticURL='${staticURL}';
var dynamicURL = "${dynamicURL}";
var locale = '${locale}';
</script>
<script type="text/javascript" src="${staticURL}/scripts/WinRedo.js"></script>
<link href="${staticURL}/style/style.css?v=${jsCssVersion}" rel="stylesheet"/>
<link href="${staticURL}/style/errorMsg.css?v=${jsCssVersion}" rel="stylesheet"/>
<link href="${staticURL}/style/demo/css/demo.css?v=${jsCssVersion}" rel="stylesheet" />
<object id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0 ><embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0 style="display: block;"></embed></object>
<style type="text/css">
	.form-table { width:100%;}
	.form-table td{ border:1px solid #CCCCCC; padding:2px 5px 2px 10px;}
	.form-table th{ height:20px; line-height:20px;color:#69696b; background:#F0EFF3; padding-left:10px; border:1px solid #CCCCCC;}
	.h5{height: 5px;}
	
	/* easyui下拉选修正样式 */
	.righttext .combo{
		height:20px;
		line-height: 20px;
	}
	.righttext .combo input.combo-text {
		border: 0 none;
		height: 20px;
	}

</style>