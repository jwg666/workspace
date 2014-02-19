package com.neusoft.security.domain.enu;

import java.util.HashMap;
import java.util.Map;

public enum FileStatusEnum {

	VALID(1,"有效"),INVALID(2,"无效");
	private static final Map<Integer, FileStatusEnum> CACHE = new HashMap<Integer, FileStatusEnum>(){
		private static final long serialVersionUID = 1802140338455124215L;

		{
			for(FileStatusEnum enu : FileStatusEnum.values()){
				put(enu.getStatus(), enu);
			}
		}
	};
	private Integer status;
	private String desc;
	
	private FileStatusEnum(Integer status,String desc){
		this.status = status;
		this.desc = desc;
	}

	public Integer getStatus() {
		return status;
	}

	public String getDesc() {
		return desc;
	}
	public static FileStatusEnum toEnum(Integer status){
		return CACHE.get(status);
	}
}
