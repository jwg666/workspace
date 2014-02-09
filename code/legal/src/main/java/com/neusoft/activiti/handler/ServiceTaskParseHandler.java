package com.neusoft.activiti.handler;

import org.activiti.bpmn.model.BaseElement;
import org.activiti.bpmn.model.ServiceTask;
import org.activiti.engine.delegate.ExecutionListener;
import org.activiti.engine.impl.bpmn.parser.BpmnParse;
import org.activiti.engine.impl.bpmn.parser.handler.AbstractExternalInvocationBpmnParseHandler;
import org.activiti.engine.impl.pvm.process.ActivityImpl;

import com.neusoft.base.common.SpringApplicationContextHolder;


public class ServiceTaskParseHandler extends
		AbstractExternalInvocationBpmnParseHandler<ServiceTask> {

	@Override
	protected void executeParse(BpmnParse bpmnParse, ServiceTask element) {
		ActivityImpl activityImpl  =bpmnParse.getCurrentActivity();
		ExecutionListener executionListener=null;
		String defaultTaskListener="orderReceiveTaskStartEndRefactorListener";
		executionListener=(ExecutionListener)SpringApplicationContextHolder.getApplicationContext().getBean(defaultTaskListener);	
		activityImpl.addExecutionListener(ExecutionListener.EVENTNAME_START, executionListener);
		activityImpl.addExecutionListener(ExecutionListener.EVENTNAME_END, executionListener);
	}
	
	  public Class< ? extends BaseElement> getHandledType() {
		    return ServiceTask.class;
     }

}
