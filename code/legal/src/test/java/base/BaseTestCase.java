package base;
import org.junit.Before;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.neusoft.base.common.LoginContext;
import com.neusoft.base.common.LoginContextHolder;



@ContextConfiguration(locations = {"classpath*:/spring/spring*.xml"})
@RunWith(SpringJUnit4ClassRunner.class)
public class BaseTestCase{
	protected Logger logger = LoggerFactory.getLogger(getClass());
	@Before
	public void loadUser(){
		LoginContext context = new LoginContext();
		context.setUserId(1L);
		context.setUserName("admin");
		context.setEmpCode("1");
		LoginContextHolder.put(context);
	}
}
