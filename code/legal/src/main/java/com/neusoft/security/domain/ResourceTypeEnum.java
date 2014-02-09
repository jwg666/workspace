package com.neusoft.security.domain;

import java.util.HashMap;
import java.util.Map;

/**
 * 资源类型枚举
 * @author WangXuzheng
 *
 */
public enum ResourceTypeEnum {
	URL_RESOURCE(0,"URL资源"),COMPONENT_RESOURCE(1,"组件资源"),TASK_RESOURCE(2,"待办资源"),DESK_COMPONENT_RESOURCE(3,"桌面组件");
	private static final Map<Integer,ResourceTypeEnum> CACHE = new HashMap<Integer,ResourceTypeEnum>(){
		private static final long serialVersionUID = 2334886698187804809L;
		{
			for(ResourceTypeEnum typeEnum : ResourceTypeEnum.values()){
				put(typeEnum.getType(), typeEnum);
			}
		}
	};
	private Integer type;
	private String description;
	private ResourceTypeEnum(int type,String description){
		this.type = type;
		this.description = description;
	}
	public int getType() {
		return type;
	}
	public String getDescription() {
		return description;
	}
	
	public static ResourceTypeEnum toEnum(Integer type){
		return CACHE.get(type);
	}
	
	public static boolean isValidType(Integer type){
		return toEnum(type)!= null;
	}
}
