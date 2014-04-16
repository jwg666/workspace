<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html>
<html>
<head>
<link type="text/css" rel="stylesheet" href="cmsimages/css.css"/>
<title>法律援助审批表</title>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var legalApproveAddForm;	
	var apid='${legalApproveQuery.id}';
	$(function() {
		$.ajax({
			url:'legalApproveAction!getApproveDetail.do',
			dataType:'json',
			data:{
				id:apid
			},
			success:function(data){
				if(data.success){
					setzhi('educationalBackground',data.obj.educationalBackground);
					setzhi('kindOfCrowd',data.obj.kindOfCrowd);
					setzhi('economyLeval',data.obj.economyLeval);
					setzhi('casesSource',data.obj.casesSource);
					setzhi('application',data.obj.application);
					setzhi('aidMethods',data.obj.aidMethods);
					setzhi('applyStage',data.obj.applyStage);
					settime('examinationOpinionTime',data.obj.examinationOpinionTime);
					settime('trialOpinionTime',data.obj.trialOpinionTime);
					setradio('ifHave',data.obj.ifHave);
					setradio('ifLeval',data.obj.ifLeval);
					
					
				}else{
					$.messager.alert('提示',data.msg,'error');
				}
			}
		});
		
		legalApproveAddForm = $('#legalApproveAddForm').form({
			url : 'legalApproveAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					customWindow.reloaddata();
					parent.window.HROS.window.close(currentappid);
					top.window.showTaskCount();
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});
	});
	//解析单选框
	function setradio(radioname,radiovalue){
		var radio=document.getElementsByName(radioname);
		if(radio.length>0){
			for(var i=0;radio.length;i++){
					if(radio[i].value==radiovalue){
						radio[i].checked=true;
					}
				
			}
		}
	}
	//解析签名处的时间
 	function settime(timename,timestring){
		var armys1=new Array();
		armys1=timestring.split(',');
		if(armys1.length>0){
			for(var i=0;i<armys1.length;i++){
				$('#'+timename+i).val(armys1[i]);
			}
		}
	} 
	//拆分多选框
	function setzhi(checkname,checkvalue){
		var check=document.getElementsByName(checkname);
		if(check.length>0){
			var armys1=new Array();
			armys1=checkvalue.split(';');
			if(armys1.length>0){
				for(var i=0;i<armys1.length;i++){
					if(armys1[i]!=null&&armys1[i]!=''){
						var as=armys1[i].split(',');
						if(as.length==1){
							for(var j=0;j<check.length;j++){
								if(check[j].value==as[0]){
									check[j].checked=true;
								}
							}
						}else if(as.length==2){
							for(var j=0;j<check.length;j++){
								if(check[j].value==as[0]){
									check[j].checked=true;
									var other=$('#'+checkname+as[0]);
									if(other.length>0){
										other.val(as[1]);
									}
								}
							}
						}
					}
				}
			}
		}
	}
	function submitApprove(){
		legalApproveAddForm.submit();
	}
	function resetInfo(obj){
		obj.form('reset');
	}
	function selectonlyone(obj){
		var agentype=document.getElementsByName('educationalBackground');
		//var agentype=agentypes[0];\
		 for (var i = 0; i < agentype.length; i++) {
			 agentype[i].checked = false;
		 }
		 obj.checked = true;
	}
	function completetask(){
		var caseId='${caseId}';
		//案由
		var applicantReason=$('#applicantReason').val();
		//申请日期
		var applicantTime=$('#applicantTime').datebox('getValue');
		//文化程度
		var educationalBackground =getstring('educationalBackground');
		//人群类别
		var kindOfCrowd=getstring('kindOfCrowd');
		//申请人及家庭经济状况
		var economyLeval=getstring('economyLeval');
		//是否符合法律援助状况标准
		var ifLeval= $("input[name='ifLeval']:checked").val();
		//有无经济困难证明
		var ifHave= $("input[name='ifHave']:checked").val();
		//案件来源
		var casesSource=getstring('casesSource');
		
		//申请事项
		var application=getstring('application');
		//提供法律援助方式
		var aidMethods=getstring('aidMethods');
		
		//申请事项阶段
		var applyStage=getstring('applyStage');
		//案件概况
		var caseSurvey=$('#caseSurvey').val();
		//审查意见
		var examinationOpinion=$('#examinationOpinion').val();
		var examinationOpinionTime=$('#examinationOpinionTime1').val()+','+$('#examinationOpinionTime2').val()+','+$('#examinationOpinionTime3').val();
		//审判意见
		var trialOpinion=$('#trialOpinion').val();
		var trialOpinionTime=$('#trialOpinionTime1').val()+','+$('#trialOpinionTime2').val()+','+$('#trialOpinionTime3').val();
		$.ajax({
			url : 'legalApproveAction!add.do',
			dataType:'json',
			data:{
				caseId:caseId,
				application:application,
				applicantTime:applicantTime,
				educationalBackground:educationalBackground,
				kindOfCrowd:kindOfCrowd,
				economyLeval:economyLeval,
				ifLeval:ifLeval,
				ifHave:ifHave,
				casesSource:casesSource,
				aidMethods:aidMethods,
				applyStage:applyStage,
				applicantReason:applicantReason,
				caseSurvey:caseSurvey,
				examinationOpinion:examinationOpinion,
				examinationOpinionTime:examinationOpinionTime,
				trialOpinion:trialOpinion,
				trialOpinionTime:trialOpinionTime
			},
			success:function(data){
				if(data.success){
					$.messager.alert('提示',data.msg,'info',function(r){
						if(r){
							//代办刷新
							customWindow.reloaddata();
							//代办肯定
							parent.window.HROS.window.close(currentappid);
						}
					});
				}else{
					$.messager.alert('提示',data.msg,'error');
				}
			}
		});
	}

	function getstring(thisname){
		var application='';
		var applicationobj=document.getElementsByName(thisname);
		bb=0;
		for(var i=0;i<applicationobj.length;i++){
			if(applicationobj[i].checked){
				if(bb==0){
					application=applicationobj[i].value;
					var other=$('#'+thisname+applicationobj[i].value);
					if(other.length>0){
						application=application+','+other.val();
					}
				}else{
					application=application+';'+applicationobj[i].value;
					var other=$('#'+thisname+applicationobj[i].value);
					//alert(other.length>0);
					if(other.length>0){
						application=application+','+other.val();
					}
				}
				bb++;
			}
		}
		return application;
	}
	function dayin(){
	 	var printObj = $("#printBody").clone(true);
		printObj.width(1220);
		printObj.find("#optBnts").remove();
		printObj = gridToTable(printObj);
		printObj.find("#datagridDiv table").addClass("table2").width("100%").parent().addClass("part_zoc").width("100%");
		lodopPrintAutoWidth(printObj);
	}
</script>
</head>
<body id="body">
<div  style="overflow: auto;min-width: 1220px" align="center"  id="printBody" >
<div class="title">法律援助审批表</div>
<div class="soufan" style="width: 80%">
<div class="soufan">
<s:textfield id="legalWord" name="legalApproveQuery.legalWord" type="text" style="border:none;width:50px;" ></s:textfield>
援审字[
<s:textfield id="legalCode" name="legalApproveQuery.legalCode" type="text" style="border:none;width:50px;" ></s:textfield>
]第
<s:textfield id="legalNo" name="legalApproveQuery.legalNo" type="text" style="border:none;width:50px;" ></s:textfield>
号</div>
</div>
<table width="80%" border="0" cellspacing="0" cellpadding="0" align="center" class="sq_box">
  <tr>
    <td colspan="6" class="sq_title">申请人基本情况</td>
  </tr>
  <tr>
    <td class="sq_left" width="68">姓名：</td>
    <td class="sq_right" width="88">
       <s:textfield type="text" id="applicantname" name="legalApproveQuery.name" style="border:0;background:transparent; width: 60px" ></s:textfield>
    </td>
    <td width="66" class="sq_left">案由：</td>
    <td width="423" class="sq_right">
       <s:textfield type="text" id="applicantReason" name="legalApproveQuery.applicantReason" style="border:0;background:transparent; width: 60px"></s:textfield>
    </td>
    <td width="89" class="sq_left">申请日期：</td>
    <td width="484" class="sq_right">
       <s:textfield id="applicantTime" name="legalApproveQuery.applicantTime" type="text" class="easyui-datebox" style="border:0;background:transparent;" ></s:textfield>
    </td>
  </tr>
  <tr>
    <td class="sq_left" colspan="2" >文化程度：</td>
    <td class="sq_right" colspan="4" >
      <input name="educationalBackground" type="checkbox" value="1" onclick="selectonlyone(this)"/>
      &nbsp;文盲&nbsp;&nbsp;&nbsp;&nbsp;
      <input name="educationalBackground" type="checkbox" value="2" onclick="selectonlyone(this)"/>
      &nbsp;小学&nbsp;&nbsp;&nbsp;&nbsp;
      <input name="educationalBackground" type="checkbox" value="3" onclick="selectonlyone(this)"/>
      &nbsp;中学&nbsp;&nbsp;&nbsp;&nbsp;
      <input name="educationalBackground" type="checkbox" value="4" onclick="selectonlyone(this)"/>
      &nbsp;大专以上</td>
  </tr>
  <tr>
    <td class="sq_left" colspan="2" >人群类别：<br />
      （可交叉重复）</td>
    <td class="sq_right" colspan="4" >
      <input name="kindOfCrowd" type="checkbox" value="1" />
      &nbsp;残疾人&nbsp;&nbsp;&nbsp;&nbsp;
      <input name="kindOfCrowd" type="checkbox" value="2" />
      &nbsp;老年人（60岁以上）&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input name="kindOfCrowd" type="checkbox" value="3" />
      &nbsp;未成年人&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input name="kindOfCrowd" type="checkbox" value="4" />
      &nbsp;妇女&nbsp;&nbsp;&nbsp;&nbsp;
      <input name="kindOfCrowd" type="checkbox" value="5" />
      &nbsp;优抚对象&nbsp;&nbsp;&nbsp;&nbsp;<br />
      <input name="kindOfCrowd" type="checkbox" value="6" />
      &nbsp;农村五保户
      <input name="kindOfCrowd" type="checkbox" value="7" />
      &nbsp;低保人员&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input name="kindOfCrowd" type="checkbox" value="8" />
      &nbsp;农民工&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input name="kindOfCrowd" type="checkbox" value="9" />
      &nbsp;失业人员
      <input name="kindOfCrowd" type="checkbox" value="10" />
      &nbsp;少数民族&nbsp;&nbsp;&nbsp;&nbsp;<br />
      <input name="kindOfCrowd" type="checkbox" value="11" />
      &nbsp;军人军属&nbsp;&nbsp;
      <input name="kindOfCrowd" type="checkbox" value="12" />
      &nbsp;盲聋哑&nbsp;&nbsp;&nbsp;&nbsp;
      <input name="kindOfCrowd" type="checkbox" value="13" />
      &nbsp;可能被判处死刑的&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input name="kindOfCrowd" type="checkbox" value="14" />
      &nbsp;其他（注明）
      <input id="kindOfCrowd14" name="kindOfCrowdOther" type="text" class="sq_input" size="7" /></td>
  </tr>
  <tr>
    <td class="sq_left" colspan="2" >申请人及其家庭经济状况：</td>
    <td class="sq_right" colspan="4" >
    <input name="economyLeval" type="checkbox" value="1" />
      &nbsp;职业收入（含退休金）&nbsp;&nbsp;每月
      <input id="economyLeval1" type="text" class="sq_input" size="15" />
          元<br />
      <input name="economyLeval" type="checkbox" value="2" />
      &nbsp;救济金&nbsp;&nbsp;每月
      <input id="economyLeval2" type="text" class="sq_input" size="15" />
      元<br />
      <input name="economyLeval" type="checkbox" value="3" />
      &nbsp;其他收入&nbsp;&nbsp;每月
      <input id="economyLeval3" type="text" class="sq_input" size="15" />
      元<br />
      <input name="economyLeval" type="checkbox" value="4" />
      &nbsp;无收入<br />
      <input name="economyLeval" type="checkbox" value="5" />
      &nbsp;申请人家庭人口：
      <input id="economyLeval5" type="text" class="sq_input" size="15" />
      人<br />
      <input name="economyLeval" type="checkbox" value="6" />
      &nbsp;家庭月平均收入
      <input id="economyLeval6" type="text" class="sq_input" size="15" />
      元<br />
      <input name="economyLeval" type="checkbox" value="7" />
      &nbsp;家庭月平均开支
      <input id="economyLeval7" type="text" class="sq_input" size="15" />
      元<br />
      是否符合法律援助经济困难标准：&nbsp;&nbsp;
      <input name="ifLeval" type="radio" value="1" />
      &nbsp;是&nbsp;&nbsp;
      <input name="ifLeval" type="radio" value="2" />
      &nbsp;否&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;经济困难证明：&nbsp;&nbsp;
      <input name="ifHave" type="radio" value="1" />
      &nbsp;有&nbsp;&nbsp;
      <input name="ifHave" type="radio" value="2" />
      &nbsp;无 </td>
  </tr>
  <tr>
    <td class="sq_left" colspan="2" >案件来源：</td>
    <td class="sq_right" colspan="4" >
      <input name="casesSource" type="checkbox" value="1" />
      &nbsp;当事人申请&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input name="casesSource" type="checkbox" value="2" />
      &nbsp;人民法院指定&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input name="casesSource" type="checkbox" value="3" />
      &nbsp;公安机关转交&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input name="casesSource" type="checkbox" value="4" />
      &nbsp;检查机关转交&nbsp;&nbsp;&nbsp;&nbsp;<br />
      <input name="casesSource" type="checkbox" value="5" />
      &nbsp;社会组织转交&nbsp;&nbsp;&nbsp;&nbsp;
      <input name="casesSource" type="checkbox" value="6" />
      &nbsp;律师事务所转交&nbsp;&nbsp;&nbsp;
      <input name="casesSource" type="checkbox" value="7" />
      &nbsp;其他来源（注明）
      <input id="casesSource7" type="text" class="sq_input" size="7" /></td>
  </tr>
  <tr>
    <td class="sq_left" colspan="2" >申请事项：</td>
    <td class="sq_right" colspan="4" >
    <input name="application" type="checkbox" value="1" />
      &nbsp;刑事案件<br />
      <input name="application" type="checkbox" value="2" />
      &nbsp;请求国家赔偿<br />
      <input name="application" type="checkbox" value="3" />
      &nbsp;请求给予最低的生活保障待遇或社会保险待遇<br />
      <input name="application" type="checkbox" value="4" />
      &nbsp;请求发给抚恤金、救济金<br />
      <input name="application" type="checkbox" value="5" />
      &nbsp;请求给付赡养费、抚养费、扶养费<br />
      <input name="application" type="checkbox" value="6" />
      &nbsp;请求支付劳动报酬<br />
      <input name="application" type="checkbox" value="7" />
      &nbsp;主张因见义勇为行为产生的民事权益<br />
      <input name="application" type="checkbox" value="8" />
      &nbsp;交通事故、工伤事故、医疗事故或其他人身伤害事故追索医疗费用和赔偿<br />
      <input name="application" type="checkbox" value="9" />
      &nbsp;其它<input id="application9" type="text" class="sq_input" size="7" /><br />
      </td>
  </tr>
  <tr>
    <td class="sq_left" colspan="2" >提供法律援助方式：</td>
    <td class="sq_right" colspan="4" >
      <input name="aidMethods" type="checkbox" value="1" />
      &nbsp;刑事辩护&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input name="aidMethods" type="checkbox" value="2" />
      &nbsp;刑事被害人代理&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input name="aidMethods" type="checkbox" value="3" />
      &nbsp;刑事附带民事诉讼&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input name="aidMethods" type="checkbox" value="4" />
      &nbsp;自诉代理&nbsp;&nbsp;&nbsp;&nbsp;<br />
      <input name="aidMethods" type="checkbox" value="5" />
      &nbsp;民事诉讼代理&nbsp;&nbsp;
      <input name="aidMethods" type="checkbox" value="6" />
      &nbsp;行政诉讼代理&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input name="aidMethods" type="checkbox" value="7" />
      &nbsp;非诉讼代理（
      <input name="aidMethods" type="checkbox" value="8" />
      劳动仲裁代理&nbsp;
      <input name="aidMethods" type="checkbox" value="9" />
      其他） </td>
  </tr>
  <tr>
    <td class="sq_left" colspan="2" >申请事项所处阶段：</td>
    <td class="sq_right" colspan="4" >
      <input name="applyStage" type="checkbox" value="1" />
      &nbsp;尚未进入法律程序<br />
      <input name="applyStage" type="checkbox" value="2" />
      &nbsp;侦查<br />
      <input name="applyStage" type="checkbox" value="3" />
      &nbsp;审查起诉<br />
      <input name="applyStage" type="checkbox" value="4" />
      &nbsp;诉讼&nbsp;（&nbsp;
      <input name="applyStage" type="checkbox" value="5" />
      &nbsp;一审&nbsp;&nbsp;
      <input name="applyStage" type="checkbox" value="6" />
      &nbsp;二审&nbsp;&nbsp;
      <input name="applyStage" type="checkbox" value="7" />
      &nbsp;审判监督程序&nbsp;）<br />
      <input name="applyStage" type="checkbox" value="8" />
      &nbsp;仲裁&nbsp;&nbsp;&nbsp;&nbsp;
      <input name="applyStage" type="checkbox" value="9" />
      &nbsp;调解<br />
      <input name="applyStage" type="checkbox" value="10" />
      &nbsp;行政处理&nbsp;&nbsp;&nbsp;&nbsp;
      <input name="applyStage" type="checkbox" value="11" />
      &nbsp;行政复议&nbsp;&nbsp;&nbsp;&nbsp;
      <input name="applyStage" type="checkbox" value="12" />
      &nbsp;国家赔偿<br />
      <input name="applyStage" type="checkbox" value="13" />
      &nbsp;死刑复核<br />
      <input name="applyStage" type="checkbox" value="14" />
      &nbsp;申诉<br />
      <input name="applyStage" type="checkbox" value="15" />
      &nbsp;执行<br /></td>
  </tr>
  <tr>
    <td colspan="6" class="sq_title">案件概况</td>
  </tr>
  <tr>
    <td colspan="6" class="sq_nei h200">
       <!-- <textarea id="caseSurvey" name="caseSurvey" rows="13" cols="140"></textarea> -->
       <s:textarea id="caseSurvey" name="legalApproveQuery.caseSurvey" rows="13" cols="140"></s:textarea>
   </td>
  </tr>
  <tr>
    <td colspan="6" class="sq_title b_top">审查意见</td>
  </tr>
  <tr>
    <td colspan="6" class="sq_nei h200">
         <!-- <textarea id="examinationOpinion" name="examinationOpinion" rows="13" cols="140"></textarea> -->
         <s:textarea id="examinationOpinion" name="legalApproveQuery.examinationOpinion" rows="13" cols="140"></s:textarea>
   </td>
  </tr>
  <tr>
    <td colspan="5" class="sq_nei"></td>
    <td colspan="1" class="sq_nei">签字：</td>
  </tr>
  <tr>
    <td colspan="5" class="sq_nei"></td>
    <td colspan="1" class="sq_nei">
    <input id="examinationOpinionTime0" type="text" class="gh_input2" size="5"/>
      年
      <input id="examinationOpinionTime1" type="text" class="gh_input2" size="5"/>
      月
      <input id="examinationOpinionTime2" type="text" class="gh_input2" size="5"/>
      日 </td>
  </tr>
  <tr>
    <td colspan="6" class="sq_title b_top">审判意见</td>
  </tr>
  <tr>
    <td colspan="6" class="sq_nei h200">
       <!--  <textarea id="trialOpinion" name="trialOpinion" rows="13" cols="140"></textarea> -->
        <s:textarea id="trialOpinion" name="legalApproveQuery.trialOpinion" rows="13" cols="140"></s:textarea>
    </td>
  </tr>
  <tr>
    <td colspan="5" class="sq_nei"></td>
    <td colspan="1" class="sq_nei">签字：</td>
  </tr>
  <tr>
    <td colspan="5" class="sq_nei"></td>
    <td colspan="1" class="sq_nei"><input id="trialOpinionTime0" type="text" class="gh_input2" size="5"/>
      年
      <input id="trialOpinionTime1" type="text" class="gh_input2" size="5"/>
      月
      <input id="trialOpinionTime2" type="text" class="gh_input2" size="5"/>
      日 </td>
  </tr>
</table>
<div class="mt20 sq_nei">注：1.审判意见由对法律援助申请进行初审的工作人员出具。<br />
&nbsp;&nbsp;&nbsp;&nbsp;2.审判意见由法律援助机构负责人或者其他有权签署意见的人员出具。</div>
</div>
<table width="80%" border="0" cellspacing="0" cellpadding="0" align="center" class="sq_box">
<tr>
    <td colspan="2" class="sq_nei"></td>
    <td colspan="2" class="sq_nei">
    <input type="button" value="打印" style="width: 60px;" onclick="dayin()" />
    </td>
    <td colspan="2" class="sq_nei"></td>
  </tr>
</table>
</body>
</html>