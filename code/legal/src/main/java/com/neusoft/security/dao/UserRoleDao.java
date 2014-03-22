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

import com.neusoft.security.domain.UserRole;
import com.neusoft.security.query.UserRoleQuery;

/**
 * database table: TB_USER_ROLE
 * database table comments: UserRole
 * 
 *
 * @author jiawg-贾伟光
 * @Email jiawg@neusoft.com
 *
 
 */
@Repository
public class UserRoleDao extends HBaseDAO<UserRole>{

	
	public void saveOrUpdate(UserRole entity) {
		if(entity.getId() == null) 
			save(entity);
		else 
			update(entity);
	}
	
	public UserRole getById(Long id) {
		
		return (UserRole)getById(UserRole.class, id);
	}
	
	 
	@SuppressWarnings("unchecked")
	public List<UserRole> findList(UserRoleQuery query) {		
		return findList(UserRole.class, ConverterUtil.toHashMap(query));
	}
	
	public Pager<UserRole> findPage(UserRoleQuery query) {
		Pager<UserRole> pager = new Pager<UserRole>();
		Map map = ConverterUtil.toHashMap(query);
		List<UserRole> appList = findList(UserRole.class, map, query.getPage().intValue(), query.getRows().intValue());
		pager.setTotalRecords(getTotalCount(UserRole.class, map));
		pager.setCurrentPage(query.getPage());
		pager.setPageSize(query.getRows());
		pager.setRecords(appList);
		return pager;
	}
}
