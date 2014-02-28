package com.neusoft.service;

import java.io.File;
import java.io.IOException;

import javax.annotation.Resource;

import org.junit.Test;

import base.BaseTestCase;

import com.neusoft.security.service.FileUploadService;

public class TestFileUpload extends BaseTestCase {
	@Resource
	private FileUploadService fileUploadService;
	@Test
	public void testUploadFile(){
		File dir = new File("E:\\mobilefile\\baidu\\png");
		File[] files = dir.listFiles();
		for(File fileInput:files){
			try {
				fileUploadService.fileUpload(fileInput, fileInput.getName(), "image/png", "icon");
			} catch (IOException e) {
				logger.error("fileInput--"+fileInput.getName(),e);
			}
		}
		
	}
}
