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
var applicantid='${applicantId}';
var agentid='${agentId}';
var caseId='${caseId}';
$(function(){
	$("#applicantnationId").combobox({
	    url:'../basic/dictionaryAction!combox.do?parentCode=3',
	    valueField:'id',
	    textField:'dicValue'
	});
	setvalue(applicantid,agentid,caseId);
	
	$("#getSignButton").click(function (){
		var SignPlugin = $("#signApplet");
		var id = SignPlugin.getSignId();
	});
});
function setvalue(applicantid,agentid,caseId){
	if(applicantid!=null&&applicantid!=''){
		getapplicant(applicantid);
	}
	if(agentid!=null&&agentid!=''){
		getagent(agentid);
	}
	if(caseId!=null&&caseId!=''){
		getcase(caseId);
	}
}
//加载申请人信息
function getapplicant(applicant){
	$.ajax({
		url:'legalApplicantAction!getdesc.do',
		dataType:'json',
		data:{
			id:applicantid
		},
		success:function(data){
			if(data.success){
				//applicantid=data.obj.id;
				//submitLegalAgent();
				$('#applicantname').val(data.obj.name);
				$('#applicantgender').val(data.obj.gender);
				$('#applicantbirthday').datebox('setValue',data.obj.birthday);
				$('#applicantnationId').combobox('setValue',data.obj.nationId);
				var identifyid=data.obj.identifyid;
				if(identifyid!=null&&identifyid!=''){
					for(var i=0;i<identifyid.length;i++){
						var stringid='#applicantstring'+i;
						$(stringid).val(identifyid.charAt(i));
					}
				}
				
				$('#applicntbirthPlace').val(data.obj.birthPlace);
				$('#applicantlivePlace').val(data.obj.livePlace);
				$('#applicantpostCode').val(data.obj.postCode);
				$('#applicantphone').val(data.obj.phone);
				$('#applicantcompany').val(data.obj.company);
			}else{
				$.messager.alert('提示',data.msg,'info');
			}
		}
	});
}
//加载代理人信息
function getagent(agentid){
	$.ajax({
		url : 'legalAgentAction!getDesc.do',
		dataType:'json',
		data:{
			id:agentid
		},
		success:function(data){
			if(data.success){
				//agentid=data.obj.id;
				//submitLegalCase();
				$('#agentName').val(data.obj.name);
				
				var agentType=data.obj.name;
				if(agentType!=null&&agentType!=''){
					var agents=document.getElementsByName('agentType');
					for(var i=0;i<agents.length;i++){
						if(agents[i].value==agentType){
							agents[i].checked;
						}
					}
				}
				//代理人身份证号码
				var identifyid=data.obj.identifyid;
				if(identifyid!=null&&identifyid!=''){
					for(var i=0;i<identifyid.length;i++){
						var stringid='#agentstring'+i;
						$(stringid).val(identifyid.charAt(i));
					}
				}

			}else{
				$.messager.alert('提示',data.msg,'info');
			}
		}
	});
}
function getcase(caseId){
	$.ajax({
		url : 'legalCaseAction!getDesc.do',
		dataType:'json',
		data:{
			id:caseId
		},
		success:function(data){
			if(data.success){
				$('#description').val(data.obj.description);
				$('#year').val(data.obj.year);
				$('#month').val(data.obj.month);
				$('#day').val(data.obj.day);
				$('#legalCode').val(data.obj.legalCode);
				$('#legalWord').val(data.obj.legalWord);
				$('#legalNo').val(data.obj.legalNo);
				
			}else{
				$.messager.alert('提示',data.msg,'error');
			}
		}
	});
}
function legalApplicantAddForm(){
	//获得姓名
	var name=$('#applicantname').val();
	//性别
	var gender=$('#applicantgender').val();
	//出生日期
	var birthday = $('#applicantbirthday').datebox('getValue');
	//民族
	var nationId = $('#applicantnationId').combobox('getValue');
	//生份证号
	var identifyid='';
	for(var i=1;i<19;i++){
		var stringid='#applicantstring'+i;
		identifyid=identifyid+$(stringid).val();
	}
	//户籍所在地
	var birthPlace=$('#applicntbirthPlace').val();
	//常住地
	var livePlace=$('#applicantlivePlace').val();
	//邮政编码
	var postCode=$('#applicantpostCode').val();
	//联系电话
	var phone=$('#applicantphone').val();
	//工作单位
	var company=$('#applicantcompany').val();
	$.ajax({
		url:'legalApplicantAction!addorupdate.do',
		dataType:'json',
		data:{
			id:applicantid,
			name:name,
			gender:gender,
			birthday:birthday,
			nationId:nationId,
			identifyid:identifyid,
			birthPlace:birthPlace,
			livePlace:livePlace,
			postCode:postCode,
			phone:phone,
			company:company
		},
		success:function(data){
			if(data.success){
				applicantid=data.obj.id;
				$.messager.alert('提示',data.msg,'info');
				//submitLegalAgent();
			}else{
				$.messager.alert('提示',data.msg,'info');
			}
		}
	});
}
function submitLegalAgent(){
	//代理人姓名
	var name=$('#agentName').val();
	var agentType=''; 
	var agents=document.getElementsByName('agentType');
	for(var i=0;i<agents.length;i++){
		if(agents[i].checked){
			agentType=agents[i].value;
		}
	}
	//代理人身份证号码
	var identifyid='';
	for(var i=1;i<19;i++){
		var stringid='#agentstring'+i;
		identifyid=identifyid+$(stringid).val();
	}

	if(applicantid!=null&&applicantid!=''){
		$.ajax({
			url : 'legalAgentAction!addorupdate.do',
			dataType:'json',
			data:{
				id:agentid,
				applicantId:applicantid,
				name:name,
				identifyid:identifyid,
				agentType:agentType
			},
			success:function(data){
				if(data.success){
					agentid=data.obj.id;
					$.messager.alert('提示',data.msg,'info');
					//submitLegalCase();
				}else{
					$.messager.alert('提示',data.msg,'info');
				}
			}
		});
	}else{
		$.messager.alert('提示','请先保存申请人信息','warring');
	}
	
	
}
function submitLegalCase(){
	//申请人信息id
	var applicantId=applicantid;
	//代理人信息id
	var agentId=agentid;
	//描述
		//yes代表启动工作流
	var ifqiDong='no';
	var description=$('#description').val();
	var legalCode=$('#legalCode').val();
	var legalWord=$('#legalWord').val();
	var legalNo=$('#legalNo').val();
	
	if(applicantId!=null&&applicantId!=''){
		if(agentId!=null&&agentId!=''){
			$.ajax({
				url : 'legalCaseAction!addAndStart.do',
				dataType:'json',
				data:{
					id:caseId,
					ifqiDong:ifqiDong,
					applicantId:applicantId,
					agentId:agentId,
					description:description,
					legalCode:legalCode,
					legalWord:legalWord,
					legalNo:legalNo
				},
				success:function(data){
					if(data.success){
						caseId=data.obj.id
						$.messager.alert('提示',data.msg,'info',function(){
								parent.clasedialog();
						});
					}else{
						$.messager.alert('提示',data.msg,'error');
					}
				}
			});
		}else{
			$.messager.alert('提示','请先保存代理人信息','warring');
		}
	}else{
		$.messager.alert('提示','请先保存申请人信息和代理人信息','warring');
	}
	
}
function submitLegalCaseqidong(){
	//申请人信息id
	var applicantId=applicantid;
	//代理人信息id
	var agentId=agentid;
	//yes代表启动工作流
	var ifqiDong='yes';
	//描述
	var description=$('#description').val();
	var legalCode=$('#legalCode').val();
	var legalWord=$('#legalWord').val();
	var legalNo=$('#legalNo').val();
	if(applicantId!=null&&applicantId!=''){
		if(agentId!=null&&agentId!=''){
			$.ajax({
				url : 'legalCaseAction!addAndStart.do',
				dataType:'json',
				data:{
					id:caseId,
					ifqiDong:ifqiDong,
					applicantId:applicantId,
					agentId:agentId,
					description:description,
					legalCode:legalCode,
					legalWord:legalWord,
					legalNo:legalNo
				},
				success:function(data){
					if(data.success){
						$.messager.alert('提示',data.msg,'info',function(){
								parent.clasedialog();
						});
					}else{
						$.messager.alert('提示',data.msg,'error');
					}
				}
			});
		}else{
			$.messager.alert('提示','请先保存代理人信息','warring');
		}
	}else{
		$.messager.alert('提示','请先保存申请人信息和代理人','warring');
	}
	
	
}
function selectonlyone(obj){
	var agentype=document.getElementsByName('agentType');
	//var agentype=agentypes[0];\
	 for (var i = 0; i < agentype.length; i++) {
		 agentype[i].checked = false;
	 }
	 obj.checked = true;
}
function setkey(str){
	var str1='applicantstring'+str;
	document.getElementById(str1).focus();
	var str2='#'+str1;
	$(str2).val('');
}
function setkey2(str){
	var str1='agentstring'+str;
	document.getElementById(str1).focus();
	var str2='#'+str1;
	$(str2).val('');
}
</script>
<title>法律援助申请表</title>
</head>

<body id="body">
<div class="title">法律援助申请表</div>
<div class="soufan" style="width: 80%">
[<input id="legalWord" name="legalWord" type="text" style="border:none"/>]
援申字[<input id="legalCode" name="legalCode" type="text" style="border:none"/>]第<input id="legalNo" name="legalNo" type="text" style="border:none"/>号</div>

 <table width="70%" border="0" cellspacing="0" cellpadding="0" align="center" class="sq_box">
  <tr>
    <td colspan="8" class="sq_title">申请人基本情况</td>
  </tr>
  <tr>
    <td class="sq_left" >姓名：</td>
    <td class="sq_right" >
        <input type="text" id="applicantname" name="name" style="border:0;background:transparent; width: 60px"/>
    </td>
    <td class="sq_left">性别：   </td>
    <td class="sq_right">
    	<select id="applicantgender" name="gender">
    		<option value="m">男</option>
			<option value="f">女</option>
    	</select>
    </td>
    <td class="sq_left">出生年月：</td>
    <td class="sq_right">
    	<input id="applicantbirthday" name="birthday" type="text" class="easyui-datebox" style="border:0;background:transparent;"/>
    </td>
    <td class="sq_left">民族：</td>
    <td class="sq_right">
    	<input id="applicantnationId" name="nationId" type="text"  style="border:0;background:transparent;"/>
    </td>
  </tr>
  <tr>
    <td class="sq_left" colspan="2" width="150">身份证号：</td>
    <td class="sq_right" colspan="6" >
    <table  border="0" cellspacing="0" cellpadding="0" height="28" class="shenfenzheng">
        <tr style="width:200px">
          <td style="width:40px;"><input id="applicantstring1"  align="middle" onkeypress="setkey('2')" type="text"  style="border:0;background:transparent;width:40px;"/></td>
          <td style="width:40px;"><input id="applicantstring2"  align="middle" onkeypress="setkey('3')"  type="text"  style="border:0;background:transparent;width:40px;"/></td>
          <td style="width:40px;"><input id="applicantstring3"  align="middle" onkeypress="setkey('4')" type="text"  style="border:0;background:transparent;width:40px;"/></td>
          <td style="width:40px;"><input id="applicantstring4"  align="middle" onkeypress="setkey('5')" type="text"  style="border:0;background:transparent;width:40px;"/></td>
          <td style="width:40px;"><input id="applicantstring5"  align="middle" onkeypress="setkey('6')" type="text"  style="border:0;background:transparent;width:40px;"/></td>
          <td style="width:40px;"><input id="applicantstring6"  align="middle" onkeypress="setkey('7')" type="text"  style="border:0;background:transparent;width:40px;"/></td>
          <td style="width:40px;"><input id="applicantstring7"  align="middle" onkeypress="setkey('8')" type="text"  style="border:0;background:transparent;width:40px;"/></td>
          <td style="width:40px;"><input id="applicantstring8"  align="middle" onkeypress="setkey('9')" type="text"  style="border:0;background:transparent;width:40px;"/></td>
          <td style="width:40px;"><input id="applicantstring9"  align="middle" onkeypress="setkey('10')" type="text"  style="border:0;background:transparent;width:40px;"/></td>
          <td style="width:40px;"><input id="applicantstring10"  align="middle" onkeypress="setkey('11')" type="text"  style="border:0;background:transparent;width:40px;"/></td>
          <td style="width:40px;"><input id="applicantstring11"  align="middle" onkeypress="setkey('12')" type="text"  style="border:0;background:transparent;width:40px;"/></td>
          <td style="width:40px;"><input id="applicantstring12"  align="middle" onkeypress="setkey('13')" type="text"  style="border:0;background:transparent;width:40px;"/></td>
          <td style="width:40px;"><input id="applicantstring13"  align="middle" onkeypress="setkey('14')" type="text"  style="border:0;background:transparent;width:40px;"/></td>
          <td style="width:40px;"><input id="applicantstring14"  align="middle" onkeypress="setkey('15')" type="text"  style="border:0;background:transparent;width:40px;"/></td>
          <td style="width:40px;"><input id="applicantstring15"  align="middle" onkeypress="setkey('16')" type="text"  style="border:0;background:transparent;width:40px;"/></td>
          <td style="width:40px;"><input id="applicantstring16"  align="middle" onkeypress="setkey('17')" type="text"  style="border:0;background:transparent;width:40px;"/></td>
          <td style="width:40px;"><input id="applicantstring17"  align="middle" onkeypress="setkey('18')" type="text"  style="border:0;background:transparent;width:40px;"/></td>
          <td style="width:40px;"><input id="applicantstring18"  align="middle"  type="text"  style="border:0;background:transparent;width:40px;"/></td>
          <td></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td class="sq_left" colspan="2" width="150">户籍所在地：</td>
    <td class="sq_right" colspan="6">
    	<input id="applicntbirthPlace" name="birthPlace" style="border:0;background:transparent;" type="text"/>
    </td>
  </tr>
  <tr>
    <td class="sq_left" colspan="2" width="150">住所地（经常居住地）：</td>
    <td class="sq_right" colspan="6">
    	<input id="applicantlivePlace" style="border:0;background:transparent;" name="livePlace" type="text"/>
    </td>
  </tr>
  <tr>
    <td class="sq_left" colspan="2" width="150">邮政编码：</td>
    <td class="sq_right" colspan="2">
    	<input id="applicantpostCode" name="postCode" style="border:0;background:transparent;" type="text"/>
    </td>
     <td class="sq_left"  width="150">联系电话：</td>
    <td class="sq_right"><input id="applicantphone" style="border:0;background:transparent;" name="phone" type="text"/></td>
    <td class="sq_right" colspan="2">
    </td>
  </tr>
  <tr>
    <td class="sq_left" colspan="2" width="150">工作单位：</td>
    <td class="sq_right" colspan="6">
    	<input id="applicantcompany" style="border:0;background:transparent;" name="company" type="text"/>
    </td>
  </tr>
  <tr>
    <td colspan="4" class="sq_nei"></td>
    <td colspan="4" class="sq_nei">
        <input type="button" value="保存" style="width: 60px;" onclick="legalApplicantAddForm()" />
    </td>
  </tr>
  <tr>
    <td colspan="8" class="sq_title">代理人基本情况</td>
  </tr>
  <tr>
    <td class="sq_left" colspan="2" width="150">姓名：</td>
    <td class="sq_right" colspan="2">
    	<input id="agentName" style="border:0;background:transparent;" name="name" type="text"/>
    </td>
    <td class="sq_right" colspan="4"><input id="agentType1" name="agentType" onclick="selectonlyone(this)" type="checkbox" value="1" />&nbsp;法定代理人&nbsp;&nbsp;&nbsp;&nbsp;<input id="agentType2" onclick="selectonlyone(this)" name="agentType" type="checkbox" value="2" />&nbsp;委托代理人</td>
  </tr>
  <tr>
    <td class="sq_left" colspan="2" width="150">身份证号：</td>
    <td class="sq_right" colspan="6"><table  border="0" cellspacing="0" cellpadding="0" height="28" class="shenfenzheng">
        <tr>
          <td style="width:40px;"><input id="agentstring1"  type="text" onkeypress="setkey2('2')"  style="border:0;background:transparent;width:40px;"/></td>
          <td style="width:40px;"><input id="agentstring2"  type="text" onkeypress="setkey2('3')" style="border:0;background:transparent;width:40px;"/></td>
          <td style="width:40px;"><input id="agentstring3"  type="text" onkeypress="setkey2('4')" style="border:0;background:transparent;width:40px;"/></td>
          <td style="width:40px;"><input id="agentstring4"  type="text" onkeypress="setkey2('5')" style="border:0;background:transparent;width:40px;"/></td>
          <td style="width:40px;"><input id="agentstring5"  type="text" onkeypress="setkey2('6')" style="border:0;background:transparent;width:40px;"/></td>
          <td style="width:40px;"><input id="agentstring6"  type="text" onkeypress="setkey2('7')" style="border:0;background:transparent;width:40px;"/></td>
          <td style="width:40px;"><input id="agentstring7"  type="text" onkeypress="setkey2('8')" style="border:0;background:transparent;width:40px;"/></td>
          <td style="width:40px;"><input id="agentstring8"  type="text" onkeypress="setkey2('9')" style="border:0;background:transparent;width:40px;"/></td>
          <td style="width:40px;"><input id="agentstring9"  type="text" onkeypress="setkey2('10')" style="border:0;background:transparent;width:40px;"/></td>
          <td style="width:40px;"><input id="agentstring10"  type="text" onkeypress="setkey2('11')" style="border:0;background:transparent;width:40px;"/></td>
          <td style="width:40px;"><input id="agentstring11"  type="text" onkeypress="setkey2('12')" style="border:0;background:transparent;width:40px;"/></td>
          <td style="width:40px;"><input id="agentstring12"  type="text" onkeypress="setkey2('13')" style="border:0;background:transparent;width:40px;"/></td>
          <td style="width:40px;"><input id="agentstring13"  type="text" onkeypress="setkey2('14')" style="border:0;background:transparent;width:40px;"/></td>
          <td style="width:40px;"><input id="agentstring14"  type="text" onkeypress="setkey2('15')" style="border:0;background:transparent;width:40px;"/></td>
          <td style="width:40px;"><input id="agentstring15"  type="text" onkeypress="setkey2('16')" style="border:0;background:transparent;width:40px;"/></td>
          <td style="width:40px;"><input id="agentstring16"  type="text" onkeypress="setkey2('17')" style="border:0;background:transparent;width:40px;"/></td>
          <td style="width:40px;"><input id="agentstring17"  type="text" onkeypress="setkey2('18')" style="border:0;background:transparent;width:40px;"/></td>
          <td style="width:40px;"><input id="agentstring18"  type="text"  style="border:0;background:transparent;width:40px;"/></td>
		  <td></td>          
        </tr>
      </table></td>
  </tr>
      <tr>
    <td colspan="4" class="sq_nei"></td>
    <td colspan="4" class="sq_nei">
        <input type="button" value="保存" style="width: 60px;" onclick="submitLegalAgent()" />
    </td>
  </tr>
  <tr>
    <td colspan="8" class="sq_title">案情及申请理由概述</td>
  </tr>
  <tr>
    <td colspan="8" class="sq_nei h350">案情及申请理由概述案情及申请理由概述<br />
		<textarea id="description" name="description" rows="13" cols="140"></textarea>
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
    <td colspan="4" class="sq_nei">
    </td>
  </tr>
  <tr>
    <td colspan="4" class="sq_nei"></td>
    <td colspan="4" class="sq_nei">
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input id="year" type="text" class="gh_input2" size="5"/>年
    <input id="month" type="text" class="gh_input2" size="5"/>月
    <input id="day" type="text" class="gh_input2" size="5"/>日
</td>
  </tr>
    <tr>
    <td colspan="4" class="sq_nei"></td>
    <td colspan="4" class="sq_nei">
        <input type="button" value="保存" style="width: 60px;" onclick="submitLegalCase()" />
        <input type="button" value="提交" style="width: 60px;" onclick="submitLegalCaseqidong()" />
    </td>
  </tr>
</table>
	<input type="button" id="getSignButton"/>
	<applet codebase="." 
		code="com.neusoft.legal.applet.GetSignImage.class" 
		name="getSign" 
		archive="sign.jar"
		width="0" 
		height="0"
		id="signApplet">
		<param name="baseDomain" value="http://127.0.0.1:8080/legal" />
	</applet>
</body>
</html>
