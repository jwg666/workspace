/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */

package com.neusoft.legal.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.neusoft.base.common.ConverterUtil;
import com.neusoft.base.common.Pager;
import com.neusoft.base.dao.HBaseDAO;
import com.neusoft.legal.domain.LegalApplicant;
import com.neusoft.legal.query.LegalApplicantQuery;

/**
 * database table: LE_LEGAL_APPLICANT
 * database table comments: LegalApplicant
 * 
 *
 * @author jiawg-贾伟光
 * @Email jiawg@neusoft.com
 *
 
 */
@Repository
public class LegalApplicantDao extends HBaseDAO<LegalApplicant>{

	
	public void saveOrUpdate(LegalApplicant entity) {
		if(entity.getId() == null) 
			save(entity);
		else 
			update(entity);
	}
	
	public LegalApplicant getById(Long id) {
		
		return (LegalApplicant)getById(LegalApplicant.class, id);
	}
	
	 
	@SuppressWarnings("unchecked")
	public List<LegalApplicant> findList(LegalApplicantQuery query) {		
		return findList(LegalApplicant.class, ConverterUtil.toHashMap(query));
	}
	
	public Pager<LegalApplicant> findPage(LegalApplicantQuery query) {
		Pager<LegalApplicant> pager = new Pager<LegalApplicant>();
		Map map = ConverterUtil.toHashMap(query);
		int page = query.getPage().intValue();
		int pageSize = query.getRows().intValue();
		int begin = (page-1)*pageSize;
		List<LegalApplicant> appList = findList(LegalApplicant.class, map, begin, pageSize);
		pager.setTotalRecords(getTotalCount(LegalApplicant.class, map));
		pager.setCurrentPage(query.getPage());
		pager.setPageSize(query.getRows());
		pager.setRecords(appList);
		return pager;
	}
}
