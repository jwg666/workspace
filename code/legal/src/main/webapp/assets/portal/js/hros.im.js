/*
**  即时通信
*/
HROS.im = (function(){
	return {
		imappid : Date.parse(new Date()),
		init : function(){
			$("#b-content-msg a").off("click").on("click",function(){
				$("#msgCenter").slideToggle(); 
			});
		},
		openIm : function(){
			//还没有创建
			if(!HROS.window.show2top(HROS.im.imappid)){
				HROS.window.createNoframeTemp({appid:HROS.im.imappid,title:"在线说说",url:HROS.CONFIG.basicDynamicUrl+"/im/imAction!goIm.action",ismask:false,isflash:false,isresize:true,width:315,height:400,notask:true,movehandle:".osConnectionTop",hidehandle:".oWinMin",minWidth:300,minHeight:190})
			}
		}
	}
})();