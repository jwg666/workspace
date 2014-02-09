package com.neusoft.activiti.service.impl;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.impl.RepositoryServiceImpl;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.runtime.ProcessInstance;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import com.neusoft.activiti.dao.TransitionRecordDao;
import com.neusoft.activiti.domain.TransitionRecord;
import com.neusoft.activiti.query.TransitionRecordQuery;
import com.neusoft.activiti.service.TransitionRecordService;
import com.neusoft.activiti.service.WfProcinstanceService;
import com.neusoft.base.common.Pager;
import com.neusoft.base.common.ValidateUtil;
import com.neusoft.base.model.DataGrid;
@Service("transitionRecordService")
public class TransitionRecordServiceImpl implements TransitionRecordService{
	@Resource
	private TransitionRecordDao transitionRecordDao;
	@Resource
	private RuntimeService runtimeService;
	@Resource
	private RepositoryService repositoryService;
	@Resource
	private WfProcinstanceService wfProcinstanceService;
	
	private Logger LOG = LoggerFactory.getLogger(TransitionRecordServiceImpl.class);
	
	
	public void setTransitionRecordDao(TransitionRecordDao dao) {
		this.transitionRecordDao = dao;
	}
	
	public DataGrid datagrid(TransitionRecordQuery transitionRecordQuery) {
		DataGrid j = new DataGrid();
		Pager<TransitionRecord> pager  = find(transitionRecordQuery);
		j.setRows(getQuerysFromEntitys(pager.getRecords()));
		j.setTotal(pager.getTotalRecords());
		return j;
	}
	
	
	

	private List<TransitionRecordQuery> getQuerysFromEntitys(List<TransitionRecord> transitionRecords) {
		List<TransitionRecordQuery> transitionRecordQuerys = new ArrayList<TransitionRecordQuery>();
		if (transitionRecords != null && transitionRecords.size() > 0) {
			for (TransitionRecord tb : transitionRecords) {
				TransitionRecordQuery b = new TransitionRecordQuery();
				BeanUtils.copyProperties(tb, b);
				transitionRecordQuerys.add(b);
			}
		}
		return transitionRecordQuerys;
	}

	private Pager<TransitionRecord> find(TransitionRecordQuery transitionRecordQuery) {
		return  transitionRecordDao.findPage(transitionRecordQuery);
		
	}
	
	/**
	 * 
	 * @param processInstanceId 流程实例ID
	 * @param sourceId 原流程ID
	 * @param destId   目标流程ID
	 * @param assgin   办理人
	 * @param attachment 附件ID
	 * @param comments   备注，审批意见
	 * @return
	 */
	public TransitionRecord add(String processInstanceId,String sourceId,String destId,String assgin,String attachment,String comments){
		ProcessInstance processInstance= runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
		String processDefinitionId = processInstance.getProcessDefinitionId();
		ProcessDefinitionEntity processDefinition = (ProcessDefinitionEntity) ((RepositoryServiceImpl) repositoryService).getDeployedProcessDefinition(processDefinitionId);
		List<ActivityImpl> activitiList = processDefinition.getActivities();// 获得当前任务的所有节点
		List<ActivityImpl> subActivitiList = new ArrayList<ActivityImpl>();
		for (ActivityImpl activityImpl : activitiList) {
			Object type = activityImpl.getProperty("type");
			if ("subProcess".equals(type)) {
				subActivitiList.addAll(activityImpl.getActivities());
			}
			// logger.debug(map);
		}
		activitiList.addAll(subActivitiList);
		/*源节点*/
		ActivityImpl sourceActivity = null;
		/*目标节点*/
		ActivityImpl destActivity=null;
		for(ActivityImpl activityImpl:activitiList){
			if(activityImpl.getId().equals(sourceId)){
				sourceActivity=activityImpl;
			}else if(activityImpl.getId().equals(destId)){
				destActivity=activityImpl;
			}
		}
		if(sourceActivity==null||destActivity==null){
			return null;
		}
		
		TransitionRecord transitionRecord=new TransitionRecord();
		transitionRecord.setAssgin(assgin);
		transitionRecord.setAttachment(attachment);
		transitionRecord.setComments(comments);
		transitionRecord.setBusinformid((String)runtimeService.getVariable(processInstance.getId(),"businformId"));
		transitionRecord.setDestId(destActivity.getId());
		transitionRecord.setDestName(destActivity.getProperty("name").toString());
		transitionRecord.setDestType(((String)destActivity.getProperty("type")).toLowerCase());
		transitionRecord.setProcessdefinitionkey(processDefinition.getKey());
		transitionRecord.setProcessinstanceid(processInstanceId);
//		transitionRecord.setRowId(GenerateTableSeqUtil.generateTableSeq("act_transition_record"));
		transitionRecord.setSourceId(sourceActivity.getId());
		transitionRecord.setSourceName(sourceActivity.getProperty("name").toString());
		transitionRecord.setSourceType(((String)sourceActivity.getProperty("type")).toLowerCase());
		transitionRecord.setTransitionTime(new Date());
		transitionRecordDao.save(transitionRecord);
		return transitionRecord;
	}
	
	public void addByBussid(String bussid,String sourceId,String destId,String assgin,String attachment,String comments){
		try{
		String[]ids =  bussid.indexOf(',') != -1 ? bussid.split(",") : new String[]{bussid};
		for(String id : ids){
			if(id != null && !"".equals(id)){
				 String processInstanceId = wfProcinstanceService.findProcinstanceId(
						 id, "SO_SALES_ORDER",
						"orderTrace", "1");
				 if(ValidateUtil.isValid(processInstanceId)){
					 this.add(processInstanceId, sourceId, destId, assgin, attachment, comments);
				 }
			}
		}
		}catch (Exception e) {
		    LOG.error(e.getMessage(),e);
		}
	}

	public TransitionRecord add(TransitionRecordQuery transitionRecordQuery) {
		TransitionRecord t = new TransitionRecord();
		BeanUtils.copyProperties(transitionRecordQuery, t);
		transitionRecordDao.save(t);
		transitionRecordQuery.setRowId(t.getRowId());
		return t;
		
	}

	public void update(TransitionRecordQuery transitionRecordQuery) {
		TransitionRecord t = transitionRecordDao.getById(new Long(transitionRecordQuery.getRowId()));
	    if(t != null) {
	    	BeanUtils.copyProperties(transitionRecordQuery, t);
		}
	    transitionRecordDao.update(t);
	}

	public void delete(java.lang.String[] ids) {
		if (ids != null) {
			for(java.lang.String id : ids){
				TransitionRecord t = transitionRecordDao.getById(new Long(id));
				if (t != null) {
					transitionRecordDao.delete(t);
				}
			}
		}
	}

	public TransitionRecord get(TransitionRecordQuery transitionRecordQuery) {
		return transitionRecordDao.getById(new Long(transitionRecordQuery.getRowId()));
	}

	public TransitionRecord get(String id) {
		return transitionRecordDao.getById(new Long(id));
	}

	
	public List<TransitionRecordQuery> listAll(TransitionRecordQuery transitionRecordQuery) {
	    List<TransitionRecord> list = transitionRecordDao.findList(transitionRecordQuery);
		List<TransitionRecordQuery> listQuery =getQuerysFromEntitys(list) ;
		return listQuery;
	}
}
