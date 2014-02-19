package com.neusoft.I18n;

import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

/**
 * 资源解析器工厂类
 * @author WangXuzheng
 *
 */
public final class I18nResolverFactory {
	@SuppressWarnings("rawtypes")
	private static final ConcurrentMap<Class, I18nResolver> I18N_RESOVER_MAP = new ConcurrentHashMap<Class, I18nResolver>();
	private I18nResolverFactory(){
	}
	
	@SuppressWarnings("rawtypes")
	public static I18nResolver getDefaultI18nResolver(Class clazz){
		I18nResolver resolver = I18N_RESOVER_MAP.get(clazz);
		if(resolver == null){
			resolver = new DefaultI18nResolver();
			resolver.setClass(clazz);
			I18N_RESOVER_MAP.put(clazz, resolver);
		}
		return resolver;
	}
}
