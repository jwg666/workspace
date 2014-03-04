/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */

package com.neusoft.base.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.neusoft.base.common.ConverterUtil;
import com.neusoft.base.common.Pager;
import com.neusoft.base.common.PropertyUtils;
import com.neusoft.base.domain.Dictionary;
import com.neusoft.base.query.DictionaryQuery;

/**
 * database table: CD_DICTIONARY
 * database table comments: Dictionary
 * 
 *
 * @author jiawg-贾伟光
 * @Email jiawg@neusoft.com
 *
 
 */
@Repository
public class DictionaryDao extends HBaseDAO<Dictionary>{

	
	public void saveOrUpdate(Dictionary entity) {
		if(entity.getId() == null) 
			save(entity);
		else 
			update(entity);
	}
	
	public Dictionary getById(Long id) {
		
		return (Dictionary)getById(Dictionary.class, id);
	}
	
	 
	@SuppressWarnings("unchecked")
	public List<Dictionary> findList(DictionaryQuery query) {		
		return findList(Dictionary.class, ConverterUtil.toHashMap(query));
	}
	
	public Pager<Dictionary> findPage(DictionaryQuery query) {
		Pager<Dictionary> pager = new Pager<Dictionary>();
		Map map = ConverterUtil.toHashMap(query);
		List<Dictionary> appList = findList(Dictionary.class, map, query.getPage().intValue(), query.getRows().intValue());
		pager.setTotalRecords(getTotalCount(Dictionary.class, map));
		pager.setCurrentPage(query.getPage());
		pager.setPageSize(query.getRows());
		pager.setRecords(appList);
		return pager;
	}
}
