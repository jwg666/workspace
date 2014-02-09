package com.neusoft.portal.service.impl;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.neusoft.base.common.Pager;
import com.neusoft.base.model.DataGrid;
import com.neusoft.portal.dao.SettingDao;
import com.neusoft.portal.model.Setting;
import com.neusoft.portal.query.SettingQuery;
import com.neusoft.portal.service.SettingService;
@Service("settingService")
@Transactional
public class SettingServiceImpl implements SettingService{
	@Resource
	private SettingDao settingDao;
	
	public void setSettingDao(SettingDao dao) {
		this.settingDao = dao;
	}

	@Override
	public DataGrid datagrid(SettingQuery settingQuery) {
		DataGrid j = new DataGrid();
		Pager<Setting> pager  = find(settingQuery);
		j.setRows(getQuerysFromEntitys(pager.getRecords()));
		j.setTotal(pager.getTotalRecords());
		return j;
	}

	private List<SettingQuery> getQuerysFromEntitys(List<Setting> settings) {
		List<SettingQuery> settingQuerys = new ArrayList<SettingQuery>();
		if (settings != null && settings.size() > 0) {
			for (Setting tb : settings) {
				SettingQuery b = new SettingQuery();
				BeanUtils.copyProperties(tb, b);
				settingQuerys.add(b);
			}
		}
		return settingQuerys;
	}

	private Pager<Setting> find(SettingQuery settingQuery) {
		return  settingDao.findPage(settingQuery);
		
	}
	


	@Override
	public void add(SettingQuery settingQuery) {
		Setting t = new Setting();
		BeanUtils.copyProperties(settingQuery, t);
		settingDao.save(t);
	}

	@Override
	public void update(SettingQuery settingQuery) {
		Setting t = settingDao.getById(settingQuery.getTbid());
	    if(t != null) {
	    	BeanUtils.copyProperties(settingQuery, t);
		}
	    settingDao.update(t);
	}

	@Override
	public void delete(java.lang.Long[] ids) {
		if (ids != null) {
			for(java.lang.Long id : ids){
				Setting t = settingDao.getById(id);
				if (t != null) {
					settingDao.delete(t);
				}
			}
		}
	}

	@Override
	public Setting get(SettingQuery settingQuery) {
		return settingDao.getById(Long.valueOf(settingQuery.getTbid()));
	}

	@Override
	public Setting get(String id) {
		return settingDao.getById(Long.parseLong(id));
	}

	
	@Override
	public List<SettingQuery> listAll(SettingQuery settingQuery) {
	    List<Setting> list = settingDao.findList(settingQuery);
		List<SettingQuery> listQuery =getQuerysFromEntitys(list) ;
		return listQuery;
	}
	
	
}
