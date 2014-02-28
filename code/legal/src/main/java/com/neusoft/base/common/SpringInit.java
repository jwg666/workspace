package com.neusoft.base.common;
import java.net.MalformedURLException;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;


public class SpringInit implements ServletContextListener {
	private static WebApplicationContext context;
	private Logger logger = LoggerFactory.getLogger(getClass());
	@Override
	public void contextDestroyed(ServletContextEvent event) {
		
	}

	
	@Override
	public void contextInitialized(ServletContextEvent event) {
		logger.info("初始化静态context,以便于在非action/servlet中使用spring");
		context = WebApplicationContextUtils.getWebApplicationContext(event.getServletContext());
		//获取容器文件路径
		try {
			String contextPath =event.getServletContext().getRealPath("/");
			if(contextPath == null){
				contextPath = event.getServletContext().getResource("/").getPath();
			}
			if(contextPath!=null){
				/*if(contextPath.startsWith("/")){
					contextPath = contextPath.substring(1, contextPath.length());
				}*/
				if(contextPath.endsWith("/")){
					contextPath = contextPath.substring(0, contextPath.length()-1);
				}
			}
			FileConstants.WEB_REAL_PATH.append(contextPath);
			
		} catch (MalformedURLException e) {
			logger.error("初始化context出错",e);
		}
	}

	public static WebApplicationContext getContext() {
		return context;
	}

	public static void setContext(WebApplicationContext context) {
		SpringInit.context = context;
	}
	
}
