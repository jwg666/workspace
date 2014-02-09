var kf={};
kf.error=0;
kf.errorinfo='';
kf.start=0;
kf.count=0;
kf.stop=false;
// 选择客服
function kf_init(category){
	Wait('正在连接[ '+kf.kf_nickname+' ]，请稍等。。。');
	$.getJSON('/zixun/layout/setkf.act',{
		"kfid": kf.kf_id,
		"cid": kf.cid,
		"contents": category,
		rand: Math.random()
	},function(data){
		Wait(false);
		if(data.status==1){
			kf.kf_gid=data.gid;
			var html='<div style="line-height:20px;font-size:12px;padding:10px;">您好，欢迎使用青岛地税即时咨询！</div>';
			$("#kf_list").html(html).height(35);
			kf.main_div=$('#main_div');
			kf_append(kf.kf_nickname,new Date().getTime(),'您好，需要什么帮助？');
			kf.interval=setTimeout(kf_receive,3000);
		}else{
			alert('连接失败, 请重新连接!');
		}
	});
}
function kf_init2(){
	if(kf.stop){
		alert("由于您长时间未响应, 本次咨询服务结束, 感谢您的使用!");
		window.close();
		return;
		/*kf.count=0;
		kf.stop=false;
		kf_append(kf.kf_nickname,new Date().getTime(),'您好，还有什么可以继续帮您的？');
		kf.interval=setTimeout(kf_receive,3000);*/
	}
}
// 发送消息
function kf_send(){
	if(kf.stop){
		alert("由于您长时间未响应, 本次咨询服务结束, 感谢您的使用!");
		return;
	}
	if(!kf.kf_id){
		alert('目前不在线, 请您留言!');
		window.location.href='http://www.qdds.gov.cn/consult/addindex.jsp?category=7';
		return;
	}
	var contents=$("#contents").val();
	if(!contents){
		alert("发送内容不能为空!");
		return;
	}
	kf_append('用户',new Date().getTime(),contents);
	$("#contents").val('');
	$.getJSON('/zixun/layout/send.act',{
		"kfid": kf.kf_id,
		"cid": kf.cid,
		"gid": kf.kf_gid,
		"contents": contents,
		rand: Math.random()
	},function(data){
		if(data.status==1){
		}else if(data.status==5){
			alert('客服已离线, 请留言!');
			window.location.href='http://www.qdds.gov.cn/consult/addindex.jsp?category=7';
		}else{
			kf.error++;
			kf.errorinfo+=contents+'\n';
			if(kf.error>2){
				kf.error=0;
				alert('发送失败!\n'+kf.errorinfo);
				kf.errorinfo='';
			}
		}
	});
	kf.count=0;
}
// 计时器
function kf_receive(){
	if(kf.count>200){
		clearTimeout(kf.interval);
		kf_append(kf.kf_nickname,new Date().getTime(),'由于您长时间未响应, 本次咨询服务结束, 感谢您的使用!');
		kf.stop=true;
		$.getJSON('/zixun/layout/send.act',{
			"kfid": kf.kf_id,
			"cid": kf.cid,
			"gid": kf.kf_gid,
			"contents": '由于您长时间未响应, 本次咨询服务结束, 感谢您的使用!',
			rand: Math.random()
		},function(data){
			window.close();
		});
	}else{
		$.getJSON('/zixun/layout/receive.act',{
			"cid": kf.cid,
			"gid": kf.kf_gid,
			"start": kf.start,
			rand: Math.random()
		},function(data){
			if(data.status==1){
				kf.start=data.start;
				var html='';
				for(var i in data.list){
					var item=data.list[i];
					kf_append(kf.kf_nickname,parseFloat(item.create_time),item.contents);
				}
			}else{
			}
			kf.count++;
			kf.interval=setTimeout(kf_receive,3000);
		});
	}
}
// 添加
function kf_append(nickname,time,contents){
	var html='<div class="kf_nickname">'+nickname+' '+formatDate('h:i:s', time)+'</div>';
	html+='<div class="kf_contents">'+contents.replace(/\n/ig,'<br />')+'</div>';
	kf.main_div.append(html);
	kf.main_div.get(0).scrollTop=kf.main_div.get(0).scrollHeight;
}