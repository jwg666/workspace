package com.neusoft.portal.listener;

import javax.servlet.ServletContextEvent;

/**
 * 系统启动监听器
 * @author WangXuzheng
 *
 */
public interface SystemStartupListener {
	/**
	 * 系统启动时加载执行对应的逻辑
	 * @param contextEvent
	 */
	public void onStartup(ServletContextEvent contextEvent);
}
