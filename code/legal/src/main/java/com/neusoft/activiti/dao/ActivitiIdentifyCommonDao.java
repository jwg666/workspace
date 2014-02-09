package com.neusoft.activiti.dao;

public interface ActivitiIdentifyCommonDao {

	/**
     * 删除用户
     */
    public void deleteAllUser();
 
    /**
     * 删除组
     */
    public void deleteAllRole() ;
 
    /**
     * 删除用户和组的关系
     */
    public void deleteAllMemerShip();


}
