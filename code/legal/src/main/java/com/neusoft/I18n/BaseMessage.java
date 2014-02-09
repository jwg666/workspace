package com.neusoft.I18n;

import com.neusoft.base.common.SpringApplicationContextHolder;


public class BaseMessage {
	private static BaseI18nResolver hroisI18nResolver;
	
	public static  String getMessage(String code) {
		return getMessage(code, new Object[] {});
	}
	public static String  getMessage(String code, Object[] args) {
		if(hroisI18nResolver==null){
			hroisI18nResolver=SpringApplicationContextHolder.getBean("hroisI18nResolver");
		}
		return hroisI18nResolver.getMessage(code, args);
	}

	public static String getMessage(String code, Object[] args, String defaultMessage) {
		if(hroisI18nResolver==null){
			hroisI18nResolver=SpringApplicationContextHolder.getBean("hroisI18nResolver");
		}
		return hroisI18nResolver.getMessage(code, args, defaultMessage);
	}

	public static String getMessage(String code, String arg) {
		if(hroisI18nResolver==null){
			hroisI18nResolver=SpringApplicationContextHolder.getBean("hroisI18nResolver");
		}
		return hroisI18nResolver.getMessage(code, arg);
	}
	public static String getMessage(String code, String... args) {
		if(hroisI18nResolver==null){
			hroisI18nResolver=SpringApplicationContextHolder.getBean("hroisI18nResolver");
		}
		return hroisI18nResolver.getMessage(code, args);
	}
}
