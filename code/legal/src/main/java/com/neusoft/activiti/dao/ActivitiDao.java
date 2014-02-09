/*
 * Powered By [rapid-framework]
 * Web Site: http://www.rapid-framework.org.cn
 * Google Code: http://code.google.com/p/rapid-framework/
 * Since 2008 - 2013
 */

package com.neusoft.activiti.dao;

import java.util.Map;

import org.activiti.engine.impl.persistence.entity.HistoricActivityInstanceEntity;
import org.springframework.stereotype.Repository;

import com.neusoft.base.dao.HBaseDAO;
import com.neusoft.base.model.BaseModel;

/**
 * 对工作流的扩展应用
 * 
 */
@Repository
public class ActivitiDao extends HBaseDAO<BaseModel>{
	
	/**
	 * 删除流程活动
	 * @param historicActivityInstanceEntity
	 */
	public void deleteHistoricActivityInstance(HistoricActivityInstanceEntity  historicActivityInstanceEntity){
//		getSqlSession()delete("hrois.activiti.extend.deleteHistoricActivityInstance",historicActivityInstanceEntity );
	}
	
	/**
	 * 更新新的流程定义
	 * @param statement
	 * @param parameterMap
	 */
	public void updateProdecId(String statement,Map<String,Object> parameterMap){
//		getSqlSession().update("hrois.activiti.extend."+statement, parameterMap);
	}
	

}
