package com.neusoft.activiti.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.neusoft.activiti.domain.TransitionRecord;
import com.neusoft.activiti.query.TransitionRecordQuery;
import com.neusoft.base.common.Pager;
import com.neusoft.base.common.PropertyUtils;
import com.neusoft.base.dao.HBaseDAO;

/**
 * database table: ACT_TRANSITION_RECORD
 * database table comments: ACT_TRANSITION_RECORD
 */
@Repository
public class TransitionRecordDao extends HBaseDAO<TransitionRecord>{
	
	public void saveOrUpdate(TransitionRecord entity) {
		if(entity.getRowId() == null){ 
			save(entity);
		}else{ 
			update(entity);}
	}
	
    public TransitionRecord getById(Long id) {
		
		return (TransitionRecord)getById(TransitionRecord.class, id);
	}

	@SuppressWarnings("unchecked")
	public List<TransitionRecord> findList(TransitionRecordQuery TransitionRecordQuery) {		
		return findList(TransitionRecord.class, PropertyUtils.toParameterMap(TransitionRecordQuery));
	}


	public Pager<TransitionRecord> findPage(TransitionRecordQuery TransitionRecordQuery) {
		Pager<TransitionRecord> pager = new Pager<TransitionRecord>();
		Map map = PropertyUtils.toParameterMap(TransitionRecordQuery);
		List<TransitionRecord> TransitionRecordList = findList(TransitionRecord.class, map, TransitionRecordQuery.getPage().intValue(), TransitionRecordQuery.getRows().intValue());
		pager.setTotalRecords(getTotalCount(TransitionRecord.class, map));
		pager.setCurrentPage(TransitionRecordQuery.getPage());
		pager.setPageSize(TransitionRecordQuery.getRows());
		pager.setRecords(TransitionRecordList);
		return pager;
	}
	

}
