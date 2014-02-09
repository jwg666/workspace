package com.neusoft.activiti.service.impl;

import java.io.Serializable;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.activiti.engine.ActivitiException;
import org.activiti.engine.IdentityService;
import org.activiti.engine.TaskService;
import org.activiti.engine.delegate.DelegateTask;
import org.activiti.engine.delegate.TaskListener;
import org.activiti.engine.impl.context.Context;
import org.activiti.engine.impl.delegate.TaskListenerInvocation;
import org.activiti.engine.impl.interceptor.Command;
import org.activiti.engine.impl.interceptor.CommandContext;
import org.activiti.engine.impl.persistence.entity.ExecutionEntity;
import org.activiti.engine.impl.persistence.entity.TaskEntity;
import org.activiti.engine.task.Task;

import com.neusoft.activiti.util.TaskUtil;
import com.neusoft.base.common.SpringApplicationContextHolder;
import com.neusoft.base.common.ValidateUtil;

/**
 * 发送催办
 * @author 秦焰培
 *
 */
public class SendReminderCmd implements Command<List<Task>>,Serializable {

	/*催办的任务*/
	private Task task;
	/*发送的催办人*/
	private String senderEmpCode;

	@Resource
	private TaskService taskService;
	@Resource
	protected IdentityService identityService;

	public SendReminderCmd(Task task, String senderEmpCode) {
		super();
		this.task = task;
		this.senderEmpCode = senderEmpCode;
		SpringApplicationContextHolder.getApplicationContext().getAutowireCapableBeanFactory().autowireBean(this);
	}

	/**
	 * 
	 */
	private static final long serialVersionUID = -5746602646620353982L;

	@Override
	public List<Task> execute(CommandContext commandContext) {
		// 
		TaskServiceImpl taskServiceImpl=(TaskServiceImpl)taskService;
		TaskEntity  parentTaskEntity=(TaskEntity)task;
		Map<String, String> docuMap = null;
		String taskId=parentTaskEntity.getId();
		String documentation = parentTaskEntity.getDescription();
		if (ValidateUtil.isValid(documentation)) {
			docuMap = TaskUtil.getMapFromDocument(documentation, taskId);
		} else {
			docuMap = new HashMap<String, String>();
			// 如果当前节点没有配置documentation 那么从数据库读取对应的documentation
//			ActSetQuery actSetQuery = new ActSetQuery();
//			actSetQuery.setActId(parentTaskEntity.getTaskDefinitionKey());
//			List<ActSetQuery> actSetQueryList = actSetService.listAll(actSetQuery);
//			if (actSetQueryList != null && actSetQueryList.size() == 1) {
//				ActSetQuery actSet = actSetQueryList.get(0);
//				documentation = actSet.getWorkflowDesc();
//				parentTaskEntity.setDescription(documentation);
//				docuMap = TaskUtil.getMapFromDocument(documentation, taskId);
//				// taskService.saveTask(taskEntity);
//			}
		}

		Set<String>  empCodeSet=TaskUtil.getEmpCodeInfo(parentTaskEntity, docuMap, taskId);
		for(String empCode:empCodeSet){
			TaskEntity taskEntity=(TaskEntity)taskServiceImpl.newTask();
			taskEntity.setParentTaskIdWithoutCascade(parentTaskEntity.getId());
			taskEntity.setNameWithoutCascade(parentTaskEntity.getName()+"<催办>");
			taskEntity.setCreateTime(new Date());
			taskEntity.setDescriptionWithoutCascade(parentTaskEntity.getDescription());
			taskEntity.setAssigneeWithoutCascade(empCode);
			taskEntity.setOwnerWithoutCascade(senderEmpCode);
			taskEntity.setDueDateWithoutCascade(parentTaskEntity.getDueDate());
			taskServiceImpl.saveTask(taskEntity);
			/**
			 * 任务的催办不再是共享一个催办任务，而是有为所有能看到这个项目的人发催办
			 */
			/*List<IdentityLinkEntity>  identityLinkEntityList=parentTaskEntity.getIdentityLinks();
		  for(IdentityLinkEntity identityLinkEntity:identityLinkEntityList){
			  taskEntity.addIdentityLink(identityLinkEntity.getUserId(), identityLinkEntity.getGroupId(), identityLinkEntity.getType());
		  }*/
			/*触发create事件*/
			taskEntity.setTaskDefinition(parentTaskEntity.getTaskDefinition());
			List<TaskListener> taskEventListeners =parentTaskEntity.getTaskDefinition().getTaskListener(TaskListener.EVENTNAME_CREATE);
			if (taskEventListeners != null) {
				for (TaskListener taskListener : taskEventListeners) {
					ExecutionEntity execution = parentTaskEntity.getExecution();
					taskEntity.setExecution(execution);
					if (execution != null) {
						taskEntity.setEventName(TaskListener.EVENTNAME_CREATE);
					}
					try {
						Context.getProcessEngineConfiguration()
						.getDelegateInterceptor()
						.handleInvocation(new TaskListenerInvocation(taskListener, (DelegateTask)taskEntity));
					}catch (Exception e) {
						throw new ActivitiException("Exception while invoking TaskListener: "+e.getMessage(), e);
					}
				}
			}
			taskEntity.setTaskDefinitionKeyWithoutCascade(null); 
		}
		return null;
		//return taskEntity;
	}

}
