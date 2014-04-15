package com.neusoft.security.service;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import com.neusoft.base.common.ExecuteResult;
import com.neusoft.base.common.Pager;
import com.neusoft.base.model.DataGrid;
import com.neusoft.security.domain.UploadFile;
import com.neusoft.security.query.UploadFileQuery;


public interface FileUploadService {
	
	
	ExecuteResult<UploadFile> fileUpload(File fileInput,String fileInputFileName) throws IOException;
	
	ExecuteResult<UploadFile> fileUpload(File fileInput,String fileInputFileName,String fileInputContentType) throws IOException;
	
	ExecuteResult<UploadFile> fileUpload(File fileInput,String fileInputFileName, String fileInputContentType,String remarks) throws IOException;

	ExecuteResult<UploadFile> fileUploadToLocal(File fileInput,String fileInputFileName,String fileInputContentType,String path) throws IOException;
	
	ExecuteResult<UploadFile> fileUploadToLocal(File fileInput, String path,String fileInputFileName, String fileInputContentType,String remarks) throws IOException;
	
	InputStream getFileInputStream(Long id);
	
	UploadFile getFileById(Long id);

	ExecuteResult<String> deleteFileByIds(String ids);
	
	List<UploadFile> getFileByStatusAndType(UploadFileQuery model);
	
	Pager<UploadFile> findPage(UploadFileQuery model);

	ExecuteResult<UploadFile> updateUplaodFile(Long id, File upload, String path, String uploadFileName,String uploadContentType, String remarks);
	
	public  InputStream getFileInputStream(String realPath,Long id) ;

	DataGrid datagrid(UploadFileQuery query);

	String fileUpload(InputStream ins, String fileName);
	
}
