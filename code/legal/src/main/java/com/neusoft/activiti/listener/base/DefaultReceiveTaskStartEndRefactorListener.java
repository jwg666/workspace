package com.neusoft.activiti.listener.base;

import java.util.Map;

import javax.annotation.Resource;

import org.activiti.engine.impl.persistence.entity.ExecutionEntity;
import org.springframework.stereotype.Component;

import com.neusoft.activiti.service.ActivitiService;

@Component
public class DefaultReceiveTaskStartEndRefactorListener extends
		ReceiveTaskStartEndRefactorListener {
	
	@Resource
	private ActivitiService activitiService;
	/**
	 * 
	 */
	private static final long serialVersionUID = -6991962664743291413L;

	@Override
	protected void commonEnd(ExecutionEntity executionEntity,
			Map<String, Object> variables) {
		// TODO Auto-generated method stub
		activitiService.updateHasRodoIds(executionEntity, variables);
	}

	@Override
	protected void afterEnd(ExecutionEntity executionEntity,
			Map<String, Object> variables) {
		// TODO Auto-generated method stub

	}

	@Override
	protected void commonStart(ExecutionEntity executionEntity,
			Map<String, Object> variables) {
		// TODO Auto-generated method stub

	}

	@Override
	protected void afterStart(ExecutionEntity executionEntity,
			Map<String, Object> variables) {
		// TODO Auto-generated method stub

	}

}
