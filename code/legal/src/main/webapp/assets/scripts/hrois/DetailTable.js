	(function ($) {
            $.fn.extend({
                "alterBgColor": function (options) {
                    //设置默认值
                    options = $.extend({
                        odd: "list_table_odd", /* 偶数行样式*/
                        even: "list_table_even", /* 奇数行样式*/
                        selected: "list_table_selectrow"/* 选中行样式*/
                    }, options);
                    $("tbody>tr:odd", this).addClass(options.odd);
                    $("tbody>tr:even", this).addClass(options.even);
                    $('tbody>tr', this).click(function () {
                    });
                    return this;  //返回this，使方法可链。
                }
            });
        })(jQuery);

	/**
	  初始化hidden控件
	**/
	function gethiddenEditHtml(fieldname,defaultValue){
		var htmlEl = ['<s:hidden name="'+fieldname+'" '];
		if (defaultValue != null){
		    htmlEl.push("value="+defaultValue);
		}
		htmlEl.push("id=\""+fieldname+"\"");
		htmlEl.push("/>");
	    return htmlEl.join('');
	}
	
	/**
	单据字段定义
	**/
	function CardField(fieldId,fieldType){
	    this.fieldId = fieldId;
	    this.fieldType = fieldType;
	    this.width;
	    this.onchange;
	    this.fieldEditHtml = "";
	    
	}

	/**
	  定义控件的html元素
	**/
	CardField.prototype.initEditHtml = function(){
	    var editHtml = "";
	    if(this.fieldEditHtml != ""){
	        editHtml = this.fieldEditHtml;
	    }else{
	        if(this.fieldType == "text"){
	        	editHtml =  this.getTextHtml();
		    }else if(this.fieldType == "lookup"){
	        	editHtml =  this.getLookupHtml();
		 	}else if(this.fieldType == "date"){
		   		editHtml = this.getdateEditHtml();
			}else if(this.fieldType == "number"){
			   editHtml = this.getnumberHtml();
			}else if(this.fieldType == "dateTime"){
			   editHtml = this.getdateTimeEditHtml();
			}else if(this.fieldType == "gSelect"){
			   editHtml = this.getgSelectEditHtml();
			}else if(this.fieldType == "comboSelect"){
			   editHtml = this.getcomboSelectEditHtml(xpath);
			}else if(this.fieldType == "textarea"){
			   editHtml = this.getTextAreaHtml();
			}
		  //else if(this.fieldType == "lookupBySql"){
		   //   editHtml = this.getlookupBySqlEditHtml(xpath);
		   //}
		 	else{
		    	var evalRuturnFunc = eval(this.returnFunc);
		    	editHtml = evalRuturnFunc(xpath);
		 	}
	  }
	  return editHtml;
	}
	
	/**
	 * 初始化text控件
	 */
	CardField.prototype.getTextHtml = function(){  
	     var htmlEl = ['<input type=text name='+this.fieldId+" filter=false "];
	     htmlEl.push(" id=\"" + this.fieldId+"\" ");
	     if(this.readonly){
	        htmlEl.push(" readonly=\"true\" ");
	     }
	     if(this.width){
	        htmlEl.push(" style=\"width:"+this.width+"px\" ");
	     }
	     if(this.onchange){
	        htmlEl.push(" onchange=\"" + this.onchange+" \" ");
	     }
	     if(this.value){
	        htmlEl.push(" value=\"" + this.value+"\" ");
	     }
	     if(this.styleClass){
	        htmlEl.push(" class=\"" + this.styleClass+"\" ");
	     }
	     if(this.align){
	       htmlEl.push(" align=\"" + this.align+"\" ");
	     }if(this.onfocus){
	       htmlEl.push(" onfocus=\"" + this.onfocus+"\" ");
	     }
	     htmlEl.push("/>");
	     return htmlEl.join('');
	}
	
	/**
	  初始化gselect控件
	**/
	CardField.prototype.getgSelectEditHtml = function(){
		var param = {
				lovCode:this.lovCode,
				lovSql:this.lovSql,
				beanName:this.beanName,
				name:this.name,
				code:this.code,
				condition:this.condition
		};
		var nodes_id = [];
		var nodes_name = [];
		var nodes_code = [];
		var selectName = this.fieldId;
		$.ajax({
            type:"post",
            async:false,
            dataType:"json",
           // url:"getSelectValues.action",
          // url:"/hrois/basic/searchDepartementAction.action",
            url:dynamicURL+"/system/searchDataDictAction.action",
            data:param,
            error: function(){                         
               alert('Error!');    
            },    
            success:function(data){
            	$.each(data,function(commentIndex, comment){
            		nodes_id.push(commentIndex);
            		nodes_name.push(comment.name);
            		nodes_code.push(comment.code);
            	})
            }
		},"json");
		var htmlEl = ['<select name="'];
    	htmlEl.push(selectName);
        htmlEl.push('\" ');
        htmlEl.push(" id=\"" + selectName+"\" ");
    	if(this.onchange){
    	   htmlEl.push(" onchange='"+this.onchange+"(this)'");
    	}
    	if(this.style){
    	   htmlEl.push(" style='"+this.style+"'");
    	}
    	if(this.width){
    		htmlEl.push(" width='"+this.width+"'");
    	}
    	htmlEl.push(' >\n');
    	for(i=0;i<nodes_id.length;i++){
    	  htmlEl.push("<option value=\""+nodes_code[i]+"\">"+nodes_name[i]+"</option>\n");
    	}
    	htmlEl.push("</select>");
    	return htmlEl.join('');

	}
	
	//操作方式的html；
	function getOptHTML(dsIndex){
	   var htmlEl = ["<s:a href=\"#\" style='cursor:hand' onclick='doDeleteADetailRow(this);' ><img src=\""+staticURL+"/images/grid_col_del.gif\" alt='\u5220\u9664\u884C' ></s:a>&nbsp;\n"];
	   return htmlEl.join('');
	}
	
	//初始化复杂控件
	  CardField.prototype.initObject = function(){
	       if(this.fieldType == "lookup"){
		      editHtml = this.initlookupObject();
		   }else if(this.fieldType == "date"){
		      editHtml = this.initdateObject();
		   }else if(this.fieldType == "comboSelect"){
		      editHtml = this.initcomboObject();
		   }else if(this.fieldType == "dateTime"){
		      editHtml = this.initdateTimeObject();
		   }	   
	}
	  /**
	  初始化comboSelect控件
	**/
	CardField.prototype.getcomboSelectEditHtml = function(){  
	  var htmlEl = ["<div id="+this.fieldId+"_container class=\"eos-ic-container\" >\n"];  
	  htmlEl.push("<input class=\"eos-combo-select-editor-text\" type=\"text\" id=\"" + this.fieldId+"_input\" />\n");
	  htmlEl.push("<img id=\""+this.fieldId+"_button\" class='eos-ic-button' />\n");
	  htmlEl.push("<input type=\"hidden\" id=\""+ this.fieldId+"_hidden\" name=\""+this.fieldId+"\"/>");
	  htmlEl.push("</div>");
	  return htmlEl.join('');
	}

	CardField.prototype.initcomboObject = function(xpath1,index){
	    var _comboSelect =new ComboSelect(this.fieldId); 
		_comboSelect.queryAction = this.queryAction; 
		_comboSelect.xpath = this.xpath; 
		_comboSelect.valueField = this.valueField; 
		_comboSelect.textField = this.textField; 
		if(this.nullText){
		  _comboSelect.nullText = this.nullText; 
		}	
		_comboSelect.queryReturnValue = this.queryReturnValue; 
		_comboSelect.queryParamsInfo = this.queryParamsInfo; 
		_comboSelect.isIeMode = false; 
		_comboSelect.readOnly = false; 
		_comboSelect.allowInput = false; 
		_comboSelect.allowFilter = true; 
		_comboSelect.disabled = false; 
		_comboSelect.init();
		_comboSelect.loadData();
	    _comboSelect.refresh();
	}

