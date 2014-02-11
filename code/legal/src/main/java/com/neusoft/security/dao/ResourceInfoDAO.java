package com.neusoft.security.dao;

import java.util.LinkedList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.neusoft.base.common.Pager;
import com.neusoft.base.dao.HBaseDAO;
import com.neusoft.security.domain.ResourceInfo;

/**
 * 资源资源
 */
@Repository
public class ResourceInfoDAO extends HBaseDAO<ResourceInfo>{
	/**
	 * 通过资源名称获取资源信息
	 * @param name
	 * @return
	 */
	public ResourceInfo getResourceInfoByName(String name){
		return null;
	}
	
	/**
	 * 通过资源code获取资源信息
	 * @param code
	 * @return
	 */
	public ResourceInfo getResourceInfoByCode(String code){
		return null;
	}
	
	/**
	 * 查询子资源
	 * @param ResourceInfoId
	 * @return
	 */
	public List<ResourceInfo> getChildren(Long ResourceInfoId){
		return null;
	}
	
	/**
	 * 获取某个节点的所有直接父节点列表
	 * @param ResourceInfoId
	 * @return
	 */
	public LinkedList<ResourceInfo> getParentsChain(Long ResourceInfoId){
		return null;
	}
	
	/**
	 * 获取根节点资源信息列表
	 * @return
	 */
	public List<ResourceInfo> getRoots(){
		return null;
	}
	
	/**
	 * 获取指定id下的所有资源列表
	 * @param roleIds
	 * @return
	 */
	public List<ResourceInfo> getResourceInfoByRoleIds(Long[] roleIds){
		return null;
	}
	 
	/**
	 * 获取指定用户id下的所有资源列表
	 * @param roleIds
	 * @return
	 */
	public List<ResourceInfo> getGroupResourceInfoByUserId(Long userId,Integer type){
		return null;
	}
	
	/**
	 * 获取指定模块下的所有资源列表
	 * @param roles
	 * @param moduleName
	 * @return
	 */
	public List<ResourceInfo> getUserDisplayedURLResourceInfosByModuleAndRoles(Long userId,String moduleName){
		return null;
	}
	/**
	 * 查询资源
	 * @param pager
	 * @param ResourceInfo
	 * @return
	 */
	public List<ResourceInfo> searchResourceInfos(Pager<ResourceInfo> pager,ResourceInfo ResourceInfo){
		return null;
	}
	/**
	 * 查询资源
	 * @param pager
	 * @param ResourceInfo
	 * @return
	 */
	public List<ResourceInfo> searchAllResourceInfos(ResourceInfo ResourceInfo){
		return null;
	}
	
	
	
	public Long searchResourceInfosCount(Pager<ResourceInfo> pager,ResourceInfo ResourceInfo){
		return null;
	}
//	public List<ResourceInfo> searchAppResourceInfos(@Param("pager")Pager<ResourceInfo> pager,@Param("ResourceInfo")ResourceInfo ResourceInfo);
//	public Long searchAppResourceInfosCount(@Param("pager")Pager<ResourceInfo> pager,@Param("ResourceInfo")ResourceInfo ResourceInfo);
	
	
	/**
	 * 获取某个资源下的所有子节点(包含间接子节点和自身)
	 * @param userId
	 * @param code
	 * @return
	 */
	public List<ResourceInfo> getDescendants(Long userId,String code){
		return null;
	}
	
    /**
     * @author Guomm
     * 分页查询用户权限下所有的可见链接资源
     * @param userId
     * @param ResourceInfo
     * @param pager
     * @return
     */
	public List<ResourceInfo> getDescendantsPage(Long userId,ResourceInfo ResourceInfo,Pager<ResourceInfo> pager){
		return null;
	}
	public Long getDescendantsCount(Long userId,ResourceInfo ResourceInfo,Pager<ResourceInfo> pager){
		return null;
	}
	
	/**
	 * @author guomm
	 * 查询用户权限下所有的指定类型的课件链接资源
	 * @param userId
	 * @return
	 */
	public List<ResourceInfo> getUserDisplayResourceInfo(Long userId){
		return null;
	}
	
	public List<ResourceInfo> getParentResourceInfoTask(Long userId){
		return null;
	}
	
	public List<ResourceInfo> getDescendantsTask(Long userId,Long parentId){
		return null;
	}
	
	/**
	 * 获取所有moduleName的列表
	 * @return
	 */
	public List<String> getmoduleNames(){
		return null;
	}

	public ResourceInfo get(Long id) {
		
		return (ResourceInfo)getById(ResourceInfo.class, id);
	}
}
