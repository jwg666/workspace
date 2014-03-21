package com.neusoft.base.common;

import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import org.activiti.engine.impl.util.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ConverterUtil {
	private static Logger logger = LoggerFactory.getLogger(ConverterUtil.class);
	public static Map<String, Object> toHashMap(Object o) {
		Map<String,Object> map = new HashMap<String,Object>();
		Field[] fields = o.getClass().getDeclaredFields();
		Field.setAccessible(fields, true);
		for (Field field : fields) {
			try {
				int mod = field.getModifiers();
//				logger.debug(mod+":"+field.getName());
				Object value = field.get(o);
				if (mod==Modifier.PRIVATE&&!(null==value)) {
//					logger.debug("{} value is: {}",field.getName(),value);
					if(value instanceof Collection){
						//TODO  如果是集合暂时不处理
					}else{
						map.put(field.getName(),field.get(o));
					}
					
				}				
			} catch (IllegalArgumentException e) {
				logger.error("----------------",e);
			} catch (IllegalAccessException e) {
				logger.error("----------------",e);
			}
		}
		return map;
	}
	public static JSONObject toJSONObject(Object o){
		JSONObject json = new JSONObject();
		Field[] fields = o.getClass().getDeclaredFields();
		Field.setAccessible(fields, true);
		for (Field field : fields) {
			try {
				int mod = field.getModifiers();
//				logger.debug(mod+":"+field.getName());
				Object value = field.get(o);
				if (mod==Modifier.PRIVATE&&!(null==value)) {
//					logger.debug("{} value is: {}",field.getName(),value);
					json.put(field.getName(),field.get(o));
				}				
			} catch (IllegalArgumentException e) {
				logger.error("----------------",e);
			} catch (IllegalAccessException e) {
				logger.error("----------------",e);
			}
		}
		return json;
	}
}
