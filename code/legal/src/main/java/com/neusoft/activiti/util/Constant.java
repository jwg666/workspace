package com.neusoft.activiti.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 工作流相关的常量
 * @author 秦焰培
 *
 */
public class Constant {
	public static final String MANUALLY_EXECUTION_IDS="manuallyExecutionIds";
	public static final String MANUALLY_EXECUTION_COUNT="manuallyExecutionCount";
	public static final String PARALLEL_GATEWAY_END="parallelgatewayEnd";
	public static final String NEED_SKIP_NODE_IDS="needSkipNodeIds";
	public static final String HAS_RODO_NODE_IDS="hasRedoNodeIds";
	public static final String ALL_RODO_NODE_IDS="allRedoNodeIds";
	public static final String NOT_SEND_MESSAGE_IDS="notSendMessageIds";
	
	/**
	 * 画流程图时 高亮的节点类型
	 * 
	 */
	public static final String[] HIGH_LIGHT_ID={"userTask","serviceTask","subProcess","receiveTask"};
	public static final List<String> HIGH_LIGHT_ID_LISR=new ArrayList<String>();
	static {
		HIGH_LIGHT_ID_LISR.add("userTask");
		HIGH_LIGHT_ID_LISR.add("serviceTask");
		//HIGH_LIGHT_ID_LISR.add("subProcess");
		HIGH_LIGHT_ID_LISR.add("receiveTask");
	}
	
//	public static final Map<String,String> updateAssgineeMap=new  HashMap<String,String>();
	static{
//		updateAssgineeMap.put("${OperateComfirmLeader}", "sysLovService");
//		updateAssgineeMap.put("${salesOrderExeManager}", "actCntService");
		//箱单分配，物流储运经理 订舱经理 报关经理
//		updateAssgineeMap.put("${orderTransManager}", "packageBillAssignUpdateAssigneeService");
		//出运，单证经理
//		updateAssgineeMap.put("${orderDocManager}", "shipMentUpdateAssigneeSivce");
		//收汇，收汇经理
//		updateAssgineeMap.put("${orderRecManager}", "collectRevokeUpdateAssigneeService");
		//订舱货代
//		updateAssgineeMap.put("${orderAgents}", "bookOrderService");
	}
	/*订舱子流程全部的节点*/
//	public static final String[] ALL_BOOKCABIN_PROCESSS_NEEDREDO={"bookCabinConfirm","docManagerConfirm","boonAgent","agentsConfirm","agentsInputPaper","orderExeManagerConfirmPaper"};
}
