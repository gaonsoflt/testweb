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
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.util.JSONPObject;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.espa.service.QuestionCandidateService;

@RequestMapping("/mgr/question/deploy/candidate")
@Controller
public class MgrCandidateController {
	Logger logger = LoggerFactory.getLogger(MgrCandidateController.class.getName());
	
	@Resource(name = "questionCandidateService")
	private QuestionCandidateService candidateService;
	
	@RequestMapping(value = "/list.do")
	public @ResponseBody JSONPObject candidateList(@RequestParam("callback") String c, @RequestParam("params") String params) throws Exception {
		Map<String, Object> rtnMap = new HashMap<>();
		try {
			List<Map<String, Object>> rtnList = candidateService.getCandidateList(EgovWebUtil.parseJsonToMap(params));
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", rtnList.size());
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return new JSONPObject(c, rtnMap);
	}
	
	@RequestMapping(value = "/userlist.do")
	public @ResponseBody JSONPObject notCandidateList(@RequestParam("callback") String c, @RequestParam("params") String params) throws Exception {
		Map<String, Object> rtnMap = new HashMap<>();
		try {
			List<Map<String, Object>> rtnList = candidateService.getNotCandidateList(EgovWebUtil.parseJsonToMap(params));
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", rtnList.size());
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return new JSONPObject(c, rtnMap);
	}
	
	@RequestMapping(value = "/deploylist.do")
	public @ResponseBody JSONPObject notFinishDeployList(@RequestParam("callback") String c, @RequestParam("params") String params) throws Exception {
		Map<String, Object> rtnMap = new HashMap<>();
		try {
			List<Map<String, Object>> rtnList = candidateService.getDeployedQuestionList(EgovWebUtil.parseJsonToMap(params));
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", rtnList.size());
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return new JSONPObject(c, rtnMap);
	}

	@RequestMapping(value = "/update.do")
	public ModelAndView updateCandidate(@RequestParam Map<String, Object> param) throws Exception {
		ModelAndView model = new ModelAndView();
		int executeCnt = 0;
		try {
			executeCnt = candidateService.saveCandidate(param);
			logger.debug("executeCnt: " + executeCnt);
			model.addObject("result", executeCnt);
		} catch (Exception e) {
			e.printStackTrace();
			model.addObject("error", e.toString());
		}
		model.setViewName("jsonView");
		return model;
	}
}