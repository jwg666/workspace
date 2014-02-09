package com.neusoft.portal.service.impl;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.neusoft.base.common.Pager;
import com.neusoft.base.model.DataGrid;
import com.neusoft.portal.dao.FileDao;
import com.neusoft.portal.model.File;
import com.neusoft.portal.query.FileQuery;
import com.neusoft.portal.service.FileService;
@Service("fileService")
@Transactional
public class FileServiceImpl implements FileService{
	@Resource
	private FileDao fileDao;
	
	public void setFileDao(FileDao dao) {
		this.fileDao = dao;
	}

	@Override
	public DataGrid datagrid(FileQuery fileQuery) {
		DataGrid j = new DataGrid();
		Pager<File> pager  = find(fileQuery);
		j.setRows(getQuerysFromEntitys(pager.getRecords()));
		j.setTotal(pager.getTotalRecords());
		return j;
	}

	private List<FileQuery> getQuerysFromEntitys(List<File> files) {
		List<FileQuery> fileQuerys = new ArrayList<FileQuery>();
		if (files != null && files.size() > 0) {
			for (File tb : files) {
				FileQuery b = new FileQuery();
				BeanUtils.copyProperties(tb, b);
				fileQuerys.add(b);
			}
		}
		return fileQuerys;
	}

	private Pager<File> find(FileQuery fileQuery) {
		return  fileDao.findPage(fileQuery);
		
	}
	


	@Override
	public void add(FileQuery fileQuery) {
		File t = new File();
		BeanUtils.copyProperties(fileQuery, t);
		fileDao.save(t);
	}

	@Override
	public void update(FileQuery fileQuery) {
		File t = fileDao.getById(fileQuery.getTbid());
	    if(t != null) {
	    	BeanUtils.copyProperties(fileQuery, t);
		}
	    fileDao.update(t);
	}

	@Override
	public void delete(java.lang.Long[] ids) {
		if (ids != null) {
			for(java.lang.Long id : ids){
				File t = fileDao.getById(id);
				if (t != null) {
					fileDao.delete(t);
				}
			}
		}
	}

	@Override
	public File get(FileQuery fileQuery) {
		return fileDao.getById(Long.valueOf(fileQuery.getTbid()));
	}

	@Override
	public File get(String id) {
		return fileDao.getById(Long.parseLong(id));
	}

	
	@Override
	public List<FileQuery> listAll(FileQuery fileQuery) {
	    List<File> list = fileDao.findList(fileQuery);
		List<FileQuery> listQuery =getQuerysFromEntitys(list) ;
		return listQuery;
	}
	
	
}
