package com.neusoft.portal.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.neusoft.base.common.Pager;
import com.neusoft.base.common.PropertyUtils;
import com.neusoft.base.dao.HBaseDAO;
import com.neusoft.portal.model.App;
import com.neusoft.portal.query.AppQuery;


@Repository
public class AppDao extends HBaseDAO<App>{
	
		
	public void saveOrUpdate(App entity) {
		if(entity.getTbid() == null){
			save(entity);
		}else{
			update(entity);
		}
	}
	

	public App getById(Long id) {
		
		return (App)getById(App.class, id);
	}

	@SuppressWarnings("unchecked")
	public List<App> findList(AppQuery appQuery) {		
		return findList(App.class, PropertyUtils.toParameterMap(appQuery));
	}


	public Pager<App> findPager(AppQuery appQuery) {
		Pager<App> pager = new Pager<App>();
		Map map = PropertyUtils.toParameterMap(appQuery);
		List<App> appList = findList(App.class, map, appQuery.getPage().intValue(), appQuery.getRows().intValue());
		pager.setTotalRecords(getTotalCount(App.class, map));
		pager.setCurrentPage(appQuery.getPage());
		pager.setPageSize(appQuery.getRows());
		pager.setRecords(appList);
		return pager;
	}
	 

}
