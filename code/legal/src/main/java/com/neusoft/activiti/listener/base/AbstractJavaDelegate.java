package com.neusoft.activiti.listener.base;

import org.activiti.engine.delegate.JavaDelegate;

import com.neusoft.base.common.SpringApplicationContextHolder;

public abstract class AbstractJavaDelegate implements JavaDelegate {

	public AbstractJavaDelegate(){
		SpringApplicationContextHolder.getApplicationContext().getAutowireCapableBeanFactory().autowireBean(this);
	}
}
