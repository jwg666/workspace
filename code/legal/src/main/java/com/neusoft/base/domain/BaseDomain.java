package com.neusoft.base.domain;


import java.io.Serializable;
import java.util.Date;

/**
 * 所有bean类的基类，设置公共属性
 * 
 * @author WangXuzheng
 * 
 */
public class BaseDomain<PK extends Serializable> implements Serializable {
	private static final long serialVersionUID = 6686489176603998566L;
	/**
	 * 主键
	 */
	private PK id;
	/**
	 * 记录创建时间
	 */
	private Date gmtCreate;
	/**
	 * 记录修改时间
	 */
	private Date gmtModified;
	/**
	 * 记录创建者
	 */
	private String createBy;
	/**
	 * 最后修改者
	 */
	private String lastModifiedBy;

	public PK getId() {
		return id;
	}

	public void setId(PK id) {
		this.id = id;
	}

	public Date getGmtCreate() {
		return gmtCreate;
	}

	public void setGmtCreate(Date gmtCreate) {
		this.gmtCreate = gmtCreate;
	}

	public Date getGmtModified() {
		return gmtModified;
	}

	public void setGmtModified(Date gmtModified) {
		this.gmtModified = gmtModified;
	}

	public String getCreateBy() {
		return createBy;
	}

	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}

	public String getLastModifiedBy() {
		return lastModifiedBy;
	}

	public void setLastModifiedBy(String lastModifiedBy) {
		this.lastModifiedBy = lastModifiedBy;
	}
}
