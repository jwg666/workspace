/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */

package com.neusoft.legal.dao;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.hibernate.SQLQuery;
import org.hibernate.type.Type;
import org.springframework.stereotype.Repository;

import com.neusoft.base.common.ConverterUtil;
import com.neusoft.base.common.Pager;
import com.neusoft.base.common.PropertyUtils;
import com.neusoft.base.dao.HBaseDAO;
import com.neusoft.legal.domain.LegalCase;
import com.neusoft.legal.query.LegalCaseQuery;
import com.neusoft.legal.query.LegalCaseTaskQuery;

/**
 * database table: LE_LEGAL_CASE
 * database table comments: LegalCase
 * 
 *
 * @author jiawg-贾伟光
 * @Email jiawg@neusoft.com
 *
 
 */
@Repository
public class LegalCaseDao extends HBaseDAO<LegalCase>{

	
	public void saveOrUpdate(LegalCase entity) {
		if(entity.getId() == null) 
			save(entity);
		else 
			update(entity);
	}
	
	public LegalCase getById(Long id) {
		
		return (LegalCase)getById(LegalCase.class, id);
	}
	
	 
	@SuppressWarnings("unchecked")
	public List<LegalCase> findList(LegalCaseQuery query) {		
		return findList(LegalCase.class, PropertyUtils.toParameterMap(query));
	}
	
	public Pager<LegalCase> findPage(LegalCaseQuery query) {
		Pager<LegalCase> pager = new Pager<LegalCase>();
		Map map = ConverterUtil.toHashMap(query);
		List idList = query.getIdList();
		if(idList!=null&&!idList.isEmpty()){
			map.put("id",idList);
		}
		int begin = (query.getPage().intValue()-1)*(query.getRows().intValue());
		List<LegalCase> appList = findList(LegalCase.class, map, begin, query.getRows().intValue());
		pager.setTotalRecords(getTotalCount(LegalCase.class, map));
		pager.setCurrentPage(query.getPage());
		pager.setPageSize(query.getRows());
		pager.setRecords(appList);
		return pager;
	}
	public List<LegalCaseTaskQuery> findpageY(LegalCaseQuery query){
		SQLQuery obj=getSession().createSQLQuery("select leap.name applicantname,lea.name agentname,la.CREATE_TIME createTime,la.APPLICANT_TIME applicantTime,la.ID id" +
				" from LE_LEGAL_CASE lc" +
				" join WF_PROCINSTANCE wf on wf.businform_id=lc.ID" +
				" join (select at.* from ACT_HI_ACTINST at where at.ACT_ID_='caseApprove') ata on ata.PROC_INST_ID_=wf.process_instance_id" +
				" left join LE_LEGAL_APPLICANT  leap on leap.id=lc.applicant_id " +
				" left join LE_LEGAL_AGENT lea on lea.ID=lc.agent_id" +
				" left join LE_LEGAL_APPROVE  la on la.CASE_ID=lc.ID");
	    //Object o=obj.list();
		List<Object[]> listob=obj.list();
		List<LegalCaseTaskQuery> list=new ArrayList<LegalCaseTaskQuery>();
		if(listob!=null&&listob.size()>0){
			for(Object[] objs:listob){
				LegalCaseTaskQuery casq=new LegalCaseTaskQuery();
				if(objs[0]!=null){
					casq.setApplicantname((String)objs[0]);
				}
				if(objs[1]!=null){
					casq.setAgentname((String)objs[1]);
				}
				if(objs[2]!=null){
					casq.setCreateTime((Date)objs[2]);
				}
				if(objs[3]!=null){
					casq.setApplicantTime((Date)objs[3]);
				}
				if(objs[4]!=null){
					casq.setId(((BigInteger)objs[4]).longValue());
				}
				list.add(casq);
			}
		}
		return list;
	}
}
