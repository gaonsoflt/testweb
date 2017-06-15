package egovframework.com.contorller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {
	Logger logger = LoggerFactory.getLogger(HomeController.class.getName());

	/**
	 * 홈페이지 메인
	 * @return "index"
	 * @exception Exception
	 */
	@RequestMapping(value = "/index.do")
	public String hindex(ModelMap model) throws Exception {
		
		logger.debug("........................................................................../index.do");
		return "com/login/login";
	}
}