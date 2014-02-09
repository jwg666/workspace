package com.neusoft.portal.listener;


import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.InitializingBean;

import com.neusoft.base.common.Env;

/**
 * @author WangXuzheng
 *
 */
public class SystemBootstrap implements InitializingBean {
	/**
	 * CONFIG_FILE_PATH 系统变量配置文件路径
	 */
	private static final String CONFIG_FILE_PATH = "/env.properties";
	private static final Logger LOG = LoggerFactory.getLogger(SystemBootstrap.class);
	@Override
	public void afterPropertiesSet() throws Exception {
		LOG.debug("初始化系统变量");
		InputStream inputStream = null;
		Properties properties = new Properties();
		try{
			inputStream = SysconfigInitListener.class.getResourceAsStream(CONFIG_FILE_PATH);
			properties.load(inputStream);
			LOG.info("系统配置项:"+properties);
		}catch (Exception e) {
			LOG.error("读取系统配置文件时发生错误：",e);
		}finally{
			if(inputStream != null){
				try {
					inputStream.close();
				} catch (IOException e) {
					LOG.error("关闭文件输入流失败：",e);
				}
			}
		}
		Env.init(properties);
	}
}
