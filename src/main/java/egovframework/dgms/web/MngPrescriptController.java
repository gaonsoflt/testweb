package egovframework.dgms.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MngPrescriptController {
Logger logger = LoggerFactory.getLogger(MngPrescriptController.class.getName());
    
	@RequestMapping(value = "/dgms/mngPrescript.do")
	public String dgmsMngPrescript(Model model) throws Exception {
		return "dgms/mngPrescript";
	}
}