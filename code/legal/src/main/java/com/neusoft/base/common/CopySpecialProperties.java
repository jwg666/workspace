package com.neusoft.base.common;

import java.lang.reflect.Method;

import org.apache.commons.lang3.StringUtils;

/**
 * 拷贝类属性的方法
 * @author luoqi
 *
 */
public class CopySpecialProperties {
	/**
	 * 
	 *作者：罗琦
	 *拷贝Bean1到Bean2，只拷贝Bean1中不为空的属性
	 * @param obj1 拷贝源Bean
	 * @param obj2 拷贝的目标Bean
	 * @return
	 * @throws Exception
	 */
	public static Object copyBeanToBean(Object obj1, Object obj2)
			throws Exception {
		return copyBeanToBean(obj1, obj2,false);
	}
	/**
	 * 
	 *作者：罗琦
	 *拷贝Bean1到Bean2，只拷贝Bean1中不为空的属性
	 * @param obj1 拷贝源Bean
	 * @param obj2 拷贝的目标Bean
	 * @param withBlank 过滤源属性为String并且为空的字段，true时过滤，false不过滤
	 * @return
	 * @throws Exception
	 */
	public static Object copyBeanToBean(Object obj1, Object obj2,boolean withBlank)
			throws Exception {
		Method[] method1 = obj1.getClass().getMethods();
		Method[] method2 = obj2.getClass().getMethods();
		String methodName1;
		String methodFix1;
		String methodName2;
		String methodFix2;
		for (int i = 0; i < method1.length; i++) {
			methodName1 = method1[i].getName();
			methodFix1 = methodName1.substring(3, methodName1.length());
			if (methodName1.startsWith("get")) {
				for (int j = 0; j < method2.length; j++) {
					methodName2 = method2[j].getName();
					methodFix2 = methodName2.substring(3, methodName2.length());
					if (methodName2.startsWith("set")) {
						if (methodFix2.equals(methodFix1)) {
							Object[] objs1 = new Object[0];
							Object[] objs2 = new Object[1];
							objs2[0] = method1[i].invoke(obj1, objs1);
							//如果原对象的属性不为空再拷贝的目标对象
							if(null != objs2[0]) {
								if(withBlank && objs2[0] instanceof String) {
									if(StringUtils.isNotBlank(objs2[0].toString())) {
										method2[j].invoke(obj2, objs2);
									}
								}else{
										method2[j].invoke(obj2, objs2);
								}
							}
							continue;
						}
					}
				}
			}
		}
		return obj2;
	}
}
