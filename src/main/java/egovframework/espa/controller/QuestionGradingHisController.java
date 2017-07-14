package egovframework.espa.controller;

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
import egovframework.espa.service.QuestionGradingHistoryService;

@RequestMapping("/question/deploy/result")
@Controller
public class QuestionGradingHisController {
	Logger logger = LoggerFactory.getLogger(QuestionGradingHisController.class.getName());

	@Resource(name = "questionGradingHistoryService")
	private QuestionGradingHistoryService gradingHisService;
	
	@RequestMapping(value = "/readGradingResultListByUser.do")
	public @ResponseBody JSONPObject readGradingResultListByUser(@RequestParam("callback") String c, @RequestParam("params") String params) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		logger.debug("params:" + params);
		paramMap = EgovWebUtil.parseJsonToMap(params);
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			List<Map<String, Object>> rtnList = gradingHisService.getGradingResultListByUser(paramMap);
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
		Map<String, Object> paramMap = new HashMap<String, Object>();
		logger.debug("params:" + params);
		paramMap = EgovWebUtil.parseJsonToMap(params);
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			List<Map<String, Object>> rtnList = gradingHisService.getGradingResultList(paramMap);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", rtnList.size());
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return new JSONPObject(c, rtnMap);
	}

	/**
	 * ESPA manager result detail user list
	 * @param c
	 * @param params
	 * @return
	 */
	@RequestMapping(value = "/readGradingResultOfUserList.do")
	public @ResponseBody JSONPObject readGradingResultOfUserList(@RequestParam("callback") String c, @RequestParam("params") String params) {
		logger.debug("params:" + params);
		 Map<String, Object> param = EgovWebUtil.parseJsonToMap(params);
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			List<Map<String, Object>> rtnList = gradingHisService.getGradingResultOfUserList(param);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", rtnList.size());
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return new JSONPObject(c, rtnMap);
	}

}