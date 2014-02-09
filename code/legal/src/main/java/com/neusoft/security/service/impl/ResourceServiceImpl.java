package com.neusoft.security.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.neusoft.base.common.ExecuteResult;
import com.neusoft.base.common.LoginContextHolder;
import com.neusoft.base.common.Pager;
import com.neusoft.base.model.DataGrid;
import com.neusoft.security.dao.ResourceDAO;
import com.neusoft.security.domain.Resource;
import com.neusoft.security.service.ResourceService;
import com.neusoft.security.domain.ResourceTypeEnum;

/**
 * @author WangXuzheng
 * @author lupeng
 */
@Service("resourceService")
@Transactional
public class ResourceServiceImpl implements ResourceService {
	private ResourceDAO resourceDAO;   
	
	public void setResourceDAO(ResourceDAO resourceDAO) {
		this.resourceDAO = resourceDAO;
	} 

	@Override
	public ExecuteResult<Resource> createResource(Resource resource) {
		// 去空格
		resource.setName(StringUtils.trim(resource.getName()));
		resource.setCode(StringUtils.trim(resource.getCode()));
		
		ExecuteResult<Resource> executeResult = new ExecuteResult<Resource>();
		Resource dbResource = resourceDAO.getResourceByName(StringUtils.trim(resource.getName()));
		if(dbResource != null){
			executeResult.addErrorMessage("资源["+resource.getName()+"]已经存在!");
			return executeResult;
		}
		// 资源编码唯一性检查
		if(StringUtils.isNotEmpty(StringUtils.trim(resource.getCode()))){
			if(resourceDAO.getResourceByCode(resource.getCode()) != null){
				executeResult.addErrorMessage("资源编码["+resource.getCode()+"]已经存在。");
				return executeResult;
			}
		}
		
		resource.setName(StringUtils.trim(resource.getName()));
		resource.setCode(StringUtils.trim(resource.getCode()));
		resource.setGmtCreate(new Date());
		resource.setGmtModified(new Date());
		resource.setCreateBy(LoginContextHolder.get().getUserName());
		resource.setLastModifiedBy(LoginContextHolder.get().getUserName());
		
		if(resource.getParent() == null || resource.getParent().getId() == null){//普通资源
			resource.setParent(null);
			resourceDAO.save(resource);
			resource.setParent(resource);
			resourceDAO.update(resource);
		}else{//系统级资源
			Resource parent = resourceDAO.get(resource.getParent().getId());
			resource.setParent(parent);
			resourceDAO.save(resource);
		}
		initLocalMsg(resource);
		executeResult.setResult(resource);
		return executeResult;
	}

	@Override
	public ExecuteResult<Resource> updateResource(Resource resource) {
		// 去空格
		resource.setName(StringUtils.trim(resource.getName()));
		resource.setCode(StringUtils.trim(resource.getCode()));
		
		ExecuteResult<Resource> executeResult = new ExecuteResult<Resource>();
		Resource dbResource = resourceDAO.get(resource.getId());
		if(dbResource == null){
			executeResult.addErrorMessage("资源["+resource.getName()+"]不存在或已经被删除.");
			return executeResult;
		}
		
		// 重名检查
		if(!resource.getName().equals(dbResource.getName())){
			Resource m = resourceDAO.getResourceByName(resource.getName());
			if(m != null){
				executeResult.addErrorMessage("资源["+resource.getName()+"]已经存在.");
				return executeResult;
			}
		}
		
		// 资源编码唯一性检查
		if(ResourceTypeEnum.toEnum(resource.getType()) == ResourceTypeEnum.COMPONENT_RESOURCE 
				|| StringUtils.isNotEmpty(resource.getCode())){
			if(!dbResource.getCode().equals(resource.getCode())){
				if(resourceDAO.getResourceByCode(resource.getCode()) == null){
					dbResource.setCode(resource.getCode());
				}else{
					executeResult.addErrorMessage("资源编码["+resource+"]已经存在。");
					return executeResult;
				}
			}
		}
		
		// 设置父资源
		if(resource.getParent() == null || resource.getParent().getId() == null){//普通资源
			dbResource.setParent(dbResource);
		}else{//系统级资源
			Resource parent = resourceDAO.get(resource.getParent().getId());
			dbResource.setParent(parent);
		}
		
		// 设置普通字段值
		dbResource.setName(resource.getName());
		dbResource.setCode(resource.getCode());
		dbResource.setDescription(resource.getDescription());
		dbResource.setLastModifiedBy(LoginContextHolder.get().getUserName());
		dbResource.setGmtModified(new Date());
		dbResource.setOrderIndex(resource.getOrderIndex());
		dbResource.setConfiguration(resource.getConfiguration());
		dbResource.setStatus(resource.getStatus());
		dbResource.setUrl(resource.getUrl());
		dbResource.setWidth(resource.getWidth());
		dbResource.setHeight(resource.getHeight());
		dbResource.setIconUrl(resource.getIconUrl());
		resourceDAO.update(dbResource);
		initLocalMsg(dbResource);
		executeResult.setResult(dbResource);
		return executeResult;
	}

	@Override
	public ExecuteResult<Resource> deleteResource(Long resourceId) {
		ExecuteResult<Resource> executeResult = new ExecuteResult<Resource>();
		Resource resource = resourceDAO.get(resourceId);
		if(resource == null){
			executeResult.addWarningMessage("该资源不存在.");
			return executeResult;
		}
		//无子资源
		List<Resource> children = resourceDAO.getChildren(resourceId);
		if(!children.isEmpty()){
			executeResult.addErrorMessage("该资源下有"+children.size()+"个子资源，不能删除。");
			return executeResult;
		}
		resourceDAO.delete(resourceId);
		return executeResult;
	}

	@Override
	public Resource getResourceById(Long resourceId) {
		Resource resource = resourceDAO.get(resourceId);
		initLocalMsg(resource);
		return resource;
	}

	@Override
	public List<Resource> getChilden(Long resourceId) {
		List<Resource> resources = resourceDAO.getChildren(resourceId);
		initLocalMsg(resources);
		return resources;
	}

	@Override
	public LinkedList<Resource> getParentsChain(Long resourceId) {
		LinkedList<Resource> resources = new LinkedList<Resource>();
		Resource resource = resourceDAO.get(resourceId);
		if(resource == null){
			return resources;
		}
		Resource tmpResource = resource;
		while(tmpResource.getParent() != null && !tmpResource.getParent().getId().equals(tmpResource.getId())){
			resources.addFirst(tmpResource.getParent());
			tmpResource = resourceDAO.get(tmpResource.getParent().getId());
		}
		resources.addLast(resource);
		initLocalMsg(resources);
		return resources;
	}

	@Override
	public List<Resource> getRoot() {
		List<Resource> resources = resourceDAO.getRoots();
		initLocalMsg(resources);
		return resources;
	}

	@Override
	public List<Resource> getResourceByRole(Long[] roleIds) {
		if(roleIds == null || roleIds.length == 0){
			return new ArrayList<Resource>(0);
		}
		List<Resource> resources = resourceDAO.getResourceByRoleIds(roleIds);
		initLocalMsg(resources);
		return resources;
	} 

	@Override
	public List<Resource> getAll() {
		List<Resource> resources = resourceDAO.findList(Resource.class);
		initLocalMsg(resources);
		return resources;
	}

	@Override
	public List<Resource> getUserDisplayedURLResources(Long userId,String moduleName) {  
		List<Resource> resources = resourceDAO.getUserDisplayedURLResourcesByModuleAndRoles(userId,moduleName);
		initLocalMsg(resources);
		return resources;
	}

	@Override
	public Pager<Resource> searchResources(Pager<Resource> pager,Resource resource) {
		List<Resource> list = resourceDAO.searchResources(pager, resource);
		initLocalMsg(list);
		long size = resourceDAO.searchResourcesCount(pager, resource);
		return Pager.cloneFromPager(pager, size, list);
	}
	
//	@Override
//	public Pager<Resource> searchAppResources(Pager<Resource> pager,Resource resource){
//		List<Resource> list = resourceDAO.searchAppResources(pager, resource);
//		long size = resourceDAO.searchAppResourcesCount(pager, resource);
//		return Pager.cloneFromPager(pager, size, list);
//	}
	
	@Override
	public DataGrid datagrid(Pager<Resource> pager,Resource resource) {
		Long uid = LoginContextHolder.get().getUserId();
		DataGrid j = new DataGrid();
		List<Resource> resources = resourceDAO.getDescendantsPage( uid, resource, pager);
		Long count = resourceDAO.getDescendantsCount(uid, resource, pager);
		initLocalMsg(resources);
		j.setRows(resources);
		j.setTotal(count);
		return j;
	};
	
	@Override
	public java.util.List<Resource> getUserDisplayResource() {
		List<Resource> resources = resourceDAO.getUserDisplayResource(LoginContextHolder.get().getUserId());
		initLocalMsg(resources);
		return resources;
	};
	
	@Override
	public List<Resource> searchResources(Resource resource) {
		List<Resource> list = resourceDAO.searchAllResources(resource);
		initLocalMsg(list);
		return list;
	}
	
	
	@Override
	public Map<Resource, List<Resource>> getUserResourceDescendants(Long userId, List<String> codeList) {
		Map<Resource, List<Resource>> result = new LinkedHashMap<Resource, List<Resource>>();
		for(String code : codeList){
			List<Resource> resources = resourceDAO.getDescendants(userId, code);
			Resource parent = rebuildParent(code,resources);
			initLocalMsg(resources);
			initLocalMsg(parent);
			result.put(parent, resources);
		}
		return result;
	}
	
	private Resource rebuildParent(String code,List<Resource> resources){
		Resource parent = null;
		for(Resource resource : resources){
			if(StringUtils.equals(code, resource.getCode())){
				parent = resource;
				break;
			}
		}
		if(parent == null){
			parent = resourceDAO.getResourceByCode(code);
		}else{
			resources.remove(parent);
		}
		return parent;
	}
	@Override
	public List<Resource> getGroupResourceByUserId(Long userId,Integer type) {
		List<Resource> resources = resourceDAO.getGroupResourceByUserId(userId,type);
		initLocalMsg(resources);
		return resources;
	}
	@Override
	public List<Resource> getParentResourceTask(Long userId) {
		List<Resource> resources = resourceDAO.getParentResourceTask(userId);
		initLocalMsg(resources);
		return resources;
	}

	@Override
	public List<Resource> getDescendantsTask(Long userId, Long parentId) {
		List<Resource> resources = resourceDAO.getDescendantsTask(userId,parentId);
		initLocalMsg(resources);
		return resources;
	}

	private void initLocalMsg(Resource resource){
		if(resource!=null && resource.getCode()!=null){
			//FIXME 国际化
//			resource.setLocalName(HroisMessage.getMessage("res."+resource.getCode(),resource.getName()));
		}
	}
	private void initLocalMsg(List<Resource> resources){
		if(resources!=null){
			for(Resource resource:resources){
				initLocalMsg(resource);
			}
		}
	}
}
