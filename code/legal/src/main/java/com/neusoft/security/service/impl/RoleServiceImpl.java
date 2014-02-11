package com.neusoft.security.service.impl;

import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.neusoft.base.common.ExecuteResult;
import com.neusoft.base.common.LoginContextHolder;
import com.neusoft.base.common.Pager;
import com.neusoft.base.model.SearchModel;
import com.neusoft.security.dao.ResourceInfoDAO;
import com.neusoft.security.dao.RoleDAO;
import com.neusoft.security.domain.Role;
import com.neusoft.security.service.RoleService;


/**
 * @author WangXuzheng
 *
 */
@Service("roleService")
@Transactional
public class RoleServiceImpl implements RoleService {
	@Resource
	private RoleDAO roleDAO;
	@Resource
	private ResourceInfoDAO resourceInfoDAO;

	@Override
	public ExecuteResult<Role> createRole(Role role) {
		ExecuteResult<Role> executeResult = new ExecuteResult<Role>();
		Role dbRole = roleDAO.getRoleByName(StringUtils.trim(role.getName()));
		if(dbRole != null){
			executeResult.addErrorMessage("角色["+role.getName()+"]已经存在.");
			return executeResult;
		}
//		resetResource(role);
		role.setName(StringUtils.trim(role.getName()));
//		role.setGmtCreate(new Date());
//		role.setGmtModified(new Date());
//		role.setCreateBy(LoginContextHolder.get().getUserName());
//		role.setLastModifiedBy(LoginContextHolder.get().getUserName());
		roleDAO.save(role);
		executeResult.setResult(role);
		return executeResult;
	}

//	private void resetResource(Role role) {
//		if(role.getResources() == null || role.getResources().isEmpty()){
//			role.setResources(null);
//		}else{
//			final Set<Resource> permissions = role.getResources();
//			role.setResources(new HashSet<Resource>());
//			for(Resource res : permissions){
//				Resource p = resourceDAO.get(res.getId());
//				role.getResources().add(p);
//			}
//		}
//	}

	@Override
	public ExecuteResult<Role> updateRole(Role role) {
		ExecuteResult<Role> executeResult = new ExecuteResult<Role>();
		Role dbRole = roleDAO.get(role.getId());
		if(dbRole == null){
			executeResult.addErrorMessage("不存在的角色信息.");
			return executeResult;
		}
		if(!dbRole.getName().equals(role.getName())){
			if(roleDAO.getRoleByName(role.getName()) != null){
				executeResult.addErrorMessage("角色名["+role.getName()+"]已经存在.");
				return executeResult;
			}
		}
//		resetResource(role);
		dbRole.setLastModifiedBy(LoginContextHolder.get().getUserName());
		dbRole.setGmtModified(new Date());
		dbRole.setDescription(role.getDescription());
		dbRole.setName(role.getName());
//		dbRole.setResources(role.getResources());
		roleDAO.update(dbRole);
		roleDAO.deleteRole_ResourByRoleId(role.getId());
//		if(dbRole.getResources() != null && !dbRole.getResources().isEmpty()){
//			roleDAO.saveRole_Resour(dbRole);
//		}
		return executeResult;
	}

	@Override
	public ExecuteResult<Role> deleteRole(Long roleId) {
		ExecuteResult<Role> executeResult = new ExecuteResult<Role>();
		Role role = roleDAO.get(roleId);
		if(role == null){
			executeResult.addWarningMessage("该角色信息已经删除.");
			return executeResult;
		}
//		if(role.getResources() != null && !role.getResources().isEmpty()){
//			executeResult.addErrorMessage("角色["+role.getName()+"]下有"+role.getResources().size()+"个资源，不能删除.");
//			return executeResult;
//		}
		roleDAO.delete(roleId);
		return executeResult;
	}

	@Override
	public Role getRoleById(Long roleId) {
		return roleDAO.get(roleId);
	}

	@Override
	public Pager<Role> searchRoles(SearchModel searchModel) {
		List<Role> roles = roleDAO.searchRoles(searchModel);
		long size = roleDAO.searchRolesCount(searchModel);
		return Pager.cloneFromPager(searchModel.getPager(), size, roles);
	}

	@Override
	public List<Role> getRoles() {
		return roleDAO.findList(Role.class);
	}

	@Override
	public Pager<Role> getRolesByGroupId(SearchModel model) {
		List<Role> roles = roleDAO.getRolesByGroupId(model);
		long size = roleDAO.getRolesByGroupIdCount(model);
		return Pager.cloneFromPager(model.getPager(), size, roles);
	}
}
