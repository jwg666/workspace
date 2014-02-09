$.extend($.fn.validatebox.defaults.rules, {
    duplicate_hotelname: {
        validator: function (value, param) {
            return duplicate_hotelname(value,param);
        },
        message: '酒店中文全称,在系统中已经存在!'
    },
    duplicate_hotel_nameeng: {
        validator: function (value, param) {
            return duplicate_hotel_nameeng(value,param);
        },
        message: '酒店英文名字,在系统中已经存在!'
    },
    duplicate_room_engname: {
        validator: function (value, param) {
            return duplicate_room_engname(value,param);
        },
        message: '房型英文全称,在系统中已经存在!'
    },
    duplicate_roomjianname: {
        validator: function (value, param) {
            return duplicate_roomjianname(value,param);
        },
        message: '房型简称,在系统中已经存在!'
    },
    duplicate_roomname: {
        validator: function (value, param) {
            return duplicate_roomname(value,param);
        },
        message: '房型中文名称,在系统中已经存在!'
    },
    duplicate_trns_engname: {
        validator: function (value, param) {
            return duplicate_trns_engname(value,param);
        },
        message: '交通方式英文名字,在系统中已经存在!'
    },
    duplicate_trnspname: {
        validator: function (value, param) {
            return duplicate_trnspname(value,param);
        },
        message: '交通方式中文名字,在系统中已经存在!'
    }
});


//[酒店管理]酒店中文全称
var duplicate_hotelname = function(value,param){
	var returnflag = ajax_check('HotelEntity','hotelname',value,param);
	return returnflag;
}
//[酒店管理]酒店英文名字
var duplicate_hotel_nameeng = function(value,param){
	var returnflag = ajax_check('HotelEntity','nameeng',value,param);
	return returnflag;
}
//[房型管理]英文全称
var duplicate_room_engname = function(value,param){
	var returnflag = ajax_check('RoomtypeEntity','engname',value,param);
	return returnflag;
}
//[房型管理]简称
var duplicate_roomjianname = function(value,param){
	var returnflag = ajax_check('RoomtypeEntity','roomjianname',value,param);
	return returnflag;
}
//[房型管理]中文全称
var duplicate_roomname = function(value,param){
	var returnflag = ajax_check('RoomtypeEntity','roomname',value,param);
	return returnflag;
}
//[交通方式]英文名字
var duplicate_trns_engname = function(value,param){
	var returnflag = ajax_check('TransportwayEntity','engname',value,param);
	return returnflag;
}
//[交通方式]中文全称
var duplicate_trnspname = function(value,param){
	var returnflag = ajax_check('TransportwayEntity','trnspname',value,param);
	return returnflag;
}

//4) 餐标管理：英文名字和中文全称称判重
//5) 航空公司：供应商：同行会员：以公司全称和中文简称判重
//6) 同行旅行社联系人：可以填多个，以手机号为必录项，判重。
//6) 控票管理，控房管理：以控房名和控票名判重
//8) 行程线路：以线路名称判重
//9) 团购模版：以模版名称判重
//10) 旅游线路：以线路名称判重
//11)(团-基础信息）费用项目管理：以项目称判重
//12) 国籍航班城市列表：以城市三字码判重

//共通方法
var ajax_check = function(tableName,fieldName,fieldVlaue,param){
	//获取编辑页面的数据主键
	var obid = null;
	if(param!=null){
		 var obid_id = param[0];
		 obid = $("#"+obid_id+"").val();
	}else{
		 obid = $("input[name='obid']").val();
	}
	
	$.ajaxSetup({ async: false});//同步ajax 
	var check_flag;
	$.ajax({
		url : 'duplicateCheckAction!doDuplicateCheck.action',
		async:false,
		data : {
			tableName : tableName,
			fieldName : fieldName,
			fieldVlaue: fieldVlaue,
			rowObid   : obid
		},
		dataType : 'json',
		success : function(response) {
			check_flag = response.success;
		}
	});
	$.ajaxSetup({ async: false});//同步ajax 
	return check_flag;
}