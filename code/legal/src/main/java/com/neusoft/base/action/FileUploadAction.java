package com.neusoft.base.action;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.neusoft.base.common.ExecuteResult;
import com.neusoft.base.common.FileConstants;
import com.neusoft.base.common.Pager;
import com.neusoft.base.common.ValidateUtil;
import com.neusoft.base.model.Json;
import com.neusoft.security.domain.UploadFile;
import com.neusoft.security.query.UploadFileQuery;
import com.neusoft.security.service.FileUploadService;
import com.opensymphony.xwork2.ModelDriven;
//import org.apache.tools.zip.ZipEntry;
//import org.apache.tools.zip.ZipOutputStream;


@Controller
@Scope("prototype")
public class FileUploadAction extends BaseAction implements ModelDriven<UploadFileQuery>{
	

	@Resource
	private FileUploadService fileUploadService;
	
	private static final long serialVersionUID = -134254657232545L;
	
	/*上传文件*/
	private File upload;//上传文件的参数名
	private String uploadFileName;//文件参数名后加上FileName (xxxFileName) struts 会自动获取文件名
	private String uploadContentType;//文件参数名后加上ContentType (xxxContentType) struts 会自动获取文件类型
	
	/*下载文件*/
	private Long fileId;//接受前台的文件id
	private Long[] fileIds;//接受前台的文件id
	private String downloadFileName;//下载显示的文件名称
	private String downloadContentType;//下载指定文件类型
	private InputStream fileAsStream ;//文件流
	private String itemCode;//接受前台传回的数据字典中对应文件id的编码
	
	//return view code
	private static final String IMGSTREAM = "imgstream";
	private static final String FILESTREAM = "filestream";
	
	//用于返回json
	private final Json json = new Json();
	//文件搜索参数
	private String fileids;
	private Integer status;
	private Integer type;
	private String filename;
	private String remarks;
	//分页参数
	private long page;
	private long rows;
	
	private UploadFileQuery uploadFileQuery = new UploadFileQuery();
	public String goUploadFile(){
		return "uploadFile";
	}
	//请求图片
		public String downloadImage(){
//			fileAsStream = fileUploadService.getFileInputStream(ServletActionContext.getServletContext().getRealPath("/"),fileId);
			fileAsStream = fileUploadService.getFileInputStream(fileId);
			if(fileAsStream==null){
				return "nofile";
			}
			return IMGSTREAM;
		}
	/**
	 * 文件搜索
	 * @author wangzq
	 * @date 
	 * @return
	 */
	
	public String searchUploadFile() throws Exception{		
		datagrid = fileUploadService.datagrid(uploadFileQuery);
		return "datagrid";
	}
	public String deleteFile(){
		fileUploadService.deleteFileByIds(fileids);
		return SUCCESS;
	}
	
	/*下载文件*/

	public String downloadFile(){
		if(fileIds==null || fileIds.length<1){
			fileAsStream = fileUploadService.getFileInputStream(fileId);
			if(fileAsStream==null){
				return "nofile";
			}
			UploadFile uploadFile = fileUploadService.getFileById(fileId);
			downloadFileName = uploadFile.getFileName();
			try {
				downloadFileName = new String(downloadFileName.getBytes(), "ISO8859-1");
			} catch (UnsupportedEncodingException e) {
				logger.info(e.getMessage(), e);
			} 
			downloadContentType = uploadFile.getContentType();
			return FILESTREAM;
		}else{
			try {
				getResponse().setContentType("application/zip");
//				Servlets.setFileDownloadHeader(getRequest(),getResponse(), (org.apache.commons.lang3.StringUtils.isNotBlank(downloadFileName)?downloadFileName:"下载")+".zip");
				OutputStream o = getResponse().getOutputStream();
				ZipOutputStream zos = new ZipOutputStream(o);
//				zos.setEncoding("gbk");
			    zos.setComment("压缩包");   
//		        zos.putNextEntry(new org.apache.tools.zip.ZipEntry("/"));
				for(Long id : fileIds){
					fileAsStream = fileUploadService.getFileInputStream(id);
					if(fileAsStream!=null){
						BufferedInputStream bis = new BufferedInputStream(fileAsStream); 
						UploadFile uploadFile = fileUploadService.getFileById(id);
						zos.putNextEntry(new ZipEntry(uploadFile.getFileName()));
						int bytesRead = 0;  
				        for (byte[] buffer = new byte[1024]; ((bytesRead = bis.read(buffer, 0, 1024)) != -1);) {  
				        	zos.write(buffer, 0, bytesRead); // 将流写入
				        }  
				        bis.close();
				        zos.closeEntry(); 
					}
				}
				zos.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return "filezip";
		}
	}
	
	
	//上传文件 返回文件信息json格式; ajax上传文件可以请求该方法
	public String uplaodFile(){
		logger.debug("------------------------------");
		if(upload!=null){
			UploadFile uploadFile = null;
			try {
				ExecuteResult<UploadFile> result = null;
				if(StringUtils.isBlank(remarks)){
					result = fileUploadService.fileUpload(upload, uploadFileName,uploadContentType);
				}else{
					result = fileUploadService.fileUpload(upload, uploadFileName,uploadContentType,remarks);
				}
				if(result.isSuccess()){
					uploadFile = result.getResult();
					json.setSuccess(true);
					json.setObj(uploadFile);
				}else{
					json.setObj(result.getErrorMessages());
				}
			} catch (IOException e) {
				logger.info(e.getMessage(), e);
			}
		}
		return SUCCESS;
	}
	//上传文件 返回文件信息json格式; ajax上传文件可以请求该方法
	public String uplaodFileToLocal(){
		if(upload!=null){
			UploadFile uploadFile = null;
			try {
				String path = "download/template";
				ExecuteResult<UploadFile> result = null;
				if(StringUtils.isBlank(remarks)){
					 result = fileUploadService.fileUploadToLocal(upload, path, uploadFileName, uploadContentType);
				}else{
					 result = fileUploadService.fileUploadToLocal(upload, path, uploadFileName, uploadContentType, remarks);
				}
				if(result.isSuccess()){
					uploadFile = result.getResult();
					json.setSuccess(true);
					json.setObj(uploadFile);
				}else{
					json.setObj(result.getErrorMessages());
				}
			} catch (IOException e) {
				logger.info(e.getMessage(), e);
			}
		}
		return SUCCESS;
	}
	
	public String updateFile(){
		if(fileId!=null){
			String path = "download/template";
			ExecuteResult<UploadFile> result = fileUploadService.updateUplaodFile(fileId,upload, path, uploadFileName, uploadContentType, remarks);
			json.setSuccess(result.isSuccess());
			json.setObj(result.getErrorMessages());
		}else{
			json.setObj("参数有误");
		}
		return SUCCESS;
	}
	
	private Pager<UploadFile> initPage(){
		Pager<UploadFile> pager=new Pager<UploadFile>();
		if(!ValidateUtil.isValid(page)){
			page=1;
		}
		if(!ValidateUtil.isValid(rows)){
			rows=10;
		}
		pager.setCurrentPage(page);
		pager.setPageSize(rows);
		return pager;
	}

	public Long getFileId() {
		return fileId;
	}
	public void setFileId(Long fileId) {
		this.fileId = fileId;
	}
	public InputStream getFileAsStream() {
		return fileAsStream;
	}
	public void setUpload(File upload) {
		this.upload = upload;
	}
	public void setUploadFileName(String uploadFileName) {
		this.uploadFileName = uploadFileName;
	}
	public void setUploadContentType(String uploadContentType) {
		this.uploadContentType = uploadContentType;
	}
	public String getDownloadFileName() {
		return downloadFileName;
	}
	public String setDownloadFileName(String downloadFileName) {
		return this.downloadFileName = downloadFileName;
	}
	public String getDownloadContentType() {
		return downloadContentType;
	}
	public Json getJson() {
		return json;
	}
	public String getFileids() {
		return fileids;
	}
	public void setFileids(String fileids) {
		this.fileids = fileids;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public long getPage() {
		return page;
	}
	public void setPage(long page) {
		this.page = page;
	}
	public long getRows() {
		return rows;
	}
	public void setRows(long rows) {
		this.rows = rows;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getItemCode() {
		return itemCode;
	}
	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public void setFileIds(Long[] fileIds) {
		this.fileIds = fileIds;
	}
	@Override
	public UploadFileQuery getModel() {
		return uploadFileQuery;
	}	
}
