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
import com.neusoft.legal.domain.LegalAgent;
import com.neusoft.legal.query.LegalAgentQuery;

/**
 * database table: LE_LEGAL_AGENT
 * database table comments: LegalAgent
 * 
 *
 * @author jiawg-贾伟光
 * @Email jiawg@neusoft.com
 *
 
 */
@Repository
public class LegalAgentDao extends HBaseDAO<LegalAgent>{

	
	public void saveOrUpdate(LegalAgent entity) {
		if(entity.getId() == null) 
			save(entity);
		else 
			update(entity);
	}
	
	public LegalAgent getById(Long id) {
		
		return (LegalAgent)getById(LegalAgent.class, id);
	}
	
	 
	@SuppressWarnings("unchecked")
	public List<LegalAgent> findList(LegalAgentQuery query) {		
		return findList(LegalAgent.class, ConverterUtil.toHashMap(query));
	}
	
	public Pager<LegalAgent> findPage(LegalAgentQuery query) {
		Pager<LegalAgent> pager = new Pager<LegalAgent>();
		Map map = ConverterUtil.toHashMap(query);
		int begin = (query.getPage().intValue()-1)*(query.getRows().intValue());
		List<LegalAgent> appList = findList(LegalAgent.class, map, begin, query.getRows().intValue());
		pager.setTotalRecords(getTotalCount(LegalAgent.class, map));
		pager.setCurrentPage(query.getPage());
		pager.setPageSize(query.getRows());
		pager.setRecords(appList);
		return pager;
	}
}
