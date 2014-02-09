/*
 * Powered By [rapid-framework]
 * Web Site: http://www.rapid-framework.org.cn
 * Google Code: http://code.google.com/p/rapid-framework/
 * Since 2008 - 2013
 */

package com.neusoft.portal.service;

import java.util.List;

import com.neusoft.base.model.DataGrid;
import com.neusoft.portal.model.Member;
import com.neusoft.portal.query.MemberQuery;
public interface MemberService{

	/**
	 * 获得数据表格
	 * 
	 * @param bug
	 * @return
	 */
	public DataGrid datagrid(MemberQuery memberQuery);

	/**
	 * 添加
	 * 
	 * @param memberQuery
	 */
	public void add(MemberQuery memberQuery);

	/**
	 * 修改
	 * 
	 * @param memberQuery
	 */
	public void update(MemberQuery memberQuery) ;

	/**
	 * 删除
	 * 
	 * @param ids
	 */
	public void delete(java.lang.Long[] ids);

	/**
	 * 获得
	 * 
	 * @param Member
	 * @return
	 */
	public Member get(MemberQuery memberQuery);
	
	
	/**
	 * 获得
	 * 
	 * @param obid
	 * @return
	 */
	public Member get(String id);
	
	/**
	 * 获取所有数据
	 */
	public List<MemberQuery> listAll(MemberQuery memberQuery);

	/**
	 * 获取当前用户
	 */
	public Member getCurMember();
	/**
	 * 获取当前用户
	 */
	public MemberQuery getCurMemberQuery();
	/**
	 * 初始化用户桌面配置
	 */
	public MemberQuery createDefault(MemberQuery memberQuery);
}
