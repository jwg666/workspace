<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<link type="text/css" rel="stylesheet" href="cmsimages/css.css"/>
<title>法律援助申请表</title>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	
</script>
</head>
<body id="body">
	<div class="title">法律援助申请表1</div>
<div class="soufan">
<input type="text" style="border:none"/>
援申字[<input type="text" style="border:none"/>]第<input type="text" style="border:none"/>号</div>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" class="sq_box">
  <tr>
    <td colspan="8" class="sq_title">申请人基本情况</td>
  </tr>
  <tr>
    <td class="sq_left" width="70">姓名：</td>
    <td class="sq_right" width="80"><input type="text" style="border:0;background:transparent;" /></td>
    <td class="sq_left">性别：   </td>
    <td class="sq_right">
    	<select>
    		<option>男</option>
    		<option>女</option>
    	</select>
    </td>
    <td class="sq_left">出生年月：</td>
    <td class="sq_right">
    	<input type="text" class="easyui-datebox" style="border:0;background:transparent;"/>
    </td>
    <td class="sq_left">民族：</td>
    <td class="sq_right">
    	<input type="text"/>
    </td>
  </tr>
  <tr>
    <td class="sq_left" colspan="2" width="150">身份证号：</td>
    <td class="sq_right" colspan="6">
    <table width="100%" border="0" cellspacing="0" cellpadding="0" height="28" class="shenfenzheng">
        <tr>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td class="sq_left" colspan="2" width="150">户籍所在地：</td>
    <td class="sq_right" colspan="6">
    	<input type="text"/>
    </td>
  </tr>
  <tr>
    <td class="sq_left" colspan="2" width="150">住所地（经常居住地）：</td>
    <td class="sq_right" colspan="6">
    	<input type="text"/>
    </td>
  </tr>
  <tr>
    <td class="sq_left" colspan="2" width="150">邮政编码：</td>
    <td class="sq_right" colspan="2">
    	<input type="text"/>
    </td>
    <td class="sq_left" colspan="2" width="150">联系电话：</td>
    <td class="sq_right" colspan="2">
    	<input type="text"/>
    </td>
  </tr>
  <tr>
    <td class="sq_left" colspan="2" width="150">工作单位：</td>
    <td class="sq_right" colspan="6">
    	<input type="text"/>
    </td>
  </tr>
  <tr>
    <td colspan="8" class="sq_title">代理人基本情况</td>
  </tr>
  <tr>
    <td class="sq_left" colspan="2" width="150">姓名：</td>
    <td class="sq_right" colspan="2">
    	<input type="text"/>
    </td>
    <td class="sq_right" colspan="4"><input name="" type="checkbox" value="" />&nbsp;法定代理人&nbsp;&nbsp;&nbsp;&nbsp;<input name="" type="checkbox" value="" />&nbsp;委托代理人</td>
  </tr>
  <tr>
    <td class="sq_left" colspan="2" width="150">身份证号：</td>
    <td class="sq_right" colspan="6"><table width="100%" border="0" cellspacing="0" cellpadding="0" height="28" class="shenfenzheng">
        <tr>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td colspan="8" class="sq_title">案情及申请理由概述</td>
  </tr>
  <tr>
    <td colspan="8" class="sq_nei h350">案情及申请理由概述案情及申请理由概述<br />
		<textarea rows="13" cols=""></textarea>
	</td>
  </tr>
  <tr>
    <td colspan="8" class="sq_nei">本人承诺以上所填内容和提交的证件、证明均真实。</td>
  </tr>
  <tr>
    <td colspan="4" class="sq_nei"></td>
    <td colspan="4" class="sq_nei">申请人（签字）：</td>
  </tr>
  <tr>
    <td colspan="4" class="sq_nei"></td>
    <td colspan="4" class="sq_nei">代理人（签字）：</td>
  </tr>
  <tr>
    <td colspan="4" class="sq_nei"></td>
    <td colspan="4" class="sq_nei"></td>
  </tr>
  <tr>
    <td colspan="4" class="sq_nei"></td>
    <td colspan="4" class="sq_nei">
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input name="" type="text" class="gh_input2" size="5"/>年
    <input name="" type="text" class="gh_input2" size="5"/>月
    <input name="" type="text" class="gh_input2" size="5"/>日
</td>
  </tr>
</table>
</body>
</html>