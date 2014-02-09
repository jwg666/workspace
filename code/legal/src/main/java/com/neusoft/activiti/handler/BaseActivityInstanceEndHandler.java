package com.neusoft.activiti.handler;

import org.activiti.engine.delegate.DelegateExecution;
import org.activiti.engine.delegate.ExecutionListener;
import org.activiti.engine.impl.context.Context;
import org.activiti.engine.impl.persistence.entity.ExecutionEntity;
import org.springframework.stereotype.Component;

import com.neusoft.activiti.behavior.DecideSkipBehavior;

@Component
public class BaseActivityInstanceEndHandler implements ExecutionListener {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7764690461302941464L;

	@Override
	public void notify(DelegateExecution execution) throws Exception {
		// TODO Auto-generated method stub
		ExecutionEntity executionEntity = (ExecutionEntity) execution;
		Boolean needSkip = DecideSkipBehavior.isNeedSkip(executionEntity);
		if (!needSkip) {
			Context.getCommandContext().getHistoryManager()
					.recordActivityEnd((ExecutionEntity) execution);
		}
	}

}
