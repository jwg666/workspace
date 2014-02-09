package com.neusoft.security.domain;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import com.neusoft.base.domain.BaseDomain;



/**
 * 系统菜单
 * @author WangXuzheng
 *
 */
@Entity
@Table(name = "tb_resource")
public class Resource  extends BaseDomain<Long>{
	private static final long serialVersionUID = -4061243420033359942L;
	private Resource parent;
	private String name;
	private String code;
	private String description;
	private String url;
	private Integer type;
	private Integer status;
	private String moduleName;
	private String configuration;
	private Integer orderIndex;
	private Set<Role> roles = new HashSet<Role>();
	private Set<Resource> childResources = new HashSet<Resource>();
	private Integer width;
	private Integer height;
	private String iconUrl;
	private Long parentId;
	private Long tbid;
	private Long memberId;
	//辅助字段 国家化
	private String localName;
	public String getIconUrl() {
		return iconUrl;
	}
	public void setIconUrl(String iconUrl) {
		this.iconUrl = iconUrl;
	}
	public Integer getWidth() {
		return width;
	}
	public void setWidth(Integer width) {
		this.width = width;
	}
	public Integer getHeight() {
		return height;
	}
	public void setHeight(Integer height) {
		this.height = height;
	}
	public Resource getParent() {
		return parent;
	}
	public void setParent(Resource parent) {
		this.parent = parent;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getModuleName() {
		return moduleName;
	}
	public void setModuleName(String moduleName) {
		this.moduleName = moduleName;
	}
	public String getConfiguration() {
		return configuration;
	}
	public void setConfiguration(String configuration) {
		this.configuration = configuration;
	}
	public Integer getOrderIndex() {
		return orderIndex;
	}
	public void setOrderIndex(Integer orderIndex) {
		this.orderIndex = orderIndex;
	}
	public Set<Role> getRoles() {
		return roles;
	}
	public void setRoles(Set<Role> roles) {
		this.roles = roles;
	}
	public Set<Resource> getChildResources() {
		return childResources;
	}
	public void setChildResources(Set<Resource> childResources) {
		this.childResources = childResources;
	}
	
	public Long getParentId() {
		return parentId;
	}
	public void setParentId(Long parentId) {
		this.parentId = parentId;
	}
	
	@Id  
    @GeneratedValue
	@Column(name="tbid")
	public Long getTbid() {
		return tbid;
	}
	public void setTbid(Long tbid) {
		this.tbid = tbid;
	}
	public Long getMemberId() {
		return memberId;
	}
	public void setMemberId(Long memberId) {
		this.memberId = memberId;
	}
        public String getLocalName() {
                return localName;
        }
        public void setLocalName(String localName) {
                this.localName = localName;
        }
	
}
