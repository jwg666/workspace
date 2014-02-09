/*
 * Powered By [rapid-framework]
 * Web Site: http://www.rapid-framework.org.cn
 * Google Code: http://code.google.com/p/rapid-framework/
 * Since 2008 - 2013
 */


package com.neusoft.portal.service.impl;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.neusoft.base.common.Pager;
import com.neusoft.base.model.DataGrid;
import com.neusoft.portal.dao.AppDao;
import com.neusoft.portal.model.App;
import com.neusoft.portal.query.AppQuery;
import com.neusoft.portal.service.AppService;
@Service("appService")
@Transactional
public class AppServiceImpl implements AppService{
	@Resource
	private AppDao appDao;
	
	public void setAppDao(AppDao dao) {
		this.appDao = dao;
	}

	@Override
	public DataGrid datagrid(AppQuery appQuery) {
		DataGrid j = new DataGrid();
		Pager<App> pager  = appDao.findPager(appQuery);
		j.setRows(getQuerysFromEntitys(pager.getRecords()));
		j.setTotal(pager.getTotalRecords());
		return j;
	}

	private List<AppQuery> getQuerysFromEntitys(List<App> apps) {
		List<AppQuery> appQuerys = new ArrayList<AppQuery>();
		if (apps != null && apps.size() > 0) {
			for (App tb : apps) {
				AppQuery b = new AppQuery();
				BeanUtils.copyProperties(tb, b);
				appQuerys.add(b);
			}
		}
		return appQuerys;
	}

	


	@Override
	public void add(AppQuery appQuery) {
		App t = new App();
		BeanUtils.copyProperties(appQuery, t);
		appDao.save(t);
	}

	@Override
	public void update(AppQuery appQuery) {
		App t = appDao.getById(appQuery.getTbid());
	    if(t != null) {
	    	BeanUtils.copyProperties(appQuery, t);
		}
	    appDao.update(t);
	}

	@Override
	public void delete(java.lang.Long[] ids) {
		if (ids != null) {
			for(java.lang.Long id : ids){
				App t = appDao.getById(id);
				if (t != null) {
					appDao.delete(t);
				}
			}
		}
	}

	@Override
	public App get(AppQuery appQuery) {
		return appDao.getById(Long.valueOf(appQuery.getTbid()));
	}

	@Override
	public App get(String id) {
		return appDao.getById(Long.parseLong(id));
	}

	
	@Override
	public List<AppQuery> listAll(AppQuery appQuery) {
	    List<App> list = appDao.findList(appQuery);
		List<AppQuery> listQuery =getQuerysFromEntitys(list) ;
		return listQuery;
	}
	
	
}
