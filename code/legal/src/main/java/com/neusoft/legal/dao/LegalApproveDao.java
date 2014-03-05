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
import com.neusoft.legal.domain.LegalApprove;
import com.neusoft.legal.query.LegalApproveQuery;

/**
 * database table: LE_LEGAL_APPROVE
 * database table comments: LegalApprove
 * 
 *
 * @author jiawg-贾伟光
 * @Email jiawg@neusoft.com
 *
 
 */
@Repository
public class LegalApproveDao extends HBaseDAO<LegalApprove>{

	
	public void saveOrUpdate(LegalApprove entity) {
		if(entity.getId() == null) 
			save(entity);
		else 
			update(entity);
	}
	
	public LegalApprove getById(Long id) {
		
		return (LegalApprove)getById(LegalApprove.class, id);
	}
	
	 
	@SuppressWarnings("unchecked")
	public List<LegalApprove> findList(LegalApproveQuery query) {		
		return findList(LegalApprove.class, PropertyUtils.toParameterMap(query));
	}
	
	public Pager<LegalApprove> findPage(LegalApproveQuery query) {
		Pager<LegalApprove> pager = new Pager<LegalApprove>();
		Map map = ConverterUtil.toHashMap(query);
		List idList = query.getIdList();
		if(idList!=null&&!idList.isEmpty()){
			map.put("id",idList);
		}
		List<LegalApprove> appList = findList(LegalApprove.class, map, query.getPage().intValue(), query.getRows().intValue());
		pager.setTotalRecords(getTotalCount(LegalApprove.class, map));
		pager.setCurrentPage(query.getPage());
		pager.setPageSize(query.getRows());
		pager.setRecords(appList);
		return pager;
	}

}
