/*
 * Powered By [rapid-framework]
 * Web Site: http://www.rapid-framework.org.cn
 * Google Code: http://code.google.com/p/rapid-framework/
 * Since 2008 - 2013
 */

package com.neusoft.portal.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.neusoft.base.common.Pager;
import com.neusoft.base.common.PropertyUtils;
import com.neusoft.base.dao.HBaseDAO;
import com.neusoft.portal.model.File;
import com.neusoft.portal.query.FileQuery;

/**
 * database table: tb_file
 * database table comments: File
 */
@Repository
public class FileDao extends HBaseDAO<File>{
	
		
	public void saveOrUpdate(File entity) {
		if(entity.getTbid() == null){
			save(entity);
		}else{
			update(entity);
		}
	}
	
    public File getById(Long id) {
		
		return (File)getById(File.class, id);
	}

	@SuppressWarnings("unchecked")
	public List<File> findList(FileQuery appQuery) {		
		return findList(File.class, PropertyUtils.toParameterMap(appQuery));
	}


	public Pager<File> findPage(FileQuery appQuery) {
		Pager<File> pager = new Pager<File>();
		Map map = PropertyUtils.toParameterMap(appQuery);
		List<File> appList = findList(File.class, map, appQuery.getPage().intValue(), appQuery.getRows().intValue());
		pager.setTotalRecords(getTotalCount(File.class, map));
		pager.setCurrentPage(appQuery.getPage());
		pager.setPageSize(appQuery.getRows());
		pager.setRecords(appList);
		return pager;
	}
	 

}
