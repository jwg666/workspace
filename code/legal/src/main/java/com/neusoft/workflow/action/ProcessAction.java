package com.neusoft.workflow.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.zip.ZipInputStream;

import javax.annotation.Resource;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.activiti.bpmn.model.BpmnModel;
import org.activiti.engine.history.HistoricActivityInstance;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.impl.RepositoryServiceImpl;
import org.activiti.engine.impl.cfg.ProcessEngineConfigurationImpl;
import org.activiti.engine.impl.context.Context;
import org.activiti.engine.impl.persistence.entity.HistoricProcessInstanceEntity;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.repository.ProcessDefinitionQuery;
import org.activiti.engine.runtime.ProcessInstance;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.NoSuchBeanDefinitionException;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.neusoft.activiti.diagram.HroisProcessDiagramGenerator;
import com.neusoft.activiti.listener.base.DefaultUserTaskListener;
import com.neusoft.activiti.service.ActivitiService;
import com.neusoft.activiti.service.WfProcinstanceService;
import com.neusoft.activiti.taskdetail.TaskDetailService;
import com.neusoft.activiti.util.Constant;
import com.neusoft.base.common.DateUtils;
import com.neusoft.base.common.Pager;
import com.neusoft.base.common.SpringApplicationContextHolder;
import com.neusoft.base.common.ValidateUtil;
import com.neusoft.base.model.DataGrid;
import com.neusoft.base.model.Json;
import com.neusoft.security.domain.UserInfo;
import com.neusoft.security.service.UserInfoService;

@Controller
@Scope("prototype")
public class ProcessAction extends BaseWorkFlowAction {

	private static final long serialVersionUID = -6849627788742928808L;
	private long page;
	private long rows;
	private DataGrid datagrid = new DataGrid();
	private Json json = new Json();
	private File processFile;
	private String processInstanceId;
	private String processFileFileName;
	private String deploymentId;
	private String resourceName;
	private InputStream resourceAsStream;
	private String[] deploymentIds;
	private List<Map<String, Object>> activityInfos;
	private List<ActivityImpl> activitiList;
	private String taskId;
	private String taskKey;
	/* 流程的状态 */
	private String state;
	private String processDefinitionName;

	
	private String key;
	private String processDefinitionId;
	
	@Resource
	private ProcessEngineConfigurationImpl processEngineConfiguration;
	@Resource
	private WfProcinstanceService procinstanceService;
	@Resource
	private UserInfoService userInfoService;
	@Resource
	private ActivitiService activitiService;
	@Resource
	private DefaultUserTaskListener defaultUserTaskListener;
	@Resource
	private WfProcinstanceService wfProcinstanceService;

	/**
	 * 跳转到流程管理管理页面
	 * 
	 * @return
	 */
	public String processAction() {

		/*Map<String,Object> map=new HashMap<String, Object>();
		map.put("transConfirm", true);
		map.put("infoAgentConfirm", true);
		map.put("infoGoodsConfirm", true);
		runtimeService.setVariables("113974", map);*/
		// String
		// processDefinitionId=historyService.createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult().getProcessDefinitionId();
		/*
		 * String
		 * processDefinitiontId=repositoryService.createProcessDefinitionQuery
		 * ().
		 * processDefinitionKey("orderTrace").latestVersion().singleResult().
		 * getId (); ProcessDefinitionEntity processDefinition =
		 * (ProcessDefinitionEntity) ((RepositoryServiceImpl) repositoryService)
		 * .getDeployedProcessDefinition(processDefinitiontId); activitiList =
		 * processDefinition.getActivities();// 获得当前任务的所有节点
		 * logger.debug(activitiList);
		 */
		// ApplicationContext ctx =
		// WebApplicationContextUtils.getRequiredWebApplicationContext(this.getServletConfig().getServletContext());
		/*
		 * try { test(); } catch (HroisException exception) { // Auto-generated
		 * catch block json.setMsg(exception.getLocalizedMessage());
		 * //exception.printStackTrace(); }
		 */
		// json.setMsg()
		// logger.debug(HroisMessage.getMessage(""));

		// return "i18n";
		// logger.debug(HroisMessage.getMessage("pcm.vessel.carrier"));
		// logger.debug(getText("global.form.select"));
		// getText(aTextName, args)
		// StaticMessageSource
		/*
		 * QueryManager queryManager=Factory.getQueryManager(Ralasafe.appName);
		 * Query query= queryManager.getQuery(121); Map context=new HashMap();
		 * //Object businformId=taskService.getVariable(taskEntity.getId(),
		 * "businformId"); //context.put("businformId",businformId); Collection
		 * empCodeCollection=query.execute(RalasafeUtil.getUser(),
		 * context).getData(); logger.debug(((org.ralasafe.db.MapStorgeObject
		 * )empCodeCollection.iterator().next()).toString());
		 */
		/*		*/

		/*
		 * List<HistoricActivityInstance>
		 * historicActivityInstanceList=historyService
		 * .createHistoricActivityInstanceQuery
		 * ().activityId("orderAutoAudit").unfinished().list();
		 * for(HistoricActivityInstance
		 * historicActivityInstance:historicActivityInstanceList){
		 * HistoricActivityInstanceEntity
		 * activityInstanceEntity=(HistoricActivityInstanceEntity
		 * )historicActivityInstance;
		 * logger.debug(activityInstanceEntity.getProcessInstanceId()); }
		 */

		// runtimeService.activateProcessInstanceById("55124");

		/*
		 * Execution execution =
		 * runtimeService.createExecutionQuery().processInstanceId
		 * ("105507").activityId("packageBudget") .singleResult(); execution.
		 * runtimeService.signal(execution.getId());
		 */
		// runtimeService.deleteProcessInstance("100111", "");
		// runtimeService.s
		// runtimeService.suspendProcessInstanceById("50501");
		// runtimeService.activateProcessInstanceById("50501");
		// procinstanceService.taskQueryByFrom();
		// HroisRalasafe.queryCount(3, null);
		// taskQueryByFrom();
		/*
		 * Map<String,Object> variables=new HashMap<String, Object>();
		 * variables.
		 * put(Constant.NEED_SKIP_NODE_IDS,"usertask1,servicetask1,receivetask1"
		 * ); runtimeService.startProcessInstanceByKey("join", variables);
		 */
		/*
		 * try { // generateTableSeqUtil.generateTableSeqUtil("CD_TECH_ORDER");
		 * // runtimeService.deleteProcessInstance("50501", null);
		 * 
		 * } catch (Exception e) { // logger.error("got exception--",e); }
		 */

		// runtimeService.setVariable("88132", "isSecondPay",true);
		// runtimeService.
		/*
		 * List<ProcessInstance>
		 * processInstanceList=runtimeService.createProcessInstanceQuery
		 * ().processDefinitionKey("orderEditPro").list(); for(ProcessInstance
		 * processInstance: processInstanceList){
		 * runtimeService.deleteProcessInstance(processInstance.getId(), ""); }
		 */
		// runtimeService.createExecutionQuery().activityId(activityId)
		// return null;
		/*
		 * Task task=taskService.createTaskQuery().taskId("").singleResult();
		 * taskService.setDueDate(taskId, dueDate)
		 */
		// taskService.createTaskQuery().taskDefinitionKey(key)
		//runtimeService.startProcessInstanceById("join:7:270004");
		return "processList";
		/*
		 * Execution execution =
		 * runtimeService.createExecutionQuery().processInstanceId
		 * ("76001").activityId("getNegoInfoFromHope") .singleResult();
		 * runtimeService.signal(execution.getId());
		 */
		/*
		 * Map variables=new HashMap(); variables.put("businformId",
		 * "test-hxq-0703"); variables.put("businformType", "LC_LETTERCREDIT");
		 * variables.put("operateManager", "1");
		 * 
		 * runtimeService.startProcessInstanceByKey("letterCredit", variables);
		 */
		// return null;
		// runtimeService.startProcessInstanceById("join:1:61304");
		// orderTraceService.testMessage("66303");
		// return null;
	}

	public String test() {
		
		
		activitiService.instanceUpgrade("1258890", "orderTrace:5:1351952");
		/*runtimeService.startProcessInstanceById(processDefinitionId);*/
		
		//repositoryService.createProcessDefinitionQuery().processDefinitionKey("myProcess").list();
		
		//orderEditService.reDoTask(, "244801");
		
		//runtimeService.startProcessInstanceById("join:7:270004");
		//runtimeService.deleteProcessInstance(processInstanceId, deleteReason)
		//System.out.println(activitiService.isCanEndshipMent("270502"));
		
		/*Deployment deployment=repositoryService.createDeploymentQuery().deploymentId("188959").singleResult();
		activitiService.instanceUpgrade(deployment);*/
		//ProcessDefinition processDefinition= repositoryService.createProcessDefinitionQuery().processDefinitionId("orderTrace_Yj:13:133226").singleResult();
		//activitiService.instanceUpgrade("578091","orderTrace:4:631028");
		//activitiService.("6050instanceUpgrade59", "orderTrace:4:631028");
		//runtimeService.activateProcessInstanceById("605059");
		//orderEditService.reDoTask(null,"605059");
		//runtimeService.suspendProcessInstanceById("605059");
/*
		Set<String> orderCodes=new HashSet<String>();
		orderCodes.add("0001872114");
		List<String> a=new ArrayList<String>();
		for(String orderCode:orderCodes) {
			String processInstanceId = wfProcinstanceService.findProcinstanceId(
					orderCode, "SO_SALES_ORDER",
					"orderTrace", "1");
			try {
				wfProcinstanceService.test(orderCode);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				a.add(orderCode);
				e.printStackTrace();
			}
		 
		}
		System.out.println(a);*/
	
	/*	Set<String> orderCodes=new HashSet<String>();
		orderCodes.add("0001827418");
		orderCodes.add("0001856513");
		orderCodes.add("0001856518");
		List<String> a=new ArrayList<String>();
		for(String orderCode:orderCodes) {
			try {
				String processInstanceId = wfProcinstanceService.findProcinstanceId(
						orderCode, "SO_SALES_ORDER",
						"orderTrace", "1");
				ProcessInstance  processInstance=runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
				if(processInstance.isSuspended()){
					runtimeService.activateProcessInstanceById(processInstanceId);
					activitiService.updateAssgin(processInstanceId, orderCode);
					runtimeService.suspendProcessInstanceById(processInstanceId);
				}else{
					activitiService.updateAssgin(processInstanceId, orderCode);
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				a.add(orderCode);
			}
		}
		System.out.println(a);*/
	/*	List<String> ids=orderUserInfoDao.findList("OrderUserInfo.catchWrongOrder", new HashMap());
		for(String id:ids){
			String processInstanceId = wfProcinstanceService.findProcinstanceId(
					id, "SO_SALES_ORDER",
					"orderTrace", "1");
			try {
				runtimeService.activateProcessInstanceById(processInstanceId);
				orderEditService.reDoTask("getPackageInfo", processInstanceId);
				runtimeService.suspendProcessInstanceById(processInstanceId);
			} catch (Throwable e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}*/
/*		String processInstanceId = wfProcinstanceService.findProcinstanceId(
				"0001854302", "SO_SALES_ORDER",
				"orderTrace", "1");
		orderEditService.reDoTask("getPackageInfo", processInstanceId);*/
		
		//System.out.println(ids);
	/*	taskService.setVariable("164873", "result", false);
		try {
			processCustomService.endProcess("164873");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
		
	
		
		/*runtimeService.removeVariable("229384", "needSkipNodeIds");
		runtimeService.removeVariable("229384", "allRedoNodeIds");
		runtimeService.removeVariable("229384", "hasRedoNodeIds");*/
	/*	Set<String> hasRedoNodeIds=(Set<String>)runtimeService.getVariable("229384", "allRedoNodeIds");
		hasRedoNodeIds.remove("scheduling");
		runtimeService.setVariable("229384", "allRedoNodeIds", hasRedoNodeIds);*/
		/*Map<String,Object> map=new HashMap<String, Object>();
		map.put("transConfirm", true);
		map.put("infoAgentConfirm", true);
		map.put("infoGoodsConfirm", true);
		map.put("custCompany", "admin");
		runtimeService.setVariables("113974", map);*/
		
	/* Set<String> ids=(Set<String>)	runtimeService.getVariable("94432", "needSkipNodeIds");
	ids.remove("scheduling");	
	runtimeService.setVariable("94432", "needSkipNodeIds", ids);
	 System.out.println(ids);*/
		// wfProcinstanceService.get("2013090500007202");
		// wfProcinstanceService.delete()
		// runtimeService.deleteProcessInstance("60470", "change T Mode");
		/*ProcessInstance processInstance = runtimeService
				.createProcessInstanceQuery().processInstanceId("225858")
				.singleResult();
		ProcessDefinitionEntity processDefinition = (ProcessDefinitionEntity) ((RepositoryServiceImpl) repositoryService)
				.getDeployedProcessDefinition(processInstance
						.getProcessDefinitionId());
		activitiList = processDefinition.getActivities();
		List<Task> taskList = taskService.createTaskQuery()
				.processInstanceId("225858").list();
		for (Task task : taskList) {
			TaskEntity taskEntity = (TaskEntity) task;
			for (ActivityImpl activityImpl : activitiList) {
				if (activityImpl.getId().equals(
						taskEntity.getTaskDefinitionKey())) {
					TaskDefinition  taskDefinition=(TaskDefinition)activityImpl.getProperty("taskDefinition");
					Expression expression=taskDefinition.getAssigneeExpression();
					if (expression != null) {
						//System.out.println(expression.getExpressionText());
						String beanId=Constant.updateAssgineeMap.get(expression.getExpressionText());
						if(ValidateUtil.isValid(beanId)){
							UpdateAssgineeService assgineeService=SpringApplicationContextHolder.getBean(beanId);
							//assgineeService.getNewAssgineeService(processInstanceId, orderCode);
						}
					}
				}

			}
		}*/

		//processCustomService.endProcess(taskId)
		
		/*
		 * String processDefinitionId =
		 * historicProcessInstance.getProcessDefinitionId();
		 * ProcessDefinitionEntity processDefinition = (ProcessDefinitionEntity)
		 * ((RepositoryServiceImpl) repositoryService)
		 * .getDeployedProcessDefinition(processDefinitionId);
		 * processDefinitionName=processDefinition.getName(); activitiList =
		 * processDefinition.getActivities()
		 */// 获得当前任务的所有节点

		// runtimeService.suspendProcessInstanceById("28333");

		/*
		 * runtimeService.setVariable("47209", "isSecondPay", false);
		 * taskService.complete("49049");
		 */

		/*
		 * List<SMS> smsz = new ArrayList<SMS>(); SMS smsOwner = new SMS();
		 * smsOwner.setMsgCode(String.valueOf(System.currentTimeMillis()));
		 * smsOwner
		 * .setMsgContent("您的个人账户刘艺华于2013-09-06 收到付款8000.00元 ;付款人：秦焰培;请注意查收。[中国银行]"
		 * ); smsOwner.setPhoneNum("15166058629"); smsz.add(smsOwner);
		 * 
		 * SMSMessage smsMsg = new SMSMessage(); smsMsg.setSenderName("中国银行");
		 * smsMsg.setSmsList(smsz); smsSender.sendMsg(smsMsg);
		 */

		/*
		 * Email email = new Email(); List<Recipient> recipients = new
		 * ArrayList<Recipient>(); recipients.add(new
		 * Recipient("327802151@qq.com", "秦焰培")); //recipients.add(new
		 * Recipient("908912659@qq.com", "于方兴"));
		 * email.setToRecipient(recipients); email.setSender(new
		 * Recipient("110@china.com", "测试"));
		 * 
		 * StringBuffer bodyContent = new StringBuffer();
		 * bodyContent.append("你被举报涉嫌非法活动");
		 * email.setBodyContent(bodyContent.toString(), false);
		 * 
		 * email.setSubject("警告"); email.setSystem("test");
		 * 
		 * emailSender.sendEmail(email);
		 */
		
		
		//runtimeService.startProcessInstanceById("join:7:270004");

		
		// runtimeService.startProcessInstanceByKey(processDefinitionKey)
		/*
		 * ProcessDefinition processDefinitionTemp = repositoryService
		 * .createProcessDefinitionQuery().latestVersion()
		 * .processDefinitionKey("orderTrace").singleResult();
		 * ProcessDefinitionEntity processDefinition = (ProcessDefinitionEntity)
		 * ((RepositoryServiceImpl) repositoryService)
		 * .getDeployedProcessDefinition(processDefinitionTemp.getId());
		 * List<ActivityImpl> activityImpls = processDefinition.getActivities();
		 * List<ActivityImpl> subActivitiList = new ArrayList<ActivityImpl>();
		 * for (ActivityImpl activityImpl : activityImpls) { Object type =
		 * activityImpl.getProperty("type"); if ("subProcess".equals(type)) {
		 * subActivitiList.addAll(activityImpl.getActivities()); } //
		 * logger.debug(map); } activityImpls.addAll(subActivitiList);
		 * 
		 * List<ActSetQuery> actSetQuerieList=actSetService.listAll(new
		 * ActSetQuery());
		 * 
		 * for (ActivityImpl activityImpl : activityImpls) { TaskDefinition
		 * taskDefinition = (TaskDefinition) activityImpl
		 * .getProperty("taskDefinition"); if (taskDefinition != null) {
		 * Expression expression = taskDefinition .getDescriptionExpression();
		 * if (expression != null) { if
		 * (ValidateUtil.isValid(expression.getExpressionText())) {
		 * logger.debug(activityImpl.getId() + "++++" +
		 * taskDefinition.getDescriptionExpression()); for(ActSetQuery
		 * actSetQuery:actSetQuerieList){
		 * if(actSetQuery.getActId().equals(activityImpl.getId())){
		 * actSetQuery.setWorkflowDesc
		 * (taskDefinition.getDescriptionExpression().getExpressionText());
		 * logger.debug(actSetQuery.getWorkflowDesc());
		 * //actSetService.update(actSetQuery); } }
		 * 
		 * } }
		 * 
		 * } }
		 */
		/*
		 * Map<String, Object> variables =new HashMap<String, Object>();
		 * variables.put("businformId","123");
		 * variables.put("businformType","ddf");
		 * runtimeService.startProcessInstanceByKey("join",variables);
		 */
		/*
		 * List<String> hurdleList=new ArrayList<String>();
		 * hurdleList.add("admin"); runtimeService.setVariable("136946",
		 * "hurdleList", hurdleList);
		 */
		/* runtimeService.deleteProcessInstance("105781", null); */
		// orderTraceService.testMessage(taksId)\
		// new HroisRemoveMessageRunable(userIdList, taskIdList).execute();
		/*
		 * List<Execution>
		 * executionList=runtimeService.createExecutionQuery().activityId
		 * ("exportHGVS").list(); for(Execution execution:executionList){ try {
		 * runtimeService.signal(execution.getId());
		 * //taskService.complete(task.getId()); } catch (Exception e) { //
		 * logger.error("got exception--",e); } }
		 * executionList=runtimeService.createExecutionQuery
		 * ().activityId("followGoods").list(); for(Execution
		 * execution:executionList){ try {
		 * runtimeService.signal(execution.getId()); } catch (Exception e) { //
		 * logger.error("got exception--",e); } }
		 * executionList=runtimeService.createExecutionQuery
		 * ().activityId("getPackageInfo").list(); for(Execution
		 * execution:executionList){ try {
		 * runtimeService.signal(execution.getId()); } catch (Exception e) { //
		 * logger.error("got exception--",e); } }
		 */
		/*
		 * String id=
		 * repositoryService.createProcessDefinitionQuery().processDefinitionId
		 * ("YjOrderTrace:1:72928").singleResult().getDeploymentId();
		 * repositoryService.deleteDeployment(id, true);
		 */
		// orderTraceService.Test2();
		// taskService.setVariable("38141", "custCompany", "admin");
		// TaskEntity taskEntity=(TaskEntity)
		// taskService.createTaskQuery().taskId("168424").includeProcessVariables().singleResult();
		// taskEntity.setVariables(taskService.getVariables("166288"));
		// DefaultUserTaskListener listener=new DefaultUserTaskListener();
		/*
		 * taskEntity.setEventName(org.activiti.engine.delegate.TaskListener.
		 * EVENTNAME_CREATE); defaultUserTaskListener.notify(taskEntity);
		 */
		return null;
		// return "test";
	}

	public String datagrid() {
		Pager pager = initPage();
		ProcessDefinitionQuery processDefinitionQuery = repositoryService
				.createProcessDefinitionQuery().orderByDeploymentId().desc();
		if(ValidateUtil.isValid(key)){
			processDefinitionQuery.processDefinitionKeyLike(key);
		}
		if(ValidateUtil.isValid(deploymentId)){
			processDefinitionQuery.deploymentId(deploymentId);
		}
		if(ValidateUtil.isValid(processDefinitionId)){
			processDefinitionQuery.processDefinitionId(processDefinitionId);
		}
		List<ProcessDefinition> processDefinitionList = processDefinitionQuery
				.listPage(pager.getFirstResult().intValue(), pager
						.getPageSize().intValue());
		/*
		 * 保存两个对象，一个是ProcessDefinition（流程定义），一个是Deployment（流程部署）
		 */
		List<Map<String, Object>> objecList = new ArrayList<Map<String, Object>>();
		datagrid.setRows(objecList);
		for (ProcessDefinition processDefinition : processDefinitionList) {
			String deploymentId = processDefinition.getDeploymentId();
			Deployment deployment = repositoryService.createDeploymentQuery()
					.deploymentId(deploymentId).singleResult();
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("isSuspended", processDefinition.isSuspended());
			map.put("id", processDefinition.getId());
			map.put("deploymentId", processDefinition.getDeploymentId());
			map.put("name", processDefinition.getName());
			map.put("key", processDefinition.getKey());
			map.put("version", processDefinition.getVersion());
			map.put("resourceName", processDefinition.getResourceName());
			map.put("diagramResourceName",
					processDefinition.getDiagramResourceName());
			map.put("deploymentTime",
					DateUtils.format(DateUtils.FORMAT3,
							deployment.getDeploymentTime()));
			objecList.add(map);
		}
		datagrid.setTotal(processDefinitionQuery.count());
		return "datagrid";
	}

	public String deploy() {
		InputStream fileInputStream;
		try {
			fileInputStream = new FileInputStream(processFile);

			String extension = FilenameUtils.getExtension(processFileFileName);
			if (extension.equals("zip") || extension.equals("bar")) {
				ZipInputStream zip = new ZipInputStream(fileInputStream);
				repositoryService.createDeployment().addZipInputStream(zip)
						.deploy();
			} else {
				repositoryService.createDeployment()
						.addInputStream(processFileFileName, fileInputStream)
						.deploy();
			}
		} catch (FileNotFoundException e) {
			//
			logger.error("got exception--", e);
		}
		json.setSuccess(true);
		json.setMsg("添加成功！");
		return SUCCESS;
	}

	public String delete() {
		for (String tempId : deploymentIds) {
			repositoryService.deleteDeployment(tempId, true);
		}
		json.setSuccess(true);
		json.setMsg("删除成功！");
		return SUCCESS;
	}

	public String loadByDeployment() {
		resourceAsStream = repositoryService.getResourceAsStream(deploymentId,
				resourceName);
		return "xml";
	}

	public String trace() {
		try {
			// activityInfos = traceService.traceSubProcess(processInstanceId);

			/*
			 * // 当前活动的节点 List<HistoricActivityInstance>
			 * activeActivityTaskInstanceList = historyService
			 * .createHistoricActivityInstanceQuery()
			 * .processInstanceId(processInstanceId).unfinished().list();
			 */
			activityInfos = new ArrayList<Map<String, Object>>();
			Map<String,Map<String,Object>> activityInfoMap=new HashMap<String, Map<String,Object>>();
			// 当前已经完成的节点
			List<HistoricActivityInstance> historicTaskInstanceList = historyService
					.createHistoricActivityInstanceQuery()
					.processInstanceId(processInstanceId).orderByHistoricActivityInstanceStartTime().asc().list();

			for (HistoricActivityInstance historicActivityInstance : historicTaskInstanceList) {
				for (String id : Constant.HIGH_LIGHT_ID) {
					// 需要展示详情的节点
					if (id.equals(historicActivityInstance.getActivityType())) {
						/**
						 * 过滤回退之后 第二次办理 所以应该不显示第一次办理结束的详情 当前处于活动的节点 不显示详情
						 */

						Map<String, Object> map = new HashMap<String, Object>();
						map.put("taskKey",
								historicActivityInstance.getActivityId());
						map.put("taskName",
								historicActivityInstance.getActivityName());
						map.put("actInstId",
								historicActivityInstance.getExecutionId());
						map.put("startTimeStr", DateUtils.format(
								DateUtils.FORMAT2,
								historicActivityInstance.getStartTime()));
						map.put("endTimeStr", DateUtils.format(
								DateUtils.FORMAT2,
								historicActivityInstance.getEndTime()));
						map.put("durTimeStr", DateUtils
								.formatDuring(historicActivityInstance
										.getDurationInMillis()));
						if (ValidateUtil.isValid(historicActivityInstance
								.getAssignee())) {
							UserInfo userInfo = userInfoService.getUserInfoByCode(historicActivityInstance
											.getAssignee());
							if (userInfo != null) {
								map.put("exeFullname", userInfo.getName() + "<"
										+ userInfo.getEmpCode() + ">");
							} else {
								map.put("exeFullname", "无");
							}
						} else {
							map.put("exeFullname", "无");
						}
						//activityInfos.add(map);
						if(historicActivityInstance.getId().equals("175673")){
							System.out.println("dd");
						}
						if(!(historicActivityInstance.getDurationInMillis()!=null&&historicActivityInstance.getDurationInMillis()<100L&&!"serviceTask".equals(historicActivityInstance.getActivityType()))){
							activityInfoMap.put(map.get("taskKey").toString(), map);
						}
					}
					// finshedActivityIds.add(historicActivityInstance.getActivityId());
				}
			}
			activityInfos.addAll(activityInfoMap.values());
			/* 找到有结束的index，移除 */
			List<Map<String, Object>> newActivityInfos = new ArrayList<Map<String, Object>>(
					activityInfos);
			for (Map<String, Object> newActivityInfo : newActivityInfos) {
				for (Map<String, Object> activityInfo : newActivityInfos) {
					if (activityInfo.get("taskKey").equals(newActivityInfo.get("taskKey"))
					&& !activityInfo.get("endTimeStr").equals(newActivityInfo.get("endTimeStr"))) {
						
						if (newActivityInfo.get("endTimeStr") != null
						&& !"".equals(newActivityInfo.get("endTimeStr"))) {
							// logger.debug(activityInfo.get("taskKey"));
							activityInfos.remove(newActivityInfo);
						}
					}
				}
			}

		} catch (Exception e) {
			//
			logger.error("got exception--", e);
		}
		return "trace";
	}

	public String goTrace() {
		/*
		 * ProcessInstance processInstance = historyService
		 * .createHistoricProcessInstanceQuery()
		 * .processInstanceId(processInstanceId).singleResult();
		 */
		HistoricProcessInstance historicProcessInstance = historyService
				.createHistoricProcessInstanceQuery()
				.processInstanceId(processInstanceId).singleResult();
		HistoricProcessInstanceEntity processInstanceEntity = (HistoricProcessInstanceEntity) historicProcessInstance;
		if (processInstanceEntity.getEndTime() != null) {
			state = "结束";
		} else {
			ProcessInstance processInstance = runtimeService
					.createProcessInstanceQuery()
					.processInstanceId(processInstanceEntity.getId())
					.singleResult();
			if (processInstance.isSuspended()) {
				state = "挂起";
			} else {
				state = "正常";
			}
		}
		String processDefinitionId = historicProcessInstance
				.getProcessDefinitionId();
		ProcessDefinitionEntity processDefinition = (ProcessDefinitionEntity) ((RepositoryServiceImpl) repositoryService)
				.getDeployedProcessDefinition(processDefinitionId);
		processDefinitionName = processDefinition.getName();
		activitiList = processDefinition.getActivities();// 获得当前任务的所有节点
		List<ActivityImpl> subActivitiList = new ArrayList<ActivityImpl>();
		for (ActivityImpl activityImpl : activitiList) {
			Object type = activityImpl.getProperty("type");
			if ("subProcess".equals(type)) {
				subActivitiList.addAll(activityImpl.getActivities());
			}
			// logger.debug(map);
		}
		activitiList.addAll(subActivitiList);
		return "goTrace";
	}

	@SuppressWarnings("unchecked")
	public String loadImageByPid() {
		Context.setProcessEngineConfiguration(processEngineConfiguration);
		String processDefinitionId = null;
		/*
		 * ProcessInstance processInstance = runtimeService
		 * .createProcessInstanceQuery()
		 * .processInstanceId(processInstanceId).singleResult();
		 */
		processDefinitionId = historyService
				.createHistoricProcessInstanceQuery()
				.processInstanceId(processInstanceId).singleResult()
				.getProcessDefinitionId();
		BpmnModel bpmnModel = repositoryService
				.getBpmnModel(processDefinitionId);
		Set<String> activeActivityIds = new HashSet<String>();
		List<HistoricActivityInstance> activeActivityTaskInstanceList = historyService
				.createHistoricActivityInstanceQuery()
				.processInstanceId(processInstanceId).unfinished().list();

		for (HistoricActivityInstance activityInstance : activeActivityTaskInstanceList) {
			activeActivityIds.add(activityInstance.getActivityId());
		}

		List<HistoricActivityInstance> historicTaskInstanceList = historyService
				.createHistoricActivityInstanceQuery()
				.processInstanceId(processInstanceId).finished().list();
		Set<String> finshedActivityIds = new HashSet<String>(
				historicTaskInstanceList.size());
		for (HistoricActivityInstance historicActivityInstance : historicTaskInstanceList) {
			for (String id : Constant.HIGH_LIGHT_ID) {
				if (id.equals(historicActivityInstance.getActivityType())) {
					finshedActivityIds.add(historicActivityInstance
							.getActivityId());
				}
			}
		}

		Set<String> showEndActivityIds;
		Set<String> needSkipNodes = (Set<String>) runtimeService.getVariable(
				processInstanceId, Constant.NEED_SKIP_NODE_IDS);
		if (ValidateUtil.isValid(needSkipNodes)) {
			showEndActivityIds = new HashSet<String>(needSkipNodes);
			showEndActivityIds.addAll(finshedActivityIds);
		} else {
			showEndActivityIds = finshedActivityIds;
		}
		Set<String> hasRedoNodes = (Set<String>) runtimeService.getVariable(
				processInstanceId, Constant.HAS_RODO_NODE_IDS);
		if (ValidateUtil.isValid(hasRedoNodes)) {
			showEndActivityIds.addAll(hasRedoNodes);
		}
		Set<String> allNeddRedoNodes = (Set<String>) runtimeService
				.getVariable(processInstanceId, Constant.ALL_RODO_NODE_IDS);
		if (allNeddRedoNodes!=null) {
			Set<String> allNeddRedoNodesCopy=new HashSet<String>(allNeddRedoNodes);
			allNeddRedoNodes.removeAll(hasRedoNodes);
			showEndActivityIds.addAll(finshedActivityIds);
			showEndActivityIds.removeAll(allNeddRedoNodes);
			//增加skiip 和 allneedRedo 交集
			Set<String> needSkipNodesCopy = new HashSet<String>(needSkipNodes);
			needSkipNodesCopy.retainAll(allNeddRedoNodesCopy);
			showEndActivityIds.addAll(needSkipNodesCopy);
			// finshedActivityIds.addAll(allNeddRedoNodes);
			// //finshedActivityIds.addAll(hasRedoNodes);
		}

		resourceAsStream = HroisProcessDiagramGenerator.generateDiagram(
				bpmnModel, "png", activeActivityIds,
				Collections.<String> emptySet(), showEndActivityIds);
		return "img";
	}

	public String loadTaskDetail() {
		// processInstanceId
		// taskKey
		if (ValidateUtil.isValid(taskKey)
				&& ValidateUtil.isValid(processInstanceId)) {
			try {
				TaskDetailService taskDetailService = SpringApplicationContextHolder
						.getBean(taskKey + "TaskDetail");
				String info = taskDetailService.loadTaskDetail(
						processInstanceId).replace("\"", "");
				if (!ValidateUtil.isValid(info)) {
					info = "无详细信息";
				}
				json.setMsg(info);
			} catch (NoSuchBeanDefinitionException e) {
				// TODO: handle exception
				json.setMsg("无详细信息");
			}
		}
		return "msg";
	}

	public String loadImage() {
		resourceAsStream = repositoryService.getResourceAsStream(deploymentId,
				resourceName);
		return "img";
	}

	public String sendReminders() {
		try {
			activitiService.sendReminders(processInstanceId, taskKey);
			json.setSuccess(true);
			json.setMsg("发送催办成功！");
		} catch (Exception e) {
			// TODO: handle exception
			logger.error("got exception--", e);
			json.setSuccess(false);
			json.setMsg("发送催办失败！");
		}
		return SUCCESS;
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

	public void setProcessFile(File processFile) {
		this.processFile = processFile;
	}

	public void setProcessFileFileName(String processFileFileName) {
		this.processFileFileName = processFileFileName;
	}

	public void setDeploymentId(String deploymentId) {
		this.deploymentId = deploymentId;
	}

	public void setResourceName(String resourceName) {
		this.resourceName = resourceName;
	}

	public InputStream getResourceAsStream() {
		return resourceAsStream;
	}

	public void setDeploymentIds(String[] deploymentIds) {
		this.deploymentIds = deploymentIds;
	}

	public void setProcessInstanceId(String processInstanceId) {
		this.processInstanceId = processInstanceId;
	}

	public String getProcessInstanceId() {
		return processInstanceId;
	}

	public List<Map<String, Object>> getActivityInfos() {
		return activityInfos;
	}

	public List<ActivityImpl> getActivitiList() {
		return activitiList;
	}

	public String getTaskId() {
		return taskId;
	}

	public void setTaskId(String taskId) {
		this.taskId = taskId;
	}

	public void setTaskKey(String taskKey) {
		this.taskKey = taskKey;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getProcessDefinitionName() {
		return processDefinitionName;
	}
	public static void main(String[] args) {
		try {
			File file=new File("D:\\json2.txt");
			//StringBuffer stringBuffer=new StringBuffer();
			List<String> list2=new ArrayList<String>();
			String content=FileUtils.readFileToString(new File("D:\\json.txt"), "UTF-8");
			for(String s:content.split("\\r\\n")){
				 //s=s.replaceAll("\\\"", "'");
				System.out.println(s);
				 JSONObject jsonObject=JSONObject.fromObject(s);
				 JSONArray jsonArray=jsonObject.getJSONArray("redoList");
				 list2.add(jsonArray.toString());
			}
			FileUtils.writeLines(file, "UTF-8", list2);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void setKey(String key) {
		this.key = key;
	}

	public void setProcessDefinitionId(String processDefinitionId) {
		this.processDefinitionId = processDefinitionId;
	}

	
}
