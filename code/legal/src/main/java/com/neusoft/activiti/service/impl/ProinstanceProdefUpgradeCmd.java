package com.neusoft.activiti.service.impl;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.activiti.engine.HistoryService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.impl.interceptor.Command;
import org.activiti.engine.impl.interceptor.CommandContext;
import org.activiti.engine.impl.persistence.entity.ExecutionEntity;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.ProcessDefinition;
import org.springframework.beans.factory.annotation.Autowired;

import com.neusoft.activiti.dao.ActivitiDao;
import com.neusoft.activiti.service.WfProcinstanceService;
import com.neusoft.base.common.SpringApplicationContextHolder;
import com.neusoft.base.common.ValidateUtil;
/**
 * 将流程重新回归到开始节点
 * 
 * @author 秦焰培
 * 
 */
public class ProinstanceProdefUpgradeCmd implements Command<Void>, Serializable {

	@Autowired
	protected RepositoryService repositoryService;
	@Autowired
	protected RuntimeService runtimeService;
	@Autowired
	protected HistoryService historyService;
	@Autowired
	protected TaskService taskService;
	@Autowired
	protected ActivitiDao activitiDao;
//	@Autowired
//	protected OrderEditService orderEditService; 
	@Autowired
	protected WfProcinstanceService wfProcinstanceService;

	private String[] updateStatements={"updateRunTasks","updateExecutes","updateJobs",
			"updateIdentitylinks","updateTaskinsts","updateProcinsts","updateActinsts","updateWF"};
	
	private String proinstanceId;

	private Deployment deployment;
	
	private String processDefinitionId;
	
	
	private ProcessDefinition oldProcessDefinition;
	private String newProcessDefinitionId;
	
	
	public ProinstanceProdefUpgradeCmd(String proinstanceId,String processDefinitionId) {
		super();
		this.proinstanceId = proinstanceId;
		this.processDefinitionId=processDefinitionId;
		SpringApplicationContextHolder.getApplicationContext()
				.getAutowireCapableBeanFactory().autowireBean(this);
	}

	public ProinstanceProdefUpgradeCmd(Deployment deployment) {
		super();
		this.deployment = deployment;
		SpringApplicationContextHolder.getApplicationContext()
				.getAutowireCapableBeanFactory().autowireBean(this);
	}
	
	public ProinstanceProdefUpgradeCmd(ProcessDefinition oldProcessDefinition,String newProcessDefinitionId){
		this.oldProcessDefinition=oldProcessDefinition;
		this.newProcessDefinitionId=newProcessDefinitionId;
		SpringApplicationContextHolder.getApplicationContext()
		.getAutowireCapableBeanFactory().autowireBean(this);
	}

	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	public Void execute(CommandContext commandContext)  {
		//Context.setCommandContext(commandContext);
		if(deployment!=null){
				instanceUpgrade(deployment);
		} else if(ValidateUtil.isValid(proinstanceId)&&ValidateUtil.isValid(processDefinitionId)){
			instanceUpgrade(proinstanceId, processDefinitionId);
		}
		else if(oldProcessDefinition!=null&&ValidateUtil.isValid(newProcessDefinitionId)){
			instanceUpgrade(oldProcessDefinition, newProcessDefinitionId);
		}
		return null;
	}
	
	
	/**
	 * 升级对应部署包中对应的流程旧版本任务实例
	 * @param deployment
	 * @throws Exception
	 */
	public void instanceUpgrade(Deployment deployment){
		String deploymentId = deployment.getId();
		List<ProcessDefinition> processDefinitionList=repositoryService.createProcessDefinitionQuery().deploymentId(deploymentId).list();
		for(ProcessDefinition processDefinition:processDefinitionList){
			String key =processDefinition.getKey();
			int version = processDefinition.getVersion();
			//String DEPLOYMENT_ID_ = processDefinition.getDeploymentId();
			String procDefId = processDefinition.getId();
			Map<String,Object> parameterMap=new HashMap<String, Object>();
			parameterMap.put("key", key);
			parameterMap.put("version", version);
			parameterMap.put("op", "<");
			parameterMap.put("PROC_DEF_ID", procDefId);
			for(String updateStatement:updateStatements){
				activitiDao.updateProdecId(updateStatement, parameterMap);
			}
		}
	}
	/**
	 * 把某一个流程定义进行更换
	 * @param oldProcessDefinition
	 * @param newProcessDefinitionId
	 */
	public void instanceUpgrade(ProcessDefinition oldProcessDefinition,String newProcessDefinitionId){
		ProcessDefinition processDefinition=repositoryService.createProcessDefinitionQuery().processDefinitionId(newProcessDefinitionId).singleResult();
		String key =oldProcessDefinition.getKey();
		int version = oldProcessDefinition.getVersion();
		//String DEPLOYMENT_ID_ = processDefinition.getDeploymentId();
		String procDefId = newProcessDefinitionId;
		Map<String,Object> parameterMap=new HashMap<String, Object>();
		parameterMap.put("newKey", key);
		parameterMap.put("key", processDefinition.getKey());
		parameterMap.put("version", version);
		parameterMap.put("op", "=");
		parameterMap.put("PROC_DEF_ID", procDefId);
		for(String updateStatement:updateStatements){
			activitiDao.updateProdecId(updateStatement, parameterMap);
		}
		
	}
	
	
	/**
	 * 为该流程实例更换流程图
	 * @param proinstaceId
	 * @param processDefinitionId
	 */
	public void instanceUpgrade(String proinstanceId,String processDefinitionId){
		Map<String,Object> parameterMap=new HashMap<String, Object>();
		ExecutionEntity processInstance=(ExecutionEntity)runtimeService.createProcessInstanceQuery().processInstanceId(proinstanceId).singleResult();
		ProcessDefinition processDefinition=repositoryService.createProcessDefinitionQuery().processDefinitionId(processDefinitionId).singleResult();
		
		parameterMap.put("PROC_DEF_ID", processDefinitionId);
		parameterMap.put("procinstId", proinstanceId);
		parameterMap.put("key", processInstance.getProcessDefinition().getKey());
		parameterMap.put("newKey", processDefinition.getKey());
		for(String updateStatement:updateStatements){
			activitiDao.updateProdecId(updateStatement+"ByProcinstId", parameterMap);
		}
		
	}
	
	
	

	
	
	

}
