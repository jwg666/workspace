package com.neusoft.security.dao;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.neusoft.base.common.ConverterUtil;
import com.neusoft.base.common.Pager;
import com.neusoft.base.dao.HBaseDAO;
import com.neusoft.security.domain.ResourceInfo;
import com.neusoft.security.query.ResourceInfoQuery;

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
		String hql = " from ResourceInfo r1 where exists( from  RoleResource r2 where r1.id=r2.resourceId and  exists( from UserRole u where r2.roleId=u.roleId and u.userId=?)) ";
		
		return findList(hql, new Object[]{userId});
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

	public List<ResourceInfo> findList(ResourceInfoQuery resourceInfoQuery) {
//		String hql = " from ResourceInfo r1 where exists( from  RoleResource r2 where r1.id=r2.resourceId and  exists( from UserRole u where r2.roleId=u.roleId and u.userId=?))";
//		String hql = " from ResourceInfo r where r.parentId=?";
//		List<Object> list=new ArrayList<Object>();
//		list.add(resourceInfoQuery.getMemberId());
//		if(null!=resourceInfoQuery.getId()&&0!=resourceInfoQuery.getId()){
//			hql+=" AND r1.id=?";
//			list.add(resourceInfoQuery.getId());
//		}
//		Object[] obj=list.toArray();
//		Object[] obj = new Object[1];
//		obj[0] = 0L;
		
		Map map = ConverterUtil.toHashMap(resourceInfoQuery);
		return findList(ResourceInfo.class, map);
//		int begin = (resourceInfoQuery.getPage().intValue()-1)*resourceInfoQuery.getRows().intValue();
//		List<ResourceInfo> resourceList = findList(ResourceInfo.class, map, begin, resourceInfoQuery.getRows().intValue());
//		for (ResourceInfo resourceInfo : resourceList) {
//			ResourceInfoQuery query = new ResourceInfoQuery();
//			query.setParentId(resourceInfo.getId());
//			List <ResourceInfo> children = findList(query);
//			resourceInfo.setChildren(children);
//		}
//		return resourceList;
	}

	public Long getTotalCount(ResourceInfoQuery resourceInfoQuery) {
		Map map = ConverterUtil.toHashMap(resourceInfoQuery);
		return getTotalCount(ResourceInfo.class, map);
	}
}
