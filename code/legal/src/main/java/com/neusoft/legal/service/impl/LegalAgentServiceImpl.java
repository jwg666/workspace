/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */


package com.neusoft.legal.service.impl;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.neusoft.base.common.Pager;
import com.neusoft.base.model.DataGrid;

import com.neusoft.legal.dao.LegalAgentDao;
import com.neusoft.legal.domain.LegalAgent;
import com.neusoft.legal.query.LegalAgentQuery;
import com.neusoft.legal.service.LegalAgentService;
/**
 * 
 * @author jiawg-贾伟光
 *
 */
@Service("legalAgentService")
@Transactional
public class LegalAgentServiceImpl implements LegalAgentService{
	@Resource
	private LegalAgentDao legalAgentDao;
	

	@Override
	public DataGrid datagrid(LegalAgentQuery legalAgentQuery) {
		DataGrid j = new DataGrid();
		Pager<LegalAgent> pager  = legalAgentDao.findPage(legalAgentQuery);
		j.setRows(getQuerysFromEntitys(pager.getRecords()));
		j.setTotal(pager.getTotalRecords());
		return j;
	}

	private List<LegalAgentQuery> getQuerysFromEntitys(List<LegalAgent> legalAgents) {
		List<LegalAgentQuery> legalAgentQuerys = new ArrayList<LegalAgentQuery>();
		if (legalAgents != null && legalAgents.size() > 0) {
			for (LegalAgent tb : legalAgents) {
				LegalAgentQuery b = new LegalAgentQuery();
				BeanUtils.copyProperties(tb, b);
				legalAgentQuerys.add(b);
			}
		}
		return legalAgentQuerys;
	}

	


	@Override
	public Long add(LegalAgentQuery legalAgentQuery) {
		LegalAgent t = new LegalAgent();
		BeanUtils.copyProperties(legalAgentQuery, t);
		return legalAgentDao.save(t);
	}

	@Override
	public void update(LegalAgentQuery legalAgentQuery) {
		LegalAgent t = legalAgentDao.getById(legalAgentQuery.getId());
	    if(t != null) {
	    	BeanUtils.copyProperties(legalAgentQuery, t);
		}
	    legalAgentDao.update(t);
	}

	@Override
	public void delete(java.lang.Long[] ids) {
		if (ids != null) {
			for(java.lang.Long id : ids){
				LegalAgent t = legalAgentDao.getById(id);
				if (t != null) {
					legalAgentDao.delete(t);
				}
			}
		}
	}

	@Override
	public LegalAgent get(LegalAgentQuery legalAgentQuery) {
		return legalAgentDao.getById(legalAgentQuery.getId());
	}

	@Override
	public LegalAgent get(String id) {
		return legalAgentDao.getById(Long.parseLong(id));
	}

	
	@Override
	public List<LegalAgentQuery> listAll(LegalAgentQuery legalAgentQuery) {
	    List<LegalAgent> list = legalAgentDao.findList(legalAgentQuery);
		List<LegalAgentQuery> listQuery =getQuerysFromEntitys(list) ;
		return listQuery;
	}
	
	
}
