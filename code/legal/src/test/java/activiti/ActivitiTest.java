package activiti;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipInputStream;

import javax.annotation.Resource;

import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.task.Task;
import org.apache.commons.io.FilenameUtils;
import org.junit.Test;






import base.BaseTestCase;
public class ActivitiTest extends BaseTestCase{
	@Resource
	private RepositoryService repositoryService;
	@Resource
	private RuntimeService runtimeService;
	@Resource
	private TaskService taskService;
//	public void testDeploy(){
//		try {
//			logger.debug("--------------------------------------------------");
//			String filePath = "E:\\project\\java\\legal\\src\\main\\resources\\activiti\\process\\legal\\LegalAid.bpmn";
//			File processFile = new File(filePath);
//		    InputStream fileInputStream = new FileInputStream(processFile);
//		      Deployment deployment = null;
//		      String extension = FilenameUtils.getExtension(processFile.getName());
//		      if (extension.equals("zip") || extension.equals("bar")) {
//		        ZipInputStream zip = new ZipInputStream(fileInputStream);
//		        deployment = repositoryService.createDeployment().addZipInputStream(zip).deploy();
//		      } else {
//		        deployment = repositoryService.createDeployment().addInputStream(processFile.getName(), fileInputStream).deploy();
//		      }
//		      List<ProcessDefinition> list = repositoryService.createProcessDefinitionQuery().deploymentId(deployment.getId()).list();
//		      for (ProcessDefinition processDefinition : list) {
//				logger.debug("布署的流程:"+processDefinition.getName());
//			}
//		} catch (Exception e) {
//			logger.error("布署流程出现问题",e);
//		}
//	}
	@Test
	public void testStartWorkFlow(){
		Map<String, Object> variables = new HashMap<String, Object>();
		variables.put("businformId", "12");
		variables.put("businformType", "LE_LEGAL_CASE");
		runtimeService.startProcessInstanceByKey("LegalAidProcess", variables);	
	}
//	@Test
//	public void testGetTask(){
//		List<Task> list =  taskService.createTaskQuery().taskDefinitionKey("caseApprove").list();
//		logger.debug("------------------");
//	}
}
