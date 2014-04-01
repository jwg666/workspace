/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */


package com.neusoft.legal.service.impl;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.activiti.engine.TaskService;
import org.activiti.engine.task.Task;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.neusoft.activiti.dao.WfProcinstanceDao;
import com.neusoft.activiti.domain.WfProcinstance;
import com.neusoft.activiti.query.WfProcinstanceQuery;
import com.neusoft.base.common.Pager;
import com.neusoft.base.model.DataGrid;
import com.neusoft.legal.dao.LegalApproveDao;
import com.neusoft.legal.domain.LegalApprove;
import com.neusoft.legal.domain.LegalCase;
import com.neusoft.legal.query.LegalApproveQuery;
import com.neusoft.legal.query.LegalCaseQuery;
import com.neusoft.legal.service.LegalApproveService;
/**
 * 
 * @author jiawg-贾伟光
 *
 */
@Service("legalApproveService")
@Transactional
public class LegalApproveServiceImpl implements LegalApproveService{
	@Resource
	private LegalApproveDao legalApproveDao;
	@Resource
	private TaskService taskService;
	@Resource
	private WfProcinstanceDao wfProcinstanceDao;
	@Override
	public DataGrid datagrid(LegalApproveQuery legalApproveQuery) {
		DataGrid j = new DataGrid();
		Pager<LegalApprove> pager  = legalApproveDao.findPage(legalApproveQuery);
		j.setRows(getQuerysFromEntitys(pager.getRecords()));
		j.setTotal(pager.getTotalRecords());
		return j;
	}
	@Override
	public LegalApproveQuery getQuery(Long id) {
		LegalApprove legalApprove = legalApproveDao.getById(id);
		LegalApproveQuery query = new LegalApproveQuery();
		BeanUtils.copyProperties(legalApprove, query);
		return query;
	}
	private List<LegalApproveQuery> getQuerysFromEntitys(List<LegalApprove> legalApproves) {
		List<LegalApproveQuery> legalApproveQuerys = new ArrayList<LegalApproveQuery>();
		if (legalApproves != null && legalApproves.size() > 0) {
			for (LegalApprove tb : legalApproves) {
				LegalApproveQuery b = new LegalApproveQuery();
				BeanUtils.copyProperties(tb, b);
				legalApproveQuerys.add(b);
			}
		}
		return legalApproveQuerys;
	}

	


	@Override
	public Long add(LegalApproveQuery legalApproveQuery) {
		WfProcinstanceQuery wfQuery = new WfProcinstanceQuery();
		wfQuery.setBusinformId(legalApproveQuery.getCaseId().toString());
		WfProcinstance wf =  wfProcinstanceDao.finUnique(wfQuery);
		String processInstanceId = wf.getProcessinstanceId();
		Task task = taskService.createTaskQuery().taskDefinitionKey("caseApprove").processInstanceId(processInstanceId).singleResult();
		taskService.claim(task.getId(), legalApproveQuery.getApproveId().toString());
		taskService.complete(task.getId());
		LegalApprove t = new LegalApprove();
		BeanUtils.copyProperties(legalApproveQuery, t);
		return legalApproveDao.save(t);
	}

	@Override
	public void update(LegalApproveQuery legalApproveQuery) {
		LegalApprove t = legalApproveDao.getById(legalApproveQuery.getId());
	    if(t != null) {
	    	BeanUtils.copyProperties(legalApproveQuery, t);
		}
	    legalApproveDao.update(t);
	}

	@Override
	public void delete(java.lang.Long[] ids) {
		if (ids != null) {
			for(java.lang.Long id : ids){
				LegalApprove t = legalApproveDao.getById(id);
				if (t != null) {
					legalApproveDao.delete(t);
				}
			}
		}
	}

	@Override
	public LegalApprove get(LegalApproveQuery legalApproveQuery) {
		return legalApproveDao.getById(legalApproveQuery.getId());
	}

	@Override
	public LegalApprove get(String id) {
		return legalApproveDao.getById(Long.parseLong(id));
	}

	
	@Override
	public List<LegalApproveQuery> listAll(LegalApproveQuery legalApproveQuery) {
	    List<LegalApprove> list = legalApproveDao.findList(legalApproveQuery);
		List<LegalApproveQuery> listQuery =getQuerysFromEntitys(list) ;
		return listQuery;
	}

	@Override
	public List<LegalApproveQuery> getQueryList(Long caseId) {
		// TODO Auto-generated method stub
		return null;
	}
	
	
}
