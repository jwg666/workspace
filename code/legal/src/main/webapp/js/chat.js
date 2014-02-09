$(document).ready(function(){
	getMessageList();
	$("#main_div").timer({
		delay: 5000,
		repeat: true,
		callback: function() { getMessage(); }			
	});
});

function getMessageList(){
	
}
function getMessage(){
	//var kfid = $("#kfid").val();
	var wangyouid = $("#wangyouid").val()+'';
	
	//alert("wangyouid"+wangyouid);
	$.ajax({
		   type: "POST",
		   url: "layout/getMessageList.act",
		   data: {cid:wangyouid},
		   dataType:'json',
		   cache:false,
		   success: function(msg){
		     //alert(msg);
			   var mm = '';
			   for(var i=0;i<msg.obj.length;i++){
				   mm = '<span>客服'+msg.obj[i].kfid+'说:&nbsp; &nbsp;  '+msg.obj[i].content+' </span><br/> ';
				   $("#main_div").append(mm);
			   }
			   
		   }
		});
}
function sendMessage(){		
	var kfid = $("#kfid").val();
	var wangyouid = $("#wangyouid").val();
	if(kfid!=''){		
		var contents = $('#contents').val();
		if(contents!=''){
			$.ajax({
				   type: "POST",
				   url: "layout/saveMessage.act",
				   data: {contents:contents,kfid:kfid,id:wangyouid,mstatus:'0',wystatus:'1',flag:'0'},
				   dataType:'json',
				   success: function(msg){
				     //alert( "Data Saved: " + msg );
				   }
				});
			$('#contents').val("");
			var mm = "网友<span>"+wangyouid+"说:&nbsp; &nbsp;  "+contents+" </span><br>";
			$("#main_div").append(mm);
		}else{
			alert("请不要发空消息");
		}
		
		
	}else{
		alert("没有客服在线");
	}
	
	
}
function findKf(){
	
}