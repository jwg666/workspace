package com.neusoft.portal.listener;


import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * 系统启动初始化监听器
 * 
 * @author WangXuzheng
 * 
 */
public class BootstrapListener implements ServletContextListener {
	private static final String CONFIG_KEY = "startupListeners";
	private static final String SPERATOR = ",";//不同监听器之间的分隔符

	@Override
	public void contextDestroyed(ServletContextEvent contextEvent) {
	}

	@SuppressWarnings("unchecked")
	@Override
	public void contextInitialized(ServletContextEvent contextEvent) {
		String startupListeners = contextEvent.getServletContext().getInitParameter(CONFIG_KEY);
		if(startupListeners == null || startupListeners.isEmpty()){
			return;
		}
		String[] listeners = startupListeners.split(SPERATOR);
		if(listeners == null){
			return;
		}
		for(String listenerClass : listeners){
			try {
				Class<SystemStartupListener> clazz = (Class<SystemStartupListener>) Class.forName(listenerClass);
				clazz.newInstance().onStartup(contextEvent);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}
