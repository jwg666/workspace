package com.neusoft.activiti.listener.base;

import java.util.Date;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import org.activiti.engine.RuntimeService;
import org.activiti.engine.delegate.DelegateExecution;
import org.activiti.engine.delegate.ExecutionListener;
import org.activiti.engine.impl.persistence.entity.ExecutionEntity;
import org.activiti.engine.impl.pvm.PvmProcessElement;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.impl.pvm.process.TransitionImpl;
import org.springframework.stereotype.Component;

import com.neusoft.activiti.query.TransitionRecordQuery;
import com.neusoft.activiti.service.TransitionRecordService;
import com.neusoft.base.common.ValidateUtil;

/**
 * 
 * 在节点跳转的时候，调用
 * 
 * @author 秦焰培
 * 
 */
@Component
public class DefaultTakeListener implements ExecutionListener {

	@Resource
	private TransitionRecordService transitionRecordService;
	@Resource
	private RuntimeService runtimeService;

	/**
	 * 
	 */
	private static final long serialVersionUID = -4001363171282470512L;

	@Override
	public void notify(DelegateExecution execution) throws Exception {
		ExecutionEntity executionEntity=(ExecutionEntity)execution;
		PvmProcessElement pvmProcessElement=executionEntity.getEventSource();
		if(pvmProcessElement instanceof TransitionImpl){
			TransitionImpl transitionImpl=(TransitionImpl)pvmProcessElement;
			/*源节点*/
			ActivityImpl sourceActivity = transitionImpl.getSource();
			/*目标节点*/
			ActivityImpl destActivity=transitionImpl.getDestination();
			String transitionRecordString=(String)runtimeService.getVariable(execution.getId(),transitionImpl.getId()+"_transitionRecord");
			TransitionRecordQuery transitionRecord=new TransitionRecordQuery();
			if(ValidateUtil.isValid(transitionRecordString)){
			JSONObject transitionRecordJSON=JSONObject.fromObject(transitionRecordString);
			transitionRecord.setAssgin(transitionRecordJSON.getString("assgin"));
			transitionRecord.setAttachment(transitionRecordJSON.getString("attachment"));
			transitionRecord.setComments(transitionRecordJSON.getString("comments"));
			}
			transitionRecord.setBusinformid((String)runtimeService.getVariable(execution.getId(),"businformId"));
			transitionRecord.setDestId(destActivity.getId());
			transitionRecord.setDestName(destActivity.getProperty("name").toString());
			transitionRecord.setDestType(((String)destActivity.getProperty("type")).toLowerCase());
			transitionRecord.setProcessdefinitionkey(executionEntity.getProcessDefinition().getKey());
			transitionRecord.setProcessinstanceid(execution.getProcessInstanceId());
//			transitionRecord.setRowId(GenerateTableSeqUtil.generateTableSeq("act_transition_record"));
//			transitionRecord.setSourceId(sourceActivity.getId());
			transitionRecord.setSourceName(sourceActivity.getProperty("name").toString());
			transitionRecord.setSourceType(((String)sourceActivity.getProperty("type")).toLowerCase());
			transitionRecord.setTransitionTime(new Date());
			transitionRecordService.add(transitionRecord);
			
		}
		//System.out.println(execution.getEventName());
	}
}
