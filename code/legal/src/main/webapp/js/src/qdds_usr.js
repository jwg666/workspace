// 刷新验证码
function refreshvcode(obj){
	$(obj).attr('src','/zixun/layout/web!loginimg.act?rand='+Math.random());
}
// 登录
function u_login(){
	var uname=$('#uname').val();
	if(!uname||uname.length<5){
		Alert('用户名不符号要求','友情提示');
		return;
	}
	var password=$('#password').val();
	if(!password){
		Alert('请填写密码','友情提示');
		return;
	}
	if(password.length<6){
		Alert('密码不能少于6个字母','友情提示');
		return;
	}
	Wait(true);
	$.getJSON('/zixun/layout/ajax_login.act',{
		"u.uname": uname,
		"u.psw": password,
		rand: Math.random()
	},function(data){
		Wait(false);
		if(data.status==1){
			window.location.href = '/zixun/manage/';
		}else{
			Alert('登录失败！<br />用户名或密码错误，请重新登录！','友情提示');
		}
	});
}
// 保存密码
function h_u_save2(){
	var password=$('#password').val();
	if(password.length<6){
		Alert('密码长度必须大于6!','友情提示');
		return;
	}
	var password2=$('#password2').val();
	if(password!=password2){
		Alert('两次密码输入不一致!','友情提示');
		return;
	}
	Wait(true);
	$.getJSON('/zixun/manage/save2.act',{
		"u.psw": password,
		rand: Math.random()
	},function(data){
		Wait(false);
		if(data.status==1){
			Alert('保存成功!','友情提示',2,5000,function(){window.location.href='/zixun/manage/';});
		}else{
			Alert('保存失败!','友情提示');
		}
	});
}
// 更新客服状态
function m_u_setstatus(uid,status){
	Wait(true);
	$.getJSON('/zixun/manage/kf_setstatus.act',{
		"u.id": uid,
		"u.status": status,
		rand: Math.random()
	},function(data){
		Wait(false);
		if(data.status==1){
			Alert('更新成功!','友情提示',2,5000,function(){window.location.reload();});
		}else{
			Alert('更新失败!','友情提示');
		}
	});
}
// 保存
function m_u_save(uid){
	var uname=$('#uname').val();
	if(!uname||uname.length<5){
		Alert('用户名不符号要求','友情提示');
		return;
	}
	var password=$('#psw').val();
	if(password&&password.length<6){
		Alert('密码不能少于6个字母','友情提示');
		return;
	}
	var nickname=$('#nickname').val();
	var truename=$('#truename').val();
	var rids=",";
	$("input[name=rid]:checked").each(function(){rids+=this.value+",";});
	Wait(true);
	$.getJSON('/zixun/manage/kf_save.act',{
		"u.id": uid,
		"u.uname": uname,
		"u.psw": password,
		"u.nickname": nickname,
		"u.truename": truename,
		"u.rids": rids,
		rand: Math.random()
	},function(data){
		Wait(false);
		if(data.status==1){
			window.location.href = '/zixun/manage/kf_list.act';
		}else{
			Alert('保存失败！','友情提示');
		}
	});
}
// 更新分组状态
function m_r_setstatus(rid,status){
	Wait(true);
	$.getJSON('/zixun/manage/kf_r_setstatus.act',{
		"r.id": rid,
		"r.status": status,
		rand: Math.random()
	},function(data){
		Wait(false);
		if(data.status==1){
			Alert('更新成功!','友情提示',2,5000,function(){window.location.reload();});
		}else{
			Alert('更新失败!','友情提示');
		}
	});
}
// 保存分组
function m_r_save(rid){
	var rname=$('#rname').val();
	if(!rname){
		Alert('分组名称必须填写','友情提示');
		return;
	}
	Wait(true);
	$.getJSON('/zixun/manage/kf_r_save.act',{
		"r.id": rid,
		"r.rname": rname,
		rand: Math.random()
	},function(data){
		Wait(false);
		if(data.status==1){
			window.location.href = '/zixun/manage/kf_rlist.act';
		}else{
			Alert('失败！','友情提示');
		}
	});
}
// 保存咨询类别
function m_category_save(id){
	var title=$('#title').val();
	if(!title){
		Alert('名称必须填写','友情提示');
		return;
	}
	Wait(true);
	$.getJSON('/zixun/manage/category_save.act',{
		"c.id": id,
		"c.title": title,
		rand: Math.random()
	},function(data){
		Wait(false);
		if(data.status==1){
			window.location.href = '/zixun/manage/category_list.act';
		}else{
			Alert('失败！','友情提示');
		}
	});
}
// 保存问题
function m_q_save(id){
	var truename=$('#truename').val();
	var link=$('#link').val();
	var email=$('#email').val();
	var replymode=$('input[name=replymode]:checked').val();
	var category=$('#category').val();
	var rid=$('#rid').val()||0;
	var uid=$('#uid').val()||0;
	var create_time=$('#create_time').val();
	var question=$('#question').val();
	var answer=$('#answer').val();
	Wait(true);
	$.getJSON('/zixun/manage/question_save.act',{
		"q.id": id,
		"q.truename": truename,
		"q.link": link,
		"q.email": email,
		"q.replymode": replymode,
		"q.category": category,
		"q.rid": rid,
		"q.uid": uid,
		"q.create_time": create_time,
		"q.question": question,
		"q.answer": answer,
		rand: Math.random()
	},function(data){
		Wait(false);
		if(data.status==1){
			window.location.href = '/zixun/manage/question_list.act';
		}else{
			Alert('保存失败！','友情提示');
		}
	});
}
// 删除问题
function m_q_delete(id,status){
	Wait(true);
	$.getJSON('/zixun/manage/question_delete.act',{
		"q.id": id,
		"q.status": status,
		rand: Math.random()
	},function(data){
		Wait(false);
		if(data.status==1){
			Alert('操作成功!','友情提示',2,5000,function(){window.location.reload();});
		}else{
			Alert('操作失败!','友情提示');
		}
	});
}
// 入库申请
function m_q_put(id){
	Wait(true);
	$.getJSON('/zixun/manage/putin.act',{
		"q.id": id,
		rand: Math.random()
	},function(data){
		Wait(false);
		if(data.status==1){
			Alert('操作成功!','友情提示',2,5000,function(){window.location.reload();});
		}else{
			Alert('操作失败!','友情提示');
		}
	});
}
// 导出问题到word
function m_q_export(){
	var qids="";
	$("input[name=is_export]:checked").each(function(){
		qids+=","+this.value;
	});
	if(!qids){
		Alert('请先选择要导出的记录','友情提示');
		return;
	}
	window.open('/zixun/manage/question_export.act?qids='+qids);
}