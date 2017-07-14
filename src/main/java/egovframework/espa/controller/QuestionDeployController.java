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
import egovframework.espa.service.QuestionDeployService;

@RequestMapping("/question/deploy")
@Controller
public class QuestionDeployController {
	Logger logger = LoggerFactory.getLogger(QuestionDeployController.class.getName());

	@Resource(name = "questionDeployService")
	private QuestionDeployService deployService;

	@RequestMapping(value = "/readList.do")
	public @ResponseBody JSONPObject getDeployList(@RequestParam("callback") String c, @RequestParam("params") String params) {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		logger.debug("params:" + params);
		paramMap = EgovWebUtil.parseJsonToMap(params);
		List<Map<String, Object>> rtnList = null;
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		try {
			rtnList = deployService.getDeployList(paramMap);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", deployService.getDeployAllCount(paramMap));

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

	@RequestMapping(value = "/read.do")
	public @ResponseBody JSONPObject getDeploy(@RequestParam("callback") String c, @RequestParam("params") String params) {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		logger.debug("params:" + params);
		paramMap = EgovWebUtil.parseJsonToMap(params);
		List<Map<String, Object>> rtnList = null;
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		try {
			// rtnMap = (HashMap<String, Object>)
			// noticeService.getDeploy(paramMap).get(0);
			rtnList = deployService.getDeploy(paramMap);
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
	public @ResponseBody JSONPObject insertDeploy(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/create.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();
		paramMapList = EgovWebUtil.parseJsonToList(models);
		logger.debug("models:" + models);
		logger.debug("paramMapList:" + paramMapList);

		try {
			for (int i = 0; i < paramMapList.size(); i++) {
				deployService.createDeploy(paramMapList.get(i));
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
	public @ResponseBody JSONPObject updateDeploy(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/update.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();
		logger.debug("models:" + models);
		paramMapList = EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:" + paramMapList);

		try {
			for (int i = 0; i < paramMapList.size(); i++) {
				deployService.updateDeploy(paramMapList.get(i));
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
	public @ResponseBody JSONPObject deleteDeploy(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/delete.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();
		logger.debug("models:" + models);
		paramMapList = EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:" + paramMapList);

		try {
			for (int i = 0; i < paramMapList.size(); i++) {
				deployService.deleteDeploy(paramMapList.get(i));
			}
		} catch (Exception e) {
			e.printStackTrace();
			Map<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, models);
	}
	
	@RequestMapping(value = "/readDeployedQuestionListByUser.do")
	public @ResponseBody JSONPObject readDeployedQuestionListByUser(@RequestParam("callback") String c, @RequestParam("params") String params) {
		logger.debug("---------------->/readDeployedQuestionListByUser.do");
		logger.debug("params: " + params);
		return new JSONPObject(c, deployService.getDeployedQuestionListByUser(EgovWebUtil.parseJsonToMap(params)));
	}
	
	@RequestMapping(value = "/readDeployedQuestionDetailByUser.do")
	public @ResponseBody JSONPObject readDeployedQuestionDetailByUser(@RequestParam("callback") String c, @RequestParam("params") String params) {
		logger.debug("---------------->/readDeployedQuestionDetailByUser.do");
		return new JSONPObject(c, deployService.getDeployedQuestionDetailByUser(EgovWebUtil.parseJsonToMap(params)));
	}
	
	@RequestMapping(value = "/groupsByUser.do")
	public @ResponseBody JSONPObject getGroupOfDeployedQuestionByUser(@RequestParam("callback") String c, @RequestParam("params") String params) {
		logger.debug("---------------->/getGroupOfDeployedQuestionByUser.do");
		return new JSONPObject(c, deployService.getGroupOfDeployedQuestionByUser(EgovWebUtil.parseJsonToMap(params)).get("rtnList"));
	}
	
	@RequestMapping(value = "/groups.do")
	public @ResponseBody JSONPObject getGroupOfDeployedQuestion(@RequestParam("callback") String c, @RequestParam("params") String params) {
		logger.debug("---------------->/getGroupOfDeployedQuestion.do");
		return new JSONPObject(c, deployService.getGroupOfDeployedQuestion(EgovWebUtil.parseJsonToMap(params)).get("rtnList"));
	}
}