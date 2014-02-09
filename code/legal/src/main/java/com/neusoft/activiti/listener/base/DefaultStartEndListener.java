package com.neusoft.activiti.listener.base;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.annotation.Resource;

import org.activiti.engine.RuntimeService;
import org.activiti.engine.impl.persistence.entity.ExecutionEntity;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.pvm.PvmProcessElement;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

import com.neusoft.activiti.domain.WfProcinstance;
import com.neusoft.activiti.query.WfProcinstanceQuery;
import com.neusoft.activiti.service.WfProcinstanceService;
import com.neusoft.base.common.ValidateUtil;

/**
 * 默认流程开始结束 事件
 * 
 * @author Administrator
 * 
 */
@Component
public class DefaultStartEndListener extends StartEndRefactorListener {
	private static final long serialVersionUID = 1L;
	private Logger logger = LoggerFactory.getLogger(getClass());
	@Resource
	private WfProcinstanceService wfProcinstanceService;
	@Resource
	protected RuntimeService runtimeService;
	@Override
	protected void commonEnd(ExecutionEntity executionEntity, Map<String, Object> variables) {
		//
		PvmProcessElement pvmProcessElement = executionEntity.getEventSource();
		String type = (String) pvmProcessElement.getProperty("type");
		String parentId = executionEntity.getParentId();

		if ("endEvent".equals(type) && !ValidateUtil.isValid(parentId)) {
			Object wfProcinstanceIdObj = runtimeService.getVariable(executionEntity.getId(), "wfProcinstanceId");
			if (wfProcinstanceIdObj != null && ValidateUtil.isValid(wfProcinstanceIdObj.toString())) {
				String wfProcinstanceId = wfProcinstanceIdObj.toString();
				WfProcinstance procinstance = wfProcinstanceService.get(wfProcinstanceId);
				if (procinstance != null) {
					procinstance.setStatus("0");
					WfProcinstanceQuery wfProcinstanceQuery = new WfProcinstanceQuery();
					BeanUtils.copyProperties(procinstance, wfProcinstanceQuery);
					wfProcinstanceService.update(wfProcinstanceQuery);
				}
			}
		}
		// 如果有父流程并且父流程以orderTrace开头，说明是订单管理的子流程，那么需要维护T模式状态和时间
		if ("endEvent".equals(type) && ValidateUtil.isValid(parentId)) {
			ActivityImpl activityImpl=(ActivityImpl)pvmProcessElement;
			String subKey=activityImpl.getParentActivity().getId();
			String parentKey = activityImpl.getParent().getProcessDefinition().getKey();
			if (parentKey.startsWith("orderTrace")) {
//				String businformId = (String) variables.get("businformId");
//				String businformType = (String) variables.get("businformType");
//				if (ValidateUtil.isValid(businformId) && ValidateUtil.isValid(businformType) && businformType.equals("SO_SALES_ORDER")) {
//					ActQuery actQuery = new ActQuery();
//					actQuery.setOrderNum(businformId);
//					actQuery.setActId(subKey);
//					Act act = actService.queryOne(actQuery);
//					if (act != null) {
//						String worker = "sysBot";
//						act.setStatusCode("end");
//						act.setActId(subKey);
//						act.setActUserId(worker);
//						String negoActualFinishDateVar=(String)variables.get("negoActualFinishDateVar");
//						if(StringUtils.isNotEmpty(negoActualFinishDateVar)&&"subProcessNego".equals(subKey)){
//							SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
//							try {
//								act.setActualFinishDate(df.parse(negoActualFinishDateVar));
//							} catch (ParseException e) {
//								act.setActualFinishDate(new Date());
//								logger.info("在更新T模式子流程完成日期时转换日期出错，默认系统当前日期");
//							}
//						}else{
//							act.setActualFinishDate(new Date());
//						}
//						BeanUtils.copyProperties(act, actQuery);
//						actQuery.setTableAlias("act_");
//						actService.updateByOrderAndAct(actQuery);
//					}
//
//				}
			}
		}
		logger.debug("commonEnd");
	}

	@Override
	protected void afterEnd(ExecutionEntity executionEntity, Map<String, Object> variables) {
		//

		logger.debug("afterEnd");
	}

	@Override
	protected void commonStart(ExecutionEntity executionEntity, Map<String, Object> variables) {
		PvmProcessElement pvmProcessElement = executionEntity.getEventSource();
		String type = (String) pvmProcessElement.getProperty("type");
		String parentId = executionEntity.getParentId();
		if ("startEvent".equals(type) && !ValidateUtil.isValid(parentId)) {
			/**
			 * 保存ProcessInstanceId
			 */
			savaProcessInstance(executionEntity, variables);
		}
		
		// 如果有父流程并且父流程以orderTrace开头，说明是订单管理的子流程，那么需要维护T模式状态和时间
		if ("startEvent".equals(type) && ValidateUtil.isValid(parentId)) {
			ActivityImpl activityImpl=(ActivityImpl)pvmProcessElement;
			String subKey=activityImpl.getParentActivity().getId();
			String parentKey = activityImpl.getParent().getProcessDefinition().getKey();
//			if (parentKey.startsWith("orderTrace")) {
//				String businformId = (String) variables.get("businformId");
//				String businformType = (String) variables.get("businformType");
//				if (ValidateUtil.isValid(businformId) && ValidateUtil.isValid(businformType) && businformType.equals("SO_SALES_ORDER")) {
//					ActQuery actQuery = new ActQuery();
//					actQuery.setOrderNum(businformId);
//					actQuery.setActId(subKey);
//					Act act = actService.queryOne(actQuery);
//					if (act != null) {
//						String worker = "sysBot";
//						act.setStatusCode("start");
//						act.setActId(subKey);
//						act.setActUserId(worker);
//						act.setActualFinishDate(new Date());
//						BeanUtils.copyProperties(act, actQuery);
//						actQuery.setTableAlias("act_");
//						actService.updateByOrderAndAct(actQuery);
//					}
//
//				}
//			}
		}
	}

	/**
	 * 
	 * @param executionEntity
	 * @param variables
	 */
	private void savaProcessInstance(ExecutionEntity executionEntity, Map<String, Object> variables) {
		String businformId = (String) variables.get("businformId");
		String businformType = (String) variables.get("businformType");
		if (ValidateUtil.isValid(businformId) && ValidateUtil.isValid(businformType)) {
			ProcessDefinitionEntity definitionEntity = (ProcessDefinitionEntity) executionEntity.getProcessDefinition();
			String processDefinitionKey = definitionEntity.getKey();
			String processinstanceId = executionEntity.getProcessInstanceId();
			WfProcinstanceQuery wfProcinstanceQuery = new WfProcinstanceQuery(processinstanceId, processDefinitionKey, businformId, businformType);
			wfProcinstanceQuery.setStatus("1");
//			String rowId = GenerateTableSeqUtil.generateTableSeq("WF_PROCINSTANCE");
//			wfProcinstanceQuery.setRowId(rowId);
			executionEntity.setBusinessKey(businformId);
			wfProcinstanceService.add(wfProcinstanceQuery);
//			runtimeService.setVariable(processinstanceId, "wfProcinstanceId", rowId);
		}
	}

	@Override
	protected void afterStart(ExecutionEntity executionEntity, Map<String, Object> variables) {
		//
		logger.debug("afterStart");
	}

}
