package com.neusoft.security.domain.enu;

import java.util.HashMap;
import java.util.Map;

public enum FileTypeEnum {

	FILE_SYSTEM(1,"文件系统"),MONGODB(2,"mongodb");
	private static final Map<Integer, FileTypeEnum> CACHE = new HashMap<Integer, FileTypeEnum>(){

		private static final long serialVersionUID = -2450871211426704996L;

		{
			for(FileTypeEnum enu : FileTypeEnum.values()){
				put(enu.getType(), enu);
			}
		}
	};
	private Integer type;
	private String desc;
	
	private FileTypeEnum(Integer type,String desc){
		this.type = type;
		this.desc = desc;
	}

	public Integer getType() {
		return type;
	}

	public String getDesc() {
		return desc;
	}
	public static FileTypeEnum toEnum(Integer status){
		return CACHE.get(status);
	}
}
