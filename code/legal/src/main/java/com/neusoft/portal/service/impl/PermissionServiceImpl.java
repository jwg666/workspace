package com.neusoft.portal.service.impl;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.neusoft.base.common.Pager;
import com.neusoft.base.model.DataGrid;
import com.neusoft.portal.dao.PermissionDao;
import com.neusoft.portal.model.Permission;
import com.neusoft.portal.query.PermissionQuery;
import com.neusoft.portal.service.PermissionService;
@Service("permissionService")
@Transactional
public class PermissionServiceImpl implements PermissionService{
	@Resource
	private PermissionDao permissionDao;
	
	public void setPermissionDao(PermissionDao dao) {
		this.permissionDao = dao;
	}

	@Override
	public DataGrid datagrid(PermissionQuery permissionQuery) {
		DataGrid j = new DataGrid();
		Pager<Permission> pager  = find(permissionQuery);
		j.setRows(getQuerysFromEntitys(pager.getRecords()));
		j.setTotal(pager.getTotalRecords());
		return j;
	}

	private List<PermissionQuery> getQuerysFromEntitys(List<Permission> permissions) {
		List<PermissionQuery> permissionQuerys = new ArrayList<PermissionQuery>();
		if (permissions != null && permissions.size() > 0) {
			for (Permission tb : permissions) {
				PermissionQuery b = new PermissionQuery();
				BeanUtils.copyProperties(tb, b);
				permissionQuerys.add(b);
			}
		}
		return permissionQuerys;
	}

	private Pager<Permission> find(PermissionQuery permissionQuery) {
		return  permissionDao.findPage(permissionQuery);
		
	}
	


	@Override
	public void add(PermissionQuery permissionQuery) {
		Permission t = new Permission();
		BeanUtils.copyProperties(permissionQuery, t);
		permissionDao.save(t);
	}

	@Override
	public void update(PermissionQuery permissionQuery) {
		Permission t = permissionDao.getById(permissionQuery.getTbid());
	    if(t != null) {
	    	BeanUtils.copyProperties(permissionQuery, t);
		}
	    permissionDao.update(t);
	}

	@Override
	public void delete(java.lang.Long[] ids) {
		if (ids != null) {
			for(java.lang.Long id : ids){
				Permission t = permissionDao.getById(id);
				if (t != null) {
					permissionDao.delete(t);
				}
			}
		}
	}

	@Override
	public Permission get(PermissionQuery permissionQuery) {
		return permissionDao.getById( Long.valueOf(permissionQuery.getTbid()));
	}

	@Override
	public Permission get(String id) {
		return permissionDao.getById(Long.parseLong(id));
	}

	
	@Override
	public List<PermissionQuery> listAll(PermissionQuery permissionQuery) {
	    List<Permission> list = permissionDao.findList(permissionQuery);
		List<PermissionQuery> listQuery =getQuerysFromEntitys(list) ;
		return listQuery;
	}
	
	
}
