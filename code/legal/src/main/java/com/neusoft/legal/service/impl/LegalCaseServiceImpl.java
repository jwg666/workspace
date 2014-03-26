/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */


package com.neusoft.legal.service.impl;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.task.Task;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.neusoft.activiti.dao.WfProcinstanceDao;
import com.neusoft.activiti.domain.WfProcinstance;
import com.neusoft.activiti.query.WfProcinstanceQuery;
import com.neusoft.base.common.LoginContextHolder;
import com.neusoft.base.common.Pager;
import com.neusoft.base.model.DataGrid;
import com.neusoft.legal.dao.LegalCaseDao;
import com.neusoft.legal.domain.LegalCase;
import com.neusoft.legal.query.LegalCaseQuery;
import com.neusoft.legal.service.LegalCaseService;
/**
 * 
 * @author jiawg-贾伟光
 *
 */
@Service("legalCaseService")
@Transactional
public class LegalCaseServiceImpl implements LegalCaseService{
	private Logger logger = LoggerFactory.getLogger(getClass());
	@Resource
	private LegalCaseDao legalCaseDao;
	@Resource
	private RuntimeService runtimeService;
	@Resource
	private TaskService taskService;
	@Resource
	private WfProcinstanceDao wfProcinstanceDao;
	@Override
	public DataGrid datagrid(LegalCaseQuery legalCaseQuery) {
		DataGrid j = new DataGrid();
		Pager<LegalCase> pager  = legalCaseDao.findPage(legalCaseQuery);
		j.setRows(getQuerysFromEntitys(pager.getRecords()));
		j.setTotal(pager.getTotalRecords());
		return j;
	}

	private List<LegalCaseQuery> getQuerysFromEntitys(List<LegalCase> legalCases) {
		List<LegalCaseQuery> legalCaseQuerys = new ArrayList<LegalCaseQuery>();
		if (legalCases != null && legalCases.size() > 0) {
			for (LegalCase tb : legalCases) {
				LegalCaseQuery b = new LegalCaseQuery();
				BeanUtils.copyProperties(tb, b);
				legalCaseQuerys.add(b);
			}
		}
		return legalCaseQuerys;
	}

	


	@Override
	public Long add(LegalCaseQuery legalCaseQuery) {
		LegalCase t = new LegalCase();
		BeanUtils.copyProperties(legalCaseQuery, t);
		return legalCaseDao.save(t);
	}

	@Override
	public void update(LegalCaseQuery legalCaseQuery) {
		LegalCase t = legalCaseDao.getById(legalCaseQuery.getId());
	    if(t != null) {
	    	BeanUtils.copyProperties(legalCaseQuery, t);
		}
	    legalCaseDao.update(t);
	}

	@Override
	public void delete(java.lang.Long[] ids) {
		if (ids != null) {
			for(java.lang.Long id : ids){
				LegalCase t = legalCaseDao.getById(id);
				if (t != null) {
					legalCaseDao.delete(t);
				}
			}
		}
	}

	@Override
	public LegalCase get(LegalCaseQuery legalCaseQuery) {
		return legalCaseDao.getById(legalCaseQuery.getId());
	}

	@Override
	public LegalCase get(String id) {
		return legalCaseDao.getById(Long.parseLong(id));
	}

	
	@Override
	public List<LegalCaseQuery> listAll(LegalCaseQuery legalCaseQuery) {
	    List<LegalCase> list = legalCaseDao.findList(legalCaseQuery);
		List<LegalCaseQuery> listQuery =getQuerysFromEntitys(list) ;
		return listQuery;
	}
	
    /**
     * @param 添加信息并启动工作流
     */
    public void addAndStart(LegalCaseQuery legalCaseQuery){
    	legalCaseQuery.setCreateTime(new Date());
		Long id =add(legalCaseQuery);
		legalCaseQuery.setId(id);
		if(null!=id&&!id.equals(0)){
			//FIXME 启动工作流
			startWorkFlow(legalCaseQuery);
			logger.debug("工作流启动成功");
		}
    }
	@Override
	public void startWorkFlow(LegalCaseQuery legalCaseQuery) {
		Map<String, Object> variables = new HashMap<String, Object>();
		variables.put("businformId", legalCaseQuery.getId().toString());
		variables.put("businformType", "LE_LEGAL_CASE");
		runtimeService.startProcessInstanceByKey("LegalAidProcess", variables);		
	}
	
	@Override
	public DataGrid taskgrid(LegalCaseQuery legalCaseQuery) {
		List<Task> taskList = taskService.createTaskQuery().taskDefinitionKey(legalCaseQuery.getDefinitionKey()).list();
		WfProcinstance wf;
		WfProcinstanceQuery wfQuery = new WfProcinstanceQuery();
		List<Long> idList = new ArrayList<Long>();
		for (Task task : taskList) {
			wfQuery.setProcessinstanceId(task.getProcessInstanceId());
			wf = wfProcinstanceDao.finUnique(wfQuery);
			idList.add(new Long(wf.getBusinformId()));
		}
		legalCaseQuery.setIdList(idList);
		DataGrid j = new DataGrid();
		Pager<LegalCase> pager  = legalCaseDao.findPage(legalCaseQuery);
		j.setRows(getQuerysFromEntitys(pager.getRecords()));
		j.setTotal(pager.getTotalRecords());
		return j;
	}
	@Override
	public LegalCaseQuery getQuery(Long id) {
		LegalCase legalCase = legalCaseDao.getById(id);
		LegalCaseQuery query = new LegalCaseQuery();
		BeanUtils.copyProperties(legalCase, query);
		return query;
	}
	@Override
	public String completTask(LegalCaseQuery legalCaseQuery) {
		WfProcinstanceQuery wfQuery = new WfProcinstanceQuery();
		wfQuery.setBusinformId(legalCaseQuery.getId().toString());
		WfProcinstance wf =  wfProcinstanceDao.finUnique(wfQuery);
		String processInstanceId = wf.getProcessinstanceId();
		Task task = taskService.createTaskQuery().taskDefinitionKey(legalCaseQuery.getDefinitionKey()).processInstanceId(processInstanceId).singleResult();
		Long userId = LoginContextHolder.get().getUserId();
		//FIXME 获取legalOfficer
		taskService.setVariable(task.getId(), "LegalOfficer", "1");
		taskService.claim(task.getId(), userId.toString());
		taskService.complete(task.getId());
		if("accessCase".equals(legalCaseQuery.getDefinitionKey())){
			task = taskService.createTaskQuery().taskDefinitionKey("publishResult").processInstanceId(processInstanceId).singleResult();
			taskService.claim(task.getId(), userId.toString());
			taskService.complete(task.getId());
		}
		if("asignLegalOffice".equals(legalCaseQuery.getDefinitionKey())){
			LegalCase legalCase = legalCaseDao.getById(legalCaseQuery.getId());
			legalCase.setLegalId(legalCaseQuery.getLegalId());
			legalCaseDao.update(legalCase);
		}
		
		return null;
	}
}
