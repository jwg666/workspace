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

import com.neusoft.security.dao.RoleResourceDao;
import com.neusoft.security.domain.RoleResource;
import com.neusoft.security.query.RoleResourceQuery;
import com.neusoft.security.service.RoleResourceService;
/**
 * 
 * @author jiawg-贾伟光
 *
 */
@Service("roleResourceService")
@Transactional
public class RoleResourceServiceImpl implements RoleResourceService{
	@Resource
	private RoleResourceDao roleResourceDao;
	

	@Override
	public DataGrid datagrid(RoleResourceQuery roleResourceQuery) {
		DataGrid j = new DataGrid();
		Pager<RoleResource> pager  = roleResourceDao.findPage(roleResourceQuery);
		j.setRows(getQuerysFromEntitys(pager.getRecords()));
		j.setTotal(pager.getTotalRecords());
		return j;
	}

	private List<RoleResourceQuery> getQuerysFromEntitys(List<RoleResource> roleResources) {
		List<RoleResourceQuery> roleResourceQuerys = new ArrayList<RoleResourceQuery>();
		if (roleResources != null && roleResources.size() > 0) {
			for (RoleResource tb : roleResources) {
				RoleResourceQuery b = new RoleResourceQuery();
				BeanUtils.copyProperties(tb, b);
				roleResourceQuerys.add(b);
			}
		}
		return roleResourceQuerys;
	}

	


	@Override
	public void add(RoleResourceQuery roleResourceQuery) {
		RoleResource t = new RoleResource();
		BeanUtils.copyProperties(roleResourceQuery, t);
		roleResourceDao.save(t);
	}

	@Override
	public void update(RoleResourceQuery roleResourceQuery) {
		RoleResource t = roleResourceDao.getById(roleResourceQuery.getTbid());
	    if(t != null) {
	    	BeanUtils.copyProperties(roleResourceQuery, t);
		}
	    roleResourceDao.update(t);
	}

	@Override
	public void delete(java.lang.Long[] ids) {
		if (ids != null) {
			for(java.lang.Long id : ids){
				RoleResource t = roleResourceDao.getById(id);
				if (t != null) {
					roleResourceDao.delete(t);
				}
			}
		}
	}

	@Override
	public RoleResource get(RoleResourceQuery roleResourceQuery) {
		return roleResourceDao.getById(roleResourceQuery.getTbid());
	}

	@Override
	public RoleResource get(String id) {
		return roleResourceDao.getById(Long.parseLong(id));
	}

	
	@Override
	public List<RoleResourceQuery> listAll(RoleResourceQuery roleResourceQuery) {
	    List<RoleResource> list = roleResourceDao.findList(roleResourceQuery);
		List<RoleResourceQuery> listQuery =getQuerysFromEntitys(list) ;
		return listQuery;
	}
	
	
}
