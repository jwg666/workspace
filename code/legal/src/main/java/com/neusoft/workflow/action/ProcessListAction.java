package com.neusoft.workflow.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import net.sf.json.JSONArray;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;

import org.activiti.engine.history.HistoricActivityInstance;
import org.activiti.engine.history.HistoricActivityInstanceQuery;
import org.activiti.engine.impl.persistence.entity.TaskEntity;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.repository.ProcessDefinitionQuery;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.neusoft.base.common.DateUtils;
import com.neusoft.base.common.Pager;
import com.neusoft.base.common.ValidateUtil;
import com.neusoft.base.model.DataGrid;
import com.neusoft.base.model.Json;
import com.neusoft.security.domain.UserInfo;

@Controller
@Scope("prototype")
public class ProcessListAction extends BaseWorkFlowAction{

	private static final long serialVersionUID = -6849627788742965808L;
	private long page;
	private long rows;
	private final DataGrid datagrid=new DataGrid();
	private final Json json = new Json();
	private String name;
	private String id = "0";
	private String taskid;
	private Pager<UserInfo> pagerUser = new Pager<UserInfo>();
	private final UserInfo user = new UserInfo();
	private String group;
	private TaskEntity entity = new TaskEntity();
	
	public String goProcessList() {
		return "processList";
	}
	
	public String datagrid(){
		Pager pager=initPage();
		//TaskQuery taskQuery = taskService.createTaskQuery().orderByTaskCreateTime().desc();
		HistoricActivityInstanceQuery historicActivityInstanceQuery = historyService.createHistoricActivityInstanceQuery().unfinished().orderByHistoricActivityInstanceStartTime().desc();
		if(entity.getProcessInstanceId()!=null){
			historicActivityInstanceQuery.processInstanceId(entity.getProcessInstanceId());
		}
		List<HistoricActivityInstance> historicActivityList = historicActivityInstanceQuery.listPage(pager.getFirstResult().intValue(), pager.getPageSize().intValue());
		List<Map<String,Object>> objecList = new ArrayList<Map<String,Object>>();
	    datagrid.setRows(objecList);
	    for (HistoricActivityInstance historicActivityInstance : historicActivityList) {
	    	
			ProcessDefinitionQuery pp = repositoryService.createProcessDefinitionQuery().processDefinitionId(historicActivityInstance.getProcessDefinitionId());
			List<ProcessDefinition> processDefinitionList = pp.list();
			Map<String,Object> map=new HashMap<String, Object>();
			map.put("id", historicActivityInstance.getId());
			map.put("taskId", historicActivityInstance.getTaskId());
			map.put("executionId",historicActivityInstance.getExecutionId());
			map.put("name", historicActivityInstance.getActivityName());
			map.put("processInstanceId",historicActivityInstance.getProcessInstanceId());
			map.put("processDefinitionId",historicActivityInstance.getProcessDefinitionId());
			map.put("startTime", historicActivityInstance.getStartTime());
			map.put("assignee", historicActivityInstance.getAssignee());
			map.put("getProcessDefinitionKey", processDefinitionList.get(0).getKey());
			
			objecList.add(map);
	    }	
		datagrid.setTotal(historicActivityInstanceQuery.count());
		return "datagrid";
	}
	public String detailDatagrid()
	{
		List<Map<String,Object>> objecList = new ArrayList<Map<String,Object>>();
		if(taskService.createTaskQuery().processInstanceId(entity.getProcessInstanceId()).list().size()>0){
			TaskEntity taskEntity = (TaskEntity) taskService.createTaskQuery().processInstanceId(entity.getProcessInstanceId()).list().get(0);
			ProcessDefinitionQuery pp = repositoryService.createProcessDefinitionQuery().processDefinitionId(taskEntity.getProcessDefinitionId());
			List<ProcessDefinition> processDefinitionList = pp.list();
			datagrid.setRows(objecList);
			Map<String,Object> map=new HashMap<String, Object>();
			map.put("id", taskEntity.getId());
			map.put("name", taskEntity.getName());
			map.put("executionId",taskEntity.getExecutionId());
			map.put("processInstanceId",taskEntity.getProcessInstanceId());
			map.put("processDefinitionId",taskEntity.getProcessDefinitionId());
			map.put("createTime", DateUtils.format(DateUtils.FORMAT1,taskEntity.getCreateTime()));
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
	public String variablesDatagrid()
	{
		 List<Map<String,Object>> objecList = new ArrayList<Map<String,Object>>();
		 datagrid.setRows(objecList);
		 Map<String,Object> variables = runtimeService.getVariables(id);
			 for(Entry<String, Object>  entry:variables.entrySet()){
				Map<String,Object> map=new HashMap<String, Object>();
				map.put("key", entry.getKey());
				map.put("value",entry.getValue());
				objecList.add(map);
			}
		return "datagrid";		 
	}
	public void bathAdd(){
		String updated = this.getRequest().getParameter("effectRow");
		//executionId
		String executionId = this.getRequest().getParameter("executionId");
		//根据executionId获取
		Map<String ,Object> map = runtimeService.getVariables(executionId);
		try {
			JSONArray jsonArray = JSONArray.fromObject(updated);
			for(int i = 0;i < jsonArray.size(); i++){
				JSONObject jsonObject = jsonArray.getJSONObject(i);
				map.put(jsonObject.getString("key"), jsonObject.getString("value"));
			}
		} catch (JSONException e) {
			logger.info(e.getMessage());
		}
		runtimeService.setVariables(executionId, map);
		
	}
	private Pager initPage(){
		Pager page1=new Pager();
		if(!ValidateUtil.isValid(page)){
			page=1;
		}
		if(!ValidateUtil.isValid(rows)){
			rows=10;
		}
		page1.setCurrentPage(page);
		page1.setPageSize(rows);
		datagrid.setRows(page1.getRecords());
		datagrid.setTotal(page1.getTotalRecords());
		return page1;
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
}
