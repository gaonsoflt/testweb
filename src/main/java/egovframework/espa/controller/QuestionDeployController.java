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

@RequestMapping("/mgr/question/deploy")
@Controller
public class QuestionDeployController {
	Logger logger = LoggerFactory.getLogger(QuestionDeployController.class.getName());

	@Resource(name = "questionDeployService")
	private QuestionDeployService deployService;

	/**
	 * 사용자 정보를 조회함
	 * 
	 * @param c
	 * @param params
	 * @return
	 */
	@RequestMapping(value = "/readList.do")
	public @ResponseBody JSONPObject getDeployList(@RequestParam("callback") String c, @RequestParam("params") String params) {

		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		logger.debug("params:" + params);
		paramMap = (HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params);
		List<HashMap<String, Object>> rtnList = null;
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();

		try {
			rtnList = (List<HashMap<String, Object>>) deployService.getDeployList(paramMap);
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

	/**
	 * 사용자 정보를 조회함
	 * 
	 * @param c
	 * @param params
	 * @return
	 */
	@RequestMapping(value = "/read.do")
	public @ResponseBody JSONPObject getDeploy(@RequestParam("callback") String c, @RequestParam("params") String params) {

		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		logger.debug("params:" + params);
		paramMap = (HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params);
		List<HashMap<String, Object>> rtnList = null;
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();

		try {
			// rtnMap = (HashMap<String, Object>)
			// noticeService.getDeploy(paramMap).get(0);
			rtnList = (List<HashMap<String, Object>>) deployService.getDeploy(paramMap);
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

	/**
	 * 사용자 정보를 저장함
	 * 
	 * @param c
	 * @param models
	 * @return
	 */
	@RequestMapping(value = "/create.do")
	public @ResponseBody JSONPObject insertDeploy(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/create.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("models:" + models);
		logger.debug("paramMapList:" + paramMapList);

		try {
			for (int i = 0; i < paramMapList.size(); i++) {
				deployService.createDeploy((HashMap<String, Object>) paramMapList.get(i));
			}
		} catch (Exception e) {
			e.printStackTrace();
			HashMap<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, models);
	}

	/**
	 * 사용자 정보를 수정함
	 * 
	 * @param c
	 * @param models
	 * @return
	 */
	@RequestMapping(value = "/update.do")
	public @ResponseBody JSONPObject updateDeploy(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/update.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		logger.debug("models:" + models);
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:" + paramMapList);

		try {
			for (int i = 0; i < paramMapList.size(); i++) {
				deployService.updateDeploy((HashMap<String, Object>) paramMapList.get(i));
			}
		} catch (Exception e) {
			e.printStackTrace();
			HashMap<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, models);
	}

	/**
	 * 사용자 정보를 삭제함
	 * 
	 * @param c
	 * @param models
	 * @return
	 */
	@RequestMapping(value = "/delete.do")
	public @ResponseBody JSONPObject deleteDeploy(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/delete.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();
		logger.debug("models:" + models);
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:" + paramMapList);

		try {
			for (int i = 0; i < paramMapList.size(); i++) {
				deployService.deleteDeploy((HashMap<String, Object>) paramMapList.get(i));
			}
		} catch (Exception e) {
			e.printStackTrace();
			HashMap<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, models);
	}
}