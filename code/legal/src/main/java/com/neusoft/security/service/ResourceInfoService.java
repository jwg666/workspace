package com.neusoft.security.service;

import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import com.neusoft.base.common.ExecuteResult;
import com.neusoft.base.common.Pager;
import com.neusoft.base.model.DataGrid;
import com.neusoft.security.domain.ResourceInfo;


/**
 */
public interface ResourceInfoService {
	/**
	 * 创建资源
	 * @param ResourceInfo
	 */
	public ExecuteResult<ResourceInfo> createResourceInfo(ResourceInfo ResourceInfo);
	
	/**
	 * 更新资源信息
	 * @param ResourceInfo
	 */
	public ExecuteResult<ResourceInfo> updateResourceInfo(ResourceInfo ResourceInfo);
	
	/**
	 * 删除资源
	 * @param ResourceInfoId
	 * @return
	 */
	public ExecuteResult<ResourceInfo> deleteResourceInfo(Long ResourceInfoId);
	
	/**
	 * 通过id获取资源信息
	 * @param ResourceInfoId
	 * @return
	 */
	public ResourceInfo getResourceInfoById(Long ResourceInfoId);
	
	/**
	 * 获取资源的子资源
	 * @param ResourceInfoId
	 * @return
	 */
	public List<ResourceInfo> getChilden(Long ResourceInfoId);
	
	/**
	 * 获取某个节点的所有直接父节点列表
	 * @param ResourceInfoId
	 * @return
	 */
	public LinkedList<ResourceInfo> getParentsChain(Long ResourceInfoId);
	
	/**
	 * 获取系统根资源
	 * @return
	 */
	public List<ResourceInfo> getRoot();
	
	/**
	 * 查询指定角色下的资源列表
	 * @param roleIds
	 * @return
	 */
	public List<ResourceInfo> getResourceInfoByRole(Long[] roleIds);
	
	/**
	 * 获取系统中所有的资源列表
	 * @return
	 */
	public List<ResourceInfo> getAll();
	
	/**
	 * 获取指定模块下用户可见的所有资源列表
	 * @param userId 用户ID信息
	 * @param moduleName
	 * @return
	 */
	public List<ResourceInfo> getUserDisplayedURLResourceInfos(Long userId,String moduleName);
	
	/**
	 * 查询资源分页
	 */
	public Pager<ResourceInfo> searchResourceInfos(Pager<ResourceInfo> pager,ResourceInfo ResourceInfo);

//	public Pager<ResourceInfo> searchAppResourceInfos(Pager<ResourceInfo> pager,ResourceInfo ResourceInfo);
	
	/**
	 * @author Guomm
	 * 查询用户自定节点下的所有自己点（包含自身）
	 * @param userid
	 * @param ResourceInfo
	 * @return
	 */
	public DataGrid datagrid(Pager<ResourceInfo> pager,ResourceInfo ResourceInfo);
	
	/**
	 * @author Guomm
	 * 查询用户所有的可见的资源
	 * @return
	 */
	public List<ResourceInfo> getUserDisplayResourceInfo();
	
	/**
	 * 查询资源
	 */
	public List<ResourceInfo> searchResourceInfos(ResourceInfo ResourceInfo);
	
	/**
	 * 查询某个用户所用于的资源所有子节点(包含间接子节点和自身)
	 * @param userId
	 * @param code
	 * @return
	 */
	public Map<ResourceInfo,List<ResourceInfo>> getUserResourceInfoDescendants(Long userId,List<String> codeList);
	  
	/**
	 * 查询摸个用户对应的资源列表
	 * @param userId
	 * @return
	 */
	public List<ResourceInfo> getGroupResourceInfoByUserId(Long userId,Integer type);

	public List<ResourceInfo> getParentResourceInfoTask(Long userId); 
	public List<ResourceInfo> getDescendantsTask(Long userId,Long parentId); 
}
