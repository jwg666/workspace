package com.neusoft.portal.service.impl;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.neusoft.base.common.Pager;
import com.neusoft.base.model.DataGrid;
import com.neusoft.portal.dao.AppStarDao;
import com.neusoft.portal.model.AppStar;
import com.neusoft.portal.query.AppStarQuery;
import com.neusoft.portal.service.AppStarService;
@Service("appStarService")
@Transactional
public class AppStarServiceImpl implements AppStarService{
	@Resource
	private AppStarDao appStarDao;
	
	public void setAppStarDao(AppStarDao dao) {
		this.appStarDao = dao;
	}

	@Override
	public DataGrid datagrid(AppStarQuery appStarQuery) {
		DataGrid j = new DataGrid();
		Pager<AppStar> pager  = find(appStarQuery);
		j.setRows(getQuerysFromEntitys(pager.getRecords()));
		j.setTotal(pager.getTotalRecords());
		return j;
	}

	private List<AppStarQuery> getQuerysFromEntitys(List<AppStar> appStars) {
		List<AppStarQuery> appStarQuerys = new ArrayList<AppStarQuery>();
		if (appStars != null && appStars.size() > 0) {
			for (AppStar tb : appStars) {
				AppStarQuery b = new AppStarQuery();
				BeanUtils.copyProperties(tb, b);
				appStarQuerys.add(b);
			}
		}
		return appStarQuerys;
	}

	private Pager<AppStar> find(AppStarQuery appStarQuery) {
		return  appStarDao.findPager(appStarQuery);
		
	}
	


	@Override
	public void add(AppStarQuery appStarQuery) {
		AppStar t = new AppStar();
		BeanUtils.copyProperties(appStarQuery, t);
		appStarDao.save(t);
	}

	@Override
	public void update(AppStarQuery appStarQuery) {
		AppStar t = appStarDao.getById(appStarQuery.getTbid());
	    if(t != null) {
	    	BeanUtils.copyProperties(appStarQuery, t);
		}
	    appStarDao.update(t);
	}

	@Override
	public void delete(java.lang.Long[] ids) {
		if (ids != null) {
			for(java.lang.Long id : ids){
				AppStar t = appStarDao.getById(id);
				if (t != null) {
					appStarDao.delete(t);
				}
			}
		}
	}

	@Override
	public AppStar get(AppStarQuery appStarQuery) {
		return appStarDao.getById( Long.valueOf(appStarQuery.getTbid()));
	}

	@Override
	public AppStar get(String id) {
		return appStarDao.getById(Long.parseLong(id));
	}

	
	@Override
	public List<AppStarQuery> listAll(AppStarQuery appStarQuery) {
	    List<AppStar> list = appStarDao.findList(appStarQuery);
		List<AppStarQuery> listQuery =getQuerysFromEntitys(list) ;
		return listQuery;
	}
	
	
}
