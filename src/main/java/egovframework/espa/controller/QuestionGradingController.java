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
import egovframework.espa.service.QuestionGradingService;

@RequestMapping("/question/grading")
@Controller
public class QuestionGradingController {
Logger logger = LoggerFactory.getLogger(QuestionGradingController.class.getName());
    
	@Resource(name = "questionGradingService")
	private QuestionGradingService gradingService;
	
	@RequestMapping(value = "/readList.do")
	public @ResponseBody JSONPObject getGradingList(@RequestParam("callback") String c, @RequestParam("params") String params) {

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

	@RequestMapping(value = "/create.do")
	public @ResponseBody JSONPObject insertGrading(@RequestParam("callback") String c, @RequestParam("models") String models) {
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
	
	@RequestMapping(value = "/update.do")
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
	
	
	@RequestMapping(value = "/delete.do")
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
}