<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link type="text/css" rel="stylesheet" href="cmsimages/css.css"/>
<jsp:include page="/common/common_js.jsp"></jsp:include>
        <style type="text/css">
        td_line
        {
                border-bottom-width: 1px;
                border-bottom-style: solid;
        }
        </style>
<script type="text/javascript" charset="utf-8">
function dayin(){
 	var printObj = $("#printBody").clone(true);
	printObj.width(1220);
	printObj.find("#optBnts").remove();
	printObj = gridToTable(printObj);
	printObj.find("#datagridDiv table").addClass("table2").width("100%").parent().addClass("part_zoc").width("100%");
	lodopPrintAutoWidth(printObj);
}
</script>
<title>给予法律援助决定书</title>
</head>

<body id="body">
<div  style="overflow: auto;min-width: 1220px" align="center"  id="printBody" >
<div class="title">指派通知书</div>
<div class="soufan" style="width: 50%">
<s:textfield id="legalWord" name="legalCaseQuery.legalWord" type="text" style="border:none"/>
<font size=4>援申字[</font><s:textfield id="legalCode" name="legalCaseQuery.legalCode" type="text" style="border:none"/><font size=4>]第</font><s:textfield id="legalNo" name="legalCaseQuery.legalNo" type="text" style="border:none"/><font size=4>号</font></div>

 <table style="border:0;" width="50%"  cellspacing="0"  cellpadding="0" align="center" >

  <tr style="height:30px;">
    
    <td  width="20%"><nobr><font size=4>发往单位：</font></nobr></td>
    <td  width="80%" align="left" >
        <s:textfield type="text" id="departmentQueryname" name="departmentQuery.name" style="border:0;background:transparent; width: 600px"/>
    </td>
  </tr>
  <tr style="height:30px;">
        <td  width="20%"><nobr><font size=4>受援人：</font></nobr></td>
        <td  width="80%" align="left">
        <s:textfield type="text" id="legalApplicantQueryname" name="legalApplicantQuery.name" style="border:0;background:transparent; width: 600px"/>
    </td>
  </tr >
   <tr style="height:30px;">
        <td width="20%" ><nobr><font size=4>案由：</font></nobr></td>
        <td width="80%" align="left">
        <s:textfield type="text" id="legalApplicantQueryname" name="legalApproveQuery.approveContent" style="border:0;background:transparent; width: 600px"/>
    </td>
  </tr>
   <tr style="height:30px;">
        <td  width="20%"><nobr><font size=4>经办人：</font></nobr></td>
        <td width="80%" align="left">
        <s:textfield type="text" id="legalApplicantQueryname" name="" style="border:0;background:transparent; width: 600px"/>
    </td>
  </tr>
     <tr style="height:30px;">
        <td  width="20%"><nobr><font size=4>日期：</font></nobr></td>
        <td width="80%" align="left">
        <s:textfield type="text" id="legalApplicantQueryname" name="" style="border:0;background:transparent; width: 600px"/>
    </td>
  </tr>
  <tr style="height:30px;"></tr>
</table>
<hr />
<br />
<br />
<br />
<div class="title">指派通知书</div>
<div class="soufan" style="width: 50%">
<s:textfield id="legalWord" name="legalCaseQuery.legalWord" type="text" style="border:none"/>
<font size=4>援申字</font>[<s:textfield id="legalCode" name="legalCaseQuery.legalCode" type="text" style="border:none"/>]<font size=4>第</font><s:textfield id="legalNo" name="legalCaseQuery.legalNo" type="text" style="border:none"/><font size=4>号</font></div>

 <table style="border:0;" width="50%"  cellspacing="0"  cellpadding="0" align="center" >
 
    <tr style="height:30px;">
    
    <td  width="30%"><input id="kindOfCrowd14" name="kindOfCrowdOther" type="text" class="sq_input" size="17" />：</td>
    <td  width="70%" align="left" >
        
    </td>
  </tr>
  <tr style="height:30px;">
      <td><div style="letter-spacing: 7px;"><nobr><font size=4>本中心(处)决定对<input id="kindOfCrowd14" name="kindOfCrowdOther" type="text" class="sq_input" size="25" />一案提供法律援助，现</font></nobr></div> </td>
  </tr>
    <tr style="height:30px;">
      <td><div style="letter-spacing: 7px;"><nobr><font size=4>指派你单位承办该案，自收到本通知书之日起<input id="kindOfCrowd15" name="kindOfCrowdOther1" type="text" class="sq_input" size="10" />个工作日内 </font></nobr></div></td>
  </tr>
    <tr style="height:30px;">
      <td><div style="letter-spacing: 7px;"><nobr><font size=4>安排合适承办人，并自安排之日起5个工作日内将承办人姓名和联系</font></nobr></div></td>
    </tr>
        <tr style="height:30px;">
      <td><div style="letter-spacing: 7px;"><nobr><font size=4>安排合适承办人，并自安排之日起5个工作日内将承办人姓名和联系</font></nobr></div></td>
    </tr>
     <tr style="height:30px;">
      <td><div style="letter-spacing: 7px;"><nobr><font size=4>方式告知受援人和本中心（处），与受援人或其法定代理人、近亲属</font></nobr></div></td>
    </tr>
     <tr style="height:30px;">
      <td><div style="letter-spacing: 7px;"><nobr><font size=4>签订委托代理辩护协议</font></nobr></div></td>
    </tr>
 </table>
 
 <table style="border:0;" width="50%"  cellspacing="0"  cellpadding="0" align="center" >

  <tr style="height:30px;">
    
    <td  width="30%"><nobr><font size=4>法律援助中心(处)：</font></nobr></td>
    <td  width="70%" align="left" >
        <s:textfield type="text" id="" name="" style="border:0;background:transparent; width: 600px"/>
    </td>
  </tr>
  <tr style="height:30px;">
        <td  width="30%"><nobr><font size=4>联系人：</font></nobr></td>
        <td  width="70%" align="left">
        <s:textfield type="text" id="legalApplicantQueryname" name="" style="border:0;background:transparent; width: 600px"/>
    </td>
  </tr >
   <tr style="height:30px;">
        <td width="30%" ><nobr><font size=4>联系方式：</font></nobr></td>
        <td width="70%" align="left">
        <s:textfield type="text" id="legalApplicantQueryname" name="" style="border:0;background:transparent; width: 600px"/>
    </td>
  </tr>
  <tr style="height:30px;"></tr>
  <tr style="height:30px;"></tr>
  <tr style="height:30px;"></tr>
     <tr style="height:30px;">
        <td width="30%" ></td>
        <td width="70%" style="text-align:right;" >
        	<img alt="公章" src="../legal/images/yinzhang.gif" width="100px" height="100px">
        </td>
  </tr>
       <tr style="height:30px;">
        <td width="30%" ></td>
        <td width="70%" style="text-align:right;">
        <div style="letter-spacing: 7px;"><nobr><font size=4><input id="kindOfCrowd15" name="kindOfCrowdOther1" type="text" class="sq_input" size="10" />年<input id="kindOfCrowd15" name="kindOfCrowdOther1" type="text" class="sq_input" size="10" />月<input id="kindOfCrowd15" name="kindOfCrowdOther1" type="text" class="sq_input" size="10" />日 </font></nobr></div>
        </td>
  </tr>
  <tr>
    <td colspan="2" style="text-align:center;">
        <input type="button" value="打印" style="width: 60px;" onclick="dayin()" />
    </td>
  </tr>
</table>
</div>
</body>
</html>
