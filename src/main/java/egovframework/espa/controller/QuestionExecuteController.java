package egovframework.espa.controller;

import java.util.HashMap;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import egovframework.espa.service.QuestionExecuteService;

@RequestMapping("/question/execute")
@Controller
public class QuestionExecuteController {
	Logger logger = LoggerFactory.getLogger(QuestionExecuteController.class.getName());

	@Resource(name = "questionExecuteService")
	private QuestionExecuteService executeService;

	@RequestMapping(value = "/test.do")
	public ModelAndView executeTest(@RequestParam HashMap<String, Object> params) throws Exception {
		logger.debug("[BBAEK] params: " + params);
		boolean result = true;
		ModelAndView model = new ModelAndView();
		try {
			executeService.executeTest(params);
		} catch (Exception e) {
			e.printStackTrace();
			model.addObject("error", e);
			result = false;
		}
		model.addObject("success", result);
		model.setViewName("jsonView");
		return model;
	}
}