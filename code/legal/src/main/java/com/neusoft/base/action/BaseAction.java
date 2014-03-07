package com.neusoft.base.action;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.neusoft.base.common.ExecuteResult;
import com.neusoft.base.common.PageList;
import com.neusoft.base.model.DataGrid;
import com.neusoft.base.model.Json;
import com.opensymphony.xwork2.ActionSupport;

public class BaseAction extends ActionSupport{
	
	private static final long serialVersionUID = 9000707921993556574L;
	protected Logger logger = LoggerFactory.getLogger(getClass());
	protected int pageNo=1;
	protected int pageSize=20;
	protected String order;
	protected PageList pageList;
	protected DataGrid datagrid;
	protected final Json json = new Json();
	
	public String getOrder() {
		return order;
	}
	public void setOrder(String order) {
		this.order = order;
	}
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
	/**
	 * 将业务层返回的errorMessage和field写入到value stack中
	 * 
	 * @param result
	 */
	public void addActionErrorsFromResult(ExecuteResult<?> result) {
		for (String error : result.getErrorMessages()) {
			this.addActionError(error);
		}
	}

	public void addFieldErrorsFromResult(ExecuteResult<?> result) {
		for (String field : result.getFieldErrors().keySet()) {
			this.addFieldError(field, result.getFieldErrors().get(field));
		}
	}

	public void addErrorsFromResult(ExecuteResult<?> result) {
		addActionErrorsFromResult(result);
		addFieldErrorsFromResult(result);
	}

	protected HttpServletRequest getRequest() {
		return ServletActionContext.getRequest();
	}

	protected HttpSession getSession() {
		return getRequest().getSession();
	}

	protected HttpServletResponse getResponse() {
		return ServletActionContext.getResponse();
	}
}
