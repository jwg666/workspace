package com.neusoft.workflow.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.annotation.Resource;

import net.sf.json.JSONArray;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;

import org.activiti.engine.history.HistoricActivityInstance;
import org.activiti.engine.history.HistoricActivityInstanceQuery;
import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.history.HistoricTaskInstanceQuery;
import org.activiti.engine.identity.User;
import org.activiti.engine.impl.RepositoryServiceImpl;
import org.activiti.engine.impl.persistence.entity.ExecutionEntity;
import org.activiti.engine.impl.persistence.entity.HistoricActivityInstanceEntity;
import org.activiti.engine.impl.persistence.entity.HistoricTaskInstanceEntity;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.persistence.entity.TaskEntity;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.repository.ProcessDefinitionQuery;
import org.activiti.engine.runtime.Execution;
import org.activiti.engine.runtime.ExecutionQuery;
import org.activiti.engine.task.IdentityLink;
import org.activiti.engine.task.Task;
import org.activiti.engine.task.TaskQuery;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.neusoft.activiti.service.ActivitiService;
import com.neusoft.activiti.util.Constant;
import com.neusoft.base.common.DateUtils;
import com.neusoft.base.common.LoginContext;
import com.neusoft.base.common.LoginContextHolder;
import com.neusoft.base.common.Pager;
import com.neusoft.base.common.ValidateUtil;
import com.neusoft.base.model.DataGrid;
import com.neusoft.base.model.Json;
import com.neusoft.base.model.SearchModel;
import com.neusoft.security.domain.UserInfo;
import com.neusoft.security.query.UserInfoQuery;
import com.neusoft.security.service.UserInfoService;

@Controller
@Scope("prototype")
public class TaskListAction extends BaseWorkFlowAction {
	/**
	 * 
	 */
	private static final long serialVersionUID = -6849627788742928808L;
	private long page;
	private long rows;
	private final DataGrid datagrid = new DataGrid();
	private final Json json = new Json();
	private String name;
	private String id = "0";
	private String taskid;
	private Pager<UserInfo> pagerUser = new Pager<UserInfo>();
	private final UserInfo user = new UserInfo();
	private String group;
	private TaskEntity entity = new TaskEntity();
	private String processDefinitionKey;
	private String businessformId;
	private String taskDefKey;
	private String processInstanceId;
	private String executionId;
	private String reDoTaskKeys;
	@Resource
	private ActivitiService activitiService;
	@Resource
	private UserInfoService userInforService;
	
	
	/**
	 * 跳转到任务列表页面
	 * 
	 * @return
	 */
	public String goTaskList() {
		return "taskList";
	}
	public String goExecutionList() {
		return "executionList";
	}

	public String executionDatagrid(){
		Pager pager = initPage();
		ExecutionQuery executionQuery=runtimeService.createExecutionQuery();
			
			if (ValidateUtil.isValid(processInstanceId)) {
				executionQuery.processInstanceId(processInstanceId);
			}
			if (ValidateUtil.isValid(processDefinitionKey)) {
				executionQuery.processInstanceId(processDefinitionKey);
			}
			if (ValidateUtil.isValid(taskDefKey)) {
				executionQuery.activityId(taskDefKey);
			}
			if(ValidateUtil.isValid(businessformId)){
				executionQuery.processInstanceBusinessKey(businessformId,true);
			}
			List<Execution> executionList = executionQuery.listPage(pager.getFirstResult()
					.intValue(), pager.getPageSize().intValue());
			List<Map<String, Object>> objecList = new ArrayList<Map<String, Object>>();
			datagrid.setRows(objecList);
			datagrid.setTotal(executionQuery.count());
			for (Execution execution : executionList) {
				Map<String, Object> map = new HashMap<String, Object>();
				ExecutionEntity executionEntity=(ExecutionEntity)execution;
				ProcessDefinitionEntity processDefinition = (ProcessDefinitionEntity) ((RepositoryServiceImpl) repositoryService)
						.getDeployedProcessDefinition(executionEntity.getProcessDefinitionId());
				 List<ActivityImpl>  activitiList = processDefinition.getActivities();
				 for(ActivityImpl activityImpl:activitiList){
					 if(activityImpl.getId().equals(executionEntity.getCurrentActivityId())){
						 map.put("name", activityImpl.getProperty("name"));
					 }
				 }
				map.put("activityId", executionEntity.getCurrentActivityId());
				map.put("processInstanceId", executionEntity.getProcessInstanceId());
				map.put("processDefinitionId",executionEntity.getProcessDefinitionId());
				map.put("id", executionEntity.getId());
				//map.put("executionEntityexecutionEntity", executionEntity);
				objecList.add(map);
			}
		return "datagrid";
	}
	
	
	/**
	 * 获取所有任务
	 * 
	 * @return
	 */
	public String datagrid() {
		Pager pager = initPage();
		TaskQuery taskQuery = taskService.createTaskQuery()
				.orderByTaskCreateTime().desc();
			if (ValidateUtil.isValid(entity.getName())) {
				taskQuery.taskNameLike(entity.getName());
			}
			if (ValidateUtil.isValid(entity.getAssignee())) {
				taskQuery.taskAssignee(entity.getAssignee());
			}
			if (ValidateUtil.isValid(entity.getProcessInstanceId())) {
				taskQuery.processInstanceId(entity.getProcessInstanceId());
			}
			if (ValidateUtil.isValid(processDefinitionKey)) {
				taskQuery.processDefinitionKey(processDefinitionKey);
			}
			if (ValidateUtil.isValid(group)) {
				taskQuery.taskCandidateGroup(group);
			}
			if(ValidateUtil.isValid(businessformId)){
				taskQuery.processInstanceBusinessKey(businessformId);
			}
		List<Task> taskList = taskQuery.listPage(pager.getFirstResult()
				.intValue(), pager.getPageSize().intValue());
		List<Map<String, Object>> objecList = new ArrayList<Map<String, Object>>();
		datagrid.setRows(objecList);
		datagrid.setTotal(taskQuery.count());
		for (Task task : taskList) {
			TaskEntity taskEntity = (TaskEntity) task;
			ProcessDefinitionQuery pp = repositoryService
					.createProcessDefinitionQuery().processDefinitionId(
							taskEntity.getProcessDefinitionId());
			List<ProcessDefinition> processDefinitionList = pp.list();
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", taskEntity.getId());
			map.put("executionId", taskEntity.getExecutionId());
			map.put("name", taskEntity.getName());
			map.put("processInstanceId", taskEntity.getProcessInstanceId());
			map.put("processDefinitionId", taskEntity.getProcessDefinitionId());
			map.put("createTime", taskEntity.getCreateTime());
			map.put("suspensionState", taskEntity.getSuspensionState());
			map.put("assignee", taskEntity.getAssignee());
			map.put("dueDate", taskEntity.getDueDate());
			map.put("priority", taskEntity.getPriority());
			map.put("description", taskEntity.getDescription());
			map.put("getProcessDefinitionKey", processDefinitionList.get(0).getKey());
			objecList.add(map);
		}
		return "datagrid";
	}

	/**
	 * 当前流程历史任务
	 * 
	 * @return
	 */
	public String historicTaskDatagrid() {
		Pager pager = initPage();
		HistoricTaskInstanceQuery historicTaskInstanceQuery = historyService
				.createHistoricTaskInstanceQuery().processInstanceId(id)
				.orderByHistoricTaskInstanceEndTime().asc();
		List<HistoricTaskInstance> historicTaskInstanceList = historicTaskInstanceQuery
				.listPage(pager.getFirstResult().intValue(), pager
						.getPageSize().intValue());
		List<Map<String, Object>> objecList = new ArrayList<Map<String, Object>>();
		datagrid.setRows(objecList);
		for (HistoricTaskInstance historicTaskInstance : historicTaskInstanceList) {
			HistoricTaskInstanceEntity taskInstanceEntity = (HistoricTaskInstanceEntity) historicTaskInstance;
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("historicName", taskInstanceEntity.getName());
			map.put("historicPriority", taskInstanceEntity.getPriority());
			map.put("historicAssignee", taskInstanceEntity.getAssignee());
			map.put("startTime",
					DateUtils.format(DateUtils.FORMAT3,
							taskInstanceEntity.getStartTime()));
			map.put("endTime",
					DateUtils.format(DateUtils.FORMAT3,
							taskInstanceEntity.getEndTime()));
			map.put("state", taskInstanceEntity.getDeleteReason());
			map.put("claimTime",
					DateUtils.format(DateUtils.FORMAT3,
							taskInstanceEntity.getClaimTime()));
			map.put("taskKey", taskInstanceEntity.getTaskDefinitionKey());
			map.put("id", taskInstanceEntity.getId());
			// map.put("startTime",
			// DateUtils.format(DateUtils.format3,taskInstanceEntity.getStartTime()));
			objecList.add(map);
		}

		datagrid.setTotal(historicTaskInstanceQuery.count());
		return "datagrid";
	}
	
	public String historicActDatagrid() {
		//Pager pager = initPage();
		HistoricActivityInstanceQuery  historicTaskInstanceQuery = historyService
				.createHistoricActivityInstanceQuery().processInstanceId(id)
				.orderByHistoricActivityInstanceStartTime().asc();
		List<HistoricActivityInstance> historicTaskInstanceList = historicTaskInstanceQuery
				.list();
		List<Map<String, Object>> objecList = new ArrayList<Map<String, Object>>();
		datagrid.setRows(objecList);
		for (HistoricActivityInstance historicTaskInstance : historicTaskInstanceList) {
			HistoricActivityInstanceEntity taskInstanceEntity = (HistoricActivityInstanceEntity) historicTaskInstance;
			Map<String, Object> map = new HashMap<String, Object>();
			//Constant.HIGH_LIGHT_ID.
			if(Constant.HIGH_LIGHT_ID_LISR.contains(taskInstanceEntity.getActivityType())){
			map.put("historicName", taskInstanceEntity.getActivityName());
			map.put("historicAssignee", taskInstanceEntity.getAssignee());
			map.put("startTime",
					DateUtils.format(DateUtils.FORMAT3,
							taskInstanceEntity.getStartTime()));
			map.put("endTime",
					DateUtils.format(DateUtils.FORMAT3,
							taskInstanceEntity.getEndTime()));
			map.put("state",taskInstanceEntity.getEndTime()==null?"":"已结束" );
			map.put("claimTime",null);
			map.put("taskKey", taskInstanceEntity.getActivityId());
			map.put("id", taskInstanceEntity.getId());
			// map.put("startTime",
			// DateUtils.format(DateUtils.format3,taskInstanceEntity.getStartTime()));
			objecList.add(map);
			}
		}

		datagrid.setTotal(historicTaskInstanceQuery.count());
		return "datagrid";
	}
	
	

	public String reDoTask() {
		if (ValidateUtil.isValid(reDoTaskKeys)&&ValidateUtil.isValid(taskid)) {
			try {
//				orderEditService.reDoTask(reDoTaskKeys,processInstanceId);
			} catch (Exception e) {
				// 
				logger.error("got exception--",e);
			}
		}

		return SUCCESS;
	}

	/**
	 * 流程变量
	 * 
	 * @return
	 */
	public String variablesDatagrid() {
		List<Map<String, Object>> objecList = new ArrayList<Map<String, Object>>();
		datagrid.setRows(objecList);
		Map<String, Object> variables = taskService.getVariables(id);
		for (Entry<String, Object> entry : variables.entrySet()) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("key", entry.getKey());
			map.put("value", entry.getValue());
			objecList.add(map);
		}
		return "datagrid";
	}
	public String executionVariablesDatagrid() {
		List<Map<String, Object>> objecList = new ArrayList<Map<String, Object>>();
		datagrid.setRows(objecList);
		Map<String, Object> variables =runtimeService.getVariables(processInstanceId);
		for (Entry<String, Object> entry : variables.entrySet()) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("key", entry.getKey());
			map.put("value", entry.getValue());
			objecList.add(map);
		}
		return "datagrid";
	}

	/**
	 * 任务完成
	 * 
	 * @return
	 */
	public String complete() {
		taskService.complete(taskid);
		return "datagrid";
	}
	/**
	 * 
	 */
	public String signalExecution(){
		try {
			LoginContext loginContext=(LoginContext)LoginContextHolder.get();
			activitiService.signalExecution(executionId,loginContext.getEmpCode());
			json.setSuccess(true);
		} catch (Exception e) {
			// 
			logger.error("got exception--",e);
			json.setSuccess(false);
		}
		return SUCCESS;
	}
	/**
	 * 用户查询
	 * 
	 * @return
	 */
	public String search() {
		Pager pager = initPage();
		if (pagerUser.getPageSize() == 20) {
			pagerUser.setPageSize(pager.getPageSize());
			pagerUser.setCurrentPage(pager.getCurrentPage());
		}
//		userSearchModel.setUser(user);
//		userSearchModel.setPager(pagerUser);
//		pagerUser = userService.searchUser(userSearchModel);
		pagerUser = null;
		UserInfoQuery userInfoQuery = new UserInfoQuery();
		List<Map<String, Object>> objecList = new ArrayList<Map<String, Object>>();
		datagrid.setRows(objecList);
		for (UserInfo u : pagerUser.getRecords()) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", u.getId());
			map.put("name", u.getName());
			map.put("email", u.getEmail());
			map.put("empCode", u.getEmpCode());
			objecList.add(map);
		}
		datagrid.setTotal(userInforService.searchUserInfoCount(userInfoQuery));
		return "datagrid";
	}

	/**
	 * 任务重新分配
	 * 
	 * @return
	 */
	public String setAssignee() {
		if(user.getId()==0){
			taskService.setAssignee(taskid,null);
		}else{
		UserInfo u = userInforService.getUserInfoById(user.getId());
		taskService.setAssignee(taskid, u.getEmpCode());
		}
		return "datagrid";
	}

	/**
	 * 一个任务的详细信息
	 * 
	 * @return
	 */
	public String detailDatagrid() {
		List<Map<String, Object>> objecList = new ArrayList<Map<String, Object>>();
		TaskEntity taskEntity = (TaskEntity) taskService.createTaskQuery()
				.taskId(entity.getId()).list().get(0);
		ProcessDefinitionQuery pp = repositoryService
				.createProcessDefinitionQuery().processDefinitionId(
						taskEntity.getProcessDefinitionId());
		List<ProcessDefinition> processDefinitionList = pp.list();
		datagrid.setRows(objecList);
		Set<String> groupIds = new HashSet<String>();
		List<IdentityLink> identityLinks = taskService.getIdentityLinksForTask(entity.getId());
		for (IdentityLink identityLink : identityLinks) {
			if(ValidateUtil.isValid(identityLink.getGroupId())){
				groupIds.add(identityLink.getGroupId());
			}
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", taskEntity.getId());
		map.put("name", taskEntity.getName());
		map.put("processInstanceId", taskEntity.getProcessInstanceId());
		map.put("processDefinitionId", taskEntity.getProcessDefinitionId());
		map.put("createTime",
				DateUtils.format(DateUtils.FORMAT1, taskEntity.getCreateTime()));
		map.put("suspensionState", taskEntity.getSuspensionState());
		map.put("assignee", taskEntity.getAssignee());
		map.put("groupIds", groupIds);
		map.put("dueDate", taskEntity.getDueDate());
		map.put("priority", taskEntity.getPriority());
		map.put("description", taskEntity.getDescription());
		map.put("getProcessDefinitionKey", processDefinitionList.get(0)
				.getKey());
		objecList.add(map);
		return "datagrid";
	}

	private Pager initPage() {
		Pager page1 = new Pager();
		if (!ValidateUtil.isValid(page)) {
			page = 1;
		}
		if (!ValidateUtil.isValid(rows)) {
			rows = 10;
		}
		page1.setCurrentPage(page);
		page1.setPageSize(rows);
		datagrid.setRows(page1.getRecords());
		datagrid.setTotal(page1.getTotalRecords());
		return page1;
	}

	/**
	 * 批量保存
	 * 
	 * @return
	 */
	public void bathAdd() {
		String updated = this.getRequest().getParameter("effectRow");
		// 任务ID
		String taskId = this.getRequest().getParameter("taskId");
		// 根据任务ID获取
		Map<String, Object> map = taskService.getVariables(taskId);
		try {
			JSONArray jsonArray = JSONArray.fromObject(updated);
			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject jsonObject = jsonArray.getJSONObject(i);
				map.put(jsonObject.getString("key"),
						jsonObject.getString("value"));
			}
		} catch (JSONException e) {
			logger.info(e.getMessage());
		}
		taskService.setVariables(taskId, map);

	}

	public DataGrid getDatagrid() {
		return datagrid;
	}

	public void setPage(long page) {
		this.page = page;
	}

	public void setRows(long rows) {
		this.rows = rows;
	}

	public Json getJson() {
		return json;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTaskid() {
		return taskid;
	}

	public void setTaskid(String taskid) {
		this.taskid = taskid;
	}

	public Pager<UserInfo> getPagerUser() {
		return pagerUser;
	}

	public void setPagerUser(Pager<UserInfo> pagerUser) {
		this.pagerUser = pagerUser;
	}

	public UserInfo getUser() {
		return user;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getGroup() {
		return group;
	}

	public void setGroup(String group) {
		this.group = group;
	}

	public TaskEntity getEntity() {
		return entity;
	}

	public void setEntity(TaskEntity entity) {
		this.entity = entity;
	}

	public String getProcessDefinitionKey() {
		return processDefinitionKey;
	}

	public void setProcessDefinitionKey(String processDefinitionKey) {
		this.processDefinitionKey = processDefinitionKey;
	}

	public String getBusinessformId() {
		return businessformId;
	}

	public void setBusinessformId(String businessformId) {
		this.businessformId = businessformId;
	}

	public void setReDoTaskKeys(String reDoTaskKeys) {
		this.reDoTaskKeys = reDoTaskKeys;
	}

	public String getTaskDefKey() {
		return taskDefKey;
	}

	public void setTaskDefKey(String taskDefKey) {
		this.taskDefKey = taskDefKey;
	}

	public String getProcessInstanceId() {
		return processInstanceId;
	}

	public void setProcessInstanceId(String processInstanceId) {
		this.processInstanceId = processInstanceId;
	}
	public void setExecutionId(String executionId) {
		this.executionId = executionId;
	}
	
	
	

}
