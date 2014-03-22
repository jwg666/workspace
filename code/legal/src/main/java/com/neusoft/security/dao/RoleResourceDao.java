/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */

package com.neusoft.security.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import com.neusoft.base.common.ConverterUtil;
import com.neusoft.base.common.Pager;
import com.neusoft.base.dao.HBaseDAO;

import com.neusoft.security.domain.RoleResource;
import com.neusoft.security.query.RoleResourceQuery;

/**
 * database table: TB_ROLE_RESOURCE
 * database table comments: RoleResource
 * 
 *
 * @author jiawg-贾伟光
 * @Email jiawg@neusoft.com
 *
 
 */
@Repository
public class RoleResourceDao extends HBaseDAO<RoleResource>{

	
	public void saveOrUpdate(RoleResource entity) {
		if(entity.getId() == null) 
			save(entity);
		else 
			update(entity);
	}
	
	public RoleResource getById(Long id) {
		
		return (RoleResource)getById(RoleResource.class, id);
	}
	
	 
	@SuppressWarnings("unchecked")
	public List<RoleResource> findList(RoleResourceQuery query) {		
		return findList(RoleResource.class, ConverterUtil.toHashMap(query));
	}
	
	public Pager<RoleResource> findPage(RoleResourceQuery query) {
		Pager<RoleResource> pager = new Pager<RoleResource>();
		Map map = ConverterUtil.toHashMap(query);
		List<RoleResource> appList = findList(RoleResource.class, map, query.getPage().intValue(), query.getRows().intValue());
		pager.setTotalRecords(getTotalCount(RoleResource.class, map));
		pager.setCurrentPage(query.getPage());
		pager.setPageSize(query.getRows());
		pager.setRecords(appList);
		return pager;
	}
}
