package com.neusoft.activiti.handler.factory;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.activiti.engine.ProcessEngine;
import org.activiti.engine.impl.bpmn.parser.factory.DefaultActivityBehaviorFactory;
import org.activiti.engine.impl.history.parse.ProcessHistoryParseHandler;
import org.activiti.engine.impl.history.parse.StartEventHistoryParseHandler;
import org.activiti.engine.impl.history.parse.UserTaskHistoryParseHandler;
import org.activiti.engine.parse.BpmnParseHandler;
import org.activiti.spring.SpringProcessEngineConfiguration;

import com.neusoft.activiti.handler.BaseFlowNodeHistoryParseHandler;

public class BaseSpringProcessEngineConfiguration extends SpringProcessEngineConfiguration {
	
	@Resource
	private BaseFlowNodeHistoryParseHandler hroisFlowNodeHistoryParseHandler;
	
	@Override
	public ProcessEngine buildProcessEngine() {
		// 
		ProcessEngine processEngine=super.buildProcessEngine();
		DefaultActivityBehaviorFactory defaultActivityBehaviorFactory=(DefaultActivityBehaviorFactory)getActivityBehaviorFactory();
		defaultActivityBehaviorFactory.setExpressionManager(super.getExpressionManager());
		return processEngine;
	}
	@Override
	protected List<BpmnParseHandler> getDefaultHistoryParseHandlers() {
		    List<BpmnParseHandler> parseHandlers = new ArrayList<BpmnParseHandler>();
		    parseHandlers.add(hroisFlowNodeHistoryParseHandler);
		    parseHandlers.add(new ProcessHistoryParseHandler());
		    parseHandlers.add(new StartEventHistoryParseHandler());
		    parseHandlers.add(new UserTaskHistoryParseHandler());
		    return parseHandlers;
	}
	
	

	
	
	
}
