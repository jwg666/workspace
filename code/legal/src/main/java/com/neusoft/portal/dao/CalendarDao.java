package com.neusoft.portal.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.neusoft.base.common.ConverterUtil;
import com.neusoft.base.common.Pager;
import com.neusoft.base.dao.HBaseDAO;
import com.neusoft.portal.model.Calendar;
import com.neusoft.portal.query.CalendarQuery;

/**
 * database table: tb_calendar
 * database table comments: Calendar
 */
@Repository
public class CalendarDao extends HBaseDAO<Calendar>{
	
	
	public void saveOrUpdate(Calendar entity) {
		if(entity.getTbid() == null){
			save(entity);
		}else{
			update(entity);
		}
	}
	
    public Calendar getById(Long id) {
		
		return (Calendar)getById(Calendar.class, id);
	}

	@SuppressWarnings("unchecked")
	public List<Calendar> findList(CalendarQuery appQuery) {		
		return findList(Calendar.class, ConverterUtil.toHashMap(appQuery));
	}


	public Pager<Calendar> findPage(CalendarQuery appQuery) {
		Pager<Calendar> pager = new Pager<Calendar>();
		Map map = ConverterUtil.toHashMap(appQuery);
		List<Calendar> appList = findList(Calendar.class, map, appQuery.getPage().intValue(), appQuery.getRows().intValue());
		pager.setTotalRecords(getTotalCount(Calendar.class, map));
		pager.setCurrentPage(appQuery.getPage());
		pager.setPageSize(appQuery.getRows());
		pager.setRecords(appList);
		return pager;
	}
	 

}
