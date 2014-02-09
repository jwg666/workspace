package com.neusoft.portal.service.impl;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.neusoft.base.common.Pager;
import com.neusoft.base.model.DataGrid;
import com.neusoft.portal.dao.WallpaperDao;
import com.neusoft.portal.model.Wallpaper;
import com.neusoft.portal.query.WallpaperQuery;
import com.neusoft.portal.service.WallpaperService;
@Service("wallpaperService")
@Transactional
public class WallpaperServiceImpl implements WallpaperService{
	@Resource
	private WallpaperDao wallpaperDao;
	
	public void setWallpaperDao(WallpaperDao dao) {
		this.wallpaperDao = dao;
	}

	@Override
	public DataGrid datagrid(WallpaperQuery wallpaperQuery) {
		DataGrid j = new DataGrid();
		Pager<Wallpaper> pager  = find(wallpaperQuery);
		j.setRows(getQuerysFromEntitys(pager.getRecords()));
		j.setTotal(pager.getTotalRecords());
		return j;
	}

	private List<WallpaperQuery> getQuerysFromEntitys(List<Wallpaper> wallpapers) {
		List<WallpaperQuery> wallpaperQuerys = new ArrayList<WallpaperQuery>();
		if (wallpapers != null && wallpapers.size() > 0) {
			for (Wallpaper tb : wallpapers) {
				WallpaperQuery b = new WallpaperQuery();
				BeanUtils.copyProperties(tb, b);
				wallpaperQuerys.add(b);
			}
		}
		return wallpaperQuerys;
	}

	private Pager<Wallpaper> find(WallpaperQuery wallpaperQuery) {
		return  wallpaperDao.findPage(wallpaperQuery);
		
	}
	


	@Override
	public void add(WallpaperQuery wallpaperQuery) {
		Wallpaper t = new Wallpaper();
		BeanUtils.copyProperties(wallpaperQuery, t);
		wallpaperDao.save(t);
	}

	@Override
	public void update(WallpaperQuery wallpaperQuery) {
		Wallpaper t = wallpaperDao.getById(wallpaperQuery.getTbid());
	    if(t != null) {
	    	BeanUtils.copyProperties(wallpaperQuery, t);
		}
	    wallpaperDao.update(t);
	}

	@Override
	public void delete(java.lang.Long[] ids) {
		if (ids != null) {
			for(java.lang.Long id : ids){
				Wallpaper t = wallpaperDao.getById(id);
				if (t != null) {
					wallpaperDao.delete(t);
				}
			}
		}
	}

	@Override
	public Wallpaper get(WallpaperQuery wallpaperQuery) {
		return wallpaperDao.getById( Long.valueOf(wallpaperQuery.getTbid()) );
	}

	@Override
	public Wallpaper get(String id) {
		return wallpaperDao.getById(Long.parseLong(id));
	}

	
	@Override
	public List<WallpaperQuery> listAll(WallpaperQuery wallpaperQuery) {
	    List<Wallpaper> list = wallpaperDao.findList(wallpaperQuery);
		List<WallpaperQuery> listQuery =getQuerysFromEntitys(list) ;
		return listQuery;
	}
	
	
}
