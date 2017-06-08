package egovframework.urtown.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ExecuteProgramController {
Logger logger = LoggerFactory.getLogger(ExecuteProgramController.class.getName());

	@RequestMapping(value = "/executeApp.do", method=RequestMethod.GET)
	public String executeApp(Model model, @RequestParam(value="target", required=false) String target) throws Exception {
		logger.debug("---------------->/execute.do");
		logger.debug("execute target: " + target);
		
		//String file = "C:\\Program Files (x86)\\Skype\\Phone\\" + target;
		//String file = "skype.exe";
		
		try {
			Process oProcess = new ProcessBuilder(target).start();
		} catch(Exception e) {
			e.printStackTrace();
			return "redirect:/urtown/connectSkype.do?error=true";
		}
		return "redirect:/urtown/connectSkype.do";
	}
}