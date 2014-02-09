package com.neusoft.base.action;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
//import org.apache.tools.zip.ZipEntry;
//import org.apache.tools.zip.ZipOutputStream;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.neusoft.base.model.Json;


@Controller
@Scope("prototype")
public class FileUploadAction extends BaseAction {
	
	private static Log logger=LogFactory.getLog( FileUploadAction.class );

//	@Resource
//	private FileUploadService fileUploadServiceImpl;
	
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

	public String goUploadFile(){
		return "uploadFile";
	}
	/**
	 * 文件搜索
	 * @author wangzq
	 * @date 
	 * @return
	 */
	/**
	public void searchUploadFile() throws Exception{
		Pager<UploadFile> pager=initPage();
		FileSearchModel model = new FileSearchModel();
		UploadFile file = new UploadFile();
		file.setStatus(status);
		file.setType(type);
		file.setFileName(filename);
		file.setRemarks(remarks);
		model.setFile(file);
		model.setPager(pager);
		JSONObject datas = new JSONObject();
		pager=this.fileUploadService.findPage(model);
		datas.put(FileConstants.TOTAL, pager.getTotalRecords());
		datas.put(FileConstants.PAGE_SIZE, pager.getRecords());
		this.getResponse().setCharacterEncoding(FileConstants.ENCODING_UTF8);
		this.getResponse().getWriter().print(datas.toString());
	}
	public String deleteFile(){
		fileUploadServiceImpl.deleteFileByIds(fileids);
		return SUCCESS;
	}
	**/
	/*下载文件*/
	/**
	public String downloadFile(){
		if(fileIds==null || fileIds.length<1){
			fileAsStream = fileUploadServiceImpl.getFileInputStream(fileId);
			if(fileAsStream==null){
				return "nofile";
			}
			UploadFile uploadFile = fileUploadServiceImpl.getFileById(fileId);
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
				Servlets.setFileDownloadHeader(getRequest(),getResponse(), (org.apache.commons.lang3.StringUtils.isNotBlank(downloadFileName)?downloadFileName:"hrois下载")+".zip");
				OutputStream o = getResponse().getOutputStream();
				ZipOutputStream zos = new ZipOutputStream(o);
				zos.setEncoding("gbk");
			    zos.setComment("HROIS压缩包");   
		        zos.putNextEntry(new org.apache.tools.zip.ZipEntry("/"));
				for(Long id : fileIds){
					fileAsStream = fileUploadServiceImpl.getFileInputStream(id);
					if(fileAsStream!=null){
						BufferedInputStream bis = new BufferedInputStream(fileAsStream); 
						UploadFile uploadFile = fileUploadServiceImpl.getFileById(id);
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
	**/
	/**
	 * 下载文件-通过数据字典中的itemCode下载
	 * @author huangxq
	 * @date 2013-7-25
	 * @return
	 */
	/**
	public String downloadFileByItemCode(){
		SysLov sysLov= lovService.getByItemCode("DOCUMENT_ID", itemCode);
		fileAsStream = fileUploadServiceImpl.getFileInputStream(Long.parseLong(sysLov.getItemNameCn()));
		if(fileAsStream==null){
			return "nofile";
		}
		UploadFile uploadFile = fileUploadServiceImpl.getFileById(Long.parseLong(sysLov.getItemNameCn()));
		downloadFileName = uploadFile.getFileName();
		try {
			downloadFileName = new String(downloadFileName.getBytes(), "ISO8859-1");
		} catch (UnsupportedEncodingException e) {
			logger.info(e.getMessage(), e);
		} 
		downloadContentType = uploadFile.getContentType();
		return FILESTREAM;
	}
	//请求图片
	public String downloadImage(){
		fileAsStream = fileUploadServiceImpl.getFileInputStream(fileId);
		if(fileAsStream==null){
			return "nofile";
		}
		return IMGSTREAM;
	}
	//上传文件 返回文件信息json格式; ajax上传文件可以请求该方法
	public String uplaodFile(){
		if(upload!=null){
			UploadFile uploadFile = null;
			try {
				ExecuteResult<UploadFile> result = null;
				if(StringUtils.isBlank(remarks)){
					result = fileUploadServiceImpl.fileUpload(upload, uploadFileName,uploadContentType);
				}else{
					result = fileUploadServiceImpl.fileUpload(upload, uploadFileName,uploadContentType,remarks);
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
					 result = fileUploadServiceImpl.fileUploadToLocal(upload, path, uploadFileName, uploadContentType);
				}else{
					 result = fileUploadServiceImpl.fileUploadToLocal(upload, path, uploadFileName, uploadContentType, remarks);
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
			ExecuteResult<UploadFile> result = fileUploadServiceImpl.updateUplaodFile(fileId,upload, path, uploadFileName, uploadContentType, remarks);
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
	**/
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
}
