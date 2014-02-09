package com.neusoft.portal.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.neusoft.base.common.Pager;
import com.neusoft.base.common.PropertyUtils;
import com.neusoft.base.dao.HBaseDAO;
import com.neusoft.portal.model.MemberApp;
import com.neusoft.portal.query.MemberAppQuery;

/**
 * database table: tb_member_app
 * database table comments: MemberApp
 */
@Repository
public class MemberAppDao extends HBaseDAO<MemberApp>{
	
	public void saveOrUpdate(MemberApp entity) {
		if(entity.getTbid() == null){
			save(entity);
		}else{
			update(entity);
		}
	}
	
    public MemberApp getById(Long id) {
		
		return (MemberApp)getById(MemberApp.class, id);
	}

	@SuppressWarnings("unchecked")
	public List<MemberApp> findList(MemberAppQuery appQuery) {		
		return findList(MemberApp.class, PropertyUtils.toParameterMap(appQuery));
	}


	public Pager<MemberApp> findPage(MemberAppQuery appQuery) {
		Pager<MemberApp> pager = new Pager<MemberApp>();
		Map map = PropertyUtils.toParameterMap(appQuery);
		List<MemberApp> appList = findList(MemberApp.class, map, appQuery.getPage().intValue(), appQuery.getRows().intValue());
		pager.setTotalRecords(getTotalCount(MemberApp.class, map));
		pager.setCurrentPage(appQuery.getPage());
		pager.setPageSize(appQuery.getRows());
		pager.setRecords(appList);
		return pager;
	}
	 

}
