

package com.neusoft.portal.service;

import java.util.List;
import java.util.Map;

import com.neusoft.base.model.DataGrid;
import com.neusoft.portal.model.MemberApp;
import com.neusoft.portal.query.MemberAppQuery;
public interface MemberAppService{

	/**
	 * 获得数据表格
	 * 
	 * @param bug
	 * @return
	 */
	public DataGrid datagrid(MemberAppQuery memberAppQuery);

	/**
	 * 添加
	 * 
	 * @param memberAppQuery
	 */
	public MemberApp add(MemberAppQuery memberAppQuery);

	/**
	 * 修改
	 * 
	 * @param memberAppQuery
	 */
	public void update(MemberAppQuery memberAppQuery) ;

	/**
	 * 删除
	 * 
	 * @param ids
	 */
	public void delete(java.lang.Long[] ids);

	/**
	 * 获得
	 * 
	 * @param MemberApp
	 * @return
	 */
	public MemberApp get(MemberAppQuery memberAppQuery);
	
	
	/**
	 * 获得
	 * 
	 * @param obid
	 * @return
	 */
	public MemberApp get(String id);
	
	/**
	 * 获取所有数据
	 */
	public List<MemberAppQuery> listAll(MemberAppQuery memberAppQuery);

	/**
	 * 添加应用
	 */
	public void addMyApp(MemberAppQuery memberAppQuery);
	/**
	 * 删除应用
	 */
	public void delApp(MemberAppQuery memberAppQuery);
	/**
	 * 更新应用
	 */
	public void updateMyApp(Long id,String movetype,Integer desk,Integer otherdesk,Integer from ,Integer to);
	
	public Map findMyApp();

}
