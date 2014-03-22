package com.neusoft.security.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.neusoft.base.common.Pager;
import com.neusoft.base.model.DataGrid;
import com.neusoft.security.dao.ResourceInfoDAO;
import com.neusoft.security.dao.RoleDAO;
import com.neusoft.security.domain.Role;
import com.neusoft.security.query.RoleQuery;
import com.neusoft.security.service.RoleService;

@Service("roleService")
@Transactional
public class RoleServiceImpl implements RoleService {
	@Resource
	private RoleDAO roleDAO;
	@Resource
	private ResourceInfoDAO resourceInfoDAO;

	@Override
	public Role getRoleById(Long roleId) {
		return roleDAO.get(roleId);
	}


	@Override
	public List<Role> getRoles() {
		return roleDAO.findList(Role.class);
	}
	@Override
	public DataGrid datagrid(RoleQuery roleQuery) {
		DataGrid j = new DataGrid();
		Pager<Role> pager  = roleDAO.findPage(roleQuery);
		j.setRows(getQuerysFromEntitys(pager.getRecords()));
		j.setTotal(pager.getTotalRecords());
		return j;
	}

	private List<RoleQuery> getQuerysFromEntitys(List<Role> roles) {
		List<RoleQuery> roleQuerys = new ArrayList<RoleQuery>();
		if (roles != null && roles.size() > 0) {
			for (Role tb : roles) {
				RoleQuery b = new RoleQuery();
				BeanUtils.copyProperties(tb, b);
				roleQuerys.add(b);
			}
		}
		return roleQuerys;
	}

	


	@Override
	public void add(RoleQuery roleQuery) {
		Role t = new Role();
		BeanUtils.copyProperties(roleQuery, t);
		roleDAO.save(t);
	}

	@Override
	public void update(RoleQuery roleQuery) {
		Role t = roleDAO.getById(roleQuery.getId());
	    if(t != null) {
	    	BeanUtils.copyProperties(roleQuery, t);
		}
	    roleDAO.update(t);
	}

	@Override
	public void delete(java.lang.Long[] ids) {
		if (ids != null) {
			for(java.lang.Long id : ids){
				Role t = roleDAO.getById(id);
				if (t != null) {
					roleDAO.delete(t);
				}
			}
		}
	}

	@Override
	public Role get(RoleQuery roleQuery) {
		return roleDAO.getById(roleQuery.getId());
	}

	@Override
	public Role get(String id) {
		return roleDAO.getById(Long.parseLong(id));
	}

	
	@Override
	public List<RoleQuery> listAll(RoleQuery roleQuery) {
	    List<Role> list = roleDAO.findList(roleQuery);
		List<RoleQuery> listQuery =getQuerysFromEntitys(list) ;
		return listQuery;
	}

}
