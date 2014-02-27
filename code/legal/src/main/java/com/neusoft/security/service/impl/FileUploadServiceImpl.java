package com.neusoft.security.service.impl;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.neusoft.I18n.I18nResolver;
import com.neusoft.I18n.I18nResolverFactory;
import com.neusoft.base.common.DataFormat;
import com.neusoft.base.common.DateUtils;
import com.neusoft.base.common.ExecuteResult;
import com.neusoft.base.common.FileConstants;
import com.neusoft.base.common.LoginContextHolder;
import com.neusoft.base.common.Pager;
import com.neusoft.base.model.SearchModel;
import com.neusoft.security.dao.FileUploadDAO;
import com.neusoft.security.domain.UploadFile;
import com.neusoft.security.domain.enu.FileStatusEnum;
import com.neusoft.security.domain.enu.FileTypeEnum;
import com.neusoft.security.service.FileUploadService;

/**
 * @author jiawg
 *
 */
@Service("fileUploadService")
public class FileUploadServiceImpl implements FileUploadService {
	
	private static final Logger LOG = LoggerFactory.getLogger(FileUploadServiceImpl.class);
	private static final I18nResolver I18N_RESOLVER = I18nResolverFactory.getDefaultI18nResolver(FileUploadServiceImpl.class);
	
	private static final int BUFFERED_SIZE = 4 * 1024;
	@Resource
	private FileUploadDAO fileUploadDAO;
	private FileConstants fileConstants;
//	private FileServiceClientAdapter fileServiceClientAdapter;
	
	@Override
	public List<UploadFile> getFileByStatusAndType(SearchModel<UploadFile> model){
		return fileUploadDAO.getFileByStatusAndType(model);
	}
	
	@Override
	public UploadFile getFileById(Long id){
		return fileUploadDAO.get(id);
	}
	
	/**@author 
	 * @param
	 * 文件上传
	 */
	@Override
	public ExecuteResult<UploadFile> fileUpload(File fileInput,String fileInputFileName,String fileInputContentType,String remarks) throws IOException
	{
		ExecuteResult<UploadFile> result = new ExecuteResult<UploadFile>();
		String saveFileName = null;
		if(isSaveFileSystem()){
			//文件系统存储
			saveFileName = DateUtils.FORMAT7.format(new Date()) + fileInputFileName.substring(fileInputFileName.lastIndexOf('.'));
			saveToFileSystem(fileInput,saveFileName,result);
		}else{
			//mongodb存储
			String uuid = saveToMongodb(fileInput,fileInputFileName,result);
			if(StringUtils.isNotBlank(uuid)){
				saveFileName = uuid;
			}
			
		}
		if(!result.isSuccess()){
			return result;
		}
		Date curDate = new Date();
		UploadFile uploadFile=new UploadFile();
		uploadFile.setFileName(fileInputFileName);
		uploadFile.setSaveFileName(saveFileName);
		uploadFile.setFilePath1(fileConstants.getFileSavePath());
		uploadFile.setStatus(FileStatusEnum.VALID.getStatus());
		uploadFile.setLastModifiedBy(LoginContextHolder.get().getUserName());
		uploadFile.setLastModifiedDt(curDate);
		uploadFile.setCreateBy(LoginContextHolder.get().getUserName());
		uploadFile.setCreateDt(curDate);
		if(StringUtils.isNotBlank(fileInputContentType)){
			uploadFile.setContentType(fileInputContentType);
		}
		if(StringUtils.isNotBlank(remarks)){
			uploadFile.setRemarks(remarks);
		}
		if(isSaveFileSystem()){
			uploadFile.setType(FileTypeEnum.FILE_SYSTEM.getType());
		}else{
			uploadFile.setType(FileTypeEnum.MONGODB.getType());
		}
		fileUploadDAO.save(uploadFile);
		result.setResult(uploadFile);
		return result;
	}
	@Override
	public ExecuteResult<UploadFile> fileUpload(File fileInput,String fileInputFileName,String fileInputContentType) throws IOException
	{
		return fileUpload(fileInput,fileInputFileName,fileInputContentType,null);
	}
	@Override
	public ExecuteResult<UploadFile> fileUpload(File fileInput,String fileInputFileName) throws IOException
	{
		return fileUpload(fileInput,fileInputFileName,null);
	}
	
	@Override
	public ExecuteResult<UploadFile> fileUploadToLocal(File fileInput, String path, String fileInputFileName, String fileInputContentType, String remarks)
			throws IOException {
		ExecuteResult<UploadFile> result = new ExecuteResult<UploadFile>();
		String saveFileName = null;
		//文件系统存储
		saveFileName = DataFormat.formatDate(new Date(), "yyyyMMddHHmmssSSS") + fileInputFileName.substring(fileInputFileName.lastIndexOf('.'));
		saveToFileSystem(fileInput,saveFileName,path,result);
		if(!result.isSuccess()){
			return result;
		}
		Date curDate = new Date();
		UploadFile uploadFile=new UploadFile();
		uploadFile.setFileName(fileInputFileName);
		uploadFile.setSaveFileName(saveFileName);
		//保存相对web容器根目录的文件存储路径
		uploadFile.setFilePath1(path);
		uploadFile.setStatus(FileStatusEnum.VALID.getStatus());
		uploadFile.setLastModifiedBy(LoginContextHolder.get().getUserName());
		uploadFile.setLastModifiedDt(curDate);
		uploadFile.setCreateBy(LoginContextHolder.get().getUserName());
		uploadFile.setCreateDt(curDate);
		if(StringUtils.isNotBlank(fileInputContentType)){
			uploadFile.setContentType(fileInputContentType);
		}
		if(StringUtils.isNotBlank(remarks)){
			uploadFile.setRemarks(remarks);
		}
		uploadFile.setType(FileTypeEnum.FILE_SYSTEM.getType());
		fileUploadDAO.save(uploadFile);
		result.setResult(uploadFile);
		return result;
	}
	@Override
	public ExecuteResult<UploadFile> fileUploadToLocal(File fileInput, String path, String fileInputFileName, String fileInputContentType)
			throws IOException {
		return fileUploadToLocal(fileInput, path, fileInputFileName, fileInputContentType,null);
	}
	
	@Override
	public InputStream getFileInputStream(Long id) {
		UploadFile uploadFile = fileUploadDAO.get(id);
		if(uploadFile == null){
			return null;
		}
		InputStream is = null;
		if(FileTypeEnum.FILE_SYSTEM.getType().equals(uploadFile.getType())){
			try {
				//uploadFile.getFilePath1() 不为空 表示 存在web容器的目录下  否则 取 固定目录fileConstants.getFileSavePath()
//				File file = new File((uploadFile.getFilePath1()==null?fileConstants.getFileSavePath():FileConstants.WEB_REAL_PATH.toString() + File.separator + uploadFile.getFilePath1()) + File.separator + uploadFile.getSaveFileName());
				File file = new File((uploadFile.getFilePath1()==null?fileConstants.getFileSavePath():FileConstants.WEB_REAL_PATH.toString() + File.separator + uploadFile.getFilePath1()));
				is = new FileInputStream(file);
			} catch (FileNotFoundException e) {
				LOG.debug(e.getMessage(),e);
			}
		}else{
//			FileResult result = fileServiceClientAdapter.findFile(uploadFile.getSaveFileName());
//			is = result.getInputStream();
		}
		return is;
	}
	@Override
	public InputStream getFileInputStream(String realPath,Long id) {
		UploadFile uploadFile = fileUploadDAO.get(id);
		if(uploadFile == null){
			return null;
		}
		InputStream is = null;
		if(FileTypeEnum.FILE_SYSTEM.getType().equals(uploadFile.getType())){
			try {
				//uploadFile.getFilePath1() 不为空 表示 存在web容器的目录下  否则 取 固定目录fileConstants.getFileSavePath()
//				File file = new File((uploadFile.getFilePath1()==null?fileConstants.getFileSavePath():FileConstants.WEB_REAL_PATH.toString() + File.separator + uploadFile.getFilePath1()) + File.separator + uploadFile.getSaveFileName());
				File file = new File(realPath+ File.separator + uploadFile.getFilePath1());
				is = new FileInputStream(file);
			} catch (FileNotFoundException e) {
				LOG.error("fileId:"+id+"||"+e.getMessage(),e);
			}
		}else{
//			FileResult result = fileServiceClientAdapter.findFile(uploadFile.getSaveFileName());
//			is = result.getInputStream();
		}
		return is;
	}
	@Override
	public ExecuteResult<String> deleteFileByIds(String ids){
		ExecuteResult<String> result = new ExecuteResult<String>();
		if(StringUtils.isBlank(ids)){
			result.addErrorMessage(I18N_RESOLVER.getMessage("file.not.select"));
			return result;
		}
		String[] nameAndIds = ids.split(",");
		for(String nameAndId : nameAndIds){
			//String msg = deleteFileById(Long.parseLong(nameAndId));
			deleteFileById(Long.parseLong(nameAndId));
		}
		return result;
	}
	@Override
	public Pager<UploadFile> findPage(SearchModel<UploadFile> model) {
		List<UploadFile> records =  fileUploadDAO.findPage(model);
		long total = fileUploadDAO.findPageCount(model);
		model.getPager().setTotalRecords(total);
		model.getPager().setRecords(records);
		return model.getPager();
	}
	
	//保存到服务器固定目录
	private void saveToFileSystem(File fileInput,String saveFileName,ExecuteResult<UploadFile> result){
		if(result == null){
			result = new ExecuteResult<UploadFile>();
		}
		if(fileInput == null){
			result.addErrorMessage(I18N_RESOLVER.getMessage("file.not.empty"));
			return;
		}
		try{
			File outDir = new File(fileConstants.getFileSavePath() + File.separator);
			if(!outDir.exists()){
				if(!outDir.mkdirs()){
					result.addErrorMessage(I18N_RESOLVER.getMessage("file.dir.create.fail"));
					return;
				}
			}
			File outFile = new File(fileConstants.getFileSavePath() + File.separator + saveFileName);
			if(!copy(fileInput,outFile)){
				result.addErrorMessage(I18N_RESOLVER.getMessage("file.save.error"));
				return;
			}
		}catch(Exception e){
			result.addErrorMessage(I18N_RESOLVER.getMessage("file.save.error"));
			LOG.error("saveToFileSystem error.",e);
		}
	}
	//保存web容器下的指定目录
	private void saveToFileSystem(File fileInput,String saveFileName,String path,ExecuteResult<UploadFile> result){
		if(result == null){
			result = new ExecuteResult<UploadFile>();
		}
		if(fileInput == null){
			result.addErrorMessage(I18N_RESOLVER.getMessage("file.not.empty"));
			return;
		}
		try{
			File outDir = new File(FileConstants.WEB_REAL_PATH.toString() + File.separator + path + File.separator);
			if(!outDir.exists()){
				if(!outDir.mkdirs()){
					result.addErrorMessage(I18N_RESOLVER.getMessage("file.dir.create.fail"));
					return;
				}
			}
			File outFile = new File(FileConstants.WEB_REAL_PATH.toString() + File.separator + path + File.separator + saveFileName);
			if(!copy(fileInput,outFile)){
				result.addErrorMessage(I18N_RESOLVER.getMessage("file.save.error"));
				return;
			}
		}catch(Exception e){
			result.addErrorMessage(I18N_RESOLVER.getMessage("file.save.error"));
			LOG.error("saveToFileSystem error.",e);
		}
	}
	//保存到文件服务器
	private String saveToMongodb(File fileInput,String fileName,ExecuteResult<UploadFile> result){
		if(result == null){
			result = new ExecuteResult<UploadFile>();
		}
//		FileResult fileResult = fileServiceClientAdapter.saveFile(fileInput, fileName);
//		FileResult fileResult = null;
//		if(fileResult.isSuccess()){
//			return fileResult.getFileUUID();
//		}else{
//			result.addErrorMessage(fileResult.getMsg());
//			return null;
//		}
		return null;
	}

	 private boolean copy(File src,File target){
		 boolean flag = false;
         InputStream in = null;
         OutputStream out = null;
         try {
             in = new BufferedInputStream(new FileInputStream(src), BUFFERED_SIZE);
             out = new BufferedOutputStream(new FileOutputStream(target), BUFFERED_SIZE);
             byte[] bs = new byte[BUFFERED_SIZE];
             int i;
             while ((i = in.read(bs)) > 0) {
                     out.write(bs, 0, i);
             }
         } catch (FileNotFoundException e) {
             LOG.error("file not found.",e);
         } catch (IOException e) {
        	 LOG.error("io exception.",e);
         } finally {
             try {
                 if (in != null){
                	 in.close();
                  }
                 if (out != null){
                	 out.close();
                 }
             } catch (IOException e) {
            	 LOG.error("close file error.",e);
             }
         }
         flag = true;
         return flag;
	 }

	private boolean isSaveFileSystem(){
		return StringUtils.isNotBlank(fileConstants.getFileSavePath());
	}
	
	private String deleteFileById(Long id){
		try{
			UploadFile uf = fileUploadDAO.get(id);
			if(uf == null){
				return "文件不存在";
			}
			if(FileTypeEnum.FILE_SYSTEM.getType().equals(uf.getType())){
				//删除文件系统文件
				//uf.getFilePath1() 不为空 表示 存在web容器的目录下  否则 取 固定目录fileConstants.getFileSavePath()
				File file = new File(uf.getFilePath1()==null?fileConstants.getFileSavePath():FileConstants.WEB_REAL_PATH.toString() + File.separator + uf.getFilePath1() + File.separator + uf.getSaveFileName());
				if(!file.exists()){
					return "文件不存在";
				}
				if(!file.delete()){
					return I18N_RESOLVER.getMessage("file.delete.error");
				}
			}else{
				//删除mongodb文件
//				FileResult delResult = fileServiceClientAdapter.deleteFile(uf.getSaveFileName());
//				if(!delResult.isSuccess()){
//					return delResult.getMsg();
//				}
			}
			uf.setStatus(FileStatusEnum.INVALID.getStatus());
			uf.setLastModifiedBy(LoginContextHolder.get().getUserName());
			uf.setLastModifiedDt(new Date());
			fileUploadDAO.update(uf);
		}catch(Exception e){
			LOG.error("deleteFileById error,id=" + id,e);
			return I18N_RESOLVER.getMessage("file.delete.error");
		}
		return null;
	}
	
	public void setFileUploadDAO(FileUploadDAO fileUploadDAO) {
		this.fileUploadDAO = fileUploadDAO;
	}

	public void setFileConstants(FileConstants fileConstants) {
		this.fileConstants = fileConstants;
	}

	@Override
	public ExecuteResult<UploadFile> updateUplaodFile(Long id, File upload, String path,
			String uploadFileName, String uploadContentType, String remarks) {
		UploadFile uploadFile = fileUploadDAO.get(id);
		ExecuteResult<UploadFile> result = new ExecuteResult<UploadFile>();
		if(uploadFile!=null){
			if(upload != null){
				String saveFileName = null;
				//存储新文件
				if(FileTypeEnum.FILE_SYSTEM.getType().equals(uploadFile.getType())){
					//文件系统存储
					saveFileName = DataFormat.formatDate(new Date(), "yyyyMMddHHmmssSSS") + uploadFileName.substring(uploadFileName.lastIndexOf('.'));
					saveToFileSystem(upload, saveFileName, path, result);
					if(!result.isSuccess()){
						return result; 
					}
					//保存相对web容器根目录的文件存储路径
					uploadFile.setFilePath1(path);
					//删除文件系统文件(旧文件)
					//uf.getFilePath1() 不为空 表示 存在web容器的目录下  否则 取 固定目录fileConstants.getFileSavePath()
					File file = new File(uploadFile.getFilePath1()==null?fileConstants.getFileSavePath():FileConstants.WEB_REAL_PATH.toString() + File.separator + uploadFile.getFilePath1() + File.separator + uploadFile.getSaveFileName());
					if(file.exists()){
						file.delete();
					}
				}else{
					//mongodb存储
					String uuid = saveToMongodb(upload,uploadFileName,result);
					if(StringUtils.isNotBlank(uuid)){
						saveFileName = uuid;
					}
					if(!result.isSuccess()){
						return result; 
					}
					uploadFile.setFilePath1(fileConstants.getFileSavePath());
					//删除mongodb文件
//					FileResult delResult = fileServiceClientAdapter.deleteFile(uploadFile.getSaveFileName());
//					if(!delResult.isSuccess()){
//						LOG.error("deleteFileById from mongodb error,id=" + id);
//					}
				}
				uploadFile.setFileName(uploadFileName);
				uploadFile.setSaveFileName(saveFileName);
				uploadFile.setContentType(uploadContentType);
			}
			//更新信息
			Date curDate = new Date();
			uploadFile.setRemarks(remarks);
			uploadFile.setLastModifiedBy(LoginContextHolder.get().getUserName());
			uploadFile.setLastModifiedDt(curDate);
			fileUploadDAO.update(uploadFile);
			result.setResult(uploadFile);
			return result;
		}
		//文件不存在
		result.setResult(null);
		result.addErrorMessage("文件不存在");
		return result;
	}

}
