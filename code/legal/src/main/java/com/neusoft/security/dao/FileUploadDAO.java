package com.neusoft.security.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.neusoft.base.dao.HBaseDAO;
import com.neusoft.base.model.SearchModel;
import com.neusoft.security.domain.UploadFile;
@Repository
public class FileUploadDAO extends HBaseDAO<UploadFile> {

	public List<UploadFile> getFileByStatusAndType(SearchModel<UploadFile> model) {
		// TODO Auto-generated method stub
		return null;
	}

	public UploadFile get(Long id) {
		
		return (UploadFile)getById(UploadFile.class, id);
	}

	public List<UploadFile> findPage(SearchModel<UploadFile> model) {
		// TODO Auto-generated method stub
		return null;
	}

	public long findPageCount(SearchModel<UploadFile> model) {
		// TODO Auto-generated method stub
		return 0;
	}

}
