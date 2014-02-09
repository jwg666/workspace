package com.neusoft.activiti.service.impl;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.neusoft.activiti.dao.WfProcinstanceDao;
import com.neusoft.activiti.domain.WfProcinstance;
import com.neusoft.activiti.query.WfProcinstanceQuery;
import com.neusoft.activiti.service.WfProcinstanceService;
import com.neusoft.base.common.Pager;
import com.neusoft.base.common.ValidateUtil;
import com.neusoft.base.model.DataGrid;
@Service("wfProcinstanceService")
@Transactional
public class WfProcinstanceServiceImpl implements WfProcinstanceService{
	private Logger logger = LoggerFactory.getLogger(getClass());
	@Resource
	private WfProcinstanceDao wfProcinstanceDao;
	@Resource
	private RuntimeService runtimeService;
	@Resource
	private TaskService taskService;
	
	public void setWfProcinstanceDao(WfProcinstanceDao dao) {
		this.wfProcinstanceDao = dao;
	}

	@Override
	public DataGrid datagrid(WfProcinstanceQuery wfProcinstanceQuery) {
		DataGrid j = new DataGrid();
		Pager<WfProcinstance> pager  = find(wfProcinstanceQuery);
		j.setRows(getQuerysFromEntitys(pager.getRecords()));
		j.setTotal(pager.getTotalRecords());
		return j;
	}

	private List<WfProcinstanceQuery> getQuerysFromEntitys(List<WfProcinstance> wfProcinstances) {
		List<WfProcinstanceQuery> wfProcinstanceQuerys = new ArrayList<WfProcinstanceQuery>();
		if (wfProcinstances != null && wfProcinstances.size() > 0) {
			for (WfProcinstance tb : wfProcinstances) {
				WfProcinstanceQuery b = new WfProcinstanceQuery();
				BeanUtils.copyProperties(tb, b);
				wfProcinstanceQuerys.add(b);
			}
		}
		return wfProcinstanceQuerys;
	}

	private Pager<WfProcinstance> find(WfProcinstanceQuery wfProcinstanceQuery) {
		return  wfProcinstanceDao.findPage(wfProcinstanceQuery);
		
	}
	
	/**
	 * 
	 *作者：罗琦
	 * @param businFormId
	 * @return
	 */
	@Override
	public WfProcinstance findProidByBusid(Map map) {
		WfProcinstance wfProcinstance = wfProcinstanceDao.findProidByBusid(map);
		return wfProcinstance;
	}
	@Override
	public String findProcinstanceId(String businformId, String businformType,
			String processdefinitionKey, String status) {
		if(!ValidateUtil.isValid(businformId)){
			logger.error("businformId 不允许为空");
		}
		if(!ValidateUtil.isValid(businformType)){
			logger.error("businformType 不允许为空");
		}
		
		WfProcinstanceQuery wfProcinstanceQuery=new WfProcinstanceQuery(processdefinitionKey,businformId,businformType);
		wfProcinstanceQuery.setStatus(status);
		List<WfProcinstanceQuery> list=listAll(wfProcinstanceQuery);
		if(!ValidateUtil.isValid(list)){
			return null;
		}
		if(list.size()>1){
			logger.error("WfProcinstanceQuery find "+list.size()+" results,except only one");
		}
		return list.get(0).getProcessinstanceId();
	}
	@Override
	public WfProcinstance add(WfProcinstanceQuery wfProcinstanceQuery) {
		WfProcinstance t = new WfProcinstance();
		BeanUtils.copyProperties(wfProcinstanceQuery, t);
		wfProcinstanceDao.save(t);
		wfProcinstanceQuery.setRowId(t.getRowId());
		return t;
		
	}

	@Override
	public void update(WfProcinstanceQuery wfProcinstanceQuery) {
		WfProcinstance t = wfProcinstanceDao.getById(wfProcinstanceQuery.getRowId());
	    if(t != null) {
	    	BeanUtils.copyProperties(wfProcinstanceQuery, t);
		}
	    wfProcinstanceDao.update(t);
	}

	@Override
	public void delete(java.lang.String[] ids) {
		if (ids != null) {
			for(java.lang.String id : ids){
				WfProcinstance t = wfProcinstanceDao.getById(id);
				if (t != null) {
					wfProcinstanceDao.delete(t);
				}
			}
		}
	}

	@Override
	public WfProcinstance get(WfProcinstanceQuery wfProcinstanceQuery) {
		return wfProcinstanceDao.getById(wfProcinstanceQuery.getRowId());
	}

	@Override
	public WfProcinstance get(String id) {
		return wfProcinstanceDao.getById(id);
	}

	
	@Override
	public List<WfProcinstanceQuery> listAll(WfProcinstanceQuery wfProcinstanceQuery) {
	    List<WfProcinstance> list = wfProcinstanceDao.findList(wfProcinstanceQuery);
		List<WfProcinstanceQuery> listQuery =getQuerysFromEntitys(list) ;
		return listQuery;
	}

	@Override
	public ProcessInstance getTaskFromBusinId(String businformId,
			String businformType, String processdefinitionKey) {
		WfProcinstanceQuery procinstanceQuery = queryWfProcinstance(businformId, businformType, processdefinitionKey);
		if(procinstanceQuery!=null){
			String  processInstanceId=procinstanceQuery.getProcessinstanceId();
			ProcessInstance processInstance=runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
			return processInstance;
		}else{
			return null;
		}
	}

	private WfProcinstanceQuery queryWfProcinstance(String businformId,
			String businformType, String processdefinitionKey) {
		// 
		if(!ValidateUtil.isValid(businformId)){
			logger.error("businformId 不允许为空");
		}
		if(!ValidateUtil.isValid(businformType)){
			logger.error("businformType 不允许为空");
		}
		
		WfProcinstanceQuery wfProcinstanceQuery=new WfProcinstanceQuery(processdefinitionKey,businformId,businformType);
		List<WfProcinstanceQuery> list=listAll(wfProcinstanceQuery);
		if(!ValidateUtil.isValid(list)){
			return null;
		}
		if(list.size()>1){
			logger.error("WfProcinstanceQuery find "+list.size()+" results,except only one");
		}
		WfProcinstanceQuery procinstanceQuery=list.get(0);
		return procinstanceQuery;
	}

	@Override
	public Task getTaskFromBusinId(String businformId, String businformType,
			String processdefinitionKey, Long userId) {
		WfProcinstanceQuery procinstanceQuery = queryWfProcinstance(businformId, businformType, processdefinitionKey);
		String  processInstanceId=procinstanceQuery.getProcessinstanceId();
		List<Task> tasks = taskService.createTaskQuery().processInstanceId(processInstanceId).taskAssignee(userId.toString()).list();
		if(tasks.size() > 1) {
			logger.error("getTaskFromBusinId find "+tasks.size()+" results,except only one");
		}
		return tasks.get(0);
	}

	@Override
	public Task getTaskFromBusinId(String businformId, String businformType,
			String processdefinitionKey, Long userId,String taskDefinitionKey ) {
		// 
		WfProcinstanceQuery procinstanceQuery = 	queryWfProcinstance(businformId, businformType, processdefinitionKey);
		String  processInstanceId=procinstanceQuery.getProcessinstanceId();
		return taskService.createTaskQuery().processInstanceId(processInstanceId).taskDefinitionKey(taskDefinitionKey).taskAssignee(userId.toString()).singleResult();
	}
	@Override
	public Task getTaskByBusinId(String businformId, String businformType,
			String processdefinitionKey, String userCode,String taskDefinitionKey ) {
		WfProcinstanceQuery procinstanceQuery = 	queryWfProcinstance(businformId, businformType, processdefinitionKey);
		if(procinstanceQuery!=null){
		String  processInstanceId=procinstanceQuery.getProcessinstanceId();
			return taskService.createTaskQuery().processInstanceId(processInstanceId).taskDefinitionKey(taskDefinitionKey).singleResult();
		}else{
			return null;
		}
	}
	@Override
	public Task getGroupTaskFromBusinId(String businformId, String businformType,
			String processdefinitionKey, Long groupId,String taskDefinitionKey ) {
		// 
		WfProcinstanceQuery procinstanceQuery = 	queryWfProcinstance(businformId, businformType, processdefinitionKey);
		String  processInstanceId=procinstanceQuery.getProcessinstanceId();
		return taskService.createTaskQuery().processInstanceId(processInstanceId).taskDefinitionKey(taskDefinitionKey).taskCandidateGroup(groupId.toString()).singleResult();
	}
	
	
}
