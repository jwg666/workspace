package com.neusoft.security.domain.enu;

import java.util.HashMap;
import java.util.Map;

/**
 * 用户账号类型
 * @author WangXuzheng
 *
 */
public enum UserTypeEnum {
	ACTIVE(1,"域账号"),INACTIVE(0,"普通用户");
	private static final Map<Integer, UserTypeEnum> CACHE = new HashMap<Integer, UserTypeEnum>(){
		private static final long serialVersionUID = -8986866330615001847L;
		{
			for(UserTypeEnum enu : UserTypeEnum.values()){
				put(enu.getStatus(), enu);
			}
		}
	};
	private Integer status;
	private String description;
	private UserTypeEnum(Integer status, String description) {
		this.status = status;
		this.description = description;
	}
	public Integer getStatus() {
		return status;
	}
	public String getDescription() {
		return description;
	}
	public static UserTypeEnum toEnum(Integer status){
		return CACHE.get(status);
	}
}
