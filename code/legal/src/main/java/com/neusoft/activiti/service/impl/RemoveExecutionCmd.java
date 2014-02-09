package com.neusoft.activiti.service.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.activiti.engine.HistoryService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.history.HistoricActivityInstance;
import org.activiti.engine.impl.RepositoryServiceImpl;
import org.activiti.engine.impl.context.Context;
import org.activiti.engine.impl.interceptor.Command;
import org.activiti.engine.impl.interceptor.CommandContext;
import org.activiti.engine.impl.persistence.entity.ExecutionEntity;
import org.activiti.engine.impl.persistence.entity.HistoricActivityInstanceEntity;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.persistence.entity.TaskEntity;
import org.activiti.engine.impl.pvm.PvmTransition;
import org.activiti.engine.impl.pvm.delegate.ActivityExecution;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.runtime.Execution;
import org.activiti.engine.task.Task;
import org.springframework.beans.factory.annotation.Autowired;

import com.neusoft.activiti.dao.ActivitiDao;
import com.neusoft.base.common.SpringApplicationContextHolder;
import com.neusoft.base.common.ValidateUtil;

/**
 * 将流程重新回归到开始节点
 * 
 * @author 秦焰培
 * 
 */
public class RemoveExecutionCmd implements Command<Void>, Serializable {

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

	private String processInstanceId;

	public RemoveExecutionCmd(String processInstanceId) {
		super();
		this.processInstanceId = processInstanceId;
		SpringApplicationContextHolder.getApplicationContext()
				.getAutowireCapableBeanFactory().autowireBean(this);
	}

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	public Void execute(CommandContext commandContext) {
//		Context.setCommandContext(commandContext);

		// 获取所有的线程
		List<Execution> executionList = runtimeService.createExecutionQuery()
				.processInstanceId(processInstanceId).list();
		List<ActivityExecution> inExecutionEntitieList = new ArrayList<ActivityExecution>();
		ExecutionEntity rootExecutionEntity = null;
		/**
		 * 遍历线程，找到root线程和 其他的子线程
		 */
		for (Execution execution : executionList) {
			ExecutionEntity executionEntity = (ExecutionEntity) execution;
			if (executionEntity.getParentId() != null) {
				inExecutionEntitieList.add(executionEntity);
			} else if (executionEntity.getParentId() == null
					&& executionEntity.isScope()) {
				rootExecutionEntity = executionEntity;
			}
		}
		/**
		 * 将当前活动节点的历史记录清除
		 */
		List<HistoricActivityInstance> historicActivityInstanceList = historyService
				.createHistoricActivityInstanceQuery()
				.processInstanceId(processInstanceId).unfinished().list();
		for (HistoricActivityInstance historicActivityInstance : historicActivityInstanceList) {
			HistoricActivityInstanceEntity historicActivityInstanceEntity = (HistoricActivityInstanceEntity) historicActivityInstance;
			activitiDao.deleteHistoricActivityInstance(historicActivityInstanceEntity);
		}
		/**
		 * 删除当前的任务历史记录
		 * 
		 */
		List<Task> taskList = taskService.createTaskQuery()
				.processInstanceId(processInstanceId).list();
		for (Task task : taskList) {
			historyService.deleteHistoricTaskInstance(task.getId());
		}
		/**
		 * 找到流程的开始节点，把主线程回到开始节点，其他线程删除
		 */
		ProcessDefinitionEntity processDefinition = (ProcessDefinitionEntity) ((RepositoryServiceImpl) repositoryService)
				.getDeployedProcessDefinition(rootExecutionEntity
						.getProcessDefinitionId());
		List<ActivityImpl> activityImplList= processDefinition.getActivities();
		ActivityImpl startEvent=null;
		for(ActivityImpl activityImpl:activityImplList){
			if (activityImpl.getProperty("type").equals("startEvent")&&activityImpl.getParentActivity()==null) {
				startEvent=activityImpl;
			}
		}
		
		List<PvmTransition> pvmTransitionList = startEvent.getOutgoingTransitions();
		List<ExecutionEntity> ExecutionEntityList=new ArrayList<ExecutionEntity>();
		for(ActivityExecution activityExecution:inExecutionEntitieList){
			ExecutionEntity executionEntity=(ExecutionEntity)activityExecution;
			ExecutionEntityList.add(executionEntity);
		}
		List<ExecutionEntity> delExecutionOrder=new ArrayList<ExecutionEntity>();
		/**
		 * 递归删除子流程的顺序
		 */
		deleteExecution(ExecutionEntityList,delExecutionOrder);
		/*依次调用删除*/
		for(ExecutionEntity executionEntity:delExecutionOrder){
			executionEntity.remove();
		}
		
		rootExecutionEntity.setActive(true);
		rootExecutionEntity.setConcurrent(false);
		/* 查找跟流程对应的Task 删除 */
		List<Task> needDelTaskList = taskService.createTaskQuery()
				.executionId(rootExecutionEntity.getId()).list();
		for (Task task : needDelTaskList) {
			String reason = "rollBack";
			TaskEntity taskEntity=(TaskEntity)task;
			Context.getCommandContext().getTaskEntityManager()
					.deleteTask(taskEntity, reason, true);
			Context.getCommandContext().getHistoricTaskInstanceEntityManager()
					.deleteHistoricTaskInstanceById(task.getId());

			// taskService.deleteTask(task.getId(), true);
		}
		rootExecutionEntity.take(pvmTransitionList.get(0));
		Context.getCommandContext().getDbSqlSession()
				.update(rootExecutionEntity);
		Context.getCommandContext().getDbSqlSession().flush();
		return null;
	}
	/**
	 * 递归删除子流程
	 * @param executionList
	 */
	private void deleteExecution(List<ExecutionEntity> executionList,List<ExecutionEntity> delExecutionIdOrder){
		for (ActivityExecution activityExecution : executionList) {
			ExecutionEntity executionEntity = (ExecutionEntity) activityExecution;
		   List<ExecutionEntity> executionEntityList=executionEntity.getExecutions();
		   if(ValidateUtil.isValid(executionEntityList)){
			   deleteExecution(executionEntityList,delExecutionIdOrder);
		   }
		   delExecutionIdOrder.add(executionEntity);
			//executionEntity.remove();
		}
	}
	

}
