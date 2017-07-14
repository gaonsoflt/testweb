package egovframework.espa.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import egovframework.espa.service.QuestionMgrService;

@RequestMapping("/question")
@Controller
public class QuestionMgrController {
	Logger logger = LoggerFactory.getLogger(QuestionMgrController.class.getName());
    
	@Resource(name = "questionMgrService")
	private QuestionMgrService questionService;
	
	@RequestMapping(value = "/readList.do")
	public @ResponseBody JSONPObject getQuestionList(@RequestParam("callback") String c, @RequestParam("params") String params) {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		logger.debug("params:" + params); 
		paramMap = EgovWebUtil.parseJsonToMap(params);
		List<Map<String, Object>> rtnList = null;
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		try {
			rtnList = questionService.getQuestionList(paramMap);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", questionService.getQuestionAllCount(paramMap));
			
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		System.out.println("result size: " + rtnList.size());
		System.out.println("result: " + rtnList);
		return new JSONPObject(c,rtnMap);
	}
	
	@RequestMapping(value = "/save.do", method = RequestMethod.POST)
	public ModelAndView save(HttpServletRequest request, @RequestParam String action, @RequestParam(value="file", required=false)MultipartFile file) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		logger.debug("[BBAEK] action: " + action);
		try {
			param.put("question_seq", request.getParameter("question-seq"));
			if(action.equals("save")) {
				param.put("title", request.getParameter("title"));
				param.put("con_question", request.getParameter("con-question"));
				param.put("con_io", request.getParameter("con-io"));
				param.put("con_example", request.getParameter("con-example"));
				param.put("con_hint", request.getParameter("con-hint"));
				param.put("test_code", request.getParameter("test-code"));
				param.put("lang_type", request.getParameter("lang-type"));
				param.put("timeout", request.getParameter("timeout"));
				param.put("ban_keyword", request.getParameter("ban-keyword"));
				param.put("max_codesize", request.getParameter("max-codesize"));
				param.put("grading", request.getParameter("grading"));
				questionService.saveQuestion(param);
			} else if(action.equals("delete")) {
				questionService.deleteQuestion(param);
			}
			return new ModelAndView("redirect:/mgr/question/form.do?id=" + param.get("question_seq").toString());
		} catch (Exception e) {
			e.printStackTrace();
			return new ModelAndView("/egovframework/cmmn/bizError");
		}
	}
	
	@RequestMapping(value = "/read.do")
	public @ResponseBody JSONPObject getQuestion(@RequestParam("callback") String c, @RequestParam("params") String params) {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		logger.debug("params:" + params); 
		paramMap = EgovWebUtil.parseJsonToMap(params);
		List<Map<String, Object>> rtnList = null;
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		try {
			rtnList = questionService.getQuestion(paramMap);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", rtnList.size());
			
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		System.out.println("result size: " + rtnList.size());
		System.out.println("result: " + rtnList);
		return new JSONPObject(c, rtnMap);
	}

	@RequestMapping(value = "/create.do")
	public @ResponseBody JSONPObject insertQuestion(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/create.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();
		paramMapList = EgovWebUtil.parseJsonToList(models);
		logger.debug("models:" + models); 
		logger.debug("paramMapList:" + paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				Map<String, Object> paramMap = paramMapList.get(i);
				questionService.createQuestion(paramMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
			Map<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, models);
	}
	
	@RequestMapping(value = "/update.do")
	public @ResponseBody JSONPObject updateQuestion(@RequestParam("callback") String c, @RequestParam("models") String models) {  
		logger.debug("---------------->/update.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		logger.debug("models:" + models); 
		paramMapList = EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:" + paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				Map<String, Object> paramMap = paramMapList.get(i);
				questionService.updateQuestion(paramMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
			Map<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, models);
	}
	
	@RequestMapping(value = "/delete.do")
	public @ResponseBody JSONPObject deleteQuestion(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/delete.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();
		logger.debug("models:" + models); 
		paramMapList = EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:" + paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				Map<String, Object> paramMap = paramMapList.get(i);
				logger.debug("[BBAEK] delete question:" + paramMap.get("question_seq"));
				questionService.deleteQuestion(paramMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
			Map<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, models);
	}
	
	@RequestMapping(value = "/getSupportLanguage.do")
	public @ResponseBody JSONPObject getSupportLanguage(@RequestParam("callback") String c,@RequestParam("params") String params) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		List<Map<String, Object>> rtnList = questionService.getSupportLanguage(paramMap);
		return new JSONPObject(c, rtnList);
	}
}