package com.neusoft.security.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.neusoft.base.dao.HBaseDAO;
import com.neusoft.base.model.SearchModel;
import com.neusoft.security.domain.User;

/**
 * 用户接口
 * @author WangXuzheng
 *
 */
@Repository
public class UserDAO extends HBaseDAO<User>{
	/**
	 * 通过用户
	 * @param id
	 * @return
	 */
	public User getUserByName(String name){
		return null;
	}
	/*忽略大小写*/
	public User getByCodeIgnoreCase(String name){
		return null;
	}
	
	public List<User> searchUser(SearchModel model){
		return null;
	}
	public Long searchUserCount(SearchModel model){
		return null;
	}
	
	/**
	 * 查询部门下的员工列表
	 * @param departmentId
	 * @return
	 */
	public List<User> getDepartmentUsers(long departmentId){
		return null;
	}
	
	public List<User> getUsersByGroupId(SearchModel userSearchModel){
		return null;
	}
	public Long getUsersByGroupIdCount(SearchModel userSearchModel){
		return null;
	}
	public User getUserByCode(String empCode){
		return null;
	}
	public Long getCountByEmpCode(String empCode){
		return null;
	}
	/**
	 * 根据用户名模糊查询用户
	 * @param qName
	 * @return
	 */
	public List<User> queryUserByName(@Param("qName")String qName){
		return null;
	}

	public List<Long> getUserIdsByEmpCodes(@Param("userEmpCodeList")List<String> userEmpCodeList){
		return null;
	}
	
	public List<User> getAllUser(){
		return null;
	}
	
	public List<User> getUserByEmpCodes(@Param("userEmpCodeList")List<String> userEmpCodeList){
		return null;
	}
	
	public List<Map<String, Object>> getUsersAndGroupByGroupId(
			Map<String,Object> map){
				return null;
			}
	public long getUsersAndGroupByGroupIdCount(Map<String,Object> map){
		return 0;
	}
	public User get(Long userId) {		
		return (User)getById(User.class, userId);
	}
	public List<User> getAll() {		
		return findList(User.class);
	}
	
}
