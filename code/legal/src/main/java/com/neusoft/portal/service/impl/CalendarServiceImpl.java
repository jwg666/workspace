package com.neusoft.portal.service.impl;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.neusoft.base.common.Pager;
import com.neusoft.base.model.DataGrid;
import com.neusoft.portal.dao.CalendarDao;
import com.neusoft.portal.model.Calendar;
import com.neusoft.portal.query.CalendarQuery;
import com.neusoft.portal.service.CalendarService;
@Service("calendarService")
@Transactional
public class CalendarServiceImpl implements CalendarService{
	@Resource
	private CalendarDao calendarDao;
	
	public void setCalendarDao(CalendarDao dao) {
		this.calendarDao = dao;
	}

	@Override
	public DataGrid datagrid(CalendarQuery calendarQuery) {
		DataGrid j = new DataGrid();
		Pager<Calendar> pager  = find(calendarQuery);
		j.setRows(getQuerysFromEntitys(pager.getRecords()));
		j.setTotal(pager.getTotalRecords());
		return j;
	}

	private List<CalendarQuery> getQuerysFromEntitys(List<Calendar> calendars) {
		List<CalendarQuery> calendarQuerys = new ArrayList<CalendarQuery>();
		if (calendars != null && calendars.size() > 0) {
			for (Calendar tb : calendars) {
				CalendarQuery b = new CalendarQuery();
				BeanUtils.copyProperties(tb, b);
				calendarQuerys.add(b);
			}
		}
		return calendarQuerys;
	}

	private Pager<Calendar> find(CalendarQuery calendarQuery) {
		return  calendarDao.findPage(calendarQuery);
		
	}
	


	@Override
	public void add(CalendarQuery calendarQuery) {
		Calendar t = new Calendar();
		BeanUtils.copyProperties(calendarQuery, t);
		calendarDao.save(t);
	}

	@Override
	public void update(CalendarQuery calendarQuery) {
		Calendar t = calendarDao.getById(calendarQuery.getTbid());
	    if(t != null) {
	    	BeanUtils.copyProperties(calendarQuery, t);
		}
	    calendarDao.update(t);
	}

	@Override
	public void delete(java.lang.Long[] ids) {
		if (ids != null) {
			for(java.lang.Long id : ids){
				Calendar t = calendarDao.getById(id);
				if (t != null) {
					calendarDao.delete(t);
				}
			}
		}
	}

	@Override
	public Calendar get(CalendarQuery calendarQuery) {
		return calendarDao.getById(Long.valueOf(calendarQuery.getTbid()));
	}

	@Override
	public Calendar get(String id) {
		return calendarDao.getById(Long.parseLong(id));
	}

	
	@Override
	public List<CalendarQuery> listAll(CalendarQuery calendarQuery) {
	    List<Calendar> list = calendarDao.findList(calendarQuery);
		List<CalendarQuery> listQuery =getQuerysFromEntitys(list) ;
		return listQuery;
	}
	
	
}
