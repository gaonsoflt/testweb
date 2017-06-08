package egovframework.dgms.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AppReqController {
Logger logger = LoggerFactory.getLogger(AppReqController.class.getName());
    
	@RequestMapping(value = "/dgms/appReq.do")
	public String dgmsAppReq(Model model) throws Exception {
		return "dgms/appReq";
	}
}
