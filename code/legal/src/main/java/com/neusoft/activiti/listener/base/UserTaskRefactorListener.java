package com.neusoft.activiti.listener.base;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import javax.annotation.Resource;

import org.activiti.engine.IdentityService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.delegate.DelegateTask;
import org.activiti.engine.delegate.TaskListener;
import org.activiti.engine.identity.User;
import org.activiti.engine.impl.context.Context;
import org.activiti.engine.impl.persistence.entity.TaskEntity;
import org.activiti.engine.impl.persistence.entity.TaskEntityManager;
import org.activiti.engine.task.IdentityLink;
import org.activiti.engine.task.Task;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.neusoft.activiti.util.Constant;
import com.neusoft.activiti.util.TaskUtil;
import com.neusoft.base.common.SpringApplicationContextHolder;
import com.neusoft.base.common.ValidateUtil;
import com.neusoft.portal.dwr.BaseMessageRunable;
import com.neusoft.portal.dwr.BaseRemoveMessageRunable;
import com.neusoft.security.service.UserService;

public abstract class UserTaskRefactorListener extends ActivityCommonBehavior implements TaskListener {

	@Resource
	private IdentityService identityService;
	@Resource
	private TaskService taskService;
	@Resource
	private UserService userService;
//	@Resource
//	private ActSetService actSetService;

	/**
	 * 
	 */
	private static final long serialVersionUID = 265996712262081079L;
	protected Logger logger = LoggerFactory.getLogger(getClass());

	@Override
	public void notify(DelegateTask delegateTask) {
		TaskEntity taskEntity = (TaskEntity) delegateTask;
		String eventName = taskEntity.getEventName();
		Map<String, Object> variables=taskService.getVariables(taskEntity.getId());
		//Map<String, Object> variables = taskEntity.getVariables();
		// 如果是分配事件
		if (TaskListener.EVENTNAME_ASSIGNMENT.equals(eventName)) {
			assignment(taskEntity, variables);
			// 如果事件是任务创建
		} else if (TaskListener.EVENTNAME_CREATE.equals(eventName)) {
			creat(taskEntity, variables);
			// 如果是事件是完成任务
		} else if (TaskListener.EVENTNAME_COMPLETE.equals(eventName)) {
			complete(taskEntity, variables);
		}
	}

	/**
	 * 封装创建事件,统一织入公共操作
	 * 
	 * @param taskEntity
	 * @param variables
	 */
	protected void creat(TaskEntity taskEntity, Map<String, Object> variables) {
		afterCreat(taskEntity, variables);
		commonCreatEvent(taskEntity, variables);
	}

	/**
	 * 封装分配事件,统一织入公共操作
	 * 
	 * @param taskEntity
	 * @param variables
	 */
	protected void assignment(TaskEntity taskEntity, Map<String, Object> variables) {
		afterAssignment(taskEntity, variables);
		commonAssignmentEvent(taskEntity, variables);

	}

	/**
	 * 完成任务事件，统一织入公共操作
	 * 
	 * @param taskEntity
	 * @param variables
	 */
	protected void complete(TaskEntity taskEntity, Map<String, Object> variables) {
		afterComplete(taskEntity, variables);
		commonCompleteEvent(taskEntity, variables);
	}

	/**
	 * 任务创建之后触发的公共事件
	 * 
	 * @param taskEntity
	 * @param variables
	 */
	@SuppressWarnings("unchecked")
	protected void commonCreatEvent(TaskEntity taskEntity, Map<String, Object> variables) {
		/*如果该节点不需要发送短信 则直接跳过*/
		List<String> notSendMessageIds = (List<String>) variables.get(Constant.NOT_SEND_MESSAGE_IDS);
		if (ValidateUtil.isValid(notSendMessageIds)) {
			for (String id : notSendMessageIds) {
				if (id.equals(taskEntity.getTaskDefinitionKey())) {
					return;
				}
			}
		}
		/**
		 * 计算要发消息的empCode
		 */
		Set<String> empCodeSet = null;
		String parentTaskId = taskEntity.getParentTaskId();
		String documentation = taskEntity.getDescription();
		Map<String, String> docuMap = null;
		String taskId;
		if (ValidateUtil.isValid(parentTaskId)) {
			taskId = parentTaskId;
		} else {
			taskId = taskEntity.getId();
		}
		if (ValidateUtil.isValid(documentation)) {
			docuMap = TaskUtil.getMapFromDocument(documentation, taskId);
		} else {
			docuMap = new HashMap<String, String>();
			// 如果当前节点没有配置documentation 那么从数据库读取对应的documentation
//				ActSetQuery actSetQuery = new ActSetQuery();
//				actSetQuery.setActId(taskEntity.getTaskDefinitionKey());
//				List<ActSetQuery> actSetQueryList = actSetService.listAll(actSetQuery);
//				if (actSetQueryList != null && actSetQueryList.size() == 1) {
//					ActSetQuery actSet = actSetQueryList.get(0);
//					documentation = actSet.getWorkflowDesc();
//					taskEntity.setDescription(documentation);
//					docuMap = TaskUtil.getMapFromDocument(documentation, taskId);
//					// taskService.saveTask(taskEntity);
//				}
		}
		empCodeSet=TaskUtil.getEmpCodeInfo(taskEntity, docuMap, taskId);
		if (ValidateUtil.isValid(empCodeSet)) {
			String title;
			if (ValidateUtil.isValid(parentTaskId)) {
				title = "你有一条新催办，请及时办理";
			} else {
				title = "你有一条新待办，请及时查收";
			}
			String content = "订单号为：" + taskService.getVariable(taskId, "businformId");
			if (ValidateUtil.isValid(docuMap.get("title"))) {
				if (ValidateUtil.isValid(parentTaskId)) {
					title = "关于【" + docuMap.get("title") + "】的催办，请及时办理";
				} else {
					title = "关于【" + docuMap.get("title") + "】的待办，请及时查收";
				}
			}
			if (ValidateUtil.isValid(docuMap.get("url"))) {
				title = "<a href='javascript:void(0)' onclick=\"taskDetail('" + docuMap.get("title") + "','"
						+ docuMap.get("url") + "')\">" + title + "</a>";
			}
			Map<String, Object> message = new HashMap<String, Object>();
			if (ValidateUtil.isValid(parentTaskId)) {
				message.put("type", "【催办】");
			} else {
				message.put("type", "【待办】");
			}
			message.put("title", title);
			message.put("content", content);
			message.put("nodeUrl", docuMap.get("url"));
			message.put("nodeTitle", docuMap.get("title"));
			message.put("id", taskEntity.getId());
			List<Long> userIdList = userService.getUserIdsByEmpCodes(new ArrayList<String>(empCodeSet));
			new BaseMessageRunable(userIdList, message).execute();
		}
	}

	protected void getEmpCodeInfo(TaskEntity taskEntity, Set<String> empCodeSet, String documentation,
			Map<String, String> docuMap, String taskId) {
	

		if (ValidateUtil.isValid(taskEntity.getAssignee())) {
			empCodeSet.add(taskEntity.getAssignee());
		} else {
			List<IdentityLink> identityLinks = taskService.getIdentityLinksForTask(taskId);
			for (IdentityLink identityLink : identityLinks) {
				String groupId = identityLink.getGroupId();
				if (ValidateUtil.isValid(groupId)) {
					List<User> userList = identityService.createUserQuery().memberOfGroup(groupId).list();
					for (User user : userList) {
						empCodeSet.add(user.getId());
					}

				}
			}
//			QueryManager queryManager = Factory.getQueryManager(Ralasafe.appName);
//			String value = docuMap.get("queryId");
//			if (ValidateUtil.isValid(value)) {
//				// 找到数据分片的queryId
//				Integer queryId = Integer.parseInt(value);
//				Query query = queryManager.getQuery(queryId);
//				if (query != null) {
//					Map context = new HashMap();
//					Object businformId = taskService.getVariable(taskId, "businformId");
//					context.put("businformId", businformId);
//					Collection empCodeCollection = query.execute(RalasafeUtil.getUser(), context).getData();
//					if (ValidateUtil.isValid(empCodeCollection)) {
//						// 取交集
//						List<String> empList = new ArrayList<String>();
//						for (Object o : empCodeCollection) {
//							if (o instanceof com.haier.hrois.security.domain.User) {
//								com.haier.hrois.security.domain.User user = (com.haier.hrois.security.domain.User) o;
//								empList.add(user.getEmpCode());
//							} else if (o instanceof org.ralasafe.db.MapStorgeObject) {
//								org.ralasafe.db.MapStorgeObject mapStorgeObject = (org.ralasafe.db.MapStorgeObject) o;
//								empList.add(mapStorgeObject.get("employeeCode").toString());
//							}
//						}
//						empCodeSet.retainAll(empList);
//					}
//				}
//
//			}

		}
	}

	/**
	 * 任务分配之后触发的公共事件
	 * 
	 * @param taskEntity
	 * @param variables
	 */
	protected void commonAssignmentEvent(TaskEntity taskEntity, Map<String, Object> variables) {
		/*把子任务的分配人 也进行重新分配*/
		TaskEntityManager taskEntityManager = Context.getCommandContext().getTaskEntityManager();
		List<Task> subTaskList = taskEntityManager.findTasksByParentTaskId(taskEntity.getId());
		if(ValidateUtil.isValid(subTaskList)){
			for(Task task:subTaskList){
				taskService.setAssignee(task.getId(), taskEntity.getAssignee());
				//taskService.claim(task.getId(), taskEntity.getAssignee());
			}
		}
	}

	/**
	 * 任务完成之后触发的公共事件
	 * 
	 * @param taskEntity
	 * @param variables
	 */
	protected void commonCompleteEvent(TaskEntity taskEntity, Map<String, Object> variables) {
		
		TaskEntityManager taskEntityManager = Context.getCommandContext().getTaskEntityManager();
		Set<String> empCodeSet = new HashSet<String>();
		String documentation = taskEntity.getDescription();
		Map<String, String> docuMap = null;
		String taskId = taskEntity.getId();
		List<Task> subTaskList = taskEntityManager.findTasksByParentTaskId(taskEntity.getId());
		List<String> taskIdList = new ArrayList<String>();
		taskIdList.add(taskId);
		if (ValidateUtil.isValid(subTaskList)) {
			for (Task task : subTaskList) {
				taskIdList.add(task.getId());
			}
		}
		if (ValidateUtil.isValid(documentation)) {
			docuMap = TaskUtil.getMapFromDocument(documentation, taskId);
		} else {
			docuMap = new HashMap<String, String>();
		}
		getEmpCodeInfo(taskEntity, empCodeSet, documentation, docuMap, taskId);
		if (ValidateUtil.isValid(empCodeSet)) {
			empCodeSet.add("admin");
			List<Long> userIdList = userService.getUserIdsByEmpCodes(new ArrayList<String>(empCodeSet));
			new BaseRemoveMessageRunable(userIdList, taskIdList).execute();
		}
		
		Collection<String> allRedoNodeIds = (Collection<String>)variables.get(Constant.ALL_RODO_NODE_IDS);
		if(ValidateUtil.isValid(allRedoNodeIds)){
			String  activityId=taskEntity.getTaskDefinitionKey();
			if(allRedoNodeIds.contains(activityId)){
				Collection<String> hasRedoNodeIds = (Collection<String>)variables.get(Constant.HAS_RODO_NODE_IDS);
				if(!ValidateUtil.isValid(hasRedoNodeIds)){
					hasRedoNodeIds=new TreeSet<String>();
				}
				hasRedoNodeIds.add(activityId);
				RuntimeService runtimeService=SpringApplicationContextHolder.getBean("runtimeService");
				runtimeService.setVariable(taskEntity.getProcessInstanceId(), Constant.HAS_RODO_NODE_IDS, hasRedoNodeIds);
			}
		}
	}

	/**
	 * 当Task被创建的时候触发
	 * 
	 * @param taskEntity
	 *            任务实体
	 * @param variables
	 *            流程变量
	 */
	protected abstract void afterCreat(TaskEntity taskEntity, Map<String, Object> variables);

	/**
	 * 当Task被分配 时触发
	 * 
	 * @param taskEntity
	 * @param variables
	 */
	protected abstract void afterAssignment(TaskEntity taskEntity, Map<String, Object> variables);

	/**
	 * Task任务完成 后处理
	 * 
	 * @param taskEntity
	 * @param variables
	 */
	protected abstract void afterComplete(TaskEntity taskEntity, Map<String, Object> variables);

}
