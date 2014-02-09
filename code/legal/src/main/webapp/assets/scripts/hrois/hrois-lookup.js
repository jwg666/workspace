/**
 * lookup传递类型为数组，第一个是值，第二个是显示值.
 * lookup页面返回值时用returnValue,类型为数组，第一个是值，第二个是显示值.
 * @param {Object} id
 */
function LookUp(id){
	this.id = id;
    $.data(document.body,id,this);
	this.value = null;
	this.lookupBtn = null;
	this.lookupText = null;
	this.lookupUrl = null;
	this.lookupParam = null;
	this.lookupHidden = null;
	this.width = 200;
	this.height = 200;
	this.left = 100;
	this.top = 100;
	this.center = true;
	this.buttonImg = null;
	this.params = [];
	this.displayValue = null;
	this.container = null;
	this.onReturnFunc = null;
	this.useIeModel = false;
	this.dialogTitle = null;
	this.disabled=false;
    this.allowInput=true;
    this.readOnly=false;
}
/**
 * 初始化lookup的方法。设置lookup的弹出窗口事件.
 */
LookUp.prototype.init = function(){
	this.container = document.getElementById(this.id + "_container");
	this.lookupHidden = document.getElementById(this.id + "_hidden");
	this.lookupText = document.getElementById(this.id + "_input");
	this.lookupBtn = this.id + "_button";
	this.button=this.lookupBtn;
	this.text=this.lookupText;
	this.hidden=this.lookupHidden;
	if(this.lookupWidth!=null) this.text.css("width",this.lookupWidth);
	var lookup = this;
	var btnObj = document.getElementById(this.lookupBtn);
	btnObj.src = staticURL+"/images/lookup/lookup_button.gif";
	btnObj.onmouseover = function(){
          if(lookup.getDisabled()||lookup.getReadOnly()) return;
               this.src=staticURL+"/images/lookup/lookup_button_over.gif"
          }
    btnObj.onmouseout = function(){
         if(lookup.getDisabled()||lookup.getReadOnly()) return;
               this.src=staticURL+"/images/lookup/lookup_button.gif"
          }
    btnObj.onmousedown = function(){
         if(lookup.getDisabled()||lookup.getReadOnly()) return;
               this.src=staticURL+"/images/lookup/lookup_button_down.gif"
         }
    btnObj.onmouseup = function(){
          if(lookup.getDisabled()||lookup.getReadOnly()) return;
              this.src=staticURL+"/images/lookup/lookup_button.gif";
              lookup.show();
          }
	function textChange(){
		if(lookup.lookupText.value!=lookup.displayValue){
			lookup.displayValue = lookup.lookupText.value;
			lookup.value = lookup.lookupText.value;
			lookup.lookupHidden.value = lookup.value;
			//lookup.refreshInput();
		}
	}
	this.setReadOnly(this.readOnly);
	this.setDisabled(this.disabled);
    this.lookupText.onkeyup = function(){
    	textChange();
    }
    //eventManager.add(this.lookupText,"keyup",textChange);
}

LookUp.prototype.setReadOnly=function(isReadOnly){
    this.readOnly=isReadOnly;
    this.lookupText.readOnly=isReadOnly||!this.allowInput;
    var btnObj = document.getElementById(this.lookupBtn);
    if(isReadOnly){
    	btnObj.style.cursor = "default";
    }else{
    	btnObj.style.cursor = "pointer";
    }
}

LookUp.prototype.getReadOnly=function(){
   return this.readOnly;
}

/**
 * 获得lookup值的方法.
 */
LookUp.prototype.getValue = function (){
	this.refreshValue();
	return this.value;
}
/**
 * 设置lookup值的方法.
 * @param {Object} value
 */
LookUp.prototype.setValue = function (value){
	if (value!==this.value) {
		this.displayValue=value
	}

	this.value = value;
	this.refreshInput();
}
/**
 * 设置lookup显示值的方法.
 * @param {Object} value
 */
LookUp.prototype.setDisplayValue = function (value){
	this.displayValue = value;
	this.refreshInput();
}
/**
 * 符合控件开发规范的方法.
 */
LookUp.prototype.setFocus = function (){

}
/**
 * 符合控件开发规范的方法.
 */
LookUp.prototype.lostFocus = function (){

}
/**
 * 显示lookup窗口的方法，先刷新值，再构造传入页面的参数.
 * 内部函数为回调函数.设置值.
 */
LookUp.prototype.show = function(){
	var lookup = this;
    if(this.disabled) return;
    if(lookup.beforeOpenDialog)
    {
     if(lookup.beforeOpenDialog(lookup)===false) 
        return;
    }
    
	this.refreshValue();
	var urlStr = this.getParamURL();
	var argument = [this.value,this.displayValue];

	function callBack(returnValue){
        if (returnValue == null){
            return false;
        }
		try{
			if(lookup.onReturnFunc){
				var func= lookup.onReturnFunc;
				if((typeof lookup.onReturnFunc)=="string")
				  func=eval(lookup.onReturnFunc );
				if(func(returnValue)!==false){
					lookup.value = returnValue[0];
					lookup.displayValue = returnValue[1];
				}
			}else{
				//
				lookup.value = returnValue[0];
				lookup.displayValue = returnValue[1];
			}
		}catch(e){
			$handle(e);
			$error("returnValue of dialog is not a array");
		}
		lookup.refreshInput();
	}
    //alert("width:" + this.width + ";" + "height:" + this.height + ";" + "left:" + this.left + ";" + "top:" + this.top + ";");
	if(this.useIeModel){
		var retValue = window.showModalDialog(urlStr,argument,"width:" + this.width + ";" + "height:" + this.height + ";" + "left:" + this.left + ";" + "top:" + this.top + ";");
        callBack(retValue);
	}else{
        var retValue = window.showModalDialog(urlStr,argument,"dialogWidth=800px;dialogHeight=450px;center:yes;");
        callBack(retValue);
		//showModal(urlStr,argument,callBack,this.width,this.height,this.left||"",this.top||"",this.dialogTitle);
	}
}
/**
 * 刷新input的值的方法，同时刷新hidden
 */
LookUp.prototype.refreshInput = function (){
	var text= this.displayValue!==null &&  this.displayValue!==undefined? this.displayValue : this.value;
	this.lookupHidden.value = this.value;
	this.lookupText.value = text;
}
/**
 * 刷新lookup值的方法，读取input的值，写到js对象中.
 */
LookUp.prototype.refreshValue = function (){
	this.value = this.lookupHidden.value;
	this.displayValue = this.lookupText.value;
}
/**
 * 获得lookup参数的URL的方法,返回带参数的url
 * @return 带参数的URL
 * @type String
 */
LookUp.prototype.getParamURL = function(){
	var strParam = "";
	for(var i=0;i<this.params.length;i++){
		var param = this.params[i];
		strParam += "&" + param.key + "=" + param.value;
	}
	var strUrl = this.lookupUrl;
	if(strUrl.indexOf("?")>-1){
		strUrl += strParam;
	}else{
		strUrl += "?" + strParam.replace("&","");
	}
	return strUrl;
}

/**
 * 向lookup控件添加参数的方法.
 * @param {Object} key 参数名称.
 * @param {Object} value 参数值.
 */
LookUp.prototype.addParam = function (key,value){
	this.params.push({key:key,value:encodeURIComponent(value)});
}

/**
 * 清空lookup控件的参数的方法.
 */
LookUp.prototype.clearParam = function (){
	this.params = [];
}

LookUp.prototype.setDisabled = function(isDisabled){
	this.disabled = isDisabled;
	var btnObj = document.getElementById(this.lookupBtn);
	if(isDisabled){
		this.lookupText.disabled = true;
		this.lookupHidden.disabled = true;
		btnObj.style.cursor = "default";
	}else{
		this.lookupText.disabled = false;
		this.lookupHidden.disabled = false;
		btnObj.style.cursor = "pointer";
	}

}

LookUp.prototype.getDisabled=function(){
   return this.disabled;
}

/**
 * 设置控件的位置.
 * @param {Object} left
 * @param {Object} topx
 * @param {Object} width
 * @param {Object} height
 */
LookUp.prototype.setPosition = function(left,topx,width,height){
	if(this.container){
		this.container.style.display = "";
		this.container.style.position = "absolute";
		this.container.style.left = left;
		this.container.style.top = topx;
		//setElementXY(this.container,[left,topx]);
		var maxZindex = getMaxZindex(document);
		if(this.container.style.zIndex!=maxZindex){
			this.container.style.zIndex = maxZindex;
		}
		this.lookupText.style.width = width-17;
		this.lookupText.style.height = height;
		this.container.style.width = width;
		this.container.style.height = height;
		this.lookupBtn.style.height = height;

	}
}
LookUp.prototype.hideEditor = function(){
	this.container.style.display = "none";
	this.lookupBtn.style.display = "none";
}

LookUp.prototype.showEditor = function(){
	this.container.style.display = "";
	this.lookupBtn.style.display = "";
}

LookUp.prototype.validate = function(){
	return true;
}

LookUp.prototype.isFocus = function(){
	return false;
}

LookUp.prototype.getDisplayValue = function(value){
	if(value==this.value){
		return this.displayValue;
	}
	return value;
}