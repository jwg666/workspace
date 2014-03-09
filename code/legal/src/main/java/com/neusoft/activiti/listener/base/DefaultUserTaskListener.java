package com.neusoft.activiti.listener.base;

import java.util.Map;

import javax.annotation.Resource;

import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.impl.persistence.entity.TaskEntity;
import org.springframework.stereotype.Component;

import com.neusoft.activiti.service.WorkflowProcessDefinitionService;
import com.neusoft.activiti.service.WorkflowTraceService;

@Component
public class DefaultUserTaskListener extends UserTaskRefactorListener {

	private static final long serialVersionUID = 4554656587173626984L;

      @Resource
	  protected WorkflowProcessDefinitionService workflowProcessDefinitionService;
      @Resource
	  protected RepositoryService repositoryService;
      @Resource
	  protected RuntimeService runtimeService;
      @Resource
	  protected TaskService taskService;
      @Resource
	  protected WorkflowTraceService traceService;
	
	@Override
	protected void afterCreat(TaskEntity taskEntity,
			Map<String, Object> variables) {
		logger.debug("----do afterCreat---");
	}

	@Override
	protected void afterAssignment(TaskEntity taskEntity,
			Map<String, Object> variables) {
		logger.debug("----do afterAssignment---");
	}


	@Override
	protected void afterComplete(TaskEntity taskEntity,
			Map<String, Object> variables) {
		logger.debug("----do afterComplete---");
	}

	

}
