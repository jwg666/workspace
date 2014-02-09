package com.neusoft.activiti.service.impl;

import org.activiti.engine.impl.RepositoryServiceImpl;
import org.activiti.engine.impl.repository.DeploymentBuilderImpl;
import org.activiti.engine.repository.Deployment;
import org.springframework.stereotype.Service;

@Service("repositoryService")
public class BaseRepositoryServiceImpl extends RepositoryServiceImpl {

	@Override
	public Deployment deploy(DeploymentBuilderImpl deploymentBuilder) {
		// TODO Auto-generated method stub
		Deployment deployment = super.deploy(deploymentBuilder);
		if (deploymentBuilder instanceof BaseDeploymentBuilderImpl) {
			BaseDeploymentBuilderImpl hroisDeploymentBuilderImpl = (BaseDeploymentBuilderImpl) deploymentBuilder;
			/*if (hroisDeploymentBuilderImpl.getDeployPolicy() == HroisDeploymentBuilderImpl.Deploy_policy_upgrade) {
				instanceUpgrade.instanceUpgrade(deployment);
			} else if (hroisDeploymentBuilderImpl.getDeployPolicy() == HroisDeploymentBuilderImpl.Deploy_policy_delete) {
				instanceUpgrade.instanceDelete(deployment);
			}*/
		}
		return deployment;
	}

}
