package com.neusoft.security.query;

import java.io.Serializable;
import java.util.Date;

import com.neusoft.base.model.SearchModel;
import com.neusoft.security.domain.UploadFile;

public class UploadFileQuery extends  SearchModel<UploadFile> implements Serializable {

	private static final long serialVersionUID = -5535669460265462190L;
	private Long id;
	private String fileName;
	private String saveFileName;
	private String filePath1;
	private String filePath2;
	private Integer status;
	private Integer type;
	private String remarks;
	private Date lastModifiedDt;
	private String lastModifiedBy;
	private Date createDt;
	private String createBy;
	private String ContentType;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getSaveFileName() {
		return saveFileName;
	}
	public void setSaveFileName(String saveFileName) {
		this.saveFileName = saveFileName;
	}
	public String getFilePath1() {
		return filePath1;
	}
	public void setFilePath1(String filePath1) {
		this.filePath1 = filePath1;
	}
	public String getFilePath2() {
		return filePath2;
	}
	public void setFilePath2(String filePath2) {
		this.filePath2 = filePath2;
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
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public Date getLastModifiedDt() {
		return lastModifiedDt;
	}
	public void setLastModifiedDt(Date lastModifiedDt) {
		this.lastModifiedDt = lastModifiedDt;
	}
	public String getLastModifiedBy() {
		return lastModifiedBy;
	}
	public void setLastModifiedBy(String lastModifiedBy) {
		this.lastModifiedBy = lastModifiedBy;
	}
	public Date getCreateDt() {
		return createDt;
	}
	public void setCreateDt(Date createDt) {
		this.createDt = createDt;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getContentType() {
		return ContentType;
	}
	public void setContentType(String contentType) {
		ContentType = contentType;
	}
	
}
