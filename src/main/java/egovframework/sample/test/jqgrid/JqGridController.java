package egovframework.sample.test.jqgrid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class JqGridController {
	
    Logger logger = LoggerFactory.getLogger(JqGridController.class.getName());
    
	@RequestMapping(value = "/jqgrid/basic.do")
	public String start(Model model) throws Exception {
		return "jqgrid/basic";
	}
}
