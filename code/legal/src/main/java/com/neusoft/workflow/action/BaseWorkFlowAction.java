package com.neusoft.workflow.action;

import javax.annotation.Resource;

import org.activiti.engine.HistoryService;
import org.activiti.engine.IdentityService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.springframework.stereotype.Controller;

import com.neusoft.activiti.service.WorkflowProcessDefinitionService;
import com.neusoft.activiti.service.WorkflowTraceService;
import com.neusoft.base.action.BaseAction;

/**
 * 基础数据模块基类action
 * @author WangXuzheng
 *
 */
@Controller
public class BaseWorkFlowAction extends BaseAction {
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
      @Resource
	  protected HistoryService historyService;
      @Resource
      protected IdentityService identityService;
}
