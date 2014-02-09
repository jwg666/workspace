package com.neusoft.activiti.service.impl;

import java.util.Map;

import org.activiti.engine.RuntimeService;
import org.activiti.engine.impl.persistence.entity.TaskEntity;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.neusoft.activiti.service.ProcessCustomService;
import com.neusoft.activiti.util.Constant;
import com.neusoft.base.common.SpringApplicationContextHolder;
import com.neusoft.base.common.ValidateUtil;

@Service("taskService")
public class TaskServiceImpl extends org.activiti.engine.impl.TaskServiceImpl {
	private RuntimeService runtimeService;
	private ProcessCustomService processCustomService;
	private Logger logger = LoggerFactory.getLogger(getClass());
	@Override
	public void complete(String taskId) {
		// 
		this.complete(taskId, null);
	}

	@Override
	public void complete(String taskId, Map<String, Object> variables) {
		// 
		if(runtimeService==null){
			runtimeService=(RuntimeService)SpringApplicationContextHolder.getBean("runtimeService");
			processCustomService=(ProcessCustomService)SpringApplicationContextHolder.getBean("processCustomService");
		}
		Boolean ismanuallyExecution=false;
		try {
			TaskEntity taskEntity = processCustomService.findTaskById(taskId);
			String executionId = taskEntity.getExecutionId();
			String manuallyExecutionIds = (String) runtimeService.getVariable(
					executionId, Constant.MANUALLY_EXECUTION_IDS);
			if (ValidateUtil.isValid(manuallyExecutionIds)) {
				String[] manuallyExecutionIdArray = manuallyExecutionIds.split(",");
				for (String id : manuallyExecutionIdArray) {
					if (executionId.equals(id)) {
						ismanuallyExecution=true;
						break;
					}
				}
			}
			if(ismanuallyExecution){
				processCustomService.turnTransition(taskId,Constant.PARALLEL_GATEWAY_END,variables);
				return;
			}
		} catch (Exception e) {
			// 
			logger.error("got exception--",e);
		}
		
		super.complete(taskId,variables);
		
	}
	public void supComplete(String taskId, Map<String, Object> variables) {
		super.complete(taskId,variables);
	}

}
