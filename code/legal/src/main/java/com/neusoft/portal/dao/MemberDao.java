package com.neusoft.portal.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.neusoft.base.common.Pager;
import com.neusoft.base.common.PropertyUtils;
import com.neusoft.base.dao.HBaseDAO;
import com.neusoft.portal.model.Member;
import com.neusoft.portal.query.MemberQuery;

/**
 * database table: tb_member
 * database table comments: Member
 */
@Repository
public class MemberDao extends HBaseDAO<Member>{
	public void saveOrUpdate(Member entity) {
		if(entity.getTbid() == null){
			save(entity);
		}else{
			update(entity);
		}
	}
	
public Member getById(Long id) {
		
		return (Member)getById(Member.class, id);
	}

	@SuppressWarnings("unchecked")
	public List<Member> findList(MemberQuery appQuery) {		
		return findList(Member.class, PropertyUtils.toParameterMap(appQuery));
	}


	public Pager<Member> findPage(MemberQuery appQuery) {
		Pager<Member> pager = new Pager<Member>();
		Map map = PropertyUtils.toParameterMap(appQuery);
		List<Member> appList = findList(Member.class, map, appQuery.getPage().intValue(), appQuery.getRows().intValue());
		pager.setTotalRecords(getTotalCount(Member.class, map));
		pager.setCurrentPage(appQuery.getPage());
		pager.setPageSize(appQuery.getRows());
		pager.setRecords(appList);
		return pager;
	}
	 

}
