package com.neusoft.activiti.handler;

import org.activiti.bpmn.model.SubProcess;
import org.activiti.engine.impl.bpmn.parser.BpmnParse;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.springframework.beans.BeansException;

import com.neusoft.activiti.listener.base.StartEndRefactorListener;
import com.neusoft.base.common.SpringApplicationContextHolder;

public class SubProcessParseHandler extends org.activiti.engine.impl.bpmn.parser.handler.SubProcessParseHandler {

	@Override
	protected void executeParse(BpmnParse bpmnParse, SubProcess subProcess) {
		// 
		super.executeParse(bpmnParse, subProcess);
		ActivityImpl activityImpl=bpmnParse.getCurrentActivity();
		String id=activityImpl.getId();
		StartEndRefactorListener startEndRefactorListener=null;
		try {
		startEndRefactorListener=(StartEndRefactorListener)SpringApplicationContextHolder.getApplicationContext().getBean(id);
		} catch (BeansException e) {
			startEndRefactorListener=(StartEndRefactorListener)SpringApplicationContextHolder.getApplicationContext().getBean("defaultStartEndListener");
		}
		if(startEndRefactorListener==null){
			startEndRefactorListener=(StartEndRefactorListener)SpringApplicationContextHolder.getApplicationContext().getBean("defaultStartEndListener");
		}
		activityImpl.addExecutionListener(org.activiti.engine.impl.pvm.PvmEvent.EVENTNAME_START,startEndRefactorListener );
		activityImpl.addExecutionListener(org.activiti.engine.impl.pvm.PvmEvent.EVENTNAME_END,startEndRefactorListener );
	}

	


}
