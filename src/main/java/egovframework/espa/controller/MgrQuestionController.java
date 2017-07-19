package egovframework.espa.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.util.JSONPObject;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.espa.service.ConfigService;
import egovframework.espa.service.QuestionConditionService;
import egovframework.espa.service.QuestionExecuteService;
import egovframework.espa.service.QuestionGradingService;
import egovframework.espa.service.QuestionMgrService;
import egovframework.systemmgr.service.SystemMgrMenuService;

@RequestMapping("/mgr/question")
@Controller
public class MgrQuestionController {
	Logger logger = LoggerFactory.getLogger(MgrQuestionController.class.getName());
    
	@Resource(name = "questionMgrService")
	private QuestionMgrService questionService;
	
	@Resource(name = "systemMgrMenuService")
	private SystemMgrMenuService menuService;
	
	@Autowired
	ConfigService config;
	
	@RequestMapping(value = "/form.do")
	public ModelAndView formView(Model model, @RequestParam(value="id", required=false)String seq)  throws Exception {
		logger.debug("param: question_seq=" + seq);
		ModelAndView mav = new ModelAndView("espa/mgr/questionMgrForm");
		try {
			long _seq = Long.valueOf(seq);
			mav.addObject("questionInfo", questionService.getQuestion(_seq).get(0));
		}catch (Exception e) {
			e.printStackTrace();
		}
		mav.addObject("default_timeout", config.getEspaConfigVoValue("DEFAULT_TIMEOUT"));
		mav.addObject("default_ban_kw", config.getEspaConfigVoValue("DEFAULT_BAN_KW"));
		mav.addObject("default_max_codesize", config.getEspaConfigVoValue("DEFAULT_MAX_CODESIZE"));
		mav.addObject("menu", menuService.getMenuVo("espaMgrQuestion"));
		return mav;
	}
	
	@RequestMapping(value = "/list.do")
	public @ResponseBody JSONPObject list(@RequestParam("callback") String c, @RequestParam("params") String params) {

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
		ModelAndView mav = null;
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
				mav = new ModelAndView("redirect:/mgr/question/form.do?id=" + param.get("question_seq").toString());
			} else if(action.equals("delete")) {
				questionService.deleteQuestion(param);
				mav = new ModelAndView("redirect:/mgr/question.do");
			}
			return mav;
		} catch (Exception e) {
			e.printStackTrace();
			return new ModelAndView("/egovframework/cmmn/bizError");
		}
	}
	
	@RequestMapping(value = "/languages.do")
	public @ResponseBody JSONPObject getLanguage(@RequestParam("callback") String c,@RequestParam("params") String params) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		List<Map<String, Object>> rtnList = questionService.getSupportLanguage(paramMap);
		return new JSONPObject(c, rtnList);
	}
	
	
	/*
	 * question grading
	 */
	@Resource(name = "questionGradingService")
	private QuestionGradingService gradingService;
	
	@RequestMapping(value = "/grading/list.do")
	public @ResponseBody JSONPObject gradingList(@RequestParam("callback") String c, @RequestParam("params") String params) {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		logger.debug("params:" + params); 
		paramMap = EgovWebUtil.parseJsonToMap(params);
		List<Map<String, Object>> rtnList = null;
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		try {
			rtnList = gradingService.getGradingList(paramMap);
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

	@RequestMapping(value = "/grading/create.do")
	public @ResponseBody JSONPObject createGrading(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/create.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();
		paramMapList = EgovWebUtil.parseJsonToList(models);
		logger.debug("models:" + models); 
		logger.debug("paramMapList:" + paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				Map<String, Object> paramMap = paramMapList.get(i);
				gradingService.createGrading(paramMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
			Map<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, models);
	}
	
	@RequestMapping(value = "/grading/update.do")
	public @ResponseBody JSONPObject updateGrading(@RequestParam("callback") String c, @RequestParam("models") String models) {  
		logger.debug("---------------->/update.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		logger.debug("models:" + models); 
		paramMapList = EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:" + paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				Map<String, Object> paramMap = paramMapList.get(i);
				gradingService.updateGrading(paramMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
			Map<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, models);
	}
	
	
	@RequestMapping(value = "/grading/delete.do")
	public @ResponseBody JSONPObject deleteGrading(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/delete.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();
		logger.debug("models:" + models); 
		paramMapList = EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:" + paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				Map<String, Object> paramMap = paramMapList.get(i);
				gradingService.deleteGrading(paramMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
			Map<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, models);
	}
	
	
	/*
	 * question condition 
	 */
	@Resource(name = "questionConditionService")
	private QuestionConditionService conditionService;
	
	@RequestMapping(value = "/condition/list.do")
	public @ResponseBody JSONPObject conditionList(@RequestParam("callback") String c, @RequestParam("params") String params) {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		logger.debug("params:" + params); 
		paramMap = EgovWebUtil.parseJsonToMap(params);
		List<Map<String, Object>> rtnList = null;
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		try {
			rtnList = conditionService.getConditionList(paramMap);
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
		return new JSONPObject(c,rtnMap);
	}

	@RequestMapping(value = "/condition/create.do")
	public @ResponseBody JSONPObject createCondition(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/create.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();
		paramMapList = EgovWebUtil.parseJsonToList(models);
		logger.debug("models:" + models); 
		logger.debug("paramMapList:" + paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				Map<String, Object> paramMap = paramMapList.get(i);
				conditionService.createCondition(paramMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
			Map<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, models);
	}
	
	@RequestMapping(value = "/condition/update.do")
	public @ResponseBody JSONPObject updateCondition(@RequestParam("callback") String c, @RequestParam("models") String models) {  
		logger.debug("---------------->/update.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		logger.debug("models:" + models); 
		paramMapList = EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:" + paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				Map<String, Object> paramMap = paramMapList.get(i);
				conditionService.updateCondition(paramMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
			Map<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, models);
	}
	
	@RequestMapping(value = "/condition/delete.do")
	public @ResponseBody JSONPObject deleteCondition(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/delete.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();
		logger.debug("models:" + models); 
		paramMapList = EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:" + paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				Map<String, Object> paramMap = paramMapList.get(i);
				conditionService.deleteCondition(paramMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
			Map<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, models);
	}
	
	
	/*
	 * execute test code
	 */
	@Resource(name = "questionExecuteService")
	private QuestionExecuteService executeService;
	
	@RequestMapping(value = "/test/execute.do")
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
	
	/*
	 * download sample file for import
	 */
	@RequestMapping(value = "/import/downloadsample.do")
	public ModelAndView downloadSampleFile(Model model) throws Exception {
		ModelAndView mav = new ModelAndView();
		try {
			if(logger.isDebugEnabled()) {
				logger.debug("file: " + getClass().getResource("/egovframework/file/sample_question_import.xlsx").getFile());
			}
			File f = new File(getClass().getResource("/egovframework/file/sample_question_import.xlsx").getFile());
			mav.addObject("file", f);
			mav.setViewName("fileDownloadView");
		} catch(Exception e) {
			e.printStackTrace();
		}
		return mav;
	}

	/*
	 * import
	 */
	@RequestMapping(value = "/import/submit.do", method = RequestMethod.POST)
	public ModelAndView submitImportFile(MultipartHttpServletRequest req) throws Exception {
		ModelAndView mav;
		try {
			Map<String, Object> param = questionService.importQuestion(req);
			mav = new ModelAndView("redirect:/mgr/question/form.do?id=" + param.get("question_seq"));
		} catch(Exception e) {
			mav = new ModelAndView("redirect:/mgr/question.do");
		}
		return mav;
	}
	
	/*
	 * export
	 */
	@RequestMapping(value = "/{seq}/export.do")
	public ModelAndView exportFile(Model model, @PathVariable(value="seq") long seq) throws Exception {
		ModelAndView mav = new ModelAndView();
		try {
			File f = questionService.exportQuestion(seq);
			mav.addObject("file", f);
			mav.setViewName("fileDownloadView");
		} catch(Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
}