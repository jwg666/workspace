package com.neusoft.I18n;


/**
 * 国际化资源处理器
 * @author WangXuzheng
 *
 */
public interface I18nResolver {
	/**
	 * 设置要进行资源处理的目标类
	 * @param clazz
	 */
	@SuppressWarnings("rawtypes")
	public void setClass(Class clazz);
	/**
	 * 解析国际化资源文件，如果找不到该code，返回默认的消息
	 * @param code i18n资源的key值
	 * @return 如果找到返回具体的消息值，如果不存在返回默认消息
	 * @see java.text.MessageFormat
	 */
	String getMessage(String code);
	
	/**
	 * 解析国际化资源文件，如果找不到该code，返回默认的消息
	 * @param code i18n资源的key值
	 * @return 如果找到返回具体的消息值，如果不存在返回默认消息
	 * @see java.text.MessageFormat
	 */
	String getMessage(String code,String arg);
	/**
	 * 解析国际化资源文件，如果找不到该code，返回默认的消息
	 * @param code i18n资源的key值
	 * @param args 资源中的变量值
	 * @param defaultMessage 默认消息
	 * @return 如果找到返回具体的消息值，如果不存在返回默认消息
	 * @see java.text.MessageFormat
	 */
	String getMessage(String code, Object[] args, String defaultMessage);
	/**
	 * 解析国际化资源文件查找指定code对应的消息，如果不存在，抛出异常
	 * @param code
	 * @param args
	 * @return
	 * @throws MessageNotFoundException
	 * @see java.text.MessageFormat
	 * @throws MessageNotFoundException
	 */
	String getMessage(String code, Object[] args);
}

