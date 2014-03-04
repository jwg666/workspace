package com.neusoft.activiti.listener.legal;

import java.util.Map;

import org.activiti.engine.impl.persistence.entity.TaskEntity;
import org.springframework.stereotype.Component;

@Component
public class CaseApproveListener extends LegalDefaultUserTaskListener {

	@Override
	protected void commonCreatEvent(TaskEntity taskEntity,
			Map<String, Object> variables) {
	}

	@Override
	protected void commonAssignmentEvent(TaskEntity taskEntity,
			Map<String, Object> variables) {
	}

	@Override
	protected void commonCompleteEvent(TaskEntity taskEntity,
			Map<String, Object> variables) {
	}
	
}
