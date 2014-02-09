package com.neusoft.activiti.handler;

import javax.annotation.Resource;

import org.activiti.engine.impl.jobexecutor.JobExecutor;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;

import com.neusoft.activiti.handler.factory.BaseSpringProcessEngineConfiguration;

//@Component
public class BaseApplicationContextRefreshedListener implements
		ApplicationListener<ContextRefreshedEvent> {

	@Resource
	private BaseSpringProcessEngineConfiguration processEngineConfiguration;

	@Override
	public void onApplicationEvent(ContextRefreshedEvent event) {
		// 
		processEngineConfiguration.setJobExecutorActivate(true);
		JobExecutor jobExecutor = processEngineConfiguration.getJobExecutor();
		if (jobExecutor != null) {
			jobExecutor.setAutoActivate(true);
			jobExecutor.start();
		}
	}

}
