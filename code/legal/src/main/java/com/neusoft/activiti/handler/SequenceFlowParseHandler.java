package com.neusoft.activiti.handler;

import org.activiti.bpmn.model.BaseElement;
import org.activiti.bpmn.model.SequenceFlow;
import org.activiti.engine.delegate.ExecutionListener;
import org.activiti.engine.impl.bpmn.parser.BpmnParse;
import org.activiti.engine.impl.bpmn.parser.handler.AbstractBpmnParseHandler;
import org.activiti.engine.impl.pvm.process.TransitionImpl;

import com.neusoft.base.common.SpringApplicationContextHolder;

public class SequenceFlowParseHandler extends AbstractBpmnParseHandler<SequenceFlow> {

	
	 public Class< ? extends BaseElement> getHandledType() {
		    return SequenceFlow.class;
		 }
	
	//private ExecutionListener defaultTakeListener;
	
	@Override
	protected void executeParse(BpmnParse bpmnParse, SequenceFlow sequenceFlow) {
		  TransitionImpl transition = bpmnParse.getSequenceFlows().get(sequenceFlow.getId());
		  ExecutionListener executionListener= SpringApplicationContextHolder.getBean("defaultTakeListener");
		  transition.addExecutionListener(executionListener);
	}

}
