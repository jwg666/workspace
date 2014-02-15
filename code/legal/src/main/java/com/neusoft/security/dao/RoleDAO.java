package com.neusoft.security.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.neusoft.base.dao.HBaseDAO;
import com.neusoft.base.model.SearchModel;
import com.neusoft.security.domain.Role;


/**
 * 角色DAO
 * @author WangXuzheng
 *
 */
@Repository
public class RoleDAO  extends HBaseDAO<Role>{
	/**
	 * 查询角色信息
	 * @param searchModel
	 * @return
	 */
	public List<Role> searchRoles(SearchModel<Role> searchModel){
		return null;
	}
	public Long searchRolesCount(SearchModel<Role> searchModel){
		return null;
	}
	
	/**
	 * 通过名称查询role信息
	 * @param name
	 * @return
	 */
	public Role getRoleByName(String name){
		return null;
	}
	/**
	 * 根据组ID获取组内的角色
	 * @param userid
	 * @return
	 */
	public List<Role> getRolesByGroupId(SearchModel<Role> model){
		return null;
	}
	public Long getRolesByGroupIdCount(SearchModel<Role> model){
		return null;
	}
	/**
	 * 根据roleId 删除所有管理的resource
	 * @param id
	 */
	public void deleteRole_ResourByRoleId(Long id){
		
	}
	/**
	 * 插入role_resourece
	 * @param dbRole
	 */
	public void saveRole_Resour(Role dbRole){
		
	}
	public Role get(Long id) {
		
		return (Role)getById(Role.class, id);
	}
}
