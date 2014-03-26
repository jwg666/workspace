package com.neusoft.security.dao;

import java.util.List;
import java.util.Map;

import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.neusoft.base.common.ConverterUtil;
import com.neusoft.base.common.Pager;
import com.neusoft.base.dao.HBaseDAO;
import com.neusoft.security.domain.UserInfo;
import com.neusoft.security.query.UserInfoQuery;

/**
 * 用户接口
 * @author WangXuzheng
 *
 */
@Repository
public class UserInfoDAO extends HBaseDAO<UserInfo>{
	/**
	 * 通过用户
	 * @param id
	 * @return
	 */
	public UserInfo getUserInfoByName(String name){
		return null;
	}
	
	public UserInfo getByCodeIgnoreCase(String name){
		//TODO 忽略大小写
		return (UserInfo)getCriteria(UserInfo.class).add(Restrictions.eq("empCode", name)).uniqueResult();
	}
	
	public List<UserInfo> searchUserInfo(UserInfoQuery model){
		return null;
	}
	public Long searchUserInfoCount(UserInfoQuery model){
		return null;
	}
	
	/**
	 * 查询部门下的员工列表
	 * @param departmentId
	 * @return
	 */
	public List<UserInfo> getDepartmentUserInfos(long departmentId){
		return null;
	}
	
	public List<UserInfo> getUserInfosByGroupId(UserInfoQuery userInfoQuery){
		return null;
	}
	public Long getUserInfosByGroupIdCount(UserInfoQuery userInfoQuery){
		return null;
	}
	public UserInfo getUserInfoByCode(String empCode){
		
		return (UserInfo)getCriteria(UserInfo.class).add(Restrictions.eq("empCode", empCode)).uniqueResult();
	}
	public Long getCountByEmpCode(String empCode){
		return null;
	}
	/**
	 * 根据用户名模糊查询用户
	 * @param qName
	 * @return
	 */
	public List<UserInfo> queryUserInfoByName(String qName){
		return null;
	}

	public List<Long> getUserInfoIdsByEmpCodes(List<String> UserInfoEmpCodeList){
		return null;
	}
	
	public List<UserInfo> getAllUserInfo(){
		return null;
	}
	
	public List<UserInfo> getUserInfoByEmpCodes(List<String> UserInfoEmpCodeList){
		return null;
	}
	
	public List<Map<String, Object>> getUserInfosAndGroupByGroupId(
			Map<String,Object> map){
				return null;
			}
	public long getUserInfosAndGroupByGroupIdCount(Map<String,Object> map){
		return 0;
	}
	public UserInfo get(Long userInfoId) {		
		return (UserInfo)getById(UserInfo.class, userInfoId);
	}
	public List<UserInfo> getAll() {		
		return findList(UserInfo.class);
	}
	public void saveOrUpdate(UserInfo entity) {
		if(entity.getId() == null) 
			save(entity);
		else 
			update(entity);
	}
	
	public UserInfo getById(Long id) {
		
		return (UserInfo)getById(UserInfo.class, id);
	}
	
	 
	@SuppressWarnings("unchecked")
	public List<UserInfo> findList(UserInfoQuery query) {		
		return findList(UserInfo.class, ConverterUtil.toHashMap(query));
	}
	
	public Pager<UserInfo> findPage(UserInfoQuery query) {
		Pager<UserInfo> pager = new Pager<UserInfo>();
		Map map = ConverterUtil.toHashMap(query);
		List<UserInfo> appList = findList(UserInfo.class, map, query.getPage().intValue(), query.getRows().intValue());
		pager.setTotalRecords(getTotalCount(UserInfo.class, map)-1);
		pager.setCurrentPage(query.getPage());
		pager.setPageSize(query.getRows());
		pager.setRecords(appList);
		return pager;
	}
}
