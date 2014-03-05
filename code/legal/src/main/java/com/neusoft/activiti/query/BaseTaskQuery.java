package com.neusoft.activiti.query;

import java.util.List;

import com.neusoft.base.common.Pager.Sort;
import com.neusoft.base.model.SearchModel;


public interface BaseTaskQuery {



	public String getIdColm() ;
	public void setIdColm(String idColm) ;

	public String getSubSql() ;

	public void setSubSql(String subSql) ;

	public List<String> getJoinList() ;

	public void setJoinList(List<String> joinList) ;

	public String getReturnColum() ;

	public void setReturnColum(String returnColum) ;

	public String getDynamicSql() ;

	public void setDynamicSql(String dynamicSql) ;

	public List<String> addJoin(String join);
	
	public Boolean getHasSubSql();

	public void setHasSubSql(Boolean hasSubSql) ;

	public List<Sort> getSortList();

	public void setSortList(List<Sort> sortList) ;
	public void setSearchModel(SearchModel searchModel);
}
