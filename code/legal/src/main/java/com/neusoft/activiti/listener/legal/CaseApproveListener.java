package com.neusoft.activiti.listener.legal;

import java.util.Map;

import org.activiti.engine.impl.persistence.entity.TaskEntity;
import org.springframework.stereotype.Component;

@Component
public class CaseApproveListener extends LegalDefaultUserTaskListener {

	private static final long serialVersionUID = -2072092977454853356L;

	@Override
	protected void commonCreatEvent(TaskEntity taskEntity,
			Map<String, Object> variables) {
		super.commonCreatEvent(taskEntity, variables);
	}

	@Override
	protected void commonAssignmentEvent(TaskEntity taskEntity,
			Map<String, Object> variables) {
		super.commonAssignmentEvent(taskEntity, variables);
	}

	@Override
	protected void commonCompleteEvent(TaskEntity taskEntity,
			Map<String, Object> variables) {
		super.commonCompleteEvent(taskEntity, variables);
	}
	
}
