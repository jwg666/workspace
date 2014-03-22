package com.neusoft.security.service.impl;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.neusoft.base.common.CopySpecialProperties;
import com.neusoft.base.common.ExecuteResult;
import com.neusoft.base.common.LoginContextHolder;
import com.neusoft.base.common.Pager;
import com.neusoft.base.model.DataGrid;
import com.neusoft.security.dao.ResourceInfoDAO;
import com.neusoft.security.domain.ResourceInfo;
import com.neusoft.security.domain.ResourceTypeEnum;
import com.neusoft.security.query.ResourceInfoQuery;
import com.neusoft.security.service.ResourceInfoService;

/**
 */
@Service("resourceInfoService")
@Transactional
public class ResourceInfoServiceImpl implements ResourceInfoService {
	private Logger logger = LoggerFactory.getLogger(getClass());
	@Resource
	private ResourceInfoDAO resourceInfoDAO;   
	@Override
	public ExecuteResult<ResourceInfo> createResourceInfo(ResourceInfo ResourceInfo) {
		// 去空格
		ResourceInfo.setName(StringUtils.trim(ResourceInfo.getName()));
		ResourceInfo.setCode(StringUtils.trim(ResourceInfo.getCode()));
		
		ExecuteResult<ResourceInfo> executeResult = new ExecuteResult<ResourceInfo>();
		ResourceInfo dbResourceInfo = resourceInfoDAO.getResourceInfoByName(StringUtils.trim(ResourceInfo.getName()));
		if(dbResourceInfo != null){
			executeResult.addErrorMessage("资源["+ResourceInfo.getName()+"]已经存在!");
			return executeResult;
		}
		// 资源编码唯一性检查
		if(StringUtils.isNotEmpty(StringUtils.trim(ResourceInfo.getCode()))){
			if(resourceInfoDAO.getResourceInfoByCode(ResourceInfo.getCode()) != null){
				executeResult.addErrorMessage("资源编码["+ResourceInfo.getCode()+"]已经存在。");
				return executeResult;
			}
		}
		
		ResourceInfo.setName(StringUtils.trim(ResourceInfo.getName()));
		ResourceInfo.setCode(StringUtils.trim(ResourceInfo.getCode()));
		ResourceInfo.setGmtCreate(new Date());
		ResourceInfo.setGmtModified(new Date());
		ResourceInfo.setCreateBy(LoginContextHolder.get().getUserName());
		ResourceInfo.setLastModifiedBy(LoginContextHolder.get().getUserName());
		
		resourceInfoDAO.save(ResourceInfo);
		initLocalMsg(ResourceInfo);
		executeResult.setResult(ResourceInfo);
		return executeResult;
	}

	@Override
	public ExecuteResult<ResourceInfo> updateResourceInfo(ResourceInfo ResourceInfo) {
		// 去空格
		ResourceInfo.setName(StringUtils.trim(ResourceInfo.getName()));
		ResourceInfo.setCode(StringUtils.trim(ResourceInfo.getCode()));
		
		ExecuteResult<ResourceInfo> executeResult = new ExecuteResult<ResourceInfo>();
		ResourceInfo dbResourceInfo = resourceInfoDAO.get(ResourceInfo.getId());
		if(dbResourceInfo == null){
			executeResult.addErrorMessage("资源["+ResourceInfo.getName()+"]不存在或已经被删除.");
			return executeResult;
		}
		
		// 重名检查
		if(!ResourceInfo.getName().equals(dbResourceInfo.getName())){
			ResourceInfo m = resourceInfoDAO.getResourceInfoByName(ResourceInfo.getName());
			if(m != null){
				executeResult.addErrorMessage("资源["+ResourceInfo.getName()+"]已经存在.");
				return executeResult;
			}
		}
		
		// 资源编码唯一性检查
		if(ResourceTypeEnum.toEnum(ResourceInfo.getType()) == ResourceTypeEnum.COMPONENT_RESOURCE 
				|| StringUtils.isNotEmpty(ResourceInfo.getCode())){
			if(!dbResourceInfo.getCode().equals(ResourceInfo.getCode())){
				if(resourceInfoDAO.getResourceInfoByCode(ResourceInfo.getCode()) == null){
					dbResourceInfo.setCode(ResourceInfo.getCode());
				}else{
					executeResult.addErrorMessage("资源编码["+ResourceInfo+"]已经存在。");
					return executeResult;
				}
			}
		}
		
		// 设置父资源
		
		// 设置普通字段值
		dbResourceInfo.setName(ResourceInfo.getName());
		dbResourceInfo.setCode(ResourceInfo.getCode());
		dbResourceInfo.setDescription(ResourceInfo.getDescription());
		dbResourceInfo.setLastModifiedBy(LoginContextHolder.get().getUserName());
		dbResourceInfo.setGmtModified(new Date());
		dbResourceInfo.setOrderIndex(ResourceInfo.getOrderIndex());
		dbResourceInfo.setConfiguration(ResourceInfo.getConfiguration());
		dbResourceInfo.setStatus(ResourceInfo.getStatus());
		dbResourceInfo.setUrl(ResourceInfo.getUrl());
		dbResourceInfo.setWidth(ResourceInfo.getWidth());
		dbResourceInfo.setHeight(ResourceInfo.getHeight());
		dbResourceInfo.setIconUrl(ResourceInfo.getIconUrl());
		resourceInfoDAO.update(dbResourceInfo);
		initLocalMsg(dbResourceInfo);
		executeResult.setResult(dbResourceInfo);
		return executeResult;
	}

	@Override
	public ExecuteResult<ResourceInfo> deleteResourceInfo(Long resourceInfoId) {
		ExecuteResult<ResourceInfo> executeResult = new ExecuteResult<ResourceInfo>();
		ResourceInfo resourceInfo = resourceInfoDAO.get(resourceInfoId);
		if(resourceInfo == null){
			executeResult.addWarningMessage("该资源不存在.");
			return executeResult;
		}
		//无子资源
		List<ResourceInfo> children = resourceInfoDAO.getChildren(resourceInfoId);
		if(!children.isEmpty()){
			executeResult.addErrorMessage("该资源下有"+children.size()+"个子资源，不能删除。");
			return executeResult;
		}
		resourceInfoDAO.delete(resourceInfo);
		return executeResult;
	}

	@Override
	public ResourceInfo getResourceInfoById(Long resourceInfoId) {
		ResourceInfo resourceInfo = resourceInfoDAO.get(resourceInfoId);
		initLocalMsg(resourceInfo);
		return resourceInfo;
	}

	@Override
	public List<ResourceInfo> getChilden(Long resourceInfoId) {
		List<ResourceInfo> resourceInfos = resourceInfoDAO.getChildren(resourceInfoId);
		initLocalMsg(resourceInfos);
		return resourceInfos;
	}

	@Override
	public LinkedList<ResourceInfo> getParentsChain(Long ResourceInfoId) {
		LinkedList<ResourceInfo> ResourceInfos = new LinkedList<ResourceInfo>();
		ResourceInfo ResourceInfo = resourceInfoDAO.get(ResourceInfoId);
		if(ResourceInfo == null){
			return ResourceInfos;
		}
		ResourceInfo tmpResourceInfo = ResourceInfo;
//		while(tmpResourceInfo.getParent() != null && !tmpResourceInfo.getParent().getId().equals(tmpResourceInfo.getId())){
//			ResourceInfos.addFirst(tmpResourceInfo.getParent());
//			tmpResourceInfo = ResourceInfoDAO.get(tmpResourceInfo.getParent().getId());
//		}
		ResourceInfos.addLast(ResourceInfo);
		initLocalMsg(ResourceInfos);
		return ResourceInfos;
	}

	@Override
	public List<ResourceInfo> getRoot() {
		List<ResourceInfo> ResourceInfos = resourceInfoDAO.getRoots();
		initLocalMsg(ResourceInfos);
		return ResourceInfos;
	}

	@Override
	public List<ResourceInfo> getResourceInfoByRole(Long[] roleIds) {
		if(roleIds == null || roleIds.length == 0){
			return new ArrayList<ResourceInfo>(0);
		}
		List<ResourceInfo> ResourceInfos = resourceInfoDAO.getResourceInfoByRoleIds(roleIds);
		initLocalMsg(ResourceInfos);
		return ResourceInfos;
	} 

	@Override
	public List<ResourceInfo> getAll() {
		List<ResourceInfo> ResourceInfos = resourceInfoDAO.findList(ResourceInfo.class);
		initLocalMsg(ResourceInfos);
		return ResourceInfos;
	}

	@Override
	public List<ResourceInfo> getUserDisplayedURLResourceInfos(Long userId,String moduleName) {  
		List<ResourceInfo> ResourceInfos = resourceInfoDAO.getUserDisplayedURLResourceInfosByModuleAndRoles(userId,moduleName);
		initLocalMsg(ResourceInfos);
		return ResourceInfos;
	}

	@Override
	public Pager<ResourceInfo> searchResourceInfos(Pager<ResourceInfo> pager,ResourceInfo ResourceInfo) {
		List<ResourceInfo> list = resourceInfoDAO.searchResourceInfos(pager, ResourceInfo);
		initLocalMsg(list);
		long size = resourceInfoDAO.searchResourceInfosCount(pager, ResourceInfo);
		return Pager.cloneFromPager(pager, size, list);
	}
	
//	@Override
//	public Pager<ResourceInfo> searchAppResourceInfos(Pager<ResourceInfo> pager,ResourceInfo ResourceInfo){
//		List<ResourceInfo> list = ResourceInfoDAO.searchAppResourceInfos(pager, ResourceInfo);
//		long size = ResourceInfoDAO.searchAppResourceInfosCount(pager, ResourceInfo);
//		return Pager.cloneFromPager(pager, size, list);
//	}
	
	@Override
	public DataGrid datagrid(ResourceInfoQuery resourceInfoQuery) {
		DataGrid j = new DataGrid();
		List<ResourceInfo> resourceInfos = resourceInfoDAO.findList(resourceInfoQuery);
		Long count = resourceInfoDAO.getTotalCount(resourceInfoQuery);
		initLocalMsg(resourceInfos);
		j.setRows(resourceInfos);
		j.setTotal(count);
		return j;
	};
	
	@Override
	public java.util.List<ResourceInfo> getUserDisplayResourceInfo() {
		List<ResourceInfo> ResourceInfos = resourceInfoDAO.getUserDisplayResourceInfo(LoginContextHolder.get().getUserId());
		initLocalMsg(ResourceInfos);
		return ResourceInfos;
	};
	
	@Override
	public List<ResourceInfo> searchResourceInfos(ResourceInfo ResourceInfo) {
		List<ResourceInfo> list = resourceInfoDAO.searchAllResourceInfos(ResourceInfo);
		initLocalMsg(list);
		return list;
	}
	
	
	@Override
	public Map<ResourceInfo, List<ResourceInfo>> getUserResourceInfoDescendants(Long userId, List<String> codeList) {
		Map<ResourceInfo, List<ResourceInfo>> result = new LinkedHashMap<ResourceInfo, List<ResourceInfo>>();
		for(String code : codeList){
			List<ResourceInfo> ResourceInfos = resourceInfoDAO.getDescendants(userId, code);
			ResourceInfo parent = rebuildParent(code,ResourceInfos);
			initLocalMsg(ResourceInfos);
			initLocalMsg(parent);
			result.put(parent, ResourceInfos);
		}
		return result;
	}
	
	private ResourceInfo rebuildParent(String code,List<ResourceInfo> ResourceInfos){
		ResourceInfo parent = null;
		for(ResourceInfo ResourceInfo : ResourceInfos){
			if(StringUtils.equals(code, ResourceInfo.getCode())){
				parent = ResourceInfo;
				break;
			}
		}
		if(parent == null){
			parent = resourceInfoDAO.getResourceInfoByCode(code);
		}else{
			ResourceInfos.remove(parent);
		}
		return parent;
	}
	@Override
	public List<ResourceInfo> getGroupResourceInfoByUserId(Long userId,Integer type) {
		List<ResourceInfo> ResourceInfos = resourceInfoDAO.getGroupResourceInfoByUserId(userId,type);
		initLocalMsg(ResourceInfos);
		return ResourceInfos;
	}
	@Override
	public List<ResourceInfo> getParentResourceInfoTask(Long userId) {
		List<ResourceInfo> ResourceInfos = resourceInfoDAO.getParentResourceInfoTask(userId);
		initLocalMsg(ResourceInfos);
		return ResourceInfos;
	}

	@Override
	public List<ResourceInfo> getDescendantsTask(Long userId, Long parentId) {
		List<ResourceInfo> ResourceInfos = resourceInfoDAO.getDescendantsTask(userId,parentId);
		initLocalMsg(ResourceInfos);
		return ResourceInfos;
	}

	private void initLocalMsg(ResourceInfo ResourceInfo){
		if(ResourceInfo!=null && ResourceInfo.getCode()!=null){
			//FIXME 国际化
//			ResourceInfo.setLocalName(HroisMessage.getMessage("res."+ResourceInfo.getCode(),ResourceInfo.getName()));
		}
	}
	private void initLocalMsg(List<ResourceInfo> ResourceInfos){
		if(ResourceInfos!=null){
			for(ResourceInfo ResourceInfo:ResourceInfos){
				initLocalMsg(ResourceInfo);
			}
		}
	}

	@Override
	public Long saveOrUpdate(ResourceInfoQuery resourceInfoQuery) {
		if(resourceInfoQuery.getId()!=null){
			ResourceInfo resourceInfo = resourceInfoDAO.get(resourceInfoQuery.getId());
			if(resourceInfo!=null){
				try {
					CopySpecialProperties.copyBeanToBean(resourceInfoQuery, resourceInfo, true);
				} catch (Exception e) {
					logger.error("CopySpecialProperties.copyBeanToBean got exception",e);
				}
				resourceInfoDAO.update(resourceInfo);
			}else{
				try {
					resourceInfo = new ResourceInfo();
					CopySpecialProperties.copyBeanToBean(resourceInfoQuery, resourceInfo, true);
				} catch (Exception e) {
					logger.error("CopySpecialProperties.copyBeanToBean got exception",e);
				}
				resourceInfoDAO.save(resourceInfo);
			}
			
			return resourceInfoQuery.getId();
		}else{
			ResourceInfo info = new ResourceInfo();
			try {
				CopySpecialProperties.copyBeanToBean(resourceInfoQuery, info, true);
			} catch (Exception e) {
				logger.error("CopySpecialProperties.copyBeanToBean got exception",e);
			}
			return resourceInfoDAO.save(info);
		}
		
	}
}
