package com.neusoft.base.common;

public class FileConstants {

	//web容器地址
	public static final StringBuffer WEB_REAL_PATH = new StringBuffer("");
	
	public static final String PAGE_SIZE = "rows";
	public static final String TOTAL = "total";
	public static final String ENCODING_UTF8 = "UTF-8";
	//文件系统
	private String fileSavePath;
	
	public String getFileSavePath() {
		return fileSavePath;
	}
	public void setFileSavePath(String fileSavePath) {
		this.fileSavePath = fileSavePath;
	}
}
