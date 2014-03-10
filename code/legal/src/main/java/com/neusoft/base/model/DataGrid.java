package com.neusoft.base.model;

import java.util.Date;
import java.util.List;

/**
 * easyui的datagrid模型
 * 
 * @author 张代浩
 * 
 */
public class DataGrid implements java.io.Serializable {
	
	private Long total;// 总记录数
	private List rows;// 每行记录
	private List footer;
	private Date now = new Date();
	private List children;
	public Long getTotal() {
		return total;
	}

	public void setTotal(Long total) {
		this.total = total;
	}

	public List getRows() {
		return rows;
	}

	public void setRows(List rows) {
		this.rows = rows;
	}

	public List getFooter() {
		return footer;
	}

	public void setFooter(List footer) {
		this.footer = footer;
	}

	public Date getNow() {
		return now;
	}

	public void setNow(Date now) {
		this.now = now;
	}

	public List getChildren() {
		return children;
	}

	public void setChildren(List children) {
		this.children = children;
	}
	
}
