/**
 * 包含easyui的扩展和常用的方法
 * 
 * @author 
 * 
 * @version 20120806
 */
$.ajaxSetup ({
	cache: false
});

var sy = $.extend({}, sy);/* 定义全局对象，类似于命名空间或包的作用 */

/**
 * 
 * 取消easyui默认开启的parser
 * 
 * 在页面加载之前，先开启一个进度条
 * 
 * 然后在页面所有easyui组件渲染完毕后，关闭进度条
 * 
 * @author 
 * 
 * @requires jQuery,EasySSH
 * 
 */
/*$.parser.auto = false;
$(function() {
	$.messager.progress({
		text : '页面加载中....',
		interval : 100
	});
	$.parser.parse(window.document);
	window.setTimeout(function() {
		$.messager.progress('close');
		if (self != parent) {
			window.setTimeout(function() {
				try {
					parent.$.messager.progress('close');
				} catch (e) {
				}
			}, 500);
		}
	}, 1);
	$.parser.auto = true;
});
*/
/**
 * 使panel和datagrid在加载时提示
 * 
 * @author 
 * 
 * @requires jQuery,EasySSH
 * 
 */
$.fn.panel.defaults.loadingMessage = '加载中....';
$.fn.datagrid.defaults.loadMsg = '加载中....';

/**
 * @author 
 * 
 * @requires jQuery,EasySSH
 * 
 * 通用错误提示
 * 
 * 用于datagrid/treegrid/tree/combogrid/combobox/form加载数据出错时的操作
 */
var easyuiErrorFunction = function(XMLHttpRequest) {
	$.messager.progress('close');
	var errorMessageDiv=$("#errorMessageDiv");
	if(errorMessageDiv.size()==0){
		errorMessageDiv=$("<div id='errorMessageDiv' >ddd</div>").hide();
	}
	var responseText = XMLHttpRequest.responseText;
	if(responseText!=null && responseText!='' && responseText.indexOf("this-is-login-page-flag")>0){
		$.messager.alert('错误', "请重新登录！" );
	}else{
		errorMessageDiv.html(responseText);
		$("body").append(errorMessageDiv);
		$.messager.alert('错误', "数据加载异常！请联系管理员&nbsp;<a style='color:red;font-size:10' id='copy-description'  href='javavscript:void(0)'><复制错误信息></a>" );
		  $('a#copy-description').zclip({
		        path:staticURL+'/zeroClipboard/ZeroClipboard.swf',
		        copy:$('#errorMessageDiv').html(),
		        afterCopy:function(){
		        	alert("复制成功，请将错误信息提交给管理员");
		        }
		});
	}
};
$.fn.datagrid.defaults.onLoadError = easyuiErrorFunction;
$.fn.treegrid.defaults.onLoadError = easyuiErrorFunction;
$.fn.tree.defaults.onLoadError = easyuiErrorFunction;
$.fn.combogrid.defaults.onLoadError = easyuiErrorFunction;
$.fn.combobox.defaults.onLoadError = easyuiErrorFunction;
$.fn.form.defaults.onLoadError = easyuiErrorFunction;

/**
 * @author 
 * 
 * @requires 
 * 
 * 为datagrid翻页清除选中onLoadSuccess 调用 clearSelections
 */
$.fn.datagrid.defaults.onLoadSuccess = function(){
	$(this).datagrid("clearSelections").datagrid("clearChecked");
	
};

/**
 * @author 
 * 
 * @requires 
 * 
 * pagination 增加分页数字
 */
$.fn.pagination.defaults.pageList.push(200);
$.fn.pagination.defaults.pageList.push(500);
$.fn.pagination.defaults.pageList.push(1000);
/**
 * @author 
 * 
 * @requires 
 * datagrid 默认关闭远程排序
 * 
 */
$.fn.datagrid.defaults.remoteSort=false;
$.fn.datagrid.defaults.commonSort=false;
/*遍历data 寻找是否有公共分页*/
$.fn.datagrid.defaults.beforLoadSuccess = function(data){
      //data.columnAlias="dd";
	//console.log(data);
};
$.fn.datagrid.defaults.changeSortNameBeforeLoad = function(param){
	var sorts=param.sort;
	if(sorts){
	var sortArray=sorts.split(",");
	var newSorts="";
	var rows=$(this).datagrid("getRows");
	for(var i=0;i<sortArray.length;i++){
		var sort=sortArray[i];
		for(var j=0;j<rows.length;j++){
			var row=rows[j];
			var newSort=row[sort+"_column"];
			if(newSort){
				break;
			}
		}
		if(!newSort){
			newSort=sort;
			break;
		}
		newSorts=newSorts+newSort;
		if(i<sortArray.length-1){
			newSorts=newSorts+",";	
			}
	 }
	param.sort=newSorts;
	}
};


/**
 * @author 
 * 
 * @requires 
 * datagrid 自定义初始化options
 * 
 */
$.fn.datagrid.customInitOptions = function(options){
	//tianjsh 增加分页数字
	if(options.pageList){
		options.pageList.push(200);
		options.pageList.push(500);
		options.pageList.push(1000);
	}
	//end
	//tianjsh 初始化sortable
	if(options.columns){
		for(var i=0,l=options.columns.length;i<l;i++){
			for(var ii=0,ll=options.columns[i].length;ii<ll;ii++){
				if(!options.columns[i][ii].colspan ){
					options.columns[i][ii].sortable = (options.columns[i][ii].sortable===false?false:true);
				}
			}
		}
	}
	if(options.frozenColumns){
		for(var i=0,l=options.frozenColumns.length;i<l;i++){
			for(var ii=0,ll=options.frozenColumns[i].length;ii<ll;ii++){
				if(!options.frozenColumns[i][ii].colspan ){
					options.frozenColumns[i][ii].sortable = (options.frozenColumns[i][ii].sortable===false?false:true);
				}
			}
		}
	}
	//end
};


/**
 * @author 
 * 
 * @requires jQuery,EasySSH
 * 
 * 为datagrid、treegrid增加表头菜单，用于显示或隐藏列，注意：冻结列不在此菜单中
 */
var createGridHeaderContextMenu = function(e, field) {
	e.preventDefault();
	var grid = $(this);/* grid本身 */
	var headerContextMenu = this.headerContextMenu;/* grid上的列头菜单对象 */
	if (!headerContextMenu) {
		var tmenu = $('<div style="width:100px;"></div>').appendTo('body');
		var fields = grid.datagrid('getColumnFields');
		for ( var i = 0; i < fields.length; i++) {
			var fildOption = grid.datagrid('getColumnOption', fields[i]);
			if (!fildOption.hidden) {
				$('<div iconCls="icon-ok" field="' + fields[i] + '"/>').html(fildOption.title).appendTo(tmenu);
			} else {
				$('<div iconCls="icon-empty" field="' + fields[i] + '"/>').html(fildOption.title).appendTo(tmenu);
			}
		}
		$('<div iconCls="icon-save all" />').html("表格导出Excel").appendTo(tmenu);
		$('<div iconCls="icon-save" />').html("选中导出Excel").appendTo(tmenu);
		headerContextMenu = this.headerContextMenu = tmenu.menu({
			onClick : function(item) {
				var field = $(item.target).attr('field');
				if(item.iconCls == 'icon-save all') {
					var json = datagridParse(grid);
					json.title =$('title').text();
					var data = JSON.stringify(json);
					exportExcel(data);
				}else if(item.iconCls == 'icon-save'){
					var json = datagridParse(grid,true);
					json.title =$('title').text();
					var data = JSON.stringify(json);
					exportExcel(data);
				}else if (item.iconCls == 'icon-ok') {
					grid.datagrid('hideColumn', field);
					$(this).menu('setIcon', {
						target : item.target,
						iconCls : 'icon-empty'
					});
				} else {
					grid.datagrid('showColumn', field);
					$(this).menu('setIcon', {
						target : item.target,
						iconCls : 'icon-ok'
					});
				}
			}
		});
	}
	headerContextMenu.menu('show', {
		left : e.pageX,
		top : e.pageY
	});
};
$.fn.datagrid.defaults.onHeaderContextMenu = createGridHeaderContextMenu;
$.fn.treegrid.defaults.onHeaderContextMenu = createGridHeaderContextMenu;

//自定义rowStyler
var rowStyler = function(rowIndex, rowData) {
	if(rowData.taskId!=null && rowData.dueDate != null && rowData.endTime == null){
		var data = $(this).datagrid("getData");
		var now = data.now;
		now = moment(moment(now).format("YYYY-MM-DD"));
		var due = moment(rowData.dueDate);
		var sub = due.diff(now, 'days');
		if(sub<0){
			//超期
			return 'background-color:red;color:white;';
		}else if(sub < 2){
			//预警
			return 'background-color:yellow;';
		}
	}
}
$.fn.datagrid.defaults.rowStyler =  rowStyler;

/**
 * @author 
 * 
 * @requires jQuery,EasySSH
 * 
 * 防止panel/window/dialog组件超出浏览器边界
 * @param left
 * @param top
 */
var easyuiPanelOnMove = function(left, top) {
	var closed = $(this).panel('options').closed;
	if(!closed){
		if (left < 0) {
			$(this).window('move', {
				left : 1
			});
		}
		if (top < 0) {
			$(this).window('move', {
				top : 1
			});
		}
		var width = $(this).panel('options').width;
		var height = $(this).panel('options').height;
		var width_ = $(this).width();
		var height_ = $(this).height();
		if(isNaN(width)){
			width = width_;
		}
		if(isNaN(height)){
			height = height_;
		}
		var right = left + width;
		var buttom = top + height;
		var browserWidth = $(window).width();
		var browserHeight = $(window).height();
	/*	console.log("left:"+left);
		console.log("top:"+top);
		console.log("width:"+width);
		console.log("height:"+height);
		console.log("browserWidth:"+browserWidth);
		console.log("browserHeight:"+browserHeight);
		console.log("right:"+right);
		console.log("buttom:"+buttom);*/
		if (right > browserWidth) {
			if(browserWidth > width){
				$(this).window('move', {
					left : browserWidth - width
				});
			}else if(left > (browserWidth-10)){
				$(this).window('move', {
					left : browserWidth - 10
				});
			}
		}
		if (buttom > browserHeight) {
			if(browserHeight > height){
				$(this).window('move', {
					top : browserHeight - height
				});
			}else if(top > (browserHeight -10)){
				$(this).window('move', {
					top : browserHeight - 10
				});
			}
		}
	}
};
//$.fn.panel.defaults.onMove = easyuiPanelOnMove;
//$.fn.window.defaults.onMove = easyuiPanelOnMove;
//$.fn.dialog.defaults.onMove = easyuiPanelOnMove;

/**
 * @author 
 * 
 * @requires jQuery,EasySSH
 * 
 * window , Dialog 打开时居中 
 */
var openCenter = function(){
	$(this).window("center");
}
$.fn.window.defaults.onBeforeOpen =  openCenter;
$.fn.dialog.defaults.onBeforeOpen =  openCenter;


/**
 * @author 
 * 
 * @requires jQuery,EasySSH
 * 
 * window , Dialog 打开时 高度超过外容器 居顶显示 
 */
var openToTop = function(){
	var height = $(this).panel('options').height;
	var height_ = $(this).height();
	if(isNaN(height)){
		height = height_;
	}
	var browserHeight = $(document).height();
	if(browserHeight < height){
		$(this).window('move', {
			top : 0
		});
	}
}
$.fn.window.defaults.onOpen =  openToTop;
$.fn.dialog.defaults.onOpen =  openToTop;

/**
 * @author 
 * 
 * @requires jQuery,EasySSH
 * 
 * combo combobox datebox在调用disable后调用该方法能保持表单的提交该input值的功能 
 */
$.fn.combo.methods.enableValue=function(jq){
	jq.each(function(){
		var combo = $.data(this, "combo").combo;
		combo.find(".combo-value").removeAttr("disabled");
	});
}


/**
 * @author 
 * 
 * @requires jQuery,EasySSH
 * 
 * panel关闭时回收内存
 */
$.fn.panel.defaults.onBeforeDestroy = function() {
	var frame = $('iframe', this);
	try {
		if (frame.length > 0) {
			frame[0].contentWindow.document.write('');
			frame[0].contentWindow.close();
			frame.remove();
			if ($.browser.msie) {
				CollectGarbage();
			}
		}
	} catch (e) {
	}
};

/**
 * @author 
 * 
 * @requires jQuery,EasySSH
 * 
 * 扩展validatebox，添加验证两次密码功能
 */
$.extend($.fn.validatebox.defaults.rules, {
	eqPassword : {
		validator : function(value, param) {
			return value == $(param[0]).val();
		},
		message : '密码不一致！'
	}
});

/**
 * @author 
 * 
 * @requires jQuery,EasySSH
 * 
 * 扩展datagrid，添加动态增加或删除Editor的方法
 * 
 * 例子如下，第二个参数可以是数组
 * 
 * datagrid.datagrid('removeEditor', 'cpwd');
 * 
 * datagrid.datagrid('addEditor', [ { field : 'ccreatedatetime', editor : { type : 'datetimebox', options : { editable : false } } }, { field : 'cmodifydatetime', editor : { type : 'datetimebox', options : { editable : false } } } ]);
 * 
 */
$.extend($.fn.datagrid.methods, {
	addEditor : function(jq, param) {
		if (param instanceof Array) {
			$.each(param, function(index, item) {
				var e = $(jq).datagrid('getColumnOption', item.field);
				e.editor = item.editor;
			});
		} else {
			var e = $(jq).datagrid('getColumnOption', param.field);
			e.editor = param.editor;
		}
	},
	removeEditor : function(jq, param) {
		if (param instanceof Array) {
			$.each(param, function(index, item) {
				var e = $(jq).datagrid('getColumnOption', item);
				e.editor = {};
			});
		} else {
			var e = $(jq).datagrid('getColumnOption', param);
			e.editor = {};
		}
	}
});

$.fn.datebox.defaults.formatter = function(date){
	return moment(date).format("YYYY-MM-DD");
}


/**
 * @author 
 * 
 * @requires jQuery,EasySSH
 * 
 * 扩展datagrid的editor
 * 
 * 增加带复选框的下拉树
 * 
 * 增加日期时间组件editor
 * 
 * 增加多选combobox组件
 */
$.extend($.fn.datagrid.defaults.editors, {
	combocheckboxtree : {
		init : function(container, options) {
			var editor = $('<input />').appendTo(container);
			options.multiple = true;
			editor.combotree(options);
			return editor;
		},
		destroy : function(target) {
			$(target).combotree('destroy');
		},
		getValue : function(target) {
			return $(target).combotree('getValues').join(',');
		},
		setValue : function(target, value) {
			$(target).combotree('setValues', sy.getList(value));
		},
		resize : function(target, width) {
			$(target).combotree('resize', width);
		}
	},
	datetimebox : {
		init : function(container, options) {
			var editor = $('<input />').appendTo(container);
			editor.datetimebox(options);
			return editor;
		},
		destroy : function(target) {
			$(target).datetimebox('destroy');
		},
		getValue : function(target) {
			return $(target).datetimebox('getValue');
		},
		setValue : function(target, value) {
			$(target).datetimebox('setValue', value);
		},
		resize : function(target, width) {
			$(target).datetimebox('resize', width);
		}
	},
	multiplecombobox : {
		init : function(container, options) {
			var editor = $('<input />').appendTo(container);
			options.multiple = true;
			editor.combobox(options);
			return editor;
		},
		destroy : function(target) {
			$(target).combobox('destroy');
		},
		getValue : function(target) {
			return $(target).combobox('getValues').join(',');
		},
		setValue : function(target, value) {
			$(target).combobox('setValues', sy.getList(value));
		},
		resize : function(target, width) {
			$(target).combobox('resize', width);
		}
	},
	singlecombogrid : {
		init : function(container, options) {
			var editor = $('<input />').appendTo(container);
			options.multiple = false;
			editor.combogrid(options);
			return editor;
		},
		destroy : function(target) {
			$(target).combogrid('destroy');
		},
		getValue : function(target) {
			return $(target).combogrid('getValue');
		},
		setValue : function(target, value) {
			$(target).combogrid('setValue', value);
		},
		resize : function(target, width) {
			$(target).combogrid('resize', width);
		}
	},
	multiplecombogrid : {
		init : function(container, options) {
			var editor = $('<input />').appendTo(container);
			options.multiple = true;
			editor.combogrid(options);
			return editor;
		},
		destroy : function(target) {
			$(target).combogrid('destroy');
		},
		getValue : function(target) {
			return $(target).combogrid('getValues').join(',');
		},
		setValue : function(target, value) {
			$(target).combogrid('setValues', sy.getList(value));
		},
		resize : function(target, width) {
			$(target).combogrid('resize', width);
		}
	}
});

/**
 * @author 
 * 
 * @requires jQuery,EasySSH,jQuery cookie plugin
 * 
 * 更换EasySSH主题的方法
 * 
 * @param themeName
 *            主题名称
 */
sy.changeTheme = function(themeName) {
	var $easyuiTheme = $('#easyuiTheme');
	var url = $easyuiTheme.attr('href');
	var href = url.substring(0, url.indexOf('themes')) + 'themes/' + themeName + '/easyui.css';
	$easyuiTheme.attr('href', href);

	var $iframe = $('iframe');
	if ($iframe.length > 0) {
		for ( var i = 0; i < $iframe.length; i++) {
			var ifr = $iframe[i];
			$(ifr).contents().find('#easyuiTheme').attr('href', href);
		}
	}

	$.cookie('easyuiThemeName', themeName, {
		expires : 7
	});
};

/**
 * @author 
 * 
 * 获得项目根路径
 * 
 * 使用方法：sy.bp();
 * 
 * @returns 项目根路径
 */
sy.bp = function() {
	var curWwwPath = window.document.location.href;
	var pathName = window.document.location.pathname;
	var pos = curWwwPath.indexOf(pathName);
	var localhostPaht = curWwwPath.substring(0, pos);
	var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
	return (localhostPaht + projectName);
};

/**
 * @author 
 * 
 * 使用方法:sy.pn();
 * 
 * @returns 项目名称(/sshe)
 */
sy.pn = function() {
	return window.document.location.pathname.substring(0, window.document.location.pathname.indexOf('\/', 1));
};

/**
 * @author 
 * 
 * 增加formatString功能
 * 
 * 使用方法：sy.fs('字符串{0}字符串{1}字符串','第一个变量','第二个变量');
 * 
 * @returns 格式化后的字符串
 */
sy.fs = function(str) {
	for ( var i = 0; i < arguments.length - 1; i++) {
		str = str.replace("{" + i + "}", arguments[i + 1]);
	}
	return str;
};

/**
 * @author 
 * 
 * 增加命名空间功能
 * 
 * 使用方法：sy.ns('jQuery.bbb.ccc','jQuery.eee.fff');
 */
sy.ns = function() {
	var o = {}, d;
	for ( var i = 0; i < arguments.length; i++) {
		d = arguments[i].split(".");
		o = window[d[0]] = window[d[0]] || {};
		for ( var k = 0; k < d.slice(1).length; k++) {
			o = o[d[k + 1]] = o[d[k + 1]] || {};
		}
	}
	return o;
};

/**
 * @author 郭华(夏悸)
 * 
 * 生成UUID
 * 
 * @returns UUID字符串
 */
sy.random4 = function() {
	return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
};
sy.UUID = function() {
	return (sy.random4() + sy.random4() + "-" + sy.random4() + "-" + sy.random4() + "-" + sy.random4() + "-" + sy.random4() + sy.random4() + sy.random4());
};

/**
 * @author 
 * 
 * 获得URL参数
 * 
 * @returns 对应名称的值
 */
sy.getUrlParam = function(name) {
	var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
	var r = window.location.search.substr(1).match(reg);
	if (r != null)
		return unescape(r[2]);
	return null;
};

/**
 * @author 
 * 
 * 接收一个以逗号分割的字符串，返回List，list里每一项都是一个字符串
 * 
 * @returns list
 */
sy.getList = function(value) {
	if (value != undefined && value != '') {
		var values = [];
		var t = value.split(',');
		for ( var i = 0; i < t.length; i++) {
			values.push('' + t[i]);/* 避免他将ID当成数字 */
		}
		return values;
	} else {
		return [];
	}
};

/**
 * @author 
 * 
 * @requires jQuery
 * 
 * 判断浏览器是否是IE并且版本小于8
 * 
 * @returns true/false
 */
sy.isLessThanIe8 = function() {
	return ($.browser.msie && $.browser.version < 8);
};

/**
 * @author 
 * 
 * @requires jQuery
 * 
 * 将form表单元素的值序列化成对象
 * 
 * @returns object
 */
sy.serializeObject = function(form) {
	var o = {};
	$.each(form.serializeArray(), function(index) {
		if (o[this['name']]) {
			o[this['name']] = o[this['name']] + "," + this['value'];
		} else {
			o[this['name']] = this['value'];
		}
	});
	return o;
};

/**
 * 
 * 将JSON对象转换成字符串
 * 
 * @param o
 * @returns string
 */
sy.jsonToString = function(o) {
	var r = [];
	if (typeof o == "string")
		return "\"" + o.replace(/([\'\"\\])/g, "\\$1").replace(/(\n)/g, "\\n").replace(/(\r)/g, "\\r").replace(/(\t)/g, "\\t") + "\"";
	if (typeof o == "object") {
		if (!o.sort) {
			for ( var i in o)
				r.push(i + ":" + obj2str(o[i]));
			if (!!document.all && !/^\n?function\s*toString\(\)\s*\{\n?\s*\[native code\]\n?\s*\}\n?\s*$/.test(o.toString)) {
				r.push("toString:" + o.toString.toString());
			}
			r = "{" + r.join() + "}";
		} else {
			for ( var i = 0; i < o.length; i++)
				r.push(obj2str(o[i]));
			r = "[" + r.join() + "]";
		}
		return r;
	}
	return o.toString();
};

/**
 * @author 郭华(夏悸)
 * 
 * 格式化日期时间
 * 
 * @param format
 * @returns
 */
Date.prototype.format = function(format) {
	if (isNaN(this.getMonth())) {
		return '';
	}
	if (!format) {
		format = "yyyy-MM-dd hh:mm:ss";
	}
	var o = {
		/* month */
		"M+" : this.getMonth() + 1,
		/* day */
		"d+" : this.getDate(),
		/* hour */
		"h+" : this.getHours(),
		/* minute */
		"m+" : this.getMinutes(),
		/* second */
		"s+" : this.getSeconds(),
		/* quarter */
		"q+" : Math.floor((this.getMonth() + 3) / 3),
		/* millisecond */
		"S" : this.getMilliseconds()
	};
	if (/(y+)/.test(format)) {
		format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	}
	for ( var k in o) {
		if (new RegExp("(" + k + ")").test(format)) {
			format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
		}
	}
	return format;
};

/**
 * @author 
 * 
 * @requires jQuery
 * 
 * 改变jQuery的AJAX默认属性和方法
 */
$.ajaxSetup({
	type : 'POST',
	error : function(XMLHttpRequest, textStatus, errorThrown) {
		easyuiErrorFunction(XMLHttpRequest);
		//$.messager.progress('close');
		//$.messager.alert('错误', XMLHttpRequest.responseText);
	}
});
//订单号自动补加0 （共10位）
$(function(){
	$("input.orderAutoComple").live('focusout', function() {
		var v = $(this).val();
		if (v && v.length > 0 && v.length < 10) {
			$(this).val('0000000000'.substr(v.length) + v);
		}
	});
});
//datagrid 获取解析后的json
function datagridParse(datagrid,checked){
	var grid = datagrid;
	if(typeof(grid) == 'string'){
		grid = $(grid);
	}
	var data = {};
	data.header = [];
	data.rows = [];
	data.footer = [];
	data.total = 0;
	var selected = [];
	//表头
	grid.datagrid("getPanel").find(".datagrid-header .datagrid-htable").each(function(){
		$(this).find("tr.datagrid-header-row").each(function(i){
			$(this).find("td:not([field='ck'])").each(function(){
				if($(this).css("display")!='none'){
					var it = $(this).find("span:not(.datagrid-sort-icon),div.datagrid-cell-group");
					data.header.push(it.text());
				}
			});
		});
	});
	//表内容
	grid.datagrid("getPanel").find(".datagrid-body .datagrid-btable").each(function(){
		$(this).find("tr.datagrid-row").each(function(i){
			data.total = i+1;
			if(data.rows.length < data.total){
				data.rows.push([]);
			}
			var checkbox = $(this).find("td[field='ck'] input:checkbox");
			if(checkbox.size()==1){
				selected[i] = checkbox.attr("checked")=="checked";
			}else{
				selected[i] = selected[i] || (selected[i]=== undefined);
			}
			$(this).find("td:not([field='ck'])").each(function(j){
				if($(this).css("display")!='none'){
					var it = $(this).find("div.datagrid-cell,div.datagrid-cell-rownumber");
					data.rows[i].push(it.text());
				}
			});
		});
	});
	if(checked){
		var newrows = [];
		for(var i=0,l=selected.length;i<l;i++){
			if(selected[i]){
				newrows.push(data.rows[i]); 
			}
		}
		data.rows = newrows; 
	}
	return data;
}
function exportExcel(data){
	$("form.hiddenDataGridForm").remove();
	var form = $("<form style='dispaly:none' calss='hiddenDataGridForm' action='"+dynamicURL+"/basic/exportDataGridAction/export.action'  enctype='multipart/form-data' method='post' target='_blank'><input type='hidden' name='data' /></form>"); 
	form.find("input").val(data);
	$("body").append(form);
	form.submit();
}
//datagrid 转换成普通表格
function gridToTable(obj){
	if(typeof(obj) == 'string'){
		obj = $(obj);
	}
	obj.find(".datagrid").each(function(){
		var t = $(this);
		var oldTable = t.children(".datagrid-view").children("table");
		var table;
		if(oldTable.size()>0){
			var table = $("<table class='printTable' border='1'  cellpadding='0' cellspacing='0' id='"+ oldTable.attr("id") +"' ></table>");
		}
		var table = $("<table class='printTable' border='1'  cellpadding='0' cellspacing='0' ></table>");
		//表头
		var hm = [];
		$(this).find(".datagrid-header .datagrid-htable").each(function(){
			var height = $(this).height();
			$(this).find("tr.datagrid-header-row").each(function(i){
				var d = "";
				$(this).find("td").each(function(){
					if($(this).css("display")!='none'){
						var rowspan = $(this).attr("rowspan");
						var colspan = $(this).attr("colspan");
						if($(this).find("div.datagrid-header-rownumber").size()>0){
							if(height>25){
								rowspan = height/25;
							}
						}
						rowspan = rowspan ==null?"":"rowspan="+rowspan;
						colspan = colspan ==null?"":"colspan="+colspan;
						var it = $(this).find("span:not(.datagrid-sort-icon),div.datagrid-cell-group");
						var html = it.html();
						d = d+"<th " + colspan + " " + rowspan + " >" + (html==undefined ?"":html) + "</th>";	
					}
				});
				hm[i] = hm[i] == null?d:hm[i]+d;
			});
			
		});
		//表内容
		var bm = [];
		$(this).find(".datagrid-body .datagrid-btable").each(function(){
			$(this).find("tr.datagrid-row").each(function(i){
				var d = "";
				$(this).find("td").each(function(i){
					if($(this).css("display")!='none'){
						var rowspan = $(this).attr("rowspan");
						var colspan = $(this).attr("colspan");
						rowspan = rowspan ==null?"":"rowspan="+rowspan;
						colspan = colspan ==null?"":"colspan="+colspan;
						var it = $(this).find("div.datagrid-cell,div.datagrid-cell-rownumber");
						var html = it.html();
						d = d + "<td  " + colspan + " " + rowspan + " >" + (html==undefined ?"":html) + "</td>";
					}
				});
				bm[i] = bm[i] == null?d:bm[i]+d;
			});
		});
		//页脚
		var fm = [];
		$(this).find(".datagrid-footer .datagrid-ftable").each(function(){
			$(this).find("tr.datagrid-row").each(function(i){
				var d = "";
				$(this).find("td").each(function(i){
					if($(this).css("display")!='none'){
						var rowspan = $(this).attr("rowspan");
						var colspan = $(this).attr("colspan");
						rowspan = rowspan ==null?"":"rowspan="+rowspan;
						colspan = colspan ==null?"":"colspan="+colspan;
						var it = $(this).find("div.datagrid-cell");
						var html = it.html();
						d = d + "<td  " + colspan + " " + rowspan + " >" + (html==undefined ?"":html) + "</td>";
					}
				});
				fm[i] = fm[i] == null?d:fm[i]+d;
			});
		});
		var b = "";
		for(var i = 0,l=bm.length;i<l;i++){
			b = b + "<tr>" + bm[i] + "</tr>";
		}
		var f = "";
		for(var i = 0,l=fm.length;i<l;i++){
			f = f + "<tr>" + fm[i] + "</tr>";
		}
		var h = "";
		for(var i = 0,l=hm.length;i<l;i++){
			h = h + "<tr>" + hm[i] + "</tr>";
		}
		table.append(h+b+f);
		t.after(table);
		t.remove();
	});
	obj.find("input[type=text]").each(function(){
		var v = $(this).val();
		if(v==''){
			v = '&nbsp;'
		}
		$(this).after("<span>" + v + "</span>");
		$(this).remove();
	});
	return obj;
}
//打印预览(不能打印)
function lodopPreview(obj,title){
	lodopPreviewHtml(obj.html(),title);
};
//打印预览（返回打印的次数）
function lodopPrint(obj,title){
	//word-break:break-all;
	return lodopPrintHtml(obj.html(),title);
};
//打印预览（返回打印的次数）
function lodopPrintAutoWidth(obj,title){
	//word-break:break-all;
	var printHtml = obj.html();
	var LODOP=getLodop(document.getElementById('LODOP_OB'),document.getElementById('LODOP_EM'));
	if(title!= undefined){
		LODOP.PRINT_INIT(title);
	}
	var style="<link href='"+ staticURL +"/style/demo/css/demoPrint.css?v=1.9' rel='stylesheet' />";
	var strBodyStyle="<style>table,tr,td,th  { border: 1px solid #979a9d;border-collapse:collapse ;};table{cellpadding:0;cellspacing:0};th{font-weight: bold;};.printTable{width:100%}</style>";
	LODOP.ADD_PRINT_HTM(5,5,"100%","100%",style+strBodyStyle+"<body leftmargin=0 topmargin=0>"+printHtml+"</body>");
	LODOP.SET_PRINT_MODE("PRINT_PAGE_PERCENT","Auto-Width");
	//LODOP.SET_PREVIEW_WINDOW(0,0,0,0,0,"");
	var result = LODOP.PREVIEW();
	return result;
};
//打印预览（返回打印的次数）
function lodopPrintFullWidth(obj,title){
	//word-break:break-all;
	var printHtml = obj.html();
	var LODOP=getLodop(document.getElementById('LODOP_OB'),document.getElementById('LODOP_EM'));
	if(title!= undefined){
		LODOP.PRINT_INIT(title);
	}
	var style="<link href='"+ staticURL +"/style/demo/css/demoPrint.css?v=1.9' rel='stylesheet' />";
	var strBodyStyle="<style>table,tr,td,th  { border: 1px solid #979a9d;border-collapse:collapse ;};table{cellpadding:0;cellspacing:0};th{font-weight: bold;};.printTable{width:100%}</style>";
	LODOP.ADD_PRINT_HTM(5,5,"100%","100%",style+strBodyStyle+"<body leftmargin=0 topmargin=0>"+printHtml+"</body>");
	LODOP.SET_PRINT_MODE("PRINT_PAGE_PERCENT","Full-Width");
	//LODOP.SET_PREVIEW_WINDOW(0,0,0,0,0,"");
	var result = LODOP.PREVIEW();
	return result;
};

//打印预览（返回打印的次数）
function lodopPrintHtml(printHtml,title){
	var LODOP=getLodop(document.getElementById('LODOP_OB'),document.getElementById('LODOP_EM'));
	if(title!= undefined){
		LODOP.PRINT_INIT(title);
	}
	var style="<link href='"+ staticURL +"/style/demo/css/demoPrint.css?v=1.8' rel='stylesheet' />";
	var strBodyStyle="<style>table,tr,td,th  { border: 1px solid #979a9d;border-collapse:collapse ;};table{cellpadding:0;cellspacing:0};th{font-weight: bold;};.printTable{width:100%}</style>";
	LODOP.ADD_PRINT_HTM(5,5,"100%","100%",style+strBodyStyle+"<body leftmargin=0 topmargin=0>"+printHtml+"</body>");
	LODOP.SET_PRINT_MODE("PRINT_PAGE_PERCENT","Full-Page");
	//LODOP.SET_PREVIEW_WINDOW(0,0,0,0,0,"");
	var result = LODOP.PREVIEW();
	return result;
};
//打印预览(不能打印)
function lodopPreviewHtml(printHtml,title){
	var LODOP=getLodop(document.getElementById('LODOP_OB'),document.getElementById('LODOP_EM'));
	if(title!= undefined){
		LODOP.PRINT_INIT(title);
	}
	var style="<link href='"+ staticURL +"/style/demo/css/demoPrint.css?v=1.8' rel='stylesheet' />";
	var strBodyStyle="<style>table,tr,td,th { border: 1px solid #979a9d;border-collapse:collapse };table{cellpadding:0;cellspacing:0};th{font-weight: bold;};.printTable{width:100%}</style>";
	LODOP.ADD_PRINT_HTM(5,5,"100%","100%",style+strBodyStyle+"<body leftmargin=0 topmargin=0>"+printHtml+"</body>");
	LODOP.SET_PRINT_MODE("PRINT_PAGE_PERCENT","Full-Page");
	//LODOP.SET_PREVIEW_WINDOW(0,0,0,0,0,"");
	LODOP.SET_PREVIEW_WINDOW(1,3,0,0,0,"预览查看.开始打印");
	LODOP.PREVIEW();
};
function lodopPrintUrl(url,isPrint){
	var LODOP=getLodop(document.getElementById('LODOP_OB'),document.getElementById('LODOP_EM'));
	LODOP.ADD_PRINT_URL(0,0,"100%","100%",url);
	LODOP.SET_PRINT_MODE("PRINT_PAGE_PERCENT","Full-Width");
	if(isPrint){
		LODOP.PRINT();
	}else{
		LODOP.PREVIEW();
	}
}
String.prototype.encodeURL = function () {
	return this.replace(/\%/g,"%25").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\+/g,"%2B").replace(/\=/g,"%3D").replace(/\?/g,"%3F");
}

String.prototype.endWith=function(str){
	if(str==null||str==""||this.length==0||str.length>this.length)
	  return false;
	if(this.substring(this.length-str.length)==str)
	  return true;
	else
	  return false;
	return true;
}
