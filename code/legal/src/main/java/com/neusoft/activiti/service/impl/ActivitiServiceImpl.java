package com.neusoft.activiti.service.impl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.TreeSet;

import javax.annotation.Resource;

import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.delegate.Expression;
import org.activiti.engine.impl.RepositoryServiceImpl;
import org.activiti.engine.impl.ServiceImpl;
import org.activiti.engine.impl.interceptor.Command;
import org.activiti.engine.impl.interceptor.CommandExecutor;
import org.activiti.engine.impl.persistence.entity.ExecutionEntity;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.persistence.entity.TaskEntity;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.impl.task.TaskDefinition;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.Execution;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.springframework.stereotype.Service;

import com.neusoft.activiti.service.ActivitiService;
import com.neusoft.activiti.util.Constant;
import com.neusoft.base.common.LoginContext;
import com.neusoft.base.common.LoginContextHolder;
import com.neusoft.base.common.SpringApplicationContextHolder;
import com.neusoft.base.common.ValidateUtil;

@Service
public class ActivitiServiceImpl implements ActivitiService {

	@Resource
	private RuntimeService runtimeService;
	@Resource
	private TaskService taskService;
	@Resource
	private RepositoryService repositoryService;

	@Override
	public void signalExecution(String executionId, String empCode) {
		//
		if (ValidateUtil.isValid(executionId)) {
			List<Task> taskList = taskService.createTaskQuery()
					.executionId(executionId).list();
			if (ValidateUtil.isValid(taskList)) {
				for (Task task : taskList) {
					taskService.claim(task.getId(), empCode);
					taskService.complete(task.getId());
				}
			} else {
				runtimeService.signal(executionId);
			}
		}
	}

	@Override
	/**
	 * 发送催办
	 */
	public void sendReminders(String processInstanceId, String taskKey) {
		//
		if (ValidateUtil.isValid(processInstanceId)
				&& ValidateUtil.isValid(taskKey)) {
			List<Task> taskList = taskService.createTaskQuery()
					.processInstanceId(processInstanceId)
					.taskDefinitionKey(taskKey).active().list();
			if (ValidateUtil.isValid(taskList)) {
				TaskServiceImpl taskServiceImpl = (TaskServiceImpl) taskService;
				LoginContext loginContext = (LoginContext) LoginContextHolder
						.get();
				for (Task task : taskList) {
					/* 判断是否有该任务的催办 */
					String sql = "select count(distinct task.ID_) "
							+ " from ACT_RU_TASK task "
							+ "where task.parent_task_id_ =" + task.getId();
					Long count = taskService.createNativeTaskQuery().sql(sql)
							.count();
					if (count > 0) {
						return;
					}
					CommandExecutor commandExecutor = taskServiceImpl
							.getCommandExecutor();
					Command<List<Task>> sendReminderCmd = new SendReminderCmd(
							task, loginContext.getEmpCode());
					commandExecutor.execute(sendReminderCmd);
				}
			}
		}
	}

	public void updateHasRodoIds(ExecutionEntity executionEntity,
			Map<String, Object> variables) {
		Collection<String> allRedoNodeIds = (Collection<String>) variables
				.get(Constant.ALL_RODO_NODE_IDS);
		if (ValidateUtil.isValid(allRedoNodeIds)) {
			String activityId = executionEntity.getActivityId();
			if (allRedoNodeIds.contains(activityId)) {
				Collection<String> hasRedoNodeIds = (Collection<String>) variables
						.get(Constant.HAS_RODO_NODE_IDS);
				if (!ValidateUtil.isValid(hasRedoNodeIds)) {
					hasRedoNodeIds = new TreeSet<String>();
				}
				hasRedoNodeIds.add(activityId);
				runtimeService.setVariable(
						executionEntity.getProcessInstanceId(),
						Constant.HAS_RODO_NODE_IDS, hasRedoNodeIds);
			}
		}
	}

	public void updateAssgin(String proinstId, String orderCode) {
		ProcessInstance processInstance = runtimeService
				.createProcessInstanceQuery().processInstanceId(proinstId)
				.singleResult();
		/*
		 * 更新工作流变量
		 */
		Map<String, Object> variablesMap = new HashMap<String, Object>();
//		for (Entry<String, String> entry : Constant.updateAssgineeMap
//				.entrySet()) {
//			String variables = entry.getKey().replaceAll("[//$//{//}]", "")
//					.trim();
//			String beanId = entry.getValue();
//			UpdateAssgineeService updateAssgineeService = SpringApplicationContextHolder
//					.getBean(beanId);
//			String value = updateAssgineeService.getNewAssgineeService(
//					proinstId, orderCode);
//			variablesMap.put(variables, value);
//		}
		runtimeService.setVariables(proinstId, variablesMap);
		/* 把现在已经处于活动状态的任务 如果使用了流程变量 修改 */
		RepositoryServiceImpl repositoryServiceImpl = (RepositoryServiceImpl) repositoryService;
		ProcessDefinitionEntity processDefinition = (ProcessDefinitionEntity) repositoryServiceImpl
				.getDeployedProcessDefinition(processInstance
						.getProcessDefinitionId());
		List<ActivityImpl> activitiList = new ArrayList<ActivityImpl>();
		List<ActivityImpl> activityImpls = processDefinition.getActivities();
		List<ActivityImpl> subActivitiList = new ArrayList<ActivityImpl>();
		for (ActivityImpl activityImpl : activityImpls) {
			Object type = activityImpl.getProperty("type");
			if ("subProcess".equals(type)) {
				subActivitiList.addAll(activityImpl.getActivities());
			}
			// logger.debug(map);
		}
		activitiList.addAll(subActivitiList);
		activitiList.addAll(activityImpls);
		List<Task> taskList = taskService.createTaskQuery()
				.processInstanceId(proinstId).list();
		for (Task task : taskList) {
			TaskEntity taskEntity = (TaskEntity) task;
			for (ActivityImpl activityImpl : activitiList) {
				if (activityImpl.getId().equals(
						taskEntity.getTaskDefinitionKey())) {
					TaskDefinition taskDefinition = (TaskDefinition) activityImpl
							.getProperty("taskDefinition");
					Expression expression = taskDefinition
							.getAssigneeExpression();
					if (expression != null) {
//						Map<String, String> updateAssgineeMap = Constant.updateAssgineeMap;
//						String beanId = updateAssgineeMap.get(expression
//								.getExpressionText());
//						if (ValidateUtil.isValid(beanId)) {
//							UpdateAssgineeService updateAssgineeService = SpringApplicationContextHolder
//									.getBean(beanId);
//							String newEmpCode = updateAssgineeService
//									.getNewAssgineeService(proinstId, orderCode);
//							if (ValidateUtil.isValid(newEmpCode)) {
//								// 如果新的和老的不相等 则重新分配任务
//								if (!newEmpCode
//										.equals(taskEntity.getAssignee())) {
//									taskService.setAssignee(taskEntity.getId(),
//											newEmpCode);
//								}
//							}
//						}
					}
				}
			}
		}
	}

	/**
	 * 升级对应部署包中对应的流程旧版本任务实例(只能更换相同的流程定义key)
	 * 
	 * @param deployment
	 * @throws Exception
	 */
	public void instanceUpgrade(Deployment deployment) {
		ServiceImpl serviceImpl = (ServiceImpl) repositoryService;
		CommandExecutor commandExecutor = serviceImpl.getCommandExecutor();
		commandExecutor.execute(new ProinstanceProdefUpgradeCmd(deployment));
	}

	/**
	 * 为该流程实例更换流程图（可以更换成任意的流程定义key）
	 * 
	 * @param proinstaceId
	 * @param processDefinitionId
	 */
	public void instanceUpgrade(String proinstaceId, String processDefinitionId) {
		ServiceImpl serviceImpl = (ServiceImpl) repositoryService;
		CommandExecutor commandExecutor = serviceImpl.getCommandExecutor();
		commandExecutor.execute(new ProinstanceProdefUpgradeCmd(proinstaceId,
				processDefinitionId));
		// 重新激活新的流程
//		orderEditService.reDoTask(null, proinstaceId);
	}

	/**
	 * 指定把某一个流程的定义升级成某个版本（只能更换相同的流程定义key）
	 * 
	 * @param oldProcessDefinition
	 *            老的流程定义
	 * @param newProcessDefinitionId
	 *            新的流程定义id
	 */
	public void instanceUpgrade(ProcessDefinition oldProcessDefinition,
			String newProcessDefinitionId) {
		ServiceImpl serviceImpl = (ServiceImpl) repositoryService;
		CommandExecutor commandExecutor = serviceImpl.getCommandExecutor();
		// 查询要升级的流程实例
		List<ProcessInstance> processInstanceList = runtimeService
				.createProcessInstanceQuery()
				.processDefinitionId(oldProcessDefinition.getId()).list();
		commandExecutor.execute(new ProinstanceProdefUpgradeCmd(
				oldProcessDefinition, newProcessDefinitionId));
		// 重新激活新的流程
		for (ProcessInstance processInstance : processInstanceList) {
//			orderEditService.reDoTask(null, processInstance.getId());
		}
	}

}
