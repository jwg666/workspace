package com.neusoft.I18n;

import com.neusoft.base.common.ValidateUtil;

/**
 * 
 * hrois自定义国际化异常
 * @author 秦焰培
 *
 */
public class BaseException extends RuntimeException {

	private static final long serialVersionUID = -5413969512895218029L;

	//默认的messageKey  
	public static final String DEFAULT_MESSAGE_KEY = "gobal.exception";  
   	/*异常国际化key*/
	private String messageKey = DEFAULT_MESSAGE_KEY;
	/*异常国际化参数*/
	private Object[] args; 
	 
	public BaseException(String messageKey){
		 super(messageKey);
		 this.messageKey=messageKey;
	}
	public BaseException(String messageKey,Throwable cause){
		super(messageKey,cause);
		this.messageKey=messageKey;
	}
	public BaseException(Throwable cause){
	    super(cause);
	}
	public BaseException(String messageKey, Object arg) {
			super(messageKey);
			this.messageKey = messageKey;
			this.args = new Object[] {arg};
	}
	 
	public BaseException(String messageKey, Object[] args) {
		super(messageKey);
		this.messageKey = messageKey;
		this.args = args;
	}
	 @Override
	public String getLocalizedMessage() {
		// 
		 String message;
		if(ValidateUtil.isValid(args)){
			message= BaseMessage.getMessage(messageKey, args);
		}else{
			message= BaseMessage.getMessage(messageKey);
		}
		if(!ValidateUtil.isValid(message)){
			message= messageKey;
		}
		return message;
	}
	
	 
	 
	 
	
	
	 
	
}
