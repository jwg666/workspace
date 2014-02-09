/**
 * 文本框输入长度校验
 * @param strText
 * @author xuping
 */

function checkMaxInput(strText){
	var textLen = 0;
	for(var i=0;i<strText.length;i++){
		if(strText.charCodeAt(i) > 256){//汉字
			textLen += 2;
		}else{
			textLen ++;
		}
	}
	return textLen;
}

// 对按钮进行操作，判断对象的长度为1，或大于1时，按钮的状态
function checkButtonStatus(len,checkArray){
	if(checkArray.multiCheck){
		var multiCheckArray = checkArray.multiCheck;
		for(i=0;i<multiCheckArray.length;i++){
	    	if(len > 0){
	    		$("#"+multiCheckArray[i]).removeAttr("disabled");
	    	}else{
	    		$("#"+multiCheckArray[i]).attr("disabled","true");
	    	}
	    }
	}
	if(checkArray.singleCheck){
		var singleCheckArray = checkArray.singleCheck;
		for(i=0;i<singleCheckArray.length;i++){
	    	if(len == 1){
	    		$("#"+singleCheckArray[i]).removeAttr("disabled");
	    	}else{
	    		$("#"+singleCheckArray[i]).attr("disabled","true");
	    	}
	    }
	}	
}

//拼easyui选择行字符串
function contractRowids(checkedRows){
	var rowId = "";
	if(checkedRows && checkedRows[0]){
		$.each(checkedRows,function(index){
			if(rowId == ""){
				rowId = checkedRows[index].rowId;	
			}else{
				rowId = rowId + "," +checkedRows[index].rowId;
			}
		})
	}
	return rowId;
}

//注册easyui按钮事件。
function initButtonStatus(tableId){
	var checkedRows = $('#'+tableId).datagrid("getChecked");
	var l = checkedRows.length;
	var checkArray = {};
	var opts = $('#'+tableId).datagrid("options");
	if(opts.multiCheck){
		checkArray.multiCheck = opts.multiCheck;
	}
	if(opts.singleCheck){
		checkArray.singleCheck = opts.singleCheck;
	}
	checkButtonStatus(l,checkArray);
}
function registerButtonStatus(tableId){
	$('#'+tableId).datagrid({
	   onCheck:function(rowIndex,rowData){
			initButtonStatus(tableId);
		},
		onUncheck:function(rowIndex,rowData){
			initButtonStatus(tableId);
		},
		onCheckAll:function(rowIndex,rowData){
			initButtonStatus(tableId);
		},
		onUncheckAll:function(rowIndex,rowData){
			initButtonStatus(tableId);
		}
	});
	initButtonStatus(tableId);
}

//easyui验证扩展方法
function initRequiredAttributes(attributes){
    for(i=0;i<attributes.length;i++){
   	 $("#"+attributes[i]).validatebox({   
 		   required:true
        })  
    } 
}

//根据字典代码和code获取name。
var _dictObj={};
function getDictName(dictCode,code){
	var data;
	if(_dictObj[dictCode]){
		var dictData = _dictObj[dictCode];
	}else{
		var param = {
				lovCode:dictCode
		};
		$.ajax({
	        type:"post",
	        async:false,
	        dataType:"json",
	        url:dynamicURL+"/system/searchDataDictAction.action",
	        data:param,
	        error: function(){ 
	           alert('Error!');    
	        },    
	        success:function(data){
        		dictData = data;
        		_dictObj[dictCode] = data;
	        }
		},"json");
	}
	var returnValue = code;
	if(dictData && dictData.length > 0){
		$.each(dictData,function(i, obj){
			if(obj.code == code){
				returnValue = obj.name;
				return false;
			}
		})
		
	}
	return returnValue;
}

//扩展easyui中控件
(function($){
	/**
	 * datetimebox格式化
	 */
	$.extend($.fn.datagrid.defaults.editors, {
		datetimebox : {
			init : function(container, options) {
				var _date = new Date();
				var input = $('<input class="easyuidatetimebox">').appendTo(
						container);
				return input.datetimebox({
					formatter : function(_date) {
						return new Date().format("yyyy-MM-dd hh:mm:ss");
					}
				});
			},
			getValue : function(target) {
				return $(target).parent().find('input.combo-value').val();
			},
			setValue : function(target, value) {
				$(target).datetimebox("setValue", value);
			},
			resize : function(target, width) {
				var input = $(target);
				if ($.boxModel == true) {
					input.width(width - (input.outerWidth() - input.width()));
				} else {
					input.width(width);
				}
			}
		}
	});
	
	/**
	 * 自定义commboSelect
	 */
	$.extend($.fn.datagrid.defaults.editors,{
		commboSelect:{
			init : function(container, options){
				var data;
				var input = $('<input type=\"text\" id="cc" class="easyuicombobox">').appendTo(container);
				var strUrl = options.url;
				var _index = options.id;
				var _dataJson = {};
				var param = {};
				if(options.lovCode != "lovCode" && options.lovCode != undefined){
					strUrl = options.url + "?lovCode=" + options.lovCode;
					_index = options.lovCode;
				}
				if(options.lovSql != "lovSql" && options.lovSql != undefined){
					strUrl = options.url + "?lovSql=" + options.lovSql;
					_index = options.lovSql;
				}
				if(_dataJson[_index] == undefined){
					$.ajax({
						type:"post",
						async:false,
						url:strUrl,
						data:param,
						dataType:"json",
						success:function(data){
							_dataJson[_index] = data;
						},error:function(){
							alert("Error!");
						}
					});
				}else{
					data = _dataJson[_index];
				}
				return input.combobox(options || _dataJson[_index]);
			},
			getValue:function(target){
				return $(target).combobox("getValue");
			},
			setValue : function(target, value) {
				$(target).combobox("setValue", value);
			},
			resize : function(target, _width) {
				$(target).combobox("resize",_width);
			}
		}
	})
})(jQuery);

//时间格式化
Date.prototype.format = function(format){ if(!format){ format = "yyyy-MM-dd hh:mm:ss"; } var o = { "M+": this.getMonth() + 1, // month 
		"d+": this.getDate(), //day 
		"h+": this.getHours(), //hour 
		"m+": this.getMinutes(), // minute 
		"s+": this.getSeconds(), // second 
		"q+": Math.floor((this.getMonth() + 3) / 3), //quarter 
		"S": this.getMilliseconds() // millisecond 
		}; 
if (/(y+)/.test(format)) {
	format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length)); 
} 
for (var k in o) {
	if (new RegExp("(" + k + ")").test(format)) {
		format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" +o[k]).length)); 
	}
} 
return format; 
};


