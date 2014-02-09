$(document).ready(function() {
    /**
	 * 
	 * 调用方法如下：
	 * 1. $('Expression').validatebox({  
	 *        required: true,  
	 *        validType:"number['请输入整数']" 
	 *    }); 
	 *    
	 * 2. <input class="easyui-validatebox" required="true" validType="number['请输入整数']"></input>  
	 * 
	 */
    $.extend($.fn.validatebox.defaults.rules, {
        number: {
            validator: function(value, param) {
                return /^-?(?:\d+|\d{1,3}(?:,\d{3})+)(?:\.\d+)?$/.test(value);
            },
            message: ('{0}' == null || '{0}'=="") ? '请输入数字': '{0}'
        },
        zzs: {
            validator: function(value, param) {
                return /^[1-9]([0-9])*$/.test(value);
            },
            message: ('{0}' == null ) ? '请输入数字': '{0}'
        },
        dateFm: {
        	validator: function(value,param){
        		///^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)\s+([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9]$/
        		return /^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)\s+([01][0-9]|2[0-3]):[0-5][0-9]$/.test(value);
        	},
        	message: ( '{0}'== null || {}) ? '日期格式不符 yyyy-MM-dd HH:mm': '{0}'
        }
    });


    /**
     * 1. $('Expression').validatebox({  
	 *        required: true,  
	 *        validType: "reapet['比对的id','message']"
	 *    }); 
     * 
     * 2. <input class="easyui-validatebox" required="true" validType="reapet['比对的对象表达式','请输入整数']"></input>  
     */
    $.extend($.fn.validatebox.defaults.rules, {
        reapet: {
            validator: function(value, param) {
                var val = $(param[0]).val();
                if (val != value) {
                    return false;
                }
                return true;
            },
            message: '{1}'
        }
    });

    /**
     * 1. $('Expression').validatebox({  
	 *        required: true,  
	 *        validType: "mobileNumber['message']"
	 *    }); 
     * 
     * 2. <input class="easyui-validatebox" required="true" validType="mobileNumber['提示信息']"></input>  
     */
    $.extend($.fn.validatebox.defaults.rules, {
        mobileNumber: {
            validator: function(value, param) {
                return /^0{0,1}(13[4-9]|15[7-9]|15[0-2]|18[7-8])[0-9]{8}$/.test(value);
            },
            message: ('{0}' == null || '{0}'=="") ? '输入号码格式有误': '{0}'
        }
    });

    /** 
     * 电话号码 
     * 匹配格式：11位手机号码 
     * 3-4位区号，7-8位直播号码，1－4位分机号 
     * 如：12345678901、1234-12345678-1234 
     * 
     * 1. $('Expression').validatebox({  
	 *        required: true,  
	 *        validType: "phone['message']"
	 *    }); 
     * 
     * 2. <input class="easyui-validatebox" required="true" validType="phone['提示信息']"></input>  
     */
    $.extend($.fn.validatebox.defaults.rules, {
        phone: {
            validator: function(value, param) {
                return /^(\d{11})|^((\d{7,8})|(\d{4}|\d{3})-(\d{7,8})|(\d{4}|\d{3})-(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1})|(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1}))$/.test(value);
            },
            message: ('{0}' == null || '{0}'=="") ? '输入号码格式有误': '{0}'
        }
    });
    
    /** 
     * 日期 
     * 匹配格式：日期
     * 
     * 1. $('Expression').validatebox({  
	 *        required: true,  
	 *        validType: "date['message']"
	 *    }); 
     * 
     * 2. <input class="easyui-validatebox" required="true" validType="date['提示信息']"></input>  
     */
    $.extend($.fn.validatebox.defaults.rules, {
        date : {
            validator: function(value, param) {
                return /((^((1[8-9]\d{2})|([2-9]\d{3}))([-\/\._])(10|12|0?[13578])([-\/\._])(3[01]|[12][0-9]|0?[1-9])$)|(^((1[8-9]\d{2})|([2-9]\d{3}))([-\/\._])(11|0?[469])([-\/\._])(30|[12][0-9]|0?[1-9])$)|(^((1[8-9]\d{2})|([2-9]\d{3}))([-\/\._])(0?2)([-\/\._])(2[0-8]|1[0-9]|0?[1-9])$)|(^([2468][048]00)([-\/\._])(0?2)([-\/\._])(29)$)|(^([3579][26]00)([-\/\._])(0?2)([-\/\._])(29)$)|(^([1][89][0][48])([-\/\._])(0?2)([-\/\._])(29)$)|(^([2-9][0-9][0][48])([-\/\._])(0?2)([-\/\._])(29)$)|(^([1][89][2468][048])([-\/\._])(0?2)([-\/\._])(29)$)|(^([2-9][0-9][2468][048])([-\/\._])(0?2)([-\/\._])(29)$)|(^([1][89][13579][26])([-\/\._])(0?2)([-\/\._])(29)$)|(^([2-9][0-9][13579][26])([-\/\._])(0?2)([-\/\._])(29)$))/.test(value);
            },
            message: ('{0}' == null || '{0}'=="") ? '日期格式不正确': '{0}'
        }
    });
    
    

    /**
     * 1. $('Expression').validatebox({  
	 *        required: true,  
	 *        validType: "ip['提示信息']"
	 *    }); 
     * 
     * 2. <input class="easyui-validatebox" required="true" validType="ip['提示信息']"></input>  
     */
    $.extend($.fn.validatebox.defaults.rules, {
        ip: {
            validator: function(value, param) {
                return /(\d+)\.(\d+)\.(\d+)\.(\d+)/g.test(value);
            },
            message: ('{0}' == null || '{0}'=="") ? 'IP格式不正确': '{0}'
        }
    });

    /**
     * params[url,id,paramName,message]  
     * 
     * 
     * 1. $('Expression').validatebox({  
	 *        required: true,  
	 *        validType: 'unique["后台验证URL","对象ID","参数名称","提示信息"]'
	 *    }); 
     * 
     * 2. <input class="easyui-validatebox" required="true" validType="unique['后台验证URL','对象ID','参数名称','提示信息']"></input>  
     */
    $.extend($.fn.validatebox.defaults.rules, {
        unique: {
            validator: function(value, param) {
                value = $('#' + param[1]).attr('value');
                $('#' + param[1]).load(param[0] + "?" + param[2] + "=" + value,
                function(responseText, textStatus, XMLHttpRequest) {
                    if (responseText) //后台返回true或者false  
                    return true;
                });
                return false;
            },
            message: '{3}'
        }
    });
});