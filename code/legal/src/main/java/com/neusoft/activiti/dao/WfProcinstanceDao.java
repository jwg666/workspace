package com.neusoft.activiti.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.neusoft.activiti.domain.WfProcinstance;
import com.neusoft.activiti.query.WfProcinstanceQuery;
import com.neusoft.base.common.ConverterUtil;
import com.neusoft.base.common.Pager;
import com.neusoft.base.dao.HBaseDAO;

/**
 * database table: WF_PROCINSTANCE database table comments: 表单在工作流中的状态
 * 
 */
@Repository
public class WfProcinstanceDao extends HBaseDAO<WfProcinstance> {
	public void saveOrUpdate(WfProcinstance entity) {
		if (entity.getId() == null) {
			save(entity);
		} else {
			update(entity);
		}
	}
    public WfProcinstance getById(Long id) {
		
		return (WfProcinstance)getById(WfProcinstance.class, id);
	}

	@SuppressWarnings("unchecked")
	public List<WfProcinstance> findList(WfProcinstanceQuery WfProcinstanceQuery) {		
		return findList(WfProcinstance.class, ConverterUtil.toHashMap(WfProcinstanceQuery));
	}


	public Pager<WfProcinstance> findPage(WfProcinstanceQuery WfProcinstanceQuery) {
		Pager<WfProcinstance> pager = new Pager<WfProcinstance>();
		Map map = ConverterUtil.toHashMap(WfProcinstanceQuery);
		List<WfProcinstance> WfProcinstanceList = findList(WfProcinstance.class, map, WfProcinstanceQuery.getPage().intValue(), WfProcinstanceQuery.getRows().intValue());
		pager.setTotalRecords(getTotalCount(WfProcinstance.class, map));
		pager.setCurrentPage(WfProcinstanceQuery.getPage());
		pager.setPageSize(WfProcinstanceQuery.getRows());
		pager.setRecords(WfProcinstanceList);
		return pager;
	}
	public WfProcinstance findProidByBusid(Map map) {
		return null;
	}
	public WfProcinstance getById(String rowId) {		
		return getById(new Long(rowId));
	}
	public WfProcinstance finUnique(WfProcinstanceQuery wfQuery) {
		Map<String,Object> map = ConverterUtil.toHashMap(wfQuery);
		return (WfProcinstance)finUnique(WfProcinstance.class, map);
	}
}
