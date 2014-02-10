package com.neusoft.security.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import com.neusoft.base.domain.BaseDomain;


/**
 * 角色
 * @author WangXuzheng
 *
 */
@Entity
@Table(name = "tb_role")
public class Role  extends BaseDomain<Long>{
	private static final long serialVersionUID = -3028144700670190729L;
	private Long tbid;
	private String name;
	private String description;
//	private Set<User> users = new HashSet<User>();
	@Id  
    @GeneratedValue
	@Column(name="tbid")	
	public Long getTbid() {
		return tbid;
	}
	public void setTbid(Long tbid) {
		this.tbid = tbid;
	}
	public void setName(String name) {
		this.name = name;
	}

	public String getName() {
		return name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
//	public Set<User> getUsers() {
//		return users;
//	}
//	public void setUsers(Set<User> users) {
//		this.users = users;
//	}
}
