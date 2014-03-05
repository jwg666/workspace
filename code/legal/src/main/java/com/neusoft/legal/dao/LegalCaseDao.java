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
import com.neusoft.base.common.PropertyUtils;
import com.neusoft.base.dao.HBaseDAO;
import com.neusoft.legal.domain.LegalCase;
import com.neusoft.legal.query.LegalCaseQuery;

/**
 * database table: LE_LEGAL_CASE
 * database table comments: LegalCase
 * 
 *
 * @author jiawg-贾伟光
 * @Email jiawg@neusoft.com
 *
 
 */
@Repository
public class LegalCaseDao extends HBaseDAO<LegalCase>{

	
	public void saveOrUpdate(LegalCase entity) {
		if(entity.getId() == null) 
			save(entity);
		else 
			update(entity);
	}
	
	public LegalCase getById(Long id) {
		
		return (LegalCase)getById(LegalCase.class, id);
	}
	
	 
	@SuppressWarnings("unchecked")
	public List<LegalCase> findList(LegalCaseQuery query) {		
		return findList(LegalCase.class, PropertyUtils.toParameterMap(query));
	}
	
	public Pager<LegalCase> findPage(LegalCaseQuery query) {
		Pager<LegalCase> pager = new Pager<LegalCase>();
		Map map = ConverterUtil.toHashMap(query);
		List idList = query.getIdList();
		if(idList!=null&&!idList.isEmpty()){
			map.put("id",idList);
		}
		int begin = (query.getPage().intValue()-1)*(query.getRows().intValue());
		List<LegalCase> appList = findList(LegalCase.class, map, begin, query.getRows().intValue());
		pager.setTotalRecords(getTotalCount(LegalCase.class, map));
		pager.setCurrentPage(query.getPage());
		pager.setPageSize(query.getRows());
		pager.setRecords(appList);
		return pager;
	}
}
