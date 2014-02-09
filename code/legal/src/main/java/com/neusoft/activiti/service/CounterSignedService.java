package com.neusoft.activiti.service;

import org.activiti.engine.impl.pvm.delegate.ActivityExecution;

/**
 * 
 * 会签相关的业务类
 * @author 秦焰培
 *
 */
public interface CounterSignedService {

	public boolean isComplete(ActivityExecution execution) ;

}
