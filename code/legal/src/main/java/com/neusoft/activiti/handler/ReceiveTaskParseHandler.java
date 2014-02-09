package com.neusoft.activiti.handler;

import org.activiti.bpmn.model.BaseElement;
import org.activiti.bpmn.model.ReceiveTask;
import org.activiti.engine.delegate.ExecutionListener;
import org.activiti.engine.impl.bpmn.parser.BpmnParse;
import org.activiti.engine.impl.bpmn.parser.handler.AbstractActivityBpmnParseHandler;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.springframework.beans.BeansException;

import com.neusoft.base.common.SpringApplicationContextHolder;

public class ReceiveTaskParseHandler  extends AbstractActivityBpmnParseHandler<ReceiveTask> {

	public Class< ? extends BaseElement> getHandledType() {
	    return ReceiveTask.class;
	  }
	
	@Override
	protected void executeParse(BpmnParse bpmnParse, ReceiveTask receiveTask) {
		// TODO Auto-generated method stub
		refactorListener(bpmnParse, receiveTask);
	}
	
	private void refactorListener(BpmnParse bpmnParse, ReceiveTask receiveTask) {
		ActivityImpl activityImpl  =bpmnParse.getCurrentActivity();
		String taskId = receiveTask.getId();
		ExecutionListener executionListener=null;
		String defaultTaskListener="defaultReceiveTaskStartEndRefactorListener";
		if(bpmnParse.getCurrentProcessDefinition().getKey().startsWith("orderTrace")){
			 defaultTaskListener="orderReceiveTaskStartEndRefactorListener";
		}
		try {
			executionListener = (ExecutionListener)SpringApplicationContextHolder.getApplicationContext().getBean(taskId);
		} catch (BeansException e) {
			// 
			//logger.error("got exception--",e);
			executionListener=(ExecutionListener)SpringApplicationContextHolder.getApplicationContext().getBean(defaultTaskListener);	
		}
		if(executionListener==null){
			executionListener=(ExecutionListener)SpringApplicationContextHolder.getApplicationContext().getBean(defaultTaskListener);	
		}
		activityImpl.addExecutionListener(ExecutionListener.EVENTNAME_START, executionListener);
		activityImpl.addExecutionListener(ExecutionListener.EVENTNAME_END, executionListener);
	}

}
