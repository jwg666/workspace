function removeErrors(){
	$('#_error_message_box').html('').removeClass('errorMessage');
	$('.errorLabel').html('').removeClass('errorLabel');  
}
function handleErrors(event,data,handler) {
	removeErrors();
	var json = $.parseJSON(event.originalEvent.request.responseText);  
    if(json.doErrors && json.doErrors.length>0){//判断有没有actionErrors  
        $.each(json.doErrors,function(index,data){  
            $("#_error_message_box").append(data+"<br/>");  
        });  
        $('#_error_message_box').addClass('errorMessage');
        handler.onFaild();
        return;  
    }  
    if(json.fieldErrors && !isEmpty(json.fieldErrors)) {//判断有没有fieldError(LoginAction-validation.xml验证错误)  
        $.each(json.fieldErrors,function(index,value) {//index就是field的name,value就是该filed对应的错误列表，这里取第一个  
        	$("#_error_message_box").append(value[0]+"<br/>");  
            //$("#error_"+index).html(value[0]);  
            //$("#error_"+index).addClass("errorLabel");  
        });  
        $('#_error_message_box').addClass('errorMessage');
        handler.onFaild();
        return;  
    }  
    handler.onSuccess();
}
//判断对象是否为空(处理Object obj = {}这种情况认为isEmpty=true)  
function isEmpty(obj){
    for(var p in obj){  
        return false;  
    }  
    return true;  
} 

//各行变色表格
$(document).ready(function(){  
    $(".color_table tr").mouseover(function(){  
     $(this).addClass("over");  
     $(this).removeClass("double");
    });  
    $(".color_table tr:even").mouseover(function(){  
        $(this).find(".double").removeClass("double");
    }); 
    $(".color_table tr").mouseout(function(){  
     $(this).removeClass("over");
     $(this).find(".double").addClass("double");
    });   
    $(".color_table tr:even").mouseout(function(){  
        $(this).addClass("double");
    });  
    $(".color_table tr:even").addClass("double");   
});  
//对象内部属性信息--便于调试
function display(obj){
	var result = "";
	for(var p in obj){
		result = result + p +"="+obj[p]+"\n";
	}
	alert(result);
}

//获取当前请求链接（去除context,去除参数）
function formatURL(fullUrl){
	var paramIndex = fullUrl.indexOf("?");
	if(paramIndex == -1){
		paramIndex = fullUrl.length;
	}
	return fullUrl.substring(0,paramIndex);
}
//左侧菜单高亮选中
function highlightLeftMenu(){
	var fullUrl = window.location.href;
	var url = formatURL(fullUrl);
	$(".user-app a").each(function(i){
		var href = formatURL(this.href);
		if(href==url){
			$(this).css({"color":"#D71249"});//高亮
			$(this).addClass("cut");
			//展开父节点
			if($(this).parent("li").length>0){
				var ul = $(this).parent("li").parent();
				ul.show();
				var icon = ul.prev().children("span");
				icon.removeClass("ico-ub");
				icon.addClass("ico-up");
			}
		}
	});
}
//高亮头部导航栏按钮
function highlightTopMenu(namespace){
	var fullUrl = window.location.href;
	var url = formatURL(fullUrl);
	//1.进行url完全匹配
	var hightlight = false;
	$(".col-2 li a").each(function(i){
		var href = formatURL(this.href);
		if(href==url){
			$(this).addClass("one");
			hightlight = true;
		}
	});
	//2.进行namespace匹配
	if(!hightlight){
		$(".col-2 li>a").each(function(i){
			if(this.href.indexOf("/"+namespace+"/")!=-1){
				$(this).addClass("one");
			}
		});
	}
}
//cookie操作
function setCookie(c_name,value,exdays){
	var exdate = new Date();
	exdate.setDate(exdate.getDate() + exdays);
	var c_value=escape(value) + ((exdays==null) ? "" : "; expires="+exdate.toUTCString());
	document.cookie=c_name + "=" + c_value;
}
function getCookie(c_name){
	var i,x,y,ARRcookies=document.cookie.split(";");
	for (i=0;i<ARRcookies.length;i++){
	  x=ARRcookies[i].substr(0,ARRcookies[i].indexOf("="));
	  y=ARRcookies[i].substr(ARRcookies[i].indexOf("=")+1);
	  x=x.replace(/^\s+|\s+$/g,"");
	  if (x==c_name){
	    return unescape(y);
	  }
	}
}

//2012-11-20 add by hechunjian start 
//获取某一表单元素数组的长度
function getElementLen(elementName)
{
var obj=document.all(elementName);
if(!(typeof(obj)=="object"))return 0;
if(obj==null)
return 0;
var len=obj.length;
if(typeof(len)=="undefined")
{
 len=1;
}
return len;
}

//全选
function selectAll(objName)
{
	var objChk;
	var elementLengh=getElementLen(objName);
	for(var i=0;i<elementLengh;i++)
	{
		objChk=getObj(objName,i);
		if((!objChk.disabled))
		{
			if(objChk.checked)
			{
				objChk.checked=false;
			}
			else
			{
				objChk.checked=true;
			}
		}
	}
}

//从表单对象数组中获取表单对象
function getObj(objName,index)
{
var obj=document.all(objName);
if(!(typeof(obj)=="object"))return '';
var len=obj.length;
if(!(typeof(len)=="undefined"))
{
	 //obj=eval("document.all."+objName+"["+index+"]");
	  obj=document.getElementsByName(objName)[ index];//hejin modify 当页面只有一条记录时，可能会返回undefined类型，而不是复选框类型
}
return obj;
}

//判断是否有复选框被选择
function hasOneRecord(objName)
{
	var objChk;
	var returnval=0;
	var j=0;
	var elementLengh=getElementLen(objName);
	for(var i=0;i<elementLengh;i++)
	{
		objChk=getObj(objName,i);
		if(objChk.checked&&(!objChk.disabled))
		{
			j++;
			returnval=objChk.value;
		}
	}
	if (j==1)
		return returnval;
	else
		return -1;
}

//判断是否有复选框被选择
function hasSelectedRecord(objName)
{
	var objChk;
	var elementLengh=getElementLen(objName);
	for(var i=0;i<elementLengh;i++)
	{
		objChk=getObj(objName,i);
		if(objChk.checked&&(!objChk.disabled))
		{
			return true;
		}
	}
	return false;
}

//确认对话框,businessName为对象名字，如资产卡片，凭证记录？confirmName为执行的动作，如删除？复核？结账？
function EAP_confirm(businessName,confirmName){

return window.confirm("是否确认"+confirmName+"选中的"+businessName+"？");

}
//2012-11-20 add by hechunjian end


function dateFormatYMD(date){
	if(date!=null&&date.length>0){
		date = date.substring(0,10);
	}
	return date;
}

//JS Object to String 
//不通用,因为拼成的JSON串格式不对
function obj2str(o){
   var r = [];
   if(typeof o == "string" || o == null) {
     return "@"+o+"@";
   }
   if(typeof o == "object"){
     if(!o.sort){
       r[0]="{"
       for(var i in o){
         r[r.length]="@"+i+"@";
         r[r.length]=":";
         r[r.length]=obj2str(o[i]);
         r[r.length]=",";
       }
       r[r.length-1]="}"
     }else{
       r[0]="["
       for(var i =0;i<o.length;i++){
         r[r.length]=obj2str(o[i]);
         r[r.length]=",";
       }
       r[r.length-1]="]"
     }
     return r.join("");
   }
   return o.toString();
}

//JS String  to Object
function strToObj(json){ 
         return eval("("+json+")"); 
}

/*********************************************
列表点击不选择
*********************************************/
function unSelected(id,rowIndex,rowData){
	var selected = $('#'+id).datagrid('getSelections');
	// 获取所有选中的行数组，如果里边有这个，不选中
	if(jQuery.inArray(rowData,selected)!=-1){
		$('#'+id).datagrid('unselectRow',rowIndex);
	} else {
		$('#'+id).datagrid('selectRow',rowIndex);
	}
	// 如果没有 则选中
}

function settilte(obj){
	obj.title = $(obj).text();
}

//消息提示
	function messageshow(head,msg){
		$.messager.show({
						title : head,
						msg : msg
		});
	}

//关闭弹出iframe	
function closePayoutDialog(){
		iframeDialog.dialog('close');
	}
	
	/**
 * 根据长度截取先使用字符串，超长部分追加...
 * @param str 对象字符串
 * @param len 目标字节长度
 * @return 处理结果字符串
 */
function cutString(str, len) {
	//length属性读出来的汉字长度为1
	if(str.length*2 <= len) {
		return str;
	}
	var strlen = 0;
	var s = "";
	for(var i = 0;i < str.length; i++) {
		s = s + str.charAt(i);
		if (str.charCodeAt(i) > 128) {
			strlen = strlen + 2;
			if(strlen >= len){
				return s.substring(0,s.length-1) + "...";
			}
		} else {
			strlen = strlen + 1;
			if(strlen >= len){
				return s.substring(0,s.length-2) + "...";
			}
		}
	}
	return s;
}

/**
	*字典表取数逻辑
	*paramLevel:类型
	*name:字段NAME
	*id:字段id
	*callback：回调函数名字
	*/
	function dictCombox(paramLevel,name,callback,id){
	  if(id!=null){
	  	$("#"+id+"").combobox({
				url : 'dictParamAction!dictCombobox.do?paramLevel='+paramLevel,
				valueField:'paramValue',
				textField:'paramName',
				mode : 'remote',
				panelHeight : 'auto',
				delay : 500,
				onSelect:function(record){
				        if(callback!=null){
				        	callback.apply(this, record)
				        	}
          	 		 	}
			});
	  }
	 if(name!=null){
	 	$("input[name='"+name+"']").combobox({
				url : 'dictParamAction!dictCombobox.do?paramLevel='+paramLevel,
				valueField:'paramValue',
				textField:'paramName',
				mode : 'remote',
				panelHeight : 'auto',
				delay : 500,
				onSelect:function(record){
						    if(callback!=null){
					        	callback.apply(this, [record])
				        	}
          	 		 	}
			});
	 }
	}
	
	
	/**
	* 获取字典参数名字
	* paramLevel：参数类型
	* paramLevel：参数值
	*/
	function dictGetName(paramLevel,paramValue){
	    var name = '';
		$.ajax({
			url : 'dictParamAction!dictGetComboboxName.do',
			data : {
				paramLevel : paramLevel,
				paramValue : paramValue
			},
			dataType : 'json',
			cache : false,
			async:false,
			success : function(response) {
				if(response){
					name =  response.paramName;
				}
			}
		});
		return name;
	}