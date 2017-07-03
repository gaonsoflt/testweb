package egovframework.espa.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.util.JSONPObject;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.espa.service.QuestionService;

@RequestMapping("/question")
@Controller
public class QuestionController {
	Logger logger = LoggerFactory.getLogger(QuestionController.class.getName());
	
	@Resource(name = "questionService")
	private QuestionService questionService;
	
	@RequestMapping(value = "/readDeployedQuestionListForSubmit.do")
	public @ResponseBody JSONPObject readDeployedQuestionListForSubmit(@RequestParam("callback") String c, @RequestParam("params") String params) {
		logger.debug("---------------->/readDeployedQuestionListForSubmit.do");
		logger.debug("params: " + params);
		return new JSONPObject(c, questionService.readDeployedQuestionListForSubmit((HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params)));
	}
	
	@RequestMapping(value = "/readDeployedQuestionDetailForSubmit.do")
	public @ResponseBody JSONPObject readDeployedQuestionDetailForSubmit(@RequestParam("callback") String c, @RequestParam("params") String params) {
		logger.debug("---------------->/readDeployedQuestionDetailForSubmit.do");
		return new JSONPObject(c, questionService.readDeployedQuestionDetailForSubmit((HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params)));
	}
}