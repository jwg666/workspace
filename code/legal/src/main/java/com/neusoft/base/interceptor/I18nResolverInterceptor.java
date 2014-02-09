package com.neusoft.base.interceptor;

import java.util.Locale;

import org.springframework.context.i18n.LocaleContextHolder;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.I18nInterceptor;

public class I18nResolverInterceptor extends I18nInterceptor{
	private static final long serialVersionUID = 5888969294461266478L;

	@Override
	protected void saveLocale(ActionInvocation invocation, Locale locale) {
		super.saveLocale(invocation, locale);
		LocaleContextHolder.setLocale(locale);
	}
}
