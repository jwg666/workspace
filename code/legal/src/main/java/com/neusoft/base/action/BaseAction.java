package com.neusoft.base.action;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.neusoft.base.common.PageList;
import com.neusoft.base.model.DataGrid;
import com.neusoft.base.model.Json;
import com.opensymphony.xwork2.ActionSupport;

public class BaseAction extends ActionSupport{
	
	private static final long serialVersionUID = 9000707921993556574L;
	protected Logger logger = LoggerFactory.getLogger(getClass());
	protected int pageNo=1;
	protected int pageSize=20;
	
	protected PageList pageList;
	protected DataGrid datagrid;
	protected final Json json = new Json();
	public int getPageNo() {
		return pageNo;
	}
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public PageList getPageList() {
		return pageList;
	}
	public void setPageList(PageList pageList) {
		this.pageList = pageList;
	}
	public DataGrid getDatagrid() {
		return datagrid;
	}
	public void setDatagrid(DataGrid datagrid) {
		this.datagrid = datagrid;
	}
	public Json getJson() {
		return json;
	}
	
}
