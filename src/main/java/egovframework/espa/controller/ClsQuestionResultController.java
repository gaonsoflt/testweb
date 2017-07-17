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

@RequestMapping("/class/question/deploy/result")
@Controller
public class ClsQuestionResultController {
	Logger logger = LoggerFactory.getLogger(ClsQuestionResultController.class.getName());

	@Resource(name = "questionGradingHistoryService")
	private QuestionGradingHistoryService gradingHisService;
	
	@RequestMapping(value = "/list.do")
	public @ResponseBody JSONPObject list(@RequestParam("callback") String c, @RequestParam("params") String params) {
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
}