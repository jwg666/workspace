var kfc={};
var kfc_haschating="false";
kfc.init_num=0;

kfc.auto_rlist=false;

kfc.cid=0;
kfc.gid=0;
kfc.timer;
kfc.timer2;

kfc.ulist={};
kfc.rlist={};

// 初始化
function init(){
	function KeyDown(e){
		var e=e||event;
		if ((e.keyCode==116)|| //屏蔽F5
			(e.keyCode==122)|| //屏蔽 F11
			(e.shiftKey&&e.keyCode==121)|| //shift+F10
			(e.ctrlKey&&e.keyCode==82) //Ctrl + R 
		){
			e.keyCode=0;
			e.returnValue=false;
		}
	}
	document.onkeydown=KeyDown;
	/*
	//if (window.event){
		document.captureEvents(event.MOUSEUP);
		document.onkeydown=function(){
			if ((window.event.keyCode==116)|| //屏蔽 F5
				(window.event.keyCode==122)|| //屏蔽 F11
				(window.event.shiftKey &&window.event.keyCode==121) //shift+F10
			){
				window.event.keyCode=0;
				window.event.returnValue=false;
			}
		};
		function nocontextmenu(){
			event.cancelBubble = true;
			event.returnValue = false;
			return false;
		}     
		function norightclick(e){
			if (window.Event){
				if (e.which == 2 || e.which == 3) return false;
			}else if (event.button == 2 || event.button == 3){
				event.cancelBubble = true;
				event.returnValue = false;
				return false;
			}
		}
		document.oncontextmenu = nocontextmenu; // for IE5+
		document.onmousedown = norightclick; // for all others
	//}*/
	var $init_info = $("#init_info");
	$init_info.append('&gt;&gt; 正在获取系统数据, 请稍等...<br />');
	$init_info.append('&gt;&gt; 正在获取在线客户列表...<br />');

	kfc.init_div=$("#init_div");
	kfc.main_div=$("#main_div");
	kfc.chat_list=$("#chat_list");
	kfc.contents=$("#contents");
	kfc.ctrl_enter=$("#ctrl_enter");
	kfc.user_list=$("#user_list");
	kfc.user_info=$("#user_info");
	$.getJSON('/zixun/client/ulist.act',{
		"sso":kfc.sso,
		rand:Math.random()},function(data){
		if(data.status==1){
			kfc.user_list.html('');
			for(var i in data.ulist){
				var item=data.ulist[i];
				kfc.ulist[item.id]=item;
				make_uitem(item);
			}
		}
		kfc.timer=setTimeout(auto_ulist,1000);
		online();
	});
	
	kfc.user_info.html('');
	$init_info.html('');
	kfc.contents.bind("keydown",function(e){
		if ((e||event).keyCode==13){
			if(kfc.ctrl_enter.attr('checked')){
				if((e||event).ctrlKey){
					send_im();
					return false;
				}
			}else{
				send_im();
				return false;
			}
		}
	});
}

// 更新函数
function auto_ulist(){
	if(kfc.timer) clearTimeout(kfc.timer);
	var cid=kfc.cid;
	var start=0;
	if(kfc.rlist[cid]) start=kfc.rlist[cid].start||0;
	else kfc.rlist[cid]={};
	$.getJSON('/zixun/client/ulist.act',{
		"sso":kfc.sso,
		"gid":kfc.gid||0,
		"start":start,
		rand:Math.random()},function(data){
		if(data.status==1){
			$('div',kfc.user_list).each(function(){
				if($(this).css('background-image').indexOf('red.ico')==-1)
					$(this).css('background-image','url(/zixun/images/icon/user-off.ico)');
			});
			for(var i in data.ulist){
				var item=data.ulist[i];
				kfc.ulist[item.id]=item;
				make_uitem(item);
			}
			for(var i in kfc.ulist){
				var item=kfc.ulist[i];
				if(item.count_new_question==0&&(new Date().getTime()/1000-parseInt(item.active_time)>310)){
					$('#user_'+item.id,kfc.user_list).remove();
				}
				if(data.ulist.length>0&&item.count_new_question>0){
					kfc_haschating=true;
				}
			}
			if(data.rlist){
				kfc.rlist[cid].start=data.start;
				for(var i in data.rlist){
					var item=data.rlist[i];
					var rhtml=make_ritem(item,0);
					if(kfc.rlist[cid].html) kfc.rlist[cid].html+=rhtml;
					else kfc.rlist[cid].html=rhtml;
					if(kfc.cid=cid){
						kfc.chat_list.append(rhtml);
						kfc.chat_list.get(0).scrollTop=kfc.chat_list.get(0).scrollHeight;
					}
				}
			}
		}
		kfc.timer=setTimeout(auto_ulist,2000);
	});
	//kfc.timer=setTimeout(auto_ulist,60000);
}
// 在线
function online(){
	$.getJSON('/zixun/client/online.act',{
		"sso":kfc.sso,
		rand:Math.random()
	},function(data){
	});
	setTimeout(online,30000);
}

// 组建用户li
function make_uitem(item){
	var user=$('#user_'+item.id,kfc.user_list);
	if(user[0]){
		if(item.count_new_question>0&&kfc.cid!=item.id){
			user.css('background-image','url(/zixun/images/icon/user-red.ico)');
			user.prependTo(kfc.user_list);
		}else{
			if(new Date().getTime()/1000-parseInt(item.active_time)<300){
				user.css('background-image','url(/zixun/images/icon/user.ico)');
			}
		}
	}else{
		var s='';
		if(item.count_new_question>0&&kfc.cid!=item.id){
			s='-red';
		}else{
			if(new Date().getTime()/1000-parseInt(item.active_time)>300) s='off';
		}
		kfc.user_list.prepend('<div id="user_'+item.id+'" style="background:url(/zixun/images/icon/user'+s+'.ico) no-repeat;padding-left:22px;height:20px;overflow:hidden;white-space:nowrap;cursor:pointer;" onclick="show_im('+item.id+',this)">'+item.iparea+'('+item.ip+')</div>');
	}
}
// 组建聊天
function make_ritem(item,status){
	return '<strong>'+(status==0?'用户':kfc.nickname)+'</strong> '+formatDate("y-m-d h:i:s",parseFloat(item.create_time+"000"))+'<br />'+item.contents+'<br />';
}

// 显示会话
function show_im(id,obj){
	kfc.cid=id;
	var item=kfc.ulist[id];
	kfc.gid=item.gid;
	$(obj).css('background-image','url(/zixun/images/icon/user'+(new Date().getTime()/1000-parseInt(item.active_time)<300?'':'-off')+'.ico)');
	kfc.user_info.html('IP：'+item.ip+'<br />地区：'+item.iparea+(item.category?'<br />咨询类别：'+item.category:'')+'<br /><a href="/zixun/client/record_list.act?cid='+item.id+'&sso='+kfc.sso+'" target="_blank">查看咨询记录</a>');
	kfc.init_div.hide();
	kfc.main_div.show();
	if(kfc.rlist[id]&&kfc.rlist[id].html){
		kfc.chat_list.html(kfc.rlist[id].html);
		kfc.chat_list.get(0).scrollTop=kfc.chat_list.get(0).scrollHeight;
	}else kfc.chat_list.html('');
	//auto_rlist();
}

// 清屏
function clear_im(){
	if(kfc.cid){
		if(kfc.rlist[kfc.cid]){
			kfc.rlist[kfc.cid].html='';
			kfc.chat_list.html('');
		}
	}
}

// 发送
function send_im(){
	if(kfc.cid){
		var contents=kfc.contents.val();
		if(contents){
			contents=contents.replace(/\n/ig,'<br />');
			kfc.contents.val('');
			var item={};
			item.create_time=parseInt(new Date().getTime()/1000);
			item.contents=contents;
			var rhtml=make_ritem(item,1);
			if(kfc.rlist[kfc.cid].html) kfc.rlist[kfc.cid].html+=rhtml;
			else kfc.rlist[kfc.cid].html=rhtml;
			kfc.chat_list.append(rhtml);
			kfc.chat_list.get(0).scrollTop=kfc.chat_list.get(0).scrollHeight;
			$.getJSON('/zixun/client/send.act',{
				"sso":kfc.sso,
				"cid":kfc.cid,
				"gid":kfc.gid,
				"contents":contents,
				rand:Math.random()},function(data){
				if(data.status==1){}
			});
		}
	}
}

function addword(){
	var word = $("#wordadd").val();
	if(word){
		$("#cyword").append('<option value="'+word+'">'+word+'</option>');
		$("#wordadd").val('');
		$.getJSON('/zixun/client/addword.act',{
			"sso":kfc.sso,
			"contents":word,
			rand:Math.random()},function(data){
		});
	}
}