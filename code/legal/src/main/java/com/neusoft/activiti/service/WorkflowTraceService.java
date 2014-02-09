package com.neusoft.activiti.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.activiti.engine.IdentityService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.delegate.Expression;
import org.activiti.engine.impl.RepositoryServiceImpl;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.runtime.Execution;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task; 
import org.apache.commons.beanutils.PropertyUtils;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.neusoft.activiti.util.WorkflowUtils;

/**
 * 工作流跟踪相关Service
 * 
 * @author HenryYan
 */
@Component
public class WorkflowTraceService {
	protected Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	protected RuntimeService runtimeService;

	@Autowired
	protected TaskService taskService;

	@Autowired
	protected RepositoryService repositoryService;

	@Autowired
	protected IdentityService identityService;

	/**
	 * 流程跟踪图
	 * 
	 * @param processInstanceId
	 *            流程实例ID
	 * @return 封装了各种节点信息
	 */
	public List<Map<String, Object>> traceProcess(String processInstanceId)
			throws Exception {
		Execution execution = runtimeService.createExecutionQuery()
				.executionId(processInstanceId).singleResult();// 执行实例
		Object property = PropertyUtils.getProperty(execution, "activityId");
		String activityId = "";
		if (property != null) {
			activityId = property.toString();
		}
		ProcessInstance processInstance = runtimeService
				.createProcessInstanceQuery()
				.processInstanceId(processInstanceId).singleResult();
		ProcessDefinitionEntity processDefinition = (ProcessDefinitionEntity) ((RepositoryServiceImpl) repositoryService)
				.getDeployedProcessDefinition(processInstance
						.getProcessDefinitionId());
		List<ActivityImpl> activitiList = processDefinition.getActivities();// 获得当前任务的所有节点

		List<Map<String, Object>> activityInfos = new ArrayList<Map<String, Object>>();
		for (ActivityImpl activity : activitiList) {
			boolean currentActiviti = false;
			String id = activity.getId();
			// 当前节点
			if (id.equals(activityId)) {
				currentActiviti = true;
			}
			Map<String, Object> activityImageInfo = packageSingleActivitiInfo(
					activity, processInstance, currentActiviti);
			activityInfos.add(activityImageInfo);
		}

		return activityInfos;
	}

	/**
	 * 子流程跟踪图
	 * 
	 * @param processInstanceId
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> traceSubProcess(String processInstanceId)
			throws Exception {
		List<Execution> executionList = runtimeService.createExecutionQuery()
				.processInstanceId(processInstanceId).list();
		List<String> activityIdList = new ArrayList<String>(
				executionList.size());
		for (Execution execution : executionList) {
			Object property = PropertyUtils
					.getProperty(execution, "activityId");
			if (property != null) {
				activityIdList.add(property.toString());
			}
		} 
		ProcessInstance processInstance = runtimeService.createProcessInstanceQuery() .processInstanceId(processInstanceId).singleResult();
		ProcessDefinitionEntity processDefinition = (ProcessDefinitionEntity) ((RepositoryServiceImpl) repositoryService)
				.getDeployedProcessDefinition(processInstance
						.getProcessDefinitionId());
		List<ActivityImpl> activitiList = processDefinition.getActivities();// 获得当前任务的所有节点

		List<Map<String, Object>> activityInfos = new ArrayList<Map<String, Object>>();
		getActivityList(activityIdList, processInstance, activitiList,activityInfos);
		return activityInfos;
	}

	private void getActivityList(List<String> activityIdList,
			ProcessInstance processInstance, List<ActivityImpl> activitiList,
			List<Map<String, Object>> activityInfos) throws Exception {
		for (ActivityImpl activity : activitiList) {
			List<ActivityImpl> subActivitiList=activity.getActivities();
			if(subActivitiList!=null&&subActivitiList.size()>0){
				getActivityList(activityIdList,processInstance, subActivitiList, activityInfos);
			}
			boolean currentActiviti = false;
			String id = activity.getId();
			// 当前节点
			for (String activityId : activityIdList){
				if (id.equals(activityId)) {
					currentActiviti = true;
				}
			}
			Map<String, Object> activityImageInfo = packageSingleActivitiInfo(activity, processInstance, currentActiviti);
			activityInfos.add(activityImageInfo);
		}
	}

	/**
	 * 封装输出信息，包括：当前节点的X、Y坐标、变量信息、任务类型、任务描述
	 * 
	 * @param activity
	 * @param processInstance
	 * @param currentActiviti
	 * @return
	 */
	private Map<String, Object> packageSingleActivitiInfo(
			ActivityImpl activity, ProcessInstance processInstance,
			boolean currentActiviti) throws Exception {
		Map<String, Object> vars = new HashMap<String, Object>();
		Map<String, Object> activityInfo = new HashMap<String, Object>();
		activityInfo.put("currentActiviti", currentActiviti);
		setPosition(activity, activityInfo);
		setWidthAndHeight(activity, activityInfo);
		Map<String, Object> properties = activity.getProperties();
		vars.put("任务类型",WorkflowUtils.parseToZhType(properties.get("type").toString()));
		vars.put("节点说明", properties.get("documentation"));
        vars.put("id",activity.getId());
		String description = activity.getProcessDefinition().getDescription();
		vars.put("描述", description);

		logger.debug("trace variables: {}", vars);
		activityInfo.put("vars", vars);
		return activityInfo;
	}

	private void setTaskGroup(Map<String, Object> vars,
			Set<Expression> candidateGroupIdExpressions) {
		StringBuffer roles = new StringBuffer();
		for (Expression expression : candidateGroupIdExpressions) {
			String expressionText = expression.getExpressionText();
			if (expressionText.startsWith("$")) {
				expressionText = expressionText.replace("${insuranceType}","life");
			}
			String roleName = identityService.createGroupQuery().groupId(expressionText).singleResult().getName();
			roles.append(roleName);
		}
		vars.put("任务所属角色", roles.toString());
	}



	/**
	 * 获取当前节点信息
	 * 
	 * @param processInstance
	 * @return
	 */
	private Task getCurrentTaskInfo(ProcessInstance processInstance) {
		Task currentTask = null;
		try {
			String activitiId = (String) PropertyUtils.getProperty(
					processInstance, "activityId");
			logger.debug("current activity id: {}", activitiId);

			currentTask = taskService.createTaskQuery()
					.processInstanceId(processInstance.getId())
					.taskDefinitionKey(activitiId).singleResult();
			logger.debug("current task for processInstance: {}",
					ToStringBuilder.reflectionToString(currentTask));

		} catch (Exception e) {
			logger.error(
					"can not get property activityId from processInstance: {}",
					processInstance);
		}
		return currentTask;
	}

	/**
	 * 设置宽度、高度属性
	 * 
	 * @param activity
	 * @param activityInfo
	 */
	private void setWidthAndHeight(ActivityImpl activity,
			Map<String, Object> activityInfo) {
		activityInfo.put("width", activity.getWidth());
		activityInfo.put("height", activity.getHeight());
	}

	/**
	 * 设置坐标位置
	 * 
	 * @param activity
	 * @param activityInfo
	 */
	private void setPosition(ActivityImpl activity,
			Map<String, Object> activityInfo) {
		activityInfo.put("x", activity.getX());
		activityInfo.put("y", activity.getY());
	}
}
