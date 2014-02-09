/*
 * Powered By [rapid-framework]
 * Web Site: http://www.rapid-framework.org.cn
 * Google Code: http://code.google.com/p/rapid-framework/
 * Since 2008 - 2013
 */

package com.neusoft.activiti.query;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import com.neusoft.activiti.domain.TransitionRecord;
import com.neusoft.base.model.SearchModel;
/**
 * database table: ACT_TRANSITION_RECORD
 * database table comments: ACT_TRANSITION_RECORD
 */
public class TransitionRecordQuery extends  SearchModel<TransitionRecord> implements Serializable {
    
  private static final long serialVersionUID = 3148176768559230877L;
    

	  /**
     * 唯一标识       db_column: ROW_ID 
     */	
	private java.lang.String rowId;
	  /**
     * 业务主键       db_column: BUSINFORMID 
     */	
	private java.lang.String businformid;
	  /**
     * 流程实例Id       db_column: PROCESSINSTANCEID 
     */	
	private java.lang.String processinstanceid;
	  /**
     * 流程节点key       db_column: PROCESSDEFINITIONKEY 
     */	
	private java.lang.String processdefinitionkey;
	  /**
     * 源节点名称       db_column: SOURCE_NAME 
     */	
	private java.lang.String sourceName;
	  /**
     * 源节点ID       db_column: SOURCE_ID 
     */	
	private java.lang.String sourceId;
	  /**
     * 源节点办理人       db_column: ASSGIN 
     */	
	private java.lang.String assgin;
	  /**
     * 目标节点名称       db_column: DEST_NAME 
     */	
	private java.lang.String destName;
	  /**
     * 目标节点ID       db_column: DEST_ID 
     */	
	private java.lang.String destId;
	  /**
     * 流转时间       db_column: TRANSITION_TIME 
     */	
	private java.util.Date transitionTime;
	  /**
     * 备注（原因）       db_column: COMMENTS 
     */	
	private java.lang.String comments;
	  /**
     * 附件       db_column: ATTACHMENT 
     */	
	private java.lang.String attachment;
	  /**
     * 类型（暂时冗余）       db_column: TYPES 
     */	
	private java.lang.String types;
	  /**
     * 其他 （暂时冗余）       db_column: OTHER 
     */	
	private java.lang.String other;
	  /**
     * 源节点类型       db_column: SOURCE_TYPE 
     */	
	private java.lang.String sourceType;
	  /**
     * 目标节点类型       db_column: DEST_TYPE 
     */	
	private java.lang.String destType;

	public java.lang.String getRowId() {
		return this.rowId;
	}
	
	public void setRowId(java.lang.String value) {
		this.rowId = value;
	}
	
	public java.lang.String getBusinformid() {
		return this.businformid;
	}
	
	public void setBusinformid(java.lang.String value) {
		this.businformid = value;
	}
	
	public java.lang.String getProcessinstanceid() {
		return this.processinstanceid;
	}
	
	public void setProcessinstanceid(java.lang.String value) {
		this.processinstanceid = value;
	}
	
	public java.lang.String getProcessdefinitionkey() {
		return this.processdefinitionkey;
	}
	
	public void setProcessdefinitionkey(java.lang.String value) {
		this.processdefinitionkey = value;
	}
	
	public java.lang.String getSourceName() {
		return this.sourceName;
	}
	
	public void setSourceName(java.lang.String value) {
		this.sourceName = value;
	}
	
	public java.lang.String getSourceId() {
		return this.sourceId;
	}
	
	public void setSourceId(java.lang.String value) {
		this.sourceId = value;
	}
	
	public java.lang.String getAssgin() {
		return this.assgin;
	}
	
	public void setAssgin(java.lang.String value) {
		this.assgin = value;
	}
	
	public java.lang.String getDestName() {
		return this.destName;
	}
	
	public void setDestName(java.lang.String value) {
		this.destName = value;
	}
	
	public java.lang.String getDestId() {
		return this.destId;
	}
	
	public void setDestId(java.lang.String value) {
		this.destId = value;
	}
	
	public java.util.Date getTransitionTime() {
		return this.transitionTime;
	}
	
	public void setTransitionTime(java.util.Date value) {
		this.transitionTime = value;
	}
	
	public java.lang.String getComments() {
		return this.comments;
	}
	
	public void setComments(java.lang.String value) {
		this.comments = value;
	}
	
	public java.lang.String getAttachment() {
		return this.attachment;
	}
	
	public void setAttachment(java.lang.String value) {
		this.attachment = value;
	}
	
	public java.lang.String getTypes() {
		return this.types;
	}
	
	public void setTypes(java.lang.String value) {
		this.types = value;
	}
	
	public java.lang.String getOther() {
		return this.other;
	}
	
	public void setOther(java.lang.String value) {
		this.other = value;
	}
	
	public java.lang.String getSourceType() {
		return this.sourceType;
	}
	
	public void setSourceType(java.lang.String value) {
		this.sourceType = value;
	}
	
	public java.lang.String getDestType() {
		return this.destType;
	}
	
	public void setDestType(java.lang.String value) {
		this.destType = value;
	}
	

	
	private java.lang.String[] ids;
	
	public java.lang.String[] getIds() {
		return this.ids;
	}
	
	public void setIds(java.lang.String[] value) {
		this.ids = value;
	}
	
	public String toString() {
		return ToStringBuilder.reflectionToString(this,ToStringStyle.MULTI_LINE_STYLE);
	}
	
}

