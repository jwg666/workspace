<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript" src="${staticURL}/ckeditor/ckeditor.js"></script>
<script type="text/javascript"
	src="${staticURL}/loopj-jquery-tokeninput/jquery.tokeninput.js"></script>
<link rel="stylesheet" type="text/css"
	href="${staticURL}/loopj-jquery-tokeninput/styles/token-input.css" />
<link rel="stylesheet" type="text/css"
	href="${staticURL}/loopj-jquery-tokeninput/styles/token-input-facebook.css" />
<style>
ul.token-input-list-facebook {
	background-color: transparent;
	cursor: text;
	clear: none;
	font-family: Verdana;
	border: none;
	font-size: 12px;
	height: auto !important;
	list-style-type: none;
	margin: 0;
	min-height: 1px;
	overflow: hidden;
	padding: 0;
	width: 99%;
	z-index: 999;
}

ul.token-input-list-facebook li input {
	background-color: transparent;
	margin: 2px 0;
	padding: 3px 8px;
	width: 100px;
}
</style>
<script type="text/javascript">
	$(function() {
		var mailEditor=CKEDITOR.replace('mailEditor', {
			toolbar : [
					[ 'Styles', 'Format', 'Font', 'FontSize' ],
					[ 'TextColor', 'NumberedList', 'BulletedList', 'Bold',
							'Italic' ,'Smiley'] ],
			removePlugins : 'elementspath'
		});
		$("#selReceiver").dialog({
			closed : true,
			title : "选择收件人",
			buttons : [ {
				iconCls : 'icon-ok',
				text : "确认",
				handler : function() {
					$("#selReceiver").window("close");
				}
			} ],
			onClose : function() {
				var selData = $("#selectedList").datagrid("getData").rows;
				jquery_inpu = $("#demo-input-facebook-theme");
				token_break = true;
				jquery_inpu.tokenInput("clear");
				for ( var j = 0; j < selData.length; j++) {
					jquery_inpu.tokenInput("add", {
						id : selData[j].EMP_CODE,
						name : selData[j].NAME
					});
				}
				token_break = false;
			}
		});
		//防止token重复调用 add 
		var token_break = false;
		$("#toSelBtn").click(function() {
			$("#selReceiver").window("open");

		});

		$("#demo-input-facebook-theme").tokenInput(
				'${dynamicURL}/message/messageAction!queryUser.do',
				{
					theme : "facebook",
					queryParam : "queryName",
					searchDelay : 800,
					hintText : "输入关键字进行搜索",
					noResultsText : "没有找到该用户",
					searchingText : "正在搜索中。。。",
					onAdd : function(item) {
						if (!token_break) {
							$("#selectedList").datagrid("appendRow", {
								"NAME" : item.name,
								"EMP_CODE" : item.id
							});
						}
					},
					onDelete : function(item) {
						if (!token_break) {
							$("#selectedList").datagrid( "deleteRow", $("#selectedList").datagrid("getRowIndex", item.id));
						}
					}
				});
		$("#userSelect").combotree({
			url : '${dynamicURL}/basic/userDataConfigAction!buildTree.do',
			lines : true,
			panelWidth : 300,
			panelHeight : 300,
			onSelect : function(node) {
				$("#userList").datagrid("load", {
					"id" : node.id
				})
			}
		});
		$("#userList")
				.datagrid(
						{
							url : '${dynamicURL}/basic/userDataConfigAction!findUserByDataTree.do',
							fit : true,
							toolbar : '#tb',
							fitColumns : true,
							idField : "EMP_CODE",
							columns : [ [ {
								field : 'ck',
								title : '选择',
								checkbox : true,
								width : 200
							}, {
								field : 'NAME',
								title : '姓名',
								width : 200
							}, {
								field : 'EMP_CODE',
								title : '员工号',
								width : 200
							} ] ],
							onLoadSuccess : function(data) {
								/* 		   var selData=$("#selectedList").datagrid("getData");
									   for(var i=0;i<data.rows;i++){
										  for(var i=j;j<selData.rows;j++){
											  $(this).datagrid("selectRecord",i);
										  }
									   } */
							}
						});
		$("#selectedList").datagrid(
				{
					fit : true,
					idField : "EMP_CODE",
					toolbar : [ {
						iconCls : 'icon-remove',
						text : "移除",
						handler : function() {
						 var selectRows = $("#selectedList").datagrid(
									"getSelections");
							for ( var i = selectRows.length-1; i >= 0; i--) {
								$("#selectedList").datagrid( "deleteRow", $("#selectedList").datagrid("getRowIndex", selectRows[i]));
							} 
						}
					} ],
					fitColumns : true,
					columns : [ [ {
						field : 'ck',
						title : '选择',
						checkbox : true,
						width : 200
					}, {
						field : 'NAME',
						title : '姓名',
						width : 200
					}, {
						field : 'EMP_CODE',
						title : '员工号',
						width : 200
					} ] ]
				});

	});
	function sendMessageInit(){
		var display = $("#senduser").css('display');
		if(display=="none"){
			sendMessageToAll();
		}else{
			sendMessage();
		}
	}
	function sendMessageToAll(){
		
		var type = 3;
		if($("#loginshow input").attr("checked") == "checked"){
			type = 5;
		}
		var content = CKEDITOR.instances.mailEditor.getData();
		if(content.length>200000){
			$.messager.show({
				title : '通知内容太长',
				msg : '通知内容太长'
			});
			return false;
		}
		$.messager.progress({
			text : '发送中....',
			interval : 100
		});
		$.ajax({
			url : 'messageAction!addToAll.do',
			data : {
				'title':$("#mailSubject").val(),
				'type':type,
				'content':CKEDITOR.instances.mailEditor.getData()
			},
			dataType : 'json',
			success : function(response) {
				$.messager.progress('close');
				if(response.success){
					$.messager.show({
						title : '成功',
						msg : response.msg
					});
					$("#writeMessage").window("close");
				}else{
					$.messager.show({
						title : '失败',
						msg : response.msg
					});
				}
			}
		});
	}
	function sendMessage(){
		//mailEditor.getData();
		/*var type = "0";
		var display = $("#Announcement").css('display');
		if(display!="none"){
			type = "2";
		} */
		var userList=$("#demo-input-facebook-theme").tokenInput("get");
		if(userList.length<=0){
			return false;
		}
		var content = CKEDITOR.instances.mailEditor.getData();
		if(content.length>200000){
			$.messager.show({
				title : '通知内容太长',
				msg : '通知内容太长'
			});
			return false;
		}
		$.messager.progress({
			text : '发送中....',
			interval : 100
		});
		$.ajax({
			url : 'messageAction!add.do',
			data : {
				'userList': JSON.stringify(userList),
				'title':$("#mailSubject").val(),
				'type':2,
				'content':CKEDITOR.instances.mailEditor.getData()
			},
			dataType : 'json',
			success : function(response) {
				$.messager.progress('close');
				if(response.success){
					$.messager.show({
						title : '成功',
						msg : response.msg
					});
					$("#writeMessage").window("close");
				}else{
					$.messager.show({
						title : '失败',
						msg : response.msg
					});
				}
			}
		});
	}
	
	function addUserToList() {
		var selectRows = $("#userList").datagrid("getSelections");
		var selData = $("#selectedList").datagrid("getData").rows;
		for ( var i = 0; i < selectRows.length; i++) {
			var has = false;
			for ( var j = 0; j < selData.length; j++) {
				if (selData[j].EMP_CODE == selectRows[i].EMP_CODE) {
					has = true;
				}
			}
			if (!has) {
				$("#selectedList").datagrid("appendRow", selectRows[i]);
			}
		}
		$("#userList").datagrid("clearChecked");
	}
	function hideSendUser(){
		var dis = $("#senduser").css('display');
		if(dis=="none"){
			$("#Announcement").text("为所有人发送");
			$("#senduser").css('display','');
			$("#loginshow").hide();
		}else{
			$("#Announcement").text("返回");
			$("#senduser").css('display','none');
			$("#loginshow").show();
		}
	}
</script>
<div class="wrap"
	style="top: 28px; left: 0px; width: 100%; height: 100%;">
	<div name="sub" style="z-index: 0">
		<div class="sendbox">
			<div class="sBtnbox">
				<button style="display: none; min-width: 48px" class="sBtn"
					type="button" name="returnBtn">返 回</button>
				<button class="sBtn sendBtn" onclick="sendMessageInit()" type="button" name="sendBtn" id="sendMessage">发送邮件</button>
				<button class="sBtn sendBtn" onclick="hideSendUser()" style="display: none" id="Announcement">为所有人发送</button>
				<span id="loginshow" style="display: none"><input  type="checkbox" value="1" class="iptChk ipt" name="loginShow" style="background: #F3EBEB;vertical-align:middle;" /><label style="vertical-align:middle;">在登录页显示</label></span>
				<button style="display: none" class="disabled sBtn" type="button"
					name="sending">正在发送</button>
				<button style="display: none" class="disabled sBtn" type="button"
					name="sendBtnDisabled">正在发送</button>
				<button style="display: none" class="disabled sBtn" type="button"
					name="sching">正在处理</button>
				<button style="display: none" class="sBtn" type="button"
					name="saveBtn">存为草稿</button>
				<button style="display: none" disabled="disabled" class="disabled sBtn" type="button"
					name="saveBtnDisabled">存为草稿</button>
				<button style="display: none" class="disabled sBtn" type="button"
					name="saving">正在保存</button>
				<button style="display: none" class="disabled sBtn" type="button"
					name="saved">已保存</button>
				<button class="sBtn" style="display: none" type="button"
					name="pelDraft">舍弃草稿</button>
				<span style="display: none" class="cc" name="lastSaveTime">上次草稿保存于2012/11/11
					(周三) 17:45</span>
			</div>
			<div class="smain">
				<form action="" id="mailForm">
					<div style="display: none" class="row">
						<span class="rowdt">发件人</span>
						<div class="rowdu">

							<div class="addresser">
								<button class="addresserico" type="button"
									style="display: none;"></button>
								<p class="addsContent">
									<span class="addsName">loveslikey</span><span class="addsMail">&lt;loveslikey@gleasy.com&gt;</span>
								</p>
								<ul tabindex="99" id="senderSel" class="dropmenu addsList"
									style="display: none;">
									<li class="addsLi"><span class="fr">默认</span><span
										class="addsName">loveslikey</span><span class="addsMail">&lt;loveslikey@gleasy.com&gt;</span></li>
								</ul>
							</div>

						</div>
					</div>

					<div id="senduser" class="row">
						<span class="rowdt"> <!-- <em class="req">*</em> -->
							<button tabindex="-1" class="dropBtn" type="button" id="toSelBtn"
								name="toSelBtn">收件人</button>
						</span>
						<div class="rowdu">
							<div class="sIpt">
								<input type="text" id="demo-input-facebook-theme"
									class="iptInner" tabindex="203">
							</div>
						</div>
					</div>

					<!-- 密送开关 -->

				</form>
				<div class="row">
					<span class="rowdt">主题</span>
					<div class="rowdu">
						<div class="sIpt">
							<input type="text" tabindex="203" class="iptInner"
								id="mailSubject">
						</div>
					</div>
				</div>

				<div style="display: none" class="row">
					<span class="rowdt">quota:</span>
					<div class="rowdu locQuota">
						<!-- <div class="sIpt ">
                                    
                                </div> -->
					</div>
				</div>

				<div style="display: none" class="row">
					<span class="rowdt">sended:</span>
					<div class="rowdu locSended"></div>
				</div>


				<div class="row">
					<span class="rowdt">正文</span>
					<div class="rowdu" style="position: relative;">
						<!-- 临时的输入框 -->
						<div id="mailEditor">
						</div>
					</div>
				</div>

				<!-- <div class="row locLastRow">
					<span class="rowdt"></span>
					<div class="rowdu">
						<input type="checkbox" class="rowIpt" id="isUrgent"><label
							class="rowtxt" for="isUrgent">紧急</label> <input type="checkbox"
							class="rowIpt" id="isRept"><label class="rowtxt"
							for="isRept">需要回执</label>
					</div>
				</div> -->


			</div>
		</div>

	</div>

	<div id="selReceiver" style="width: 760px; height: 520px;">
		<div class="easyui-layout" fit="true">
			<div data-options="region:'west',title:'人员选择',split:true"
				style="width: 360px;">
				<div id="tb">
					<input id="userSelect"> <a id="add"
						href="javascript:void(0)" onclick="addUserToList()"
						class="easyui-linkbutton" data-options="iconCls:'icon-add'">增加</a>
				</div>
				<table id="userList"></table>
			</div>
			<div data-options="region:'center',title:'已选择',split:true"
				style="padding: 5px; background: #eee; width: 400px">
				<table id="selectedList"></table>
			</div>
		</div>
	</div>
	<div class="msgtip" style="display: none;"></div>
</div>