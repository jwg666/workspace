package com.neusoft.security.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.neusoft.base.common.ConverterUtil;
import com.neusoft.base.common.Pager;
import com.neusoft.base.dao.HBaseDAO;
import com.neusoft.security.domain.Role;
import com.neusoft.security.query.RoleQuery;


/**
 * 角色DAO
 * @author jiawg
 *
 */
@Repository
public class RoleDAO  extends HBaseDAO<Role>{
	public void saveOrUpdate(Role entity) {
		if(entity.getId() == null) 
			save(entity);
		else 
			update(entity);
	}
	
	public Role getById(Long id) {
		
		return (Role)getById(Role.class, id);
	}
	
	 
	@SuppressWarnings("unchecked")
	public List<Role> findList(RoleQuery query) {		
		return findList(Role.class, ConverterUtil.toHashMap(query));
	}
	
	public Pager<Role> findPage(RoleQuery query) {
		Pager<Role> pager = new Pager<Role>();
		Map map = ConverterUtil.toHashMap(query);
		List<Role> appList = findList(Role.class, map, query.getPage().intValue(), query.getRows().intValue());
		pager.setTotalRecords(getTotalCount(Role.class, map));
		pager.setCurrentPage(query.getPage());
		pager.setPageSize(query.getRows());
		pager.setRecords(appList);
		return pager;
	}
	public Role get(Long id) {
		
		return (Role)getById(Role.class, id);
	}
}
