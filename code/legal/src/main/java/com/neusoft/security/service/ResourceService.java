package com.neusoft.security.service;

import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import com.neusoft.base.common.ExecuteResult;
import com.neusoft.base.common.Pager;
import com.neusoft.base.model.DataGrid;
import com.neusoft.security.domain.Resource;


/**
 * @author WangXuzheng
 * @author lupeng
 */
public interface ResourceService {
	/**
	 * 创建资源
	 * @param resource
	 */
	public ExecuteResult<Resource> createResource(Resource resource);
	
	/**
	 * 更新资源信息
	 * @param resource
	 */
	public ExecuteResult<Resource> updateResource(Resource resource);
	
	/**
	 * 删除资源
	 * @param resourceId
	 * @return
	 */
	public ExecuteResult<Resource> deleteResource(Long resourceId);
	
	/**
	 * 通过id获取资源信息
	 * @param resourceId
	 * @return
	 */
	public Resource getResourceById(Long resourceId);
	
	/**
	 * 获取资源的子资源
	 * @param resourceId
	 * @return
	 */
	public List<Resource> getChilden(Long resourceId);
	
	/**
	 * 获取某个节点的所有直接父节点列表
	 * @param resourceId
	 * @return
	 */
	public LinkedList<Resource> getParentsChain(Long resourceId);
	
	/**
	 * 获取系统根资源
	 * @return
	 */
	public List<Resource> getRoot();
	
	/**
	 * 查询指定角色下的资源列表
	 * @param roleIds
	 * @return
	 */
	public List<Resource> getResourceByRole(Long[] roleIds);
	
	/**
	 * 获取系统中所有的资源列表
	 * @return
	 */
	public List<Resource> getAll();
	
	/**
	 * 获取指定模块下用户可见的所有资源列表
	 * @param userId 用户ID信息
	 * @param moduleName
	 * @return
	 */
	public List<Resource> getUserDisplayedURLResources(Long userId,String moduleName);
	
	/**
	 * 查询资源分页
	 */
	public Pager<Resource> searchResources(Pager<Resource> pager,Resource resource);

//	public Pager<Resource> searchAppResources(Pager<Resource> pager,Resource resource);
	
	/**
	 * @author Guomm
	 * 查询用户自定节点下的所有自己点（包含自身）
	 * @param userid
	 * @param resource
	 * @return
	 */
	public DataGrid datagrid(Pager<Resource> pager,Resource resource);
	
	/**
	 * @author Guomm
	 * 查询用户所有的可见的资源
	 * @return
	 */
	public List<Resource> getUserDisplayResource();
	
	/**
	 * 查询资源
	 */
	public List<Resource> searchResources(Resource resource);
	
	/**
	 * 查询某个用户所用于的资源所有子节点(包含间接子节点和自身)
	 * @param userId
	 * @param code
	 * @return
	 */
	public Map<Resource,List<Resource>> getUserResourceDescendants(Long userId,List<String> codeList);
	  
	/**
	 * 查询摸个用户对应的资源列表
	 * @param userId
	 * @return
	 */
	public List<Resource> getGroupResourceByUserId(Long userId,Integer type);

	public List<Resource> getParentResourceTask(Long userId); 
	public List<Resource> getDescendantsTask(Long userId,Long parentId); 
}
