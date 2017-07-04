package egovframework.espa.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.util.JSONPObject;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.espa.service.QuestionGradingHistoryService;

@RequestMapping("/question/deploy/result")
@Controller
public class QuestionGradingHisController {
	Logger logger = LoggerFactory.getLogger(QuestionGradingHisController.class.getName());

	@Resource(name = "questionGradingHistoryService")
	private QuestionGradingHistoryService gradingHisService;
	
	@RequestMapping(value = "/readGradingResultListByUser.do")
	public @ResponseBody JSONPObject readGradingResultListByUser(@RequestParam("callback") String c, @RequestParam("params") String params) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		logger.debug("params:" + params);
		paramMap = (HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params);
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			List<HashMap<String, Object>> rtnList = (List<HashMap<String, Object>>) gradingHisService.getGradingResultListByUser(paramMap);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", rtnList.size());

		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return new JSONPObject(c, rtnMap);
	}
	
	@RequestMapping(value = "/readGradingResultList.do")
	public @ResponseBody JSONPObject readGradingResultList(@RequestParam("callback") String c, @RequestParam("params") String params) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		logger.debug("params:" + params);
		paramMap = (HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params);
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			List<HashMap<String, Object>> rtnList = (List<HashMap<String, Object>>) gradingHisService.getGradingResultList(paramMap);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", rtnList.size());
			
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return new JSONPObject(c, rtnMap);
	}

}