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
import com.neusoft.legal.dao.LegalApplicantDao;
import com.neusoft.legal.domain.LegalApplicant;
import com.neusoft.legal.query.LegalApplicantQuery;
import com.neusoft.legal.service.LegalApplicantService;
/**
 * 
 * @author jiawg-贾伟光
 *
 */
@Service("legalApplicantService")
@Transactional
public class LegalApplicantServiceImpl implements LegalApplicantService{
	@Resource
	private LegalApplicantDao legalApplicantDao;
	

	@Override
	public DataGrid datagrid(LegalApplicantQuery legalApplicantQuery) {
		DataGrid j = new DataGrid();
		Pager<LegalApplicant> pager  = legalApplicantDao.findPage(legalApplicantQuery);
		j.setRows(getQuerysFromEntitys(pager.getRecords()));
		j.setTotal(pager.getTotalRecords());
		return j;
	}

	private List<LegalApplicantQuery> getQuerysFromEntitys(List<LegalApplicant> legalApplicants) {
		List<LegalApplicantQuery> legalApplicantQuerys = new ArrayList<LegalApplicantQuery>();
		if (legalApplicants != null && legalApplicants.size() > 0) {
			for (LegalApplicant tb : legalApplicants) {
				LegalApplicantQuery b = new LegalApplicantQuery();
				BeanUtils.copyProperties(tb, b);
				legalApplicantQuerys.add(b);
			}
		}
		return legalApplicantQuerys;
	}

	


	@Override
	public void add(LegalApplicantQuery legalApplicantQuery) {
		LegalApplicant t = new LegalApplicant();
		BeanUtils.copyProperties(legalApplicantQuery, t);
		legalApplicantDao.save(t);
	}

	@Override
	public void update(LegalApplicantQuery legalApplicantQuery) {
		LegalApplicant t = legalApplicantDao.getById(legalApplicantQuery.getId());
	    if(t != null) {
	    	BeanUtils.copyProperties(legalApplicantQuery, t);
		}
	    legalApplicantDao.update(t);
	}

	@Override
	public void delete(java.lang.Long[] ids) {
		if (ids != null) {
			for(java.lang.Long id : ids){
				LegalApplicant t = legalApplicantDao.getById(id);
				if (t != null) {
					legalApplicantDao.delete(t);
				}
			}
		}
	}

	@Override
	public LegalApplicant get(LegalApplicantQuery legalApplicantQuery) {
		return legalApplicantDao.getById(legalApplicantQuery.getId());
	}

	@Override
	public LegalApplicant get(String id) {
		return legalApplicantDao.getById(Long.parseLong(id));
	}

	
	@Override
	public List<LegalApplicantQuery> listAll(LegalApplicantQuery legalApplicantQuery) {
	    List<LegalApplicant> list = legalApplicantDao.findList(legalApplicantQuery);
		List<LegalApplicantQuery> listQuery =getQuerysFromEntitys(list) ;
		return listQuery;
	}
	
	
}
