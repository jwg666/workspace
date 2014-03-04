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
	@Resource
	private LegalCaseDao legalCaseDao;
	

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
	
	
}
