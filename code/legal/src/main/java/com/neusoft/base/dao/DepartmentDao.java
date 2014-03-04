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
import com.neusoft.base.domain.Department;
import com.neusoft.base.query.DepartmentQuery;

/**
 * database table: CD_DEPARTMENT
 * database table comments: Department
 * 
 *
 * @author jiawg-贾伟光
 * @Email jiawg@neusoft.com
 *
 
 */
@Repository
public class DepartmentDao extends HBaseDAO<Department>{

	
	public void saveOrUpdate(Department entity) {
		if(entity.getId() == null) 
			save(entity);
		else 
			update(entity);
	}
	
	public Department getById(Long id) {
		
		return (Department)getById(Department.class, id);
	}
	
	 
	@SuppressWarnings("unchecked")
	public List<Department> findList(DepartmentQuery query) {		
		return findList(Department.class, ConverterUtil.toHashMap(query));
	}
	
	public Pager<Department> findPage(DepartmentQuery query) {
		Pager<Department> pager = new Pager<Department>();
		Map map = ConverterUtil.toHashMap(query);
		List<Department> appList = findList(Department.class, map, query.getPage().intValue(), query.getRows().intValue());
		pager.setTotalRecords(getTotalCount(Department.class, map));
		pager.setCurrentPage(query.getPage());
		pager.setPageSize(query.getRows());
		pager.setRecords(appList);
		return pager;
	}
}
