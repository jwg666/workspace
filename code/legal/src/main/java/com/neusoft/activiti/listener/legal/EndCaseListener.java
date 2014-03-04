package com.neusoft.activiti.listener.legal;

import java.util.Map;

import org.activiti.engine.impl.persistence.entity.TaskEntity;
import org.springframework.stereotype.Component;
@Component
public class EndCaseListener extends LegalDefaultUserTaskListener {

	@Override
	protected void commonCreatEvent(TaskEntity taskEntity,
			Map<String, Object> variables) {
		// TODO Auto-generated method stub
		super.commonCreatEvent(taskEntity, variables);
	}

	@Override
	protected void commonAssignmentEvent(TaskEntity taskEntity,
			Map<String, Object> variables) {
		// TODO Auto-generated method stub
		super.commonAssignmentEvent(taskEntity, variables);
	}

	@Override
	protected void commonCompleteEvent(TaskEntity taskEntity,
			Map<String, Object> variables) {
		// TODO Auto-generated method stub
		super.commonCompleteEvent(taskEntity, variables);
	}
	
}
