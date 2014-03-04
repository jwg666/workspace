package com.neusoft.activiti.listener.legal;

import java.util.Map;

import org.activiti.engine.impl.persistence.entity.TaskEntity;
import org.springframework.stereotype.Component;

import com.neusoft.activiti.listener.base.DefaultUserTaskListener;

@Component
public class LegalDefaultUserTaskListener extends DefaultUserTaskListener {
	private static final long serialVersionUID = 3965250607696157719L;

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
