package com.neusoft.activiti.listener.legal;

import java.util.Map;

import org.activiti.engine.impl.persistence.entity.TaskEntity;
import org.springframework.stereotype.Component;
@Component
public class AsignLegalOfficeListener extends LegalDefaultUserTaskListener {

	private static final long serialVersionUID = 2150928213117239254L;

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
