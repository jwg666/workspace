package com.neusoft.activiti.service.impl;

import org.activiti.engine.impl.RepositoryServiceImpl;
import org.activiti.engine.impl.persistence.entity.DeploymentEntity;
import org.activiti.engine.impl.repository.DeploymentBuilderImpl;
import org.activiti.engine.repository.Deployment;

public class BaseDeploymentBuilderImpl extends DeploymentBuilderImpl {

	/*默认  没有执行完毕的旧版本实例任务仍然根据旧版本流程定义运行*/
	public static final int Deploy_policy_default = 0;
	/*没有执行完毕的旧版本实例任务迁移到新版本流程定义运行 */
	public static final int Deploy_policy_upgrade = 1;
	/*直接取消没有执行完毕的旧版本实例任务*/
	public static final int Deploy_policy_delete = 2;
	
	
	
	 protected int deployPolicy = Deploy_policy_default;
	
	 protected DeploymentEntity deployment = new DeploymentEntity();
	 
	 /**
	 * 
	 */
	private static final long serialVersionUID = -5205563110079556446L;

	public BaseDeploymentBuilderImpl(RepositoryServiceImpl repositoryService) {
		super(repositoryService);
		// TODO Auto-generated constructor stub
	}
	
	
	  /**
	   * 
	   * @param policy 部署策略
	   *   	DeploymentBuilder.Deploy_policy_default 默认策略 未完成的任务和流程实例还是按照旧的版本执行
	  		DeploymentBuilder.Deploy_policy_upgrade 升级未完成的任务和流程实例，全部按照新的版本执行 
	  		DeploymentBuilder.Deploy_policy_delete  删除未完成的任务和流程实例
	   * @return
	   */
	  public Deployment deploy(int deployPolicy) {
		  	this.deployPolicy = deployPolicy;
		  	//deployment.setDeployPolicy(deployPolicy);
		    return repositoryService.deploy(this);
		  }


	public int getDeployPolicy() {
		return deployPolicy;
	}


	public void setDeployPolicy(int deployPolicy) {
		this.deployPolicy = deployPolicy;
	}

	  
	  
}
