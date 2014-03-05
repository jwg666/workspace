package com.neusoft.activiti.query;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.activiti.engine.impl.TaskQueryImpl;

import com.neusoft.base.common.LoginContextHolder;
import com.neusoft.base.common.Pager.Sort;
import com.neusoft.base.common.SpringApplicationContextHolder;
import com.neusoft.base.common.ValidateUtil;
import com.neusoft.base.model.SearchModel;
import com.neusoft.security.domain.UserInfo;
import com.neusoft.security.service.UserInfoService;

public class BaseTaskQueryImpl extends TaskQueryImpl implements BaseTaskQuery {

	/**
	 * 
	 */
	private static final long serialVersionUID = 9007691141760469131L;

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
	 * 是否拥有全部的权限
	 */
	private Boolean checkAll = false;

	private Boolean hasSubSql=false;
	
	private List<Sort> sortList;

	private String sort;
	
	private String order;
	
	private SearchModel searchModel;
	
	public  BaseTaskQueryImpl(){
		//默认查询不挂起的流程
		super.active();
	}
	/**
	 * 用户分配人列表
	 */
	private Set<String> assigneeList;
	
	
	/**
	 * 查询当前登录用户的个人任务
	 */
	public BaseTaskQueryImpl taskAssigneeCurrUser() {
		Long userId = LoginContextHolder.get().getUserId();
		UserInfoService userInfoService = SpringApplicationContextHolder
				.getBean("userInfoService");
		UserInfo user = userInfoService.getUserInfoById(userId);
		super.taskAssignee(user.getEmpCode());
		return this;
	}

	/**
	 * 查询当前登录用户的组任务
	 */
	public BaseTaskQueryImpl taskCandidateGroupCurrUser() {
		Long userId = LoginContextHolder.get().getUserId();
		/**
		 * 查询用户所在的组 传入到工作流 查询组任务
		 */
		List<String> groupCodeList = new ArrayList<String>();
		super.taskCandidateGroupIn(groupCodeList);
		return this;
	}

	/**
	 * 查询当前登录用户所有任务的合集： 包括 ：个人任务，组任务，
	 * 
	 * @return
	 */
	public BaseTaskQueryImpl taskAllCanCheck() {
		this.checkAll = true;
		taskCandidateGroupCurrUser();
		taskAssigneeCurrUser();
		return this;
	}

	public Boolean getCheckAll() {
		return checkAll;
	}

	public void setCheckAll(Boolean checkAll) {
		this.checkAll = checkAll;
	}

	public String getSubSql() {
	if(ValidateUtil.isValid(subSql)){
		hasSubSql=true;
	}
		return subSql;
	}

	public void setSubSql(String subSql) {
		hasSubSql=true;
		this.subSql = subSql;
	}

	public String getIdColm() {
		return idColm;
	}

	public void setIdColm(String idColm) {
		this.idColm = idColm;
	}

	public List<String> addJoin(String join) {
		joinList.add(join);
		return joinList;
	}

	public List<String> getJoinList() {
		return joinList;
	}

	public void setJoinList(List<String> joinList) {
		this.joinList = joinList;
	}

	public String getReturnColum() {
		return returnColum;
	}

	public void setReturnColum(String returnColum) {
		this.returnColum = returnColum;
	}

	public String getDynamicSql() {
		return dynamicSql;
	}

	public void setDynamicSql(String dynamicSql) {
		this.dynamicSql = dynamicSql.replace("where", "").replace("WHERE", "");
	}

	public Boolean getHasSubSql() {
		if(ValidateUtil.isValid(subSql)){
			hasSubSql=true;
		}
		return hasSubSql;
	}


	public void setHasSubSql(Boolean hasSubSql) {
		this.hasSubSql = hasSubSql;
	}

	public Set<String> getAssigneeList() {
		return assigneeList;
	}

	public void setAssigneeList(Set<String> assigneeList) {
		this.assigneeList = assigneeList;
	}
	
	public void setAssignee(String assignee){
		super.assignee=assignee;
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
