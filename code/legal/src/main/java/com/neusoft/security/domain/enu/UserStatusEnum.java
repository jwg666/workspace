package com.neusoft.security.domain.enu;

import java.util.HashMap;
import java.util.Map;

/**
 * 用户状态枚举
 * @author WangXuzheng
 *
 */
public enum UserStatusEnum {
	ACTIVE(1,"正常"),INACTIVE(0,"锁定"),EXPIRED(2,"过期");
	private static final Map<Integer, UserStatusEnum> CACHE = new HashMap<Integer, UserStatusEnum>(){
		private static final long serialVersionUID = -8986866330615001847L;
		{
			for(UserStatusEnum enu : UserStatusEnum.values()){
				put(enu.getStatus(), enu);
			}
		}
	};
	private Integer status;
	private String description;
	private UserStatusEnum(Integer status, String description) {
		this.status = status;
		this.description = description;
	}
	public Integer getStatus() {
		return status;
	}
	public String getDescription() {
		return description;
	}
	public static UserStatusEnum toEnum(Integer status){
		return CACHE.get(status);
	}
}
