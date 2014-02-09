package com.neusoft.I18n;

import org.springframework.stereotype.Component;

/**
 * 
 * 国际化工具类
 * @author 秦焰培
 *
 */
@Component
public class BaseI18nResolver extends DefaultI18nResolver  {

	@Override
	protected String resolveBunFile() {
		// 
		return "struts/i18n/resources/message";
	}

}
