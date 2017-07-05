package egovframework.espa.controller;

import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import egovframework.common.util.FileUtil;
import egovframework.espa.service.QuestionAnswerService;
import egovframework.espa.service.QuestionExecuteService;
import egovframework.espa.service.impl.QuestionDeployMapper;
import egovframework.systemmgr.service.SystemMgrUserService;

@RequestMapping("/question/deploy/answer")
@Controller
public class QuestionAnswerController {
	Logger logger = LoggerFactory.getLogger(QuestionAnswerController.class.getName());

	@Resource(name = "questionAnswerService")
	private QuestionAnswerService questionAnswerService;
	
	@Resource(name = "questionExecuteService")
	private QuestionExecuteService executeService;
	
	@Resource(name = "questionDeployMapper")
	private QuestionDeployMapper deployMapper;
	
	@Resource(name = "systemMgrUserService")
	private SystemMgrUserService userService;
	
	
	@RequestMapping(value = "/gradingresult.do", method = RequestMethod.GET)
	public ModelAndView form(HttpServletRequest request,  ModelAndView model) {
		ModelAndView mav = new ModelAndView("espa/class/gradingResult");
//		logger.debug("model map: "+ model.getModelMap());
		return mav;
	}
	
	@RequestMapping(value = "/submit.do", method = RequestMethod.POST)
	public ModelAndView submit(HttpServletRequest request, @RequestParam(value="submit_file", required=false)MultipartFile file) throws Exception {
		ModelAndView mav = new ModelAndView("redirect:/question/deploy/answer/gradingresult.do");
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("deploy_seq", request.getParameter("deploy_seq"));
		String answerType = request.getParameter("answer_type");
		if(answerType.equals("file")) {
			param.put("answer", FileUtil.readFile(file));
		} else {
			param.put("answer", request.getParameter("submit_editor"));
		}
		// insert answer history
		if(questionAnswerService.saveAnswer(param)) {
			param.put("user_seq", userService.getLoginUserInfo().getUserseq());
			executeService.execute(param);
//			ESPAExecuteVO result = executeService.execute(param);
//			result.setCode("");
//			result.setGrading(null);
//			mav.addObject("result", result);
		}

		return mav;
	}

}