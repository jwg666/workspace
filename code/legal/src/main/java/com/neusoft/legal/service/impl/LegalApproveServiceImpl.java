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
import com.neusoft.legal.dao.LegalApproveDao;
import com.neusoft.legal.domain.LegalApprove;
import com.neusoft.legal.query.LegalApproveQuery;
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
	

	@Override
	public DataGrid datagrid(LegalApproveQuery legalApproveQuery) {
		DataGrid j = new DataGrid();
		Pager<LegalApprove> pager  = legalApproveDao.findPage(legalApproveQuery);
		j.setRows(getQuerysFromEntitys(pager.getRecords()));
		j.setTotal(pager.getTotalRecords());
		return j;
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
	public void add(LegalApproveQuery legalApproveQuery) {
		LegalApprove t = new LegalApprove();
		BeanUtils.copyProperties(legalApproveQuery, t);
		legalApproveDao.save(t);
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
	
	
}