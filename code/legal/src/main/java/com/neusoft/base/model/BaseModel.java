package com.neusoft.base.model;

public class BaseModel {
	protected int pageSize;
	protected int pageNo;
	protected Long fetchSize;
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getPageNo() {
		return pageNo;
	}
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	public Long getFetchSize() {
		return fetchSize;
	}
	public void setFetchSize(Long fetchSize) {
		this.fetchSize = fetchSize;
	}
	
}
