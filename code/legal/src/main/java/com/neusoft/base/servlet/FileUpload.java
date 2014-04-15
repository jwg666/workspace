package com.neusoft.base.servlet;

import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletException;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.neusoft.base.common.SpringApplicationContextHolder;
import com.neusoft.security.service.FileUploadService;

public class FileUpload extends HttpServlet {
	private Logger logger = LoggerFactory.getLogger(getClass());
//	@Override
//	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
//			throws ServletException, IOException {
//		super.doGet(req, resp);
//	}
//
//	@Override
//	protected void doPost(HttpServletRequest request, HttpServletResponse response)
//			throws ServletException, IOException {
//		ServletInputStream sis = request.getInputStream();
//		int i = sis.read();
//		if(i!=-1){
//			FileUploadService fileUploadService = (FileUploadService)SpringApplicationContextHolder.getBean("fileUploadService");
//			String uuid = fileUploadService.fileUpload((InputStream)sis, request.getParameter("filename"));
//			logger.debug("-----------------"+uuid);
//		}
//	}

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("GBK");   
        response.setCharacterEncoding("GBK"); 
        ServletInputStream sis = request.getInputStream();
		
		int i = sis.read();
		if(i!=-1){
			FileUploadService fileUploadService = (FileUploadService)SpringApplicationContextHolder.getBean("fileUploadService");
			String uuid = fileUploadService.fileUpload((InputStream)sis, request.getParameter("uploadFileName"));
			logger.debug("-----------------"+uuid);
			request.setAttribute("id", uuid);
//			response.getOutputStream()
		}else{
			request.setAttribute("id", "error");
		}
	}

	

}
