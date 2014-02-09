package com.neusoft.activiti.handler;

import org.activiti.bpmn.model.BaseElement;
import org.activiti.bpmn.model.StartEvent;
import org.activiti.engine.impl.bpmn.parser.BpmnParse;
import org.activiti.engine.impl.bpmn.parser.handler.AbstractBpmnParseHandler;
import org.apache.commons.lang3.StringUtils;

import com.neusoft.activiti.listener.base.DefaultStartEndListener;
import com.neusoft.base.common.SpringApplicationContextHolder;
import com.neusoft.base.common.ValidateUtil;
/**
 * 
 * @author 秦焰培
 *
 *对activiti工作流引擎开始  结束  进行重构，
 *此类为代理类,代理执行任务开始和结束事件,
 *约定目录为
 */
public class ProcessStartRefactorHandler extends AbstractBpmnParseHandler<StartEvent> {

    private String listenerClassPath;
	
	protected Class<? extends BaseElement> getHandledType() {
		return StartEvent.class;
	}

	protected void executeParse(BpmnParse bpmnParse, StartEvent element) {
		String processKey=bpmnParse.getCurrentProcessDefinition().getKey();
		String classPath = null;
		if (ValidateUtil.isValid(listenerClassPath)) {
			classPath = listenerClassPath + "." + StringUtils.capitalize(processKey);
		} else {
			classPath = "com.haier.hrois.activiti.listener." + StringUtils.capitalize(processKey);
		}
		Class<DefaultStartEndListener> listenerClass=null;
		String listenerId=null;
		try {
			listenerClass=(Class<DefaultStartEndListener>) Class.forName(classPath);
			listenerId=processKey;
		} catch (ClassNotFoundException e) {
			// 
			listenerClass=DefaultStartEndListener.class;
			listenerId="defaultStartEndListener";
		}
		DefaultStartEndListener taskListener=SpringApplicationContextHolder.getApplicationContext().getBean(listenerId,listenerClass);
		bpmnParse.getCurrentActivity().addExecutionListener(org.activiti.engine.impl.pvm.PvmEvent.EVENTNAME_START, taskListener);
	}

	public void setListenerClassPath(String listenerClassPath) {
		this.listenerClassPath = listenerClassPath;
	}
	
	

}
