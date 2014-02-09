package com.neusoft.portal.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.neusoft.base.common.Pager;
import com.neusoft.base.common.PropertyUtils;
import com.neusoft.base.dao.HBaseDAO;
import com.neusoft.portal.model.Setting;
import com.neusoft.portal.model.Setting;
import com.neusoft.portal.query.SettingQuery;

/**
 * database table: tb_setting
 * database table comments: Setting
 */
@Repository
public class SettingDao extends HBaseDAO<Setting>{
	
	public void saveOrUpdate(Setting entity) {
		if(entity.getTbid() == null){
			save(entity);
		}else{
			update(entity);
		}
	}
	
    public Setting getById(Long id) {
		
		return (Setting)getById(Setting.class, id);
	}

	@SuppressWarnings("unchecked")
	public List<Setting> findList(SettingQuery appQuery) {		
		return findList(Setting.class, PropertyUtils.toParameterMap(appQuery));
	}


	public Pager<Setting> findPage(SettingQuery appQuery) {
		Pager<Setting> pager = new Pager<Setting>();
		Map map = PropertyUtils.toParameterMap(appQuery);
		List<Setting> appList = findList(Setting.class, map, appQuery.getPage().intValue(), appQuery.getRows().intValue());
		pager.setTotalRecords(getTotalCount(Setting.class, map));
		pager.setCurrentPage(appQuery.getPage());
		pager.setPageSize(appQuery.getRows());
		pager.setRecords(appList);
		return pager;
	}
	 

}
