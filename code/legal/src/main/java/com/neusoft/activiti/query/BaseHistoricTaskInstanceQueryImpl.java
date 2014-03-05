package com.neusoft.activiti.query;

import java.util.ArrayList;
import java.util.List;

import org.activiti.engine.impl.HistoricTaskInstanceQueryImpl;

import com.neusoft.base.common.LoginContextHolder;
import com.neusoft.base.common.Pager.Sort;
import com.neusoft.base.common.SpringApplicationContextHolder;
import com.neusoft.base.model.SearchModel;
import com.neusoft.security.domain.UserInfo;
import com.neusoft.security.service.UserInfoService;

public class BaseHistoricTaskInstanceQueryImpl extends HistoricTaskInstanceQueryImpl implements BaseTaskQuery {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1181756529867326724L;

	/**
	 * 表单的ID字段默认为ROW_ID 如果不是ROW_ID需要自己定义
	 */
	protected String idColm = "ROW_ID";
	/**
	 * 业务数据子查询的sql 子查询返回结果只包括 业务表Id
	 * */
	protected String subSql;
	/**
	 * 表连接字符串 eg:inner join WF_PROCINSTANCE WF on WF.PROCESSINSTANCE_ID =
	 * RES.PROC_INST_ID_ 已经包含的表别名： FORMTABLE 业务表（也就是关联的tablename的表的别名） WF
	 * WF_PROCINSTANCE 表（流程,与业务表的 连接表） RES ACT_RU_TASK 工作流的任务表
	 * 
	 * @return
	 */
	protected List<String> joinList = new ArrayList<String>();

	/**
	 * sql要返回的字段列默认为全部按照表的原列进行显示：distinct *
	 * 
	 * @return
	 */
	protected String returnColum=" * ";

	/**
	 * 动态查询的sql
	 */
	private String dynamicSql;
	
	/**
	 * 
	 * @return
	 */

	private Boolean hasSubSql=true;
	/*排序*/
	private List<Sort> sortList;
	
	private String sort;
	
	private String order;
	
	private SearchModel searchModel;
	
	public BaseHistoricTaskInstanceQueryImpl taskAssigneeCurrUser(){
		Long userId = LoginContextHolder.get().getUserId();
		UserInfoService userInfoService = SpringApplicationContextHolder.getBean("userService");
		UserInfo userInfo = userInfoService.getUserInfoById(userId);
		super.taskAssignee(userInfo.getEmpCode());
		return  this;
	}
	

	@Override
	public String getIdColm() {
		return idColm;
	}

	@Override
	public void setIdColm(String idColm) {
		this.idColm = idColm;
	}

	@Override
	public String getSubSql() {
		return subSql;
	}

	@Override
	public void setSubSql(String subSql) {
		this.subSql = subSql;
	}

	@Override
	public List<String> getJoinList() {
		return joinList;
	}

	@Override
	public void setJoinList(List<String> joinList) {
		this.joinList = joinList;
	}

	@Override
	public String getReturnColum() {
		return returnColum;
	}

	@Override
	public void setReturnColum(String returnColum) {
		this.returnColum = returnColum;
	}

	@Override
	public String getDynamicSql() {
		return dynamicSql;
	}

	@Override
	public void setDynamicSql(String dynamicSql) {
		this.dynamicSql = dynamicSql.replace("where", "").replace("WHERE", "");
	}

	@Override
	public List<String> addJoin(String join) {
		joinList.add(join);
		return joinList;
	}


	public Boolean getHasSubSql() {
		return hasSubSql;
	}


	public void setHasSubSql(Boolean hasSubSql) {
		this.hasSubSql = hasSubSql;
	}


	public String getSort() {
		return sort;
	}


	public void setSort(String sort) {
		this.sort = sort;
	}


	public String getOrder() {
		return order;
	}


	public void setOrder(String order) {
		this.order = order;
	}
	
	
	
	public List<Sort> getSortList() {
		return sortList;
	}

	public void setSortList(List<Sort> sortList) {
		this.sortList = sortList;
	}


	public SearchModel getSearchModel() {
		return searchModel;
	}


	public void setSearchModel(SearchModel searchModel) {
		this.searchModel = searchModel;
	}

	
	
}
