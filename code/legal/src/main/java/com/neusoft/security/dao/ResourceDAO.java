package com.neusoft.security.dao;

import java.util.LinkedList;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.neusoft.base.common.Pager;
import com.neusoft.base.dao.HBaseDAO;
import com.neusoft.security.domain.Resource;

/**
 * 资源资源
 * @author WangXuzheng
 * @author lupeng
 */
@Repository
public class ResourceDAO extends HBaseDAO<Resource>{
	/**
	 * 通过资源名称获取资源信息
	 * @param name
	 * @return
	 */
	public Resource getResourceByName(String name){
		return null;
	}
	
	/**
	 * 通过资源code获取资源信息
	 * @param code
	 * @return
	 */
	public Resource getResourceByCode(String code){
		return null;
	}
	
	/**
	 * 查询子资源
	 * @param resourceId
	 * @return
	 */
	public List<Resource> getChildren(Long resourceId){
		return null;
	}
	
	/**
	 * 获取某个节点的所有直接父节点列表
	 * @param resourceId
	 * @return
	 */
	public LinkedList<Resource> getParentsChain(Long resourceId){
		return null;
	}
	
	/**
	 * 获取根节点资源信息列表
	 * @return
	 */
	public List<Resource> getRoots(){
		return null;
	}
	
	/**
	 * 获取指定id下的所有资源列表
	 * @param roleIds
	 * @return
	 */
	public List<Resource> getResourceByRoleIds(@Param("roleIds")Long[] roleIds){
		return null;
	}
	 
	/**
	 * 获取指定用户id下的所有资源列表
	 * @param roleIds
	 * @return
	 */
	public List<Resource> getGroupResourceByUserId(@Param("userId")Long userId,@Param("type")Integer type){
		return null;
	}
	
	/**
	 * 获取指定模块下的所有资源列表
	 * @param roles
	 * @param moduleName
	 * @return
	 */
	public List<Resource> getUserDisplayedURLResourcesByModuleAndRoles(@Param("userId")Long userId,@Param("moduleName")String moduleName){
		return null;
	}
	/**
	 * 查询资源
	 * @param pager
	 * @param resource
	 * @return
	 */
	public List<Resource> searchResources(@Param("pager")Pager<Resource> pager,@Param("resource")Resource resource){
		return null;
	}
	/**
	 * 查询资源
	 * @param pager
	 * @param resource
	 * @return
	 */
	public List<Resource> searchAllResources(@Param("resource")Resource resource){
		return null;
	}
	
	
	
	public Long searchResourcesCount(@Param("pager")Pager<Resource> pager,@Param("resource")Resource resource){
		return null;
	}
//	public List<Resource> searchAppResources(@Param("pager")Pager<Resource> pager,@Param("resource")Resource resource);
//	public Long searchAppResourcesCount(@Param("pager")Pager<Resource> pager,@Param("resource")Resource resource);
	
	
	/**
	 * 获取某个资源下的所有子节点(包含间接子节点和自身)
	 * @param userId
	 * @param code
	 * @return
	 */
	public List<Resource> getDescendants(@Param("userId")Long userId,@Param("code")String code){
		return null;
	}
	
    /**
     * @author Guomm
     * 分页查询用户权限下所有的可见链接资源
     * @param userId
     * @param resource
     * @param pager
     * @return
     */
	public List<Resource> getDescendantsPage(@Param("uid")Long userId,@Param("resource")Resource resource,@Param("pager")Pager<Resource> pager){
		return null;
	}
	public Long getDescendantsCount(@Param("uid")Long userId,@Param("resource")Resource resource,@Param("pager")Pager<Resource> pager){
		return null;
	}
	
	/**
	 * @author guomm
	 * 查询用户权限下所有的指定类型的课件链接资源
	 * @param userId
	 * @return
	 */
	public List<Resource> getUserDisplayResource(@Param("uid")Long userId){
		return null;
	}
	
	public List<Resource> getParentResourceTask(@Param("uid")Long userId){
		return null;
	}
	
	public List<Resource> getDescendantsTask(@Param("userId")Long userId,@Param("parentId")Long parentId){
		return null;
	}
	
	/**
	 * 获取所有moduleName的列表
	 * @return
	 */
	public List<String> getmoduleNames(){
		return null;
	}

	public Resource get(Long id) {
		
		return (Resource)getById(Resource.class, id);
	}
}
