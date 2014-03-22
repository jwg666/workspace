/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */


package com.neusoft.security.service.impl;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.neusoft.base.common.Pager;
import com.neusoft.base.model.DataGrid;

import com.neusoft.security.dao.UserRoleDao;
import com.neusoft.security.domain.UserRole;
import com.neusoft.security.query.UserRoleQuery;
import com.neusoft.security.service.UserRoleService;
/**
 * 
 * @author jiawg-贾伟光
 *
 */
@Service("userRoleService")
@Transactional
public class UserRoleServiceImpl implements UserRoleService{
	@Resource
	private UserRoleDao userRoleDao;
	

	@Override
	public DataGrid datagrid(UserRoleQuery userRoleQuery) {
		DataGrid j = new DataGrid();
		Pager<UserRole> pager  = userRoleDao.findPage(userRoleQuery);
		j.setRows(getQuerysFromEntitys(pager.getRecords()));
		j.setTotal(pager.getTotalRecords());
		return j;
	}

	private List<UserRoleQuery> getQuerysFromEntitys(List<UserRole> userRoles) {
		List<UserRoleQuery> userRoleQuerys = new ArrayList<UserRoleQuery>();
		if (userRoles != null && userRoles.size() > 0) {
			for (UserRole tb : userRoles) {
				UserRoleQuery b = new UserRoleQuery();
				BeanUtils.copyProperties(tb, b);
				userRoleQuerys.add(b);
			}
		}
		return userRoleQuerys;
	}

	


	@Override
	public void add(UserRoleQuery userRoleQuery) {
		UserRole t = new UserRole();
		BeanUtils.copyProperties(userRoleQuery, t);
		userRoleDao.save(t);
	}

	@Override
	public void update(UserRoleQuery userRoleQuery) {
		UserRole t = userRoleDao.getById(userRoleQuery.getTbid());
	    if(t != null) {
	    	BeanUtils.copyProperties(userRoleQuery, t);
		}
	    userRoleDao.update(t);
	}

	@Override
	public void delete(java.lang.Long[] ids) {
		if (ids != null) {
			for(java.lang.Long id : ids){
				UserRole t = userRoleDao.getById(id);
				if (t != null) {
					userRoleDao.delete(t);
				}
			}
		}
	}

	@Override
	public UserRole get(UserRoleQuery userRoleQuery) {
		return userRoleDao.getById(userRoleQuery.getTbid());
	}

	@Override
	public UserRole get(String id) {
		return userRoleDao.getById(Long.parseLong(id));
	}

	
	@Override
	public List<UserRoleQuery> listAll(UserRoleQuery userRoleQuery) {
	    List<UserRole> list = userRoleDao.findList(userRoleQuery);
		List<UserRoleQuery> listQuery =getQuerysFromEntitys(list) ;
		return listQuery;
	}
	
	
}
