package com.neusoft.portal.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.neusoft.base.common.ConverterUtil;
import com.neusoft.base.common.Pager;
import com.neusoft.base.dao.HBaseDAO;
import com.neusoft.portal.model.Wallpaper;
import com.neusoft.portal.query.WallpaperQuery;

/**
 * database table: tb_wallpaper
 * database table comments: Wallpaper
 */
@Repository
public class WallpaperDao extends HBaseDAO<Wallpaper>{
	
	public void saveOrUpdate(Wallpaper entity) {
		if(entity.getTbid() == null){
			save(entity);
		}else{
			update(entity);
		}
	}
	
    public Wallpaper getById(Long id) {
		
		return (Wallpaper)getById(Wallpaper.class, id);
	}

	@SuppressWarnings("unchecked")
	public List<Wallpaper> findList(WallpaperQuery appQuery) {		
		return findList(Wallpaper.class, ConverterUtil.toHashMap(appQuery));
	}


	public Pager<Wallpaper> findPage(WallpaperQuery appQuery) {
		Pager<Wallpaper> pager = new Pager<Wallpaper>();
		Map map = ConverterUtil.toHashMap(appQuery);
		List<Wallpaper> appList = findList(Wallpaper.class, map, appQuery.getPage().intValue(), appQuery.getRows().intValue());
		pager.setTotalRecords(getTotalCount(Wallpaper.class, map));
		pager.setCurrentPage(appQuery.getPage());
		pager.setPageSize(appQuery.getRows());
		pager.setRecords(appList);
		return pager;
	}
	 

}
