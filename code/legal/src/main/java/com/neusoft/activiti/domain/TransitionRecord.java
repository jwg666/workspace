/*
 * Powered By [rapid-framework]
 * Web Site: http://www.rapid-framework.org.cn
 * Google Code: http://code.google.com/p/rapid-framework/
 * Since 2008 - 2013
 */

package com.neusoft.activiti.domain;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

import com.neusoft.base.common.DateUtils;

/**
 * database table: ACT_TRANSITION_RECORD
 * database table comments: ACT_TRANSITION_RECORD
 */
public class TransitionRecord  implements java.io.Serializable{
	private static final long serialVersionUID = 5454155825314635342L;
	
	//alias
	public static final String TABLE_ALIAS = "ACT_TRANSITION_RECORD";
	public static final String ALIAS_ROW_ID = "唯一标识";
	public static final String ALIAS_BUSINFORMID = "业务主键";
	public static final String ALIAS_PROCESSINSTANCEID = "流程实例Id";
	public static final String ALIAS_PROCESSDEFINITIONKEY = "流程节点key";
	public static final String ALIAS_SOURCE_NAME = "源节点名称";
	public static final String ALIAS_SOURCE_ID = "源节点ID";
	public static final String ALIAS_ASSGIN = "源节点办理人";
	public static final String ALIAS_DEST_NAME = "目标节点名称";
	public static final String ALIAS_DEST_ID = "目标节点ID";
	public static final String ALIAS_TRANSITION_TIME = "流转时间";
	public static final String ALIAS_COMMENTS = "备注（原因）";
	public static final String ALIAS_ATTACHMENT = "附件";
	public static final String ALIAS_TYPES = "类型（暂时冗余）";
	public static final String ALIAS_OTHER = "其他 （暂时冗余）";
	public static final String ALIAS_SOURCE_TYPE = "源节点类型";
	public static final String ALIAS_DEST_TYPE = "目标节点类型";
	
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
	//columns END

	public TransitionRecord(){
	}

	public TransitionRecord(
		java.lang.String rowId
	){
		this.rowId = rowId;
	}

	public void setRowId(java.lang.String value) {
		this.rowId = value;
	}
	
	public java.lang.String getRowId() {
		return this.rowId;
	}
	public void setBusinformid(java.lang.String value) {
		this.businformid = value;
	}
	
	public java.lang.String getBusinformid() {
		return this.businformid;
	}
	public void setProcessinstanceid(java.lang.String value) {
		this.processinstanceid = value;
	}
	
	public java.lang.String getProcessinstanceid() {
		return this.processinstanceid;
	}
	public void setProcessdefinitionkey(java.lang.String value) {
		this.processdefinitionkey = value;
	}
	
	public java.lang.String getProcessdefinitionkey() {
		return this.processdefinitionkey;
	}
	public void setSourceName(java.lang.String value) {
		this.sourceName = value;
	}
	
	public java.lang.String getSourceName() {
		return this.sourceName;
	}
	public void setSourceId(java.lang.String value) {
		this.sourceId = value;
	}
	
	public java.lang.String getSourceId() {
		return this.sourceId;
	}
	public void setAssgin(java.lang.String value) {
		this.assgin = value;
	}
	
	public java.lang.String getAssgin() {
		return this.assgin;
	}
	public void setDestName(java.lang.String value) {
		this.destName = value;
	}
	
	public java.lang.String getDestName() {
		return this.destName;
	}
	public void setDestId(java.lang.String value) {
		this.destId = value;
	}
	
	public java.lang.String getDestId() {
		return this.destId;
	}
	public String getTransitionTimeString() {
		//return DateConvertUtils.format(getTransitionTime(), FORMAT_TRANSITION_TIME);
		return  DateUtils.format(DateUtils.FORMAT2,getTransitionTime());
	}
	public void setTransitionTimeString(String value) {
		setTransitionTime(DateUtils.parse(value,DateUtils.FORMAT2,java.util.Date.class));
	}
	
	public void setTransitionTime(java.util.Date value) {
		this.transitionTime = value;
	}
	
	public java.util.Date getTransitionTime() {
		return this.transitionTime;
	}
	public void setComments(java.lang.String value) {
		this.comments = value;
	}
	
	public java.lang.String getComments() {
		return this.comments;
	}
	public void setAttachment(java.lang.String value) {
		this.attachment = value;
	}
	
	public java.lang.String getAttachment() {
		return this.attachment;
	}
	public void setTypes(java.lang.String value) {
		this.types = value;
	}
	
	public java.lang.String getTypes() {
		return this.types;
	}
	public void setOther(java.lang.String value) {
		this.other = value;
	}
	
	public java.lang.String getOther() {
		return this.other;
	}
	public void setSourceType(java.lang.String value) {
		this.sourceType = value;
	}
	
	public java.lang.String getSourceType() {
		return this.sourceType;
	}
	public void setDestType(java.lang.String value) {
		this.destType = value;
	}
	
	public java.lang.String getDestType() {
		return this.destType;
	}

	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getRowId())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if( !(obj instanceof TransitionRecord )){ return false;}
		if(this == obj){ return true;}
		TransitionRecord other = (TransitionRecord)obj;
		return new EqualsBuilder()
			.append(getRowId(),other.getRowId())
			.isEquals();
	}
}

