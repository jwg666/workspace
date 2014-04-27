/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */

package com.neusoft.legal.dao;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.SQLQuery;
import org.springframework.stereotype.Repository;

import com.neusoft.base.common.ConverterUtil;
import com.neusoft.base.common.LoginContextHolder;
import com.neusoft.base.common.Pager;
import com.neusoft.base.common.PropertyUtils;
import com.neusoft.base.dao.HBaseDAO;
import com.neusoft.base.model.DataGrid;
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
	/**
	 * @param query
	 * @return
	 * 案件上报维护页面查询
	 */
	public DataGrid applicantDatagrid(LegalCaseQuery query){
		SQLQuery obj=getSession().createSQLQuery("SELECT AL.* FROM ("+
			    " select APP.id applicantId,APP.name applicantName,AGE.name agentName,AGE.ID agentId,CAS.ID caseId,WF.process_instance_id instId,APP.create_time,APP.identifyid,APP.phone"+
			    " from LE_LEGAL_APPLICANT APP"+
			    " LEFT JOIN LE_LEGAL_AGENT AGE ON APP.id=AGE.applicant_id"+
			    " LEFT JOIN LE_LEGAL_CASE CAS ON CAS.applicant_id=APP.id"+
			    " LEFT JOIN WF_PROCINSTANCE WF ON WF.businform_id=CAS.ID"+
				" ORDER BY APP.id DESC) AL"+
			    " limit :begin,:end");
	    //Object o=obj.list();
		Long begin=query.getRows()*(query.getPage().longValue()-1);
		Long end =query.getRows()*(query.getPage().longValue());
		obj.setParameter("begin", begin);
		obj.setParameter("end", end);
		SQLQuery objtotal=getSession().createSQLQuery(" select count(0)"+
			    " from LE_LEGAL_APPLICANT APP"+
			    " LEFT JOIN LE_LEGAL_AGENT AGE ON APP.id=AGE.applicant_id"+
			    " LEFT JOIN LE_LEGAL_CASE CAS ON CAS.applicant_id=APP.id"+
			    " LEFT JOIN WF_PROCINSTANCE WF ON WF.businform_id=CAS.ID");
		List<Object[]> listob=obj.list();
		//objtotal.setParameter("begin", begin);
		//objtotal.setParameter("end", end);
		BigInteger tatal =(BigInteger)objtotal.list().get(0);
		List<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
		if(listob!=null&&listob.size()>0){
			for(Object[] objs:listob){
				Map<String,Object> map=new HashMap<String,Object>();
				map.put("applicantId", objs[0]);
				map.put("applicantName", objs[1]);
				map.put("agentName", objs[2]);
				map.put("agentId", objs[3]);
				map.put("caseId", objs[4]);
				map.put("instId", objs[5]);
				map.put("createTime", objs[6]);
				map.put("identifyid", objs[7]);
				map.put("phone", objs[8]);
				list.add(map);
			}
		}
		DataGrid dagatrid=new DataGrid();
		dagatrid.setRows(list);
		dagatrid.setTotal(tatal.longValue());
		return dagatrid;
	}
	
	/** 
	 * @param query
	 * @return
	 * 案件审批已办理,指派律师事务所已办理,事务所受理案件已办理,结果公示已办理,确认结案已办理(根据task的key值来区分已办理的任务)
	 */
	public DataGrid findpageY(LegalCaseQuery query){
		Long userId=LoginContextHolder.get().getUserId();
		SQLQuery obj=getSession().createSQLQuery("SELECT AL.* FROM (" +
				" select leap.name applicantname,lea.name agentname,la.CREATE_TIME createTime,la.APPLICANT_TIME applicantTime,la.ID id,ata.END_TIME_ endTime,DP.NAME dpName,lc.ID caseId" +
				" from LE_LEGAL_CASE lc" +
				" join WF_PROCINSTANCE wf on wf.businform_id=lc.ID" +
				" join (select at.* from ACT_HI_ACTINST at where at.ACT_ID_=:taskKey  and at.END_TIME_ is not null and at.ASSIGNEE_ =:userid) ata on ata.PROC_INST_ID_=wf.process_instance_id" +
				" left join LE_LEGAL_APPLICANT  leap on leap.id=lc.applicant_id " +
				" left join LE_LEGAL_AGENT lea on lea.ID=lc.agent_id" +
				" left join LE_LEGAL_APPROVE  la on la.CASE_ID=lc.ID" +
				" left join TB_USER_INFO DP ON DP.ID=lc.legal_id"+
				" ORDER BY la.id DESC) AL" +
				" limit :begin,:end");
	    //Object o=obj.list();
		Long begin=query.getRows()*(query.getPage().longValue()-1);
		Long end =query.getRows()*(query.getPage().longValue());
		obj.setParameter("begin", begin);
		obj.setParameter("end", end);
		obj.setParameter("userid", userId.toString());
		obj.setParameter("taskKey", query.getDefinitionKey());
		List<Object[]> listob=obj.list();
		SQLQuery objcount=getSession().createSQLQuery(
				" select count(0)" +
				" from LE_LEGAL_CASE lc" +
				" join WF_PROCINSTANCE wf on wf.businform_id=lc.ID" +
				" join (select at.* from ACT_HI_ACTINST at where at.ACT_ID_=:taskKey and at.END_TIME_ is not null and at.ASSIGNEE_ =:userid) ata on ata.PROC_INST_ID_=wf.process_instance_id" +
				" left join LE_LEGAL_APPLICANT  leap on leap.id=lc.applicant_id " +
				" left join LE_LEGAL_AGENT lea on lea.ID=lc.agent_id" +
				" left join LE_LEGAL_APPROVE  la on la.CASE_ID=lc.ID" +
				" left join TB_USER_INFO DP ON DP.ID=lc.legal_id ");
		objcount.setParameter("userid", userId.toString());
		objcount.setParameter("taskKey", query.getDefinitionKey());
		BigInteger tatal =(BigInteger)objcount.list().get(0);
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
				//节点完成时间
				if(objs[5]!=null){
					casq.setEndTime((Date)objs[5]);
				}
				//律师事务所的名字
				if(objs[6]!=null){
					casq.setDpName((String)objs[6]);
				}
				//caseid
				if(objs[7]!=null){
					casq.setCaseId(((BigInteger)objs[7]).longValue());
				}
				list.add(casq);
			}
		}
		DataGrid datagrid=new DataGrid();
		datagrid.setRows(list);
		datagrid.setTotal(tatal.longValue());
		return datagrid;
	}
	
	/** 
	 * @param query
	 * @return
	 * 申报查询
	 */
	public DataGrid querydatagrid(LegalCaseQuery query){
		Long userId=LoginContextHolder.get().getUserId();
		SQLQuery obj=getSession().createSQLQuery("SELECT AL.* FROM (" +
				" select leap.name applicantname,lea.name agentname,la.CREATE_TIME createTime,la.APPLICANT_TIME applicantTime,la.ID id,ata.END_TIME_ endTime,DP.NAME dpName,lc.ID caseId" +
				" from LE_LEGAL_CASE lc" +
				" join WF_PROCINSTANCE wf on wf.businform_id=lc.ID" +
				" left join (select at.* from ACT_HI_ACTINST at where at.ACT_ID_=:taskKey  and at.END_TIME_ is not null and at.ASSIGNEE_ =:userid) ata on ata.PROC_INST_ID_=wf.process_instance_id" +
				" left join LE_LEGAL_APPLICANT  leap on leap.id=lc.applicant_id " +
				" left join LE_LEGAL_AGENT lea on lea.ID=lc.agent_id" +
				" left join LE_LEGAL_APPROVE  la on la.CASE_ID=lc.ID" +
				" left join TB_USER_INFO DP ON DP.ID=lc.legal_id"+
				" ORDER BY la.id DESC) AL" +
				" limit :begin,:end");
	    //Object o=obj.list();
		Long begin=query.getRows()*(query.getPage().longValue()-1);
		Long end =query.getRows()*(query.getPage().longValue());
		obj.setParameter("begin", begin);
		obj.setParameter("end", end);
		obj.setParameter("userid", userId.toString());
		obj.setParameter("taskKey", query.getDefinitionKey());
		List<Object[]> listob=obj.list();
		SQLQuery objcount=getSession().createSQLQuery(
				" select count(0)" +
				" from LE_LEGAL_CASE lc" +
				" join WF_PROCINSTANCE wf on wf.businform_id=lc.ID" +
				" left join (select at.* from ACT_HI_ACTINST at where at.ACT_ID_=:taskKey and at.END_TIME_ is not null and at.ASSIGNEE_ =:userid) ata on ata.PROC_INST_ID_=wf.process_instance_id" +
				" left join LE_LEGAL_APPLICANT  leap on leap.id=lc.applicant_id " +
				" left join LE_LEGAL_AGENT lea on lea.ID=lc.agent_id" +
				" left join LE_LEGAL_APPROVE  la on la.CASE_ID=lc.ID" +
				" left join TB_USER_INFO DP ON DP.ID=lc.legal_id ");
		objcount.setParameter("userid", userId.toString());
		objcount.setParameter("taskKey", query.getDefinitionKey());
		BigInteger tatal =(BigInteger)objcount.list().get(0);
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
				//节点完成时间
				if(objs[5]!=null){
					casq.setEndTime((Date)objs[5]);
				}
				//律师事务所的名字
				if(objs[6]!=null){
					casq.setDpName((String)objs[6]);
				}
				//caseid
				if(objs[7]!=null){
					casq.setCaseId(((BigInteger)objs[7]).longValue());
				}
				list.add(casq);
			}
		}
		DataGrid datagrid=new DataGrid();
		datagrid.setRows(list);
		datagrid.setTotal(tatal.longValue());
		return datagrid;
	}
}
