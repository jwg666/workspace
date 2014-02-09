package com.neusoft.base.common;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

import org.apache.commons.io.FileUtils;
public class FileUtil extends FileUtils{
	private final static SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHH24mmss"); 
	public static String getExt(File file) {
		String fileName = file.getName();
		String ext = fileName.substring(fileName.lastIndexOf("."), fileName.length());
		return ext;
	}
	public static String getRandom() {
		Random r = new Random();
		return sdf.format(new Date())+r.nextInt(4);
	}
	public static void main(String[] args) {
		File file = new File("E:\\1.txt");
		String ext = getExt(file);
		System.out.println(ext);
	}
	
}
