<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link type="text/css" rel="stylesheet" href="cmsimages/css.css" />
<jsp:include page="/common/common_js.jsp"></jsp:include>
<style type="text/css">
td_line {
	border-bottom-width: 1px;
	border-bottom-style: solid;
}
</style>
<script type="text/javascript" charset="utf-8">
	var applicantid = '${applicantId}';
	var agentid = '${agentId}';
	var caseId = '${caseId}';
	$(function() {
		/* 	$("#applicantnationId").combobox({
				url : '../basic/dictionaryAction!combox?parentCode=3',
				valueField : 'id',
				textField : 'dicValue'
			}); */
		setvalue(applicantid, agentid, caseId);
	});
	function setvalue(applicantid, agentid, caseId) {
		if (applicantid != null && applicantid != '') {
			getapplicant(applicantid);
		}
		if (agentid != null && agentid != '') {
			getagent(agentid);
		}
		if (caseId != null && caseId != '') {
			getcase(caseId);
		}
	}
	//加载申请人信息
	function getapplicant(applicant) {
		$.ajax({
			url : 'legalApplicantAction!getdesc.do',
			dataType : 'json',
			data : {
				id : applicantid
			},
			success : function(data) {
				if (data.success) {
					//applicantid=data.obj.id;
					//submitLegalAgent();
					$('#applicantname').html(data.obj.name);
					if ("m" == data.obj.gender) {
						$('#applicantgender').html("男");
					} else {
						$('#applicantgender').html("女");
					}
					$('#applicantbirthday').html(data.obj.birthday);
					if ("38" == data.obj.nationId) {
						$('#applicantnationId').html("汉族");
					} else if ("39" == data.obj.nationId) {
						$('#applicantnationId').html("壮族");
					} else {
						$('#applicantnationId').html("回族");
					}
					var identifyid = data.obj.identifyid;
					if (identifyid != null && identifyid != '') {
						for ( var i = 0; i < identifyid.length; i++) {
							var j = i + 1;
							var stringid = '#applicantstring' + j;
							$(stringid).html(identifyid.charAt(i));
						}
					}

					$('#applicntbirthPlace').html(data.obj.birthPlace);
					$('#applicantlivePlace').html(data.obj.livePlace);
					$('#applicantpostCode').html(data.obj.postCode);
					$('#applicantphone').html(data.obj.phone);
					$('#applicantcompany').html(data.obj.company);
				} else {
					$.messager.alert('提示', data.msg, 'info');
				}
			}
		});
	}
	//加载代理人信息
	function getagent(agentid) {
		$.ajax({
			url : 'legalAgentAction!getDesc.do',
			dataType : 'json',
			data : {
				id : agentid
			},
			success : function(data) {
				if (data.success) {
					//agentid=data.obj.id;
					//submitLegalCase();
					$('#agentName').html(data.obj.name);
                   
					var agentType = data.obj.agentType;
					 
					if (agentType != null && agentType != '') {
						var agents = document.getElementsByName('agentType');
						for ( var i = 0; i < agents.length; i++) {
							if (agents[i].value == agentType) {
								agents[i].checked=true;
							}
						}
					}
					//代理人身份证号码
					var identifyid = data.obj.identifyid;
					if (identifyid != null && identifyid != '') {
						for ( var i = 0; i < identifyid.length; i++) {
							var j = i + 1;
							var stringid = '#agentstring' + j;
							$(stringid).html(identifyid.charAt(i));
						}
					}

				} else {
					$.messager.alert('提示', data.msg, 'info');
				}
			}
		});
	}
	function getcase(caseId) {
		$.ajax({
			url : 'legalCaseAction!getDesc.do',
			dataType : 'json',
			data : {
				id : caseId
			},
			success : function(data) {
				if (data.success) {
					$('#description').html(data.obj.description);
					$('#year').val(data.obj.year);
					$('#month').val(data.obj.month);
					$('#day').val(data.obj.day);
					$('#legalCode').val(data.obj.legalCode);
					$('#legalWord').val(data.obj.legalWord);
					$('#legalNo').val(data.obj.legalNo);

				} else {
					$.messager.alert('提示', data.msg, 'error');
				}
			}
		});
	}
	function legalApplicantAddForm() {
		//获得姓名
		var name = $('#applicantname').val();
		//性别
		var gender = $('#applicantgender').val();
		//出生日期
		var birthday = $('#applicantbirthday').datebox('getValue');
		//民族
		var nationId = $('#applicantnationId').combobox('getValue');
		//生份证号
		var identifyid = '';
		for ( var i = 1; i < 19; i++) {
			var stringid = '#applicantstring' + i;
			identifyid = identifyid + $(stringid).val();
		}
		//户籍所在地
		var birthPlace = $('#applicntbirthPlace').val();
		//常住地
		var livePlace = $('#applicantlivePlace').val();
		//邮政编码
		var postCode = $('#applicantpostCode').val();
		//联系电话
		var phone = $('#applicantphone').val();
		//工作单位
		var company = $('#applicantcompany').val();
		$.ajax({
			url : 'legalApplicantAction!addorupdate.do',
			dataType : 'json',
			data : {
				id : applicantid,
				name : name,
				gender : gender,
				birthday : birthday,
				nationId : nationId,
				identifyid : identifyid,
				birthPlace : birthPlace,
				livePlace : livePlace,
				postCode : postCode,
				phone : phone,
				company : company
			},
			success : function(data) {
				if (data.success) {
					applicantid = data.obj.id;
					$.messager.alert('提示', data.msg, 'info');
					//submitLegalAgent();
				} else {
					$.messager.alert('提示', data.msg, 'info');
				}
			}
		});
	}
	function submitLegalAgent() {
		//代理人姓名
		var name = $('#agentName').val();
		var agentType = '';
		var agents = document.getElementsByName('agentType');
		for ( var i = 0; i < agents.length; i++) {
			if (agents[i].checked) {
				agentType = agents[i].value;
			}
		}
		//代理人身份证号码
		var identifyid = '';
		for ( var i = 1; i < 19; i++) {
			var stringid = '#agentstring' + i;
			identifyid = identifyid + $(stringid).val();
		}

		if (applicantid != null && applicantid != '') {
			$.ajax({
				url : 'legalAgentAction!addorupdate.do',
				dataType : 'json',
				data : {
					id : agentid,
					applicantId : applicantid,
					name : name,
					identifyid : identifyid,
					agentType : agentType
				},
				success : function(data) {
					if (data.success) {
						agentid = data.obj.id;
						$.messager.alert('提示', data.msg, 'info');
						//submitLegalCase();
					} else {
						$.messager.alert('提示', data.msg, 'info');
					}
				}
			});
		} else {
			$.messager.alert('提示', '请先保存申请人信息', 'warring');
		}

	}
	function submitLegalCase() {
		//申请人信息id
		var applicantId = applicantid;
		//代理人信息id
		var agentId = agentid;
		//描述
		//yes代表启动工作流
		var ifqiDong = 'no';
		var description = $('#description').val();
		var legalCode = $('#legalCode').val();
		var legalWord = $('#legalWord').val();
		var legalNo = $('#legalNo').val();

		if (applicantId != null && applicantId != '') {
			if (agentId != null && agentId != '') {
				$.ajax({
					url : 'legalCaseAction!addAndStart.do',
					dataType : 'json',
					data : {
						id : caseId,
						ifqiDong : ifqiDong,
						applicantId : applicantId,
						agentId : agentId,
						description : description,
						legalCode : legalCode,
						legalWord : legalWord,
						legalNo : legalNo
					},
					success : function(data) {
						if (data.success) {
							$.messager.alert('提示', data.msg, 'info',
									function(r) {
										if (r) {
											parent.clasedialog();
										}
									});
						} else {
							$.messager.alert('提示', data.msg, 'error');
						}
					}
				});
			} else {
				$.messager.alert('提示', '请先保存代理人信息', 'warring');
			}
		} else {
			$.messager.alert('提示', '请先保存申请人信息和代理人信息', 'warring');
		}

	}
	function submitLegalCaseqidong() {
		//申请人信息id
		var applicantId = applicantid;
		//代理人信息id
		var agentId = agentid;
		//yes代表启动工作流
		var ifqiDong = 'yes';
		//描述
		var description = $('#description').val();
		var legalCode = $('#legalCode').val();
		var legalWord = $('#legalWord').val();
		var legalNo = $('#legalNo').val();
		if (applicantId != null && applicantId != '') {
			if (agentId != null && agentId != '') {
				$.ajax({
					url : 'legalCaseAction!addAndStart.do',
					dataType : 'json',
					data : {
						id : caseId,
						ifqiDong : ifqiDong,
						applicantId : applicantId,
						agentId : agentId,
						description : description,
						legalCode : legalCode,
						legalWord : legalWord,
						legalNo : legalNo
					},
					success : function(data) {
						if (data.success) {
							$.messager.alert('提示', data.msg, 'info',
									function(r) {
										if (r) {
											parent.clasedialog();
										}
									});
						} else {
							$.messager.alert('提示', data.msg, 'error');
						}
					}
				});
			} else {
				$.messager.alert('提示', '请先保存代理人信息', 'warring');
			}
		} else {
			$.messager.alert('提示', '请先保存申请人信息和代理人', 'warring');
		}

	}
	function selectonlyone(obj) {
		var agentype = document.getElementsByName('agentType');
		//var agentype=agentypes[0];\
		for ( var i = 0; i < agentype.length; i++) {
			agentype[i].checked = false;
		}
		obj.checked = true;
	}
	function setkey(str) {
		var str1 = 'applicantstring' + str;
		document.getElementById(str1).focus();
		var str2 = '#' + str1;
		$(str2).val('');
	}
	function setkey2(str) {
		var str1 = 'agentstring' + str;
		document.getElementById(str1).focus();
		var str2 = '#' + str1;
		$(str2).val('');
	}
	function dayin() {
		var printObj = $("body").clone(true);
		printObj.find("#optBnts").remove();
		printObj = gridToTable(printObj);
		lodopPrintAutoWidth(printObj);
	}
</script>
<style type="text/css">
body {
	margin: 0px;
	padding: 0px;
	color: black;
	font-size: 14px;
}

div {
	word-wrap: break-word;
}

hr {
	margin-top: 5px;
	margin-bottom: 10px;
}

.textarea {
	height: 90px;
	width: 430px;
	border: 1px dotted black;
}

.main {
	margin: 5px auto 0px auto;
	overflow: hidden;
}

#header {
	height: 60px;
	/* border: 1px solid black; */
}

#header .fh {
	float: left;
	height: 70px;
	/* border-right: 1px solid black;  */
}

.bbfm {
	float: left;
	height: 28px;
	margin-right: 10px;
	/* border-bottom: 1px dotted black; */
}

.bbf {
	float: left;
	height: 28px;
}

.bbff {
	float: left;
	height: 28px;
	border-bottom: 0px;
}
</style>

<title>法律援助申请表</title>
</head>

<body>
	<div style="width: 980px; height: 40px;"></div>
	<div class="buttons" style="text-align: right;">
		<a href="#" class="easyui-linkbutton" id="optBnts"
				onclick="dayin();"
				data-options="iconCls:'icon-print'">打印</a>
	</div>
	<div class="main" style="width: 980px;"
		id="printBody">
		<div id="header">
			<div style="width: 90%; text-align: center; line-height: 60px;">
				<b style="font-size: 30px">法律援助申请表</b>
			</div>
		</div>
		<div style="width: 90%; height: 30px;" align="right">
			[<input id="legalWord" name="legalWord" type="text"
				style="border: none;" />] 援申字[<input id="legalCode"
				name="legalCode" type="text" style="border: none;" />]第<input
				id="legalNo" name="legalNo" type="text" style="border: none" />号
		</div>

		<div style="width: 100%;">
			<div style="border-bottom: 1px solid;">
				<b style="font-size: 20px">申请人基本情况</b>
			</div>
			<div style="height: 28px;"></div>
			<div style="height: 28px;">
				<div style="float: left; width: 240px;">
					<div class="bbfm" style="width: 50px;">姓名：</div>
					<div class="bbf" style="width: 160px;">
						<span id="applicantname" />
					</div>
				</div>
				<div style="float: left; width: 240px;">
					<div class="bbfm" style="width: 50px;">性别：</div>
					<div class="bbf" style="width: 160px;">
						<span id="applicantgender" />
					</div>
				</div>
				<div style="float: left; width: 240px;">
					<div class="bbfm" style="width: 70px;">出生年月：</div>
					<div class="bbf" style="width: 160px;">
						<span id="applicantbirthday" />
					</div>
				</div>
				<div style="float: left; width: 240px;">
					<div class="bbfm" style="width: 50px;">民族：</div>
					<div class="bbf" style="width: 160px;">
						<span id="applicantnationId" />
					</div>
				</div>
			</div>
			<div style="height: 28px;">
				<div style="float: left; width: 960px;">
					<div class="bbfm" style="width: 100px;" align="center">身份证号：</div>
					<div class="bbf" style="width: 850px;">
						<div
							style="width: 20px; height: 23; border: 1px solid; float: left;"
							align="center">
							<span id="applicantstring1" />
						</div>
						<div
							style="width: 20px; height: 23; border: 1px solid; float: left;"
							align="center">
							<span id="applicantstring2" />
						</div>
						<div
							style="width: 20px; height: 23; border: 1px solid; float: left;"
							align="center">
							<span id="applicantstring3" />
						</div>
						<div
							style="width: 20px; height: 23; border: 1px solid; float: left;"
							align="center">
							<span id="applicantstring4" />
						</div>
						<div
							style="width: 20px; height: 23; border: 1px solid; float: left;"
							align="center">
							<span id="applicantstring5" />
						</div>
						<div
							style="width: 20px; height: 23; border: 1px solid; float: left;"
							align="center">
							<span id="applicantstring6" />
						</div>
						<div
							style="width: 20px; height: 23; border: 1px solid; float: left;"
							align="center">
							<span id="applicantstring7" />
						</div>
						<div
							style="width: 20px; height: 23; border: 1px solid; float: left;"
							align="center">
							<span id="applicantstring8" />
						</div>
						<div
							style="width: 20px; height: 23; border: 1px solid; float: left;"
							align="center">
							<span id="applicantstring9" />
						</div>
						<div
							style="width: 20px; height: 23; border: 1px solid; float: left;"
							align="center">
							<span id="applicantstring10" />
						</div>
						<div
							style="width: 20px; height: 23; border: 1px solid; float: left;"
							align="center">
							<span id="applicantstring11" />
						</div>
						<div
							style="width: 20px; height: 23; border: 1px solid; float: left;"
							align="center">
							<span id="applicantstring12" />
						</div>
						<div
							style="width: 20px; height: 23; border: 1px solid; float: left;"
							align="center">
							<span id="applicantstring13" />
						</div>
						<div
							style="width: 20px; height: 23; border: 1px solid; float: left;"
							align="center">
							<span id="applicantstring14" />
						</div>
						<div
							style="width: 20px; height: 23; border: 1px solid; float: left;"
							align="center">
							<span id="applicantstring15" />
						</div>
						<div
							style="width: 20px; height: 23; border: 1px solid; float: left;"
							align="center">
							<span id="applicantstring16" />
						</div>
						<div
							style="width: 20px; height: 23; border: 1px solid; float: left;"
							align="center">
							<span id="applicantstring17" />
						</div>
						<div
							style="width: 20px; height: 23; border: 1px solid; float: left;"
							align="center">
							<span id="applicantstring18" />
						</div>
					</div>
				</div>
			</div>
			<div style="height: 28px;">
				<div style="float: left; width: 960px;">
					<div class="bbfm" style="width: 110px;" align="center">户籍所在地：</div>
					<div class="bbf" style="width: 840px;">
						<span id="applicntbirthPlace" />
					</div>
				</div>
			</div>
			<div style="height: 40px;">
				<div style="float: left; width: 960px;">
					<div class="bbfm" style="width: 110px;" align="center">
						住所地<br>(经常居住地)：
					</div>
					<div class="bbf" style="width: 840px;">
						<span id="applicantlivePlace" />
					</div>
				</div>
			</div>
			<div style="height: 28px;">
				<div style="float: left; width: 480px;">
					<div class="bbfm" style="width: 110px;" align="center">邮政编码：</div>
					<div class="bbf" style="width: 360px;">
						<span id="applicantpostCode" />
					</div>
				</div>
				<div style="float: left; width: 480px;">
					<div class="bbfm" style="width: 100px;" align="center">联系电话：</div>
					<div class="bbf" style="width: 370px;">
						<span id="applicantphone" />
					</div>
				</div>
			</div>
			<div style="height: 40px;">
				<div style="float: left; width: 960px;">
					<div class="bbfm" style="width: 100px;" align="center">工作单位：</div>
					<div class="bbf" style="width: 850px;">
						<span id="applicantcompany" />
					</div>
				</div>
			</div>
			<div style="height: 28px;border-bottom: 1px solid;">
				<b style="font-size: 20px">代理人基本情况</b>
			</div>
			<div style="height: 28px;"></div>
			<div style="height: 28px;">
				<div style="float: left; width: 480px;">
					<div class="bbfm" style="width: 100px;" align="center">姓名：</div>
					<div class="bbf" style="width: 370px;">
						<span id="agentName" />
					</div>
				</div>
				<div style="float: left; width: 480px;">
					<input id="agentType1" name="agentType"
						onclick="selectonlyone(this)" type="checkbox" value="1" />&nbsp;法定代理人&nbsp;&nbsp;&nbsp;&nbsp;<input
						id="agentType2" onclick="selectonlyone(this)" name="agentType"
						type="checkbox" value="2" />&nbsp;委托代理人
				</div>
			</div>
			<div style="height: 28px;">
				<div style="float: left; width: 960px;">
					<div class="bbfm" style="width: 100px;" align="center">身份证号：</div>
					<div class="bbf" style="width: 850px;">
						<div
							style="width: 20px; height: 23; border: 1px solid; float: left;"
							align="center">
							<span id="agentstring1" />
						</div>
						<div
							style="width: 20px; height: 23; border: 1px solid; float: left;"
							align="center">
							<span id="agentstring2" />
						</div>
						<div
							style="width: 20px; height: 23; border: 1px solid; float: left;"
							align="center">
							<span id="agentstring3" />
						</div>
						<div
							style="width: 20px; height: 23; border: 1px solid; float: left;"
							align="center">
							<span id="agentstring4" />
						</div>
						<div
							style="width: 20px; height: 23; border: 1px solid; float: left;"
							align="center">
							<span id="agentstring5" />
						</div>
						<div
							style="width: 20px; height: 23; border: 1px solid; float: left;"
							align="center">
							<span id="agentstring6" />
						</div>
						<div
							style="width: 20px; height: 23; border: 1px solid; float: left;"
							align="center">
							<span id="agentstring7" />
						</div>
						<div
							style="width: 20px; height: 23; border: 1px solid; float: left;"
							align="center">
							<span id="agentstring8" />
						</div>
						<div
							style="width: 20px; height: 23; border: 1px solid; float: left;"
							align="center">
							<span id="agentstring9" />
						</div>
						<div
							style="width: 20px; height: 23; border: 1px solid; float: left;"
							align="center">
							<span id="agentstring10" />
						</div>
						<div
							style="width: 20px; height: 23; border: 1px solid; float: left;"
							align="center">
							<span id="agentstring11" />
						</div>
						<div
							style="width: 20px; height: 23; border: 1px solid; float: left;"
							align="center">
							<span id="agentstring12" />
						</div>
						<div
							style="width: 20px; height: 23; border: 1px solid; float: left;"
							align="center">
							<span id="agentstring13" />
						</div>
						<div
							style="width: 20px; height: 23; border: 1px solid; float: left;"
							align="center">
							<span id="agentstring14" />
						</div>
						<div
							style="width: 20px; height: 23; border: 1px solid; float: left;"
							align="center">
							<span id="agentstring15" />
						</div>
						<div
							style="width: 20px; height: 23; border: 1px solid; float: left;"
							align="center">
							<span id="agentstring16" />
						</div>
						<div
							style="width: 20px; height: 23; border: 1px solid; float: left;"
							align="center">
							<span id="agentstring17" />
						</div>
						<div
							style="width: 20px; height: 23; border: 1px solid; float: left;"
							align="center">
							<span id="agentstring18" />
						</div>
					</div>
				</div>
			</div>
			<div style="height: 28px;"></div>
			<div  style="height: 28px;border-bottom: 1px solid;">
				<b style="font-size: 20px">案情及申请理由概述</b>
			</div>
			<div style="height: 28px;"></div>
			<div style="height: 428px;width: 960px;">
					<div style="float:center; width: 940px;">
						<div class="bbfm" style="width: 300px;" align="center">案情及申请理由概述案情及申请理由概述：</div>
					</div>
					<div style="float: center; width: 940px;height: 400px">
						<span id="description"/>
					</div>
			</div>
			<div  style="height: 28px;">
				<b>本人承诺以上所填内容和提交的证件、证明均真实。</b>
			</div>
			<div style="height: 28px;"></div>
			<div style="width: 960px;height: 28px;">
					<div class="bbfm" style="float:left; width: 470px;"></div>
					<div style="float:left; width: 470px;">
						<div class="bbf" align="center">申请人（签字）：</div>
					</div>
			</div>
			<div style="height: 28px;"></div>
			<div style="width: 960px;height: 28px;">
					<div class="bbfm" style="float:left; width: 470px;"></div>
					<div style="float:left; width: 470px;">
						<div class="bbf" align="center">代理人（签字）：</div>
					</div>
			</div>
			<div style="height: 28px;"></div>
			<div style="width: 960px;height: 28px;">
					<div class="bbfm" style="float:left; width: 550px;"></div>
					<div style="float:left; width: 390px;">
						<div class="bbf" align="center">&nbsp;&nbsp;年&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;日</div>
					</div>
			</div>
		</div>
	</div>
</body>
</html>
