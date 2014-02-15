/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */


package com.neusoft.base.service.impl;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.neusoft.base.common.Pager;
import com.neusoft.base.dao.DictionaryDao;
import com.neusoft.base.domain.Dictionary;
import com.neusoft.base.model.DataGrid;
import com.neusoft.base.query.DictionaryQuery;
import com.neusoft.base.service.DictionaryService;
/**
 * 
 * @author jiawg-贾伟光
 *
 */
@Service("dictionaryService")
@Transactional
public class DictionaryServiceImpl implements DictionaryService{
	@Resource
	private DictionaryDao dictionaryDao;
	

	@Override
	public DataGrid datagrid(DictionaryQuery dictionaryQuery) {
		DataGrid j = new DataGrid();
		Pager<Dictionary> pager  = dictionaryDao.findPage(dictionaryQuery);
		j.setRows(getQuerysFromEntitys(pager.getRecords()));
		j.setTotal(pager.getTotalRecords());
		return j;
	}

	private List<DictionaryQuery> getQuerysFromEntitys(List<Dictionary> Dictionarys) {
		List<DictionaryQuery> DictionaryQuerys = new ArrayList<DictionaryQuery>();
		if (Dictionarys != null && Dictionarys.size() > 0) {
			for (Dictionary tb : Dictionarys) {
				DictionaryQuery b = new DictionaryQuery();
				BeanUtils.copyProperties(tb, b);
				DictionaryQuerys.add(b);
			}
		}
		return DictionaryQuerys;
	}

	


	@Override
	public void add(DictionaryQuery dictionaryQuery) {
		Dictionary t = new Dictionary();
		BeanUtils.copyProperties(dictionaryQuery, t);
		dictionaryDao.save(t);
	}

	@Override
	public void update(DictionaryQuery dictionaryQuery) {
		Dictionary t = dictionaryDao.getById(dictionaryQuery.getId());
	    if(t != null) {
	    	BeanUtils.copyProperties(dictionaryQuery, t);
		}
	    dictionaryDao.update(t);
	}

	@Override
	public void delete(java.lang.String[] ids) {
		if (ids != null) {
			for(java.lang.String id : ids){
				Dictionary t = dictionaryDao.getById(new Long(id));
				if (t != null) {
					dictionaryDao.delete(t);
				}
			}
		}
	}

	@Override
	public Dictionary get(DictionaryQuery dictionaryQuery) {
		return dictionaryDao.getById(dictionaryQuery.getId());
	}

	@Override
	public Dictionary get(String id) {
		return dictionaryDao.getById(Long.parseLong(id));
	}

	
	@Override
	public List<DictionaryQuery> listAll(DictionaryQuery dictionaryQuery) {
	    List<Dictionary> list = dictionaryDao.findList(dictionaryQuery);
		List<DictionaryQuery> listQuery =getQuerysFromEntitys(list) ;
		return listQuery;
	}
	
	
}
