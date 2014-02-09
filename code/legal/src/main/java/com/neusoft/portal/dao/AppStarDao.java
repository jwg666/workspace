package com.neusoft.portal.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.neusoft.base.common.Pager;
import com.neusoft.base.common.PropertyUtils;
import com.neusoft.base.dao.HBaseDAO;
import com.neusoft.portal.model.AppStar;
import com.neusoft.portal.query.AppStarQuery;

/**
 * database table: tb_app_star
 * database table comments: AppStar
 */
@Repository
public class AppStarDao extends HBaseDAO<AppStar>{
	
	
	public void saveOrUpdate(AppStar entity) {
		if(entity.getTbid() == null){
			save(entity);
		}else{
			update(entity);
		}
	}
	
    public AppStar getById(Long id) {
		
		return (AppStar)getById(AppStar.class, id);
	}

	@SuppressWarnings("unchecked")
	public List<AppStar> findList(AppStarQuery appQuery) {		
		return findList(AppStar.class, PropertyUtils.toParameterMap(appQuery));
	}


	public Pager<AppStar> findPager(AppStarQuery appQuery) {
		Pager<AppStar> pager = new Pager<AppStar>();
		Map map = PropertyUtils.toParameterMap(appQuery);
		List<AppStar> appList = findList(AppStar.class, map, appQuery.getPage().intValue(), appQuery.getRows().intValue());
		pager.setTotalRecords(getTotalCount(AppStar.class, map));
		pager.setCurrentPage(appQuery.getPage());
		pager.setPageSize(appQuery.getRows());
		pager.setRecords(appList);
		return pager;
	}
	 

}
