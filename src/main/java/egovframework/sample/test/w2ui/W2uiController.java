package egovframework.sample.test.w2ui;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class W2uiController {
	
    Logger logger = LoggerFactory.getLogger(W2uiController.class.getName());
    
	@RequestMapping(value = "/w2ui/start.do")
	public String start(Model model) throws Exception {
		return "w2ui/start";
	}

	@RequestMapping(value = "/w2ui/layout.do")
	public String layout(Model model) throws Exception {
		return "w2ui/layout";
	}
	
	@RequestMapping(value = "/w2ui/grid.do")
	public String grid(Model model) throws Exception {
		return "w2ui/grid";
	}
	
	@RequestMapping(value = "/w2ui/sidebar.do")
	public String sidebar(Model model) throws Exception {
		return "w2ui/sidebar";
	}
}
