package com.neusoft.activiti.handler;

import org.activiti.bpmn.model.BaseElement;
import org.activiti.bpmn.model.UserTask;
import org.activiti.engine.delegate.TaskListener;
import org.activiti.engine.impl.bpmn.parser.BpmnParse;
import org.activiti.engine.impl.bpmn.parser.handler.AbstractBpmnParseHandler;
import org.activiti.engine.impl.bpmn.parser.handler.UserTaskParseHandler;
import org.activiti.engine.impl.task.TaskDefinition;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;

import com.neusoft.base.common.SpringApplicationContextHolder;
/**
 * 
 * 
 *         对activiti工作流引擎userTask进行重构， 此类为代理类,代理执行各个节点的taskListener, 约定目录为
 */
public class UserTaskRefactorHandler extends AbstractBpmnParseHandler<UserTask> {

	private Logger logger = LoggerFactory.getLogger(getClass());
	protected Class<? extends BaseElement> getHandledType() {
		return UserTask.class;
	}

	@SuppressWarnings("unchecked")
	protected void executeParse(BpmnParse bpmnParse, UserTask userTask) {
		TaskDefinition taskDefinition = (TaskDefinition) bpmnParse
				.getCurrentActivity().getProperty(
						UserTaskParseHandler.PROPERTY_TASK_DEFINITION);
		refactorListener(bpmnParse, userTask, taskDefinition);
	}
	

	private void refactorListener(BpmnParse bpmnParse, UserTask userTask,
			TaskDefinition taskDefinition) {
		String taskId = userTask.getId();
		TaskListener taskListener=null;
		String defaultTaskListener="defaultUserTaskListener";
		if(bpmnParse.getCurrentProcessDefinition().getKey().startsWith("Legal")){
			 defaultTaskListener="legalDefaultUserTaskListener";
		}
		try {
			taskListener = (TaskListener)SpringApplicationContextHolder.getApplicationContext().getBean(taskId+"Listener");
		} catch (BeansException e) {
			logger.error("got exception--",e);
			taskListener=(TaskListener)SpringApplicationContextHolder.getApplicationContext().getBean(defaultTaskListener);	
		}
		if(taskListener==null){
			taskListener=(TaskListener)SpringApplicationContextHolder.getApplicationContext().getBean(defaultTaskListener);	
		}
		taskDefinition.addTaskListener(TaskListener.EVENTNAME_ALL_EVENTS,taskListener);
	}


}
