/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */

package com.neusoft.base.dao;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.neusoft.base.common.ConverterUtil;
import com.neusoft.base.common.Pager;
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
		int begin = (query.getPage().intValue()-1)*(query.getRows().intValue());
//		List<Department> appList = findList(Department.class, map, begin, query.getRows().intValue());
		int pageSize = query.getRows().intValue();
		Criteria c = getSession().createCriteria(Department.class);
		if(map!=null&&map.size()>0){
			Iterator<Entry<String,Object>> it = map.entrySet().iterator();
			while (it.hasNext()) {
				Entry<String,Object> e = it.next();
				if(e.getValue() instanceof List){
					List list = (List)e.getValue();
					if(list!=null&&list.size()>0){
						c.add(Restrictions.in(e.getKey(),list));
					}					
				}else{
					c.add(Restrictions.like(e.getKey(), "%"+e.getValue()+"%"));
				}				
			}
		}
		List<Department> countList = c.list();
		
		if(countList!=null){
			pager.setTotalRecords(new Long(countList.size()));
		}else{
			pager.setTotalRecords(0L);
		}
		
		c.setFirstResult(begin-1);
		c.setMaxResults(pageSize);
		
		List<Department> appList = c.list();
		pager.setCurrentPage(query.getPage());
		pager.setPageSize(query.getRows());
		pager.setRecords(appList);
		return pager;
	}
}
