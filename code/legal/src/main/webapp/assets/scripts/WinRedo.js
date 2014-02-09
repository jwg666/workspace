
var WinRedo = {
		callback : function(){
			$.messager.alert("系统提示","执行成功!");
		},
		openWin : function(bussid,sourceId,destId){
			$("body").append("<div id='winRefuse'></div>");
			$("#winRefuse").dialog({
				title : '请填写回退原因',
				href : dynamicURL + "/workflow/transitionRecordAction!toRecordPage.do?",
				width : 370,
				height : 200,
				modal : true,
				buttons:[{
					text:'保存',
					handler:function(){
						if($("#transitionRecord").form("validate")){
						$("#transitionRecord").form("submit",{
							onSubmit : function(param){
								param.businformid = bussid,
								param.sourceId = sourceId,
								param.destId = destId
							},
							success : function(data){
								$("#winRefuse").panel("destroy");
								WinRedo.callback();
							}
						});
						}
					}
				}] , 
				onClose : function(){
					$("#winRefuse").panel("destroy");
				}
			});
		}
};