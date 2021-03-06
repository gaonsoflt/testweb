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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.util.JSONPObject;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.util.FileUtil;
import egovframework.espa.service.QuestionDeployService;
import egovframework.espa.service.QuestionExecuteService;
import egovframework.espa.service.impl.QuestionDeployMapper;

@RequestMapping("/cls/question/test")
@Controller
public class ClsTestController {
	Logger logger = LoggerFactory.getLogger(ClsTestController.class.getName());

	@Resource(name = "questionExecuteService")
	private QuestionExecuteService executeService;
	
	@Resource(name = "questionDeployMapper")
	private QuestionDeployMapper deployMapper;
	
	@RequestMapping(value = "/complete.do", method = RequestMethod.GET)
	public ModelAndView form(HttpServletRequest request,  ModelAndView model) {
		ModelAndView mav = new ModelAndView("espa/class/gradingResult");
//		logger.debug("model map: "+ model.getModelMap());
		return mav;
	}
	
	@RequestMapping(value = "/submit.do", method = RequestMethod.POST)
	public ModelAndView submit(HttpServletRequest request, @RequestParam(value="submit_file", required=false)MultipartFile file) throws Exception {
		ModelAndView mav = new ModelAndView();
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("deploy_seq", request.getParameter("deploy_seq"));
		String answerType = request.getParameter("answer_type");
		if(answerType.equals("file")) {
			param.put("answer", FileUtil.getFileString(file));
		} else {
			param.put("answer", request.getParameter("submit_editor"));
		}
		try {
			executeService.execute(param);
			mav.setViewName("redirect:/cls/question/test/complete.do");
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("error", e.getMessage());
			// TODO: setViewName for error
//			mav.setViewName(view);
		}
		return mav;
	}
	
	@Resource(name = "questionDeployService")
	private QuestionDeployService deployService;

	@RequestMapping(value = "/list.do")
	public @ResponseBody JSONPObject list(@RequestParam("callback") String c, @RequestParam("params") String params) {
		logger.debug("---------------->/readDeployedQuestionListByUser.do");
		logger.debug("params: " + params);
		return new JSONPObject(c, deployService.getDeployedQuestionListByUser(EgovWebUtil.parseJsonToMap(params)));
	}
	
	@RequestMapping(value = "/detail.do")
	public @ResponseBody JSONPObject detail(@RequestParam("callback") String c, @RequestParam("params") String params) {
		logger.debug("---------------->/readDeployedQuestionDetailByUser.do");
		return new JSONPObject(c, deployService.getDeployedQuestionDetailByUser(EgovWebUtil.parseJsonToMap(params)));
	}
}