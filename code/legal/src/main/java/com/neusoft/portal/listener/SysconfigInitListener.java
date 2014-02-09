package com.neusoft.portal.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;

import com.neusoft.base.common.Env;

/**
 * 加载env.properties中的配置项，将静态资源地址和动态资源地址放到application变量中
 * @author WangXuzheng
 *
 */
public class SysconfigInitListener implements SystemStartupListener {
	@Override
	public void onStartup(ServletContextEvent contextEvent) {
		ServletContext servletContext = contextEvent.getServletContext();
		servletContext.setAttribute("staticURL", Env.getProperty(Env.KEY_STATIC_URL));
		servletContext.setAttribute("dynamicURL", Env.getProperty(Env.KEY_DYNAMIC_URL));
		servletContext.setAttribute("jsCssVersion", Env.getProperty(Env.JS_CSS_VERSION));
		servletContext.setAttribute("envType", Env.getProperty(Env.KEY_ENV_TYPE));
	}
}
