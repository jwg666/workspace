/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */


package com.neusoft.base.service.impl;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.neusoft.base.common.Pager;
import com.neusoft.base.dao.DepartmentDao;
import com.neusoft.base.domain.Department;
import com.neusoft.base.model.DataGrid;
import com.neusoft.base.query.DepartmentQuery;
import com.neusoft.base.service.DepartmentService;
/**
 * 
 * @author jiawg-贾伟光
 *
 */
@Service("departmentService")
@Transactional
public class DepartmentServiceImpl implements DepartmentService{
	@Resource
	private DepartmentDao departmentDao;
	

	@Override
	public DataGrid datagrid(DepartmentQuery departmentQuery) {
		DataGrid j = new DataGrid();
		Pager<Department> pager  = departmentDao.findPage(departmentQuery);
		j.setRows(getQuerysFromEntitys(pager.getRecords()));
		j.setTotal(pager.getTotalRecords());
		return j;
	}

	private List<DepartmentQuery> getQuerysFromEntitys(List<Department> Departments) {
		List<DepartmentQuery> DepartmentQuerys = new ArrayList<DepartmentQuery>();
		if (Departments != null && Departments.size() > 0) {
			for (Department tb : Departments) {
				DepartmentQuery b = new DepartmentQuery();
				BeanUtils.copyProperties(tb, b);
				DepartmentQuerys.add(b);
			}
		}
		return DepartmentQuerys;
	}

	


	@Override
	public void add(DepartmentQuery departmentQuery) {
		Department t = new Department();
		BeanUtils.copyProperties(departmentQuery, t);
		departmentDao.save(t);
	}

	@Override
	public void update(DepartmentQuery departmentQuery) {
		Department t = departmentDao.getById(departmentQuery.getId());
	    if(t != null) {
	    	BeanUtils.copyProperties(departmentQuery, t);
		}
	    departmentDao.update(t);
	}

	@Override
	public void delete(java.lang.String[] ids) {
		if (ids != null) {
			for(java.lang.String id : ids){
				Department t = departmentDao.getById(new Long(id));
				if (t != null) {
					departmentDao.delete(t);
				}
			}
		}
	}

	@Override
	public Department get(DepartmentQuery DepartmentQuery) {
		return departmentDao.getById(DepartmentQuery.getId());
	}

	@Override
	public Department get(String id) {
		return departmentDao.getById(Long.parseLong(id));
	}

	
	@Override
	public List<DepartmentQuery> listAll(DepartmentQuery departmentQuery) {
	    List<Department> list = departmentDao.findList(departmentQuery);
		List<DepartmentQuery> listQuery =getQuerysFromEntitys(list) ;
		return listQuery;
	}
	
	
}
