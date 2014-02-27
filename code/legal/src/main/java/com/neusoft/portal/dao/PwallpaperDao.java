package com.neusoft.portal.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.neusoft.base.common.ConverterUtil;
import com.neusoft.base.common.Pager;
import com.neusoft.base.common.PropertyUtils;
import com.neusoft.base.dao.HBaseDAO;
import com.neusoft.portal.model.Pwallpaper;
import com.neusoft.portal.query.PwallpaperQuery;

/**
 * database table: tb_pwallpaper
 * database table comments: Pwallpaper
 */
@Repository
public class PwallpaperDao extends HBaseDAO<Pwallpaper>{
	
	public void saveOrUpdate(Pwallpaper entity) {
		if(entity.getTbid() == null){
			save(entity);
		}else{
			update(entity);
		}
	}
	
   public Pwallpaper getById(Long id) {
		
		return (Pwallpaper)getById(Pwallpaper.class, id);
	}

	@SuppressWarnings("unchecked")
	public List<Pwallpaper> findList(PwallpaperQuery appQuery) {		
		return findList(Pwallpaper.class, ConverterUtil.toHashMap(appQuery));
	}


	public Pager<Pwallpaper> findPage(PwallpaperQuery appQuery) {
		Pager<Pwallpaper> pager = new Pager<Pwallpaper>();
		Map map = ConverterUtil.toHashMap(appQuery);
		List<Pwallpaper> appList = findList(Pwallpaper.class, map, appQuery.getPage().intValue(), appQuery.getRows().intValue());
		pager.setTotalRecords(getTotalCount(Pwallpaper.class, map));
		pager.setCurrentPage(appQuery.getPage());
		pager.setPageSize(appQuery.getRows());
		pager.setRecords(appList);
		return pager;
	}
	 

}
