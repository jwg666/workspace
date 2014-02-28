package com.neusoft.security.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.neusoft.base.common.ConverterUtil;
import com.neusoft.base.common.Pager;
import com.neusoft.base.dao.HBaseDAO;
import com.neusoft.base.domain.Dictionary;
import com.neusoft.base.model.SearchModel;
import com.neusoft.security.domain.UploadFile;
import com.neusoft.security.query.UploadFileQuery;
@Repository
public class FileUploadDAO extends HBaseDAO<UploadFile> {

	public List<UploadFile> getFileByStatusAndType(SearchModel<UploadFile> model) {
		// TODO Auto-generated method stub
		return null;
	}

	public UploadFile get(Long id) {
		
		return (UploadFile)getById(UploadFile.class, id);
	}

	public List<UploadFile> findPage(UploadFileQuery model) {
		return findList(UploadFile.class, ConverterUtil.toHashMap(model));
	}

	public long findPageCount(UploadFileQuery model) {
		
		return getTotalCount(UploadFile.class, ConverterUtil.toHashMap(model));
	}

	public Pager<UploadFile> findPager(UploadFileQuery query) {
		Pager<UploadFile> pager = new Pager<UploadFile>();
		Map map = ConverterUtil.toHashMap(query);
		int page = query.getPage().intValue();
		int pageSize = query.getRows().intValue();
		int begin = (page-1)*pageSize;
		List<UploadFile> appList = findList(UploadFile.class, map, begin, pageSize);
		pager.setTotalRecords(getTotalCount(UploadFile.class, map));
		pager.setCurrentPage(query.getPage());
		pager.setPageSize(query.getRows());
		pager.setRecords(appList);
		return pager;
	}

}
