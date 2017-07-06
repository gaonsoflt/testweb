package egovframework.espa.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.util.JSONPObject;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.espa.service.ConfigService;
import egovframework.espa.service.ESPAConfigService;

@RequestMapping("/mgr/config")
@Controller
public class ESPAConfigController {
Logger logger = LoggerFactory.getLogger(ESPAConfigController.class.getName());
    
	@Resource(name = "eSPAConfigService")
	private ESPAConfigService configSvc;

	@Autowired
	private ConfigService config;

	@RequestMapping(value = "/read.do")
	public @ResponseBody JSONPObject readESPAConfig(@RequestParam("callback") String c, @RequestParam("params") String params) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		logger.debug("params:" + params);
		paramMap = (HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params);
		List<HashMap<String, Object>> rtnList = null;
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();

		try {
			rtnList = (List<HashMap<String, Object>>)configSvc.readESPAConfig(paramMap);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", configSvc.readESPAConfigAllTot(paramMap));
			
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
	
	@RequestMapping(value = "/create.do")
	public @ResponseBody JSONPObject createESPAConfig(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/create.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("models:" + models); 
		logger.debug("paramMapList:"+paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				configSvc.createESPAConfig(paramMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
			HashMap<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, models);
	}
	
	@RequestMapping(value = "/update.do")
	public @ResponseBody JSONPObject updateESPAConfig(@RequestParam("callback") String c, @RequestParam("models") String models) {  
		logger.debug("---------------->/update.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();
		logger.debug("models:" + models);
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:" + paramMapList);

		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				configSvc.updateESPAConfig(paramMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
			HashMap<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, models);
	}
	
	@RequestMapping(value = "/delete.do")
	public @ResponseBody JSONPObject deleteESPAConfig(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/delete.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		logger.debug("models:" + models);
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:" + paramMapList);

		try {
			for (int i = 0; i < paramMapList.size(); i++) {
				HashMap<String, Object> paramMap = (HashMap<String, Object>) paramMapList.get(i);
				configSvc.deleteESPAConfig(paramMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
			HashMap<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, models);
	}
	
	@RequestMapping(value = "/notify.do")
	public void refreshConfig() {
		try {
			logger.debug("[BBAEK] refresh config before: " + config.getEspaConfigVo());
			config.init();
			logger.debug("[BBAEK] refresh config after: " + config.getEspaConfigVo());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value = "/groups.do")
	public @ResponseBody JSONPObject getConfigGroupList(@RequestParam("callback") String c, @RequestParam("params") String params) {
		logger.debug("---------------->/getConfigGroupList.do");
		return new JSONPObject(c, configSvc.getConfigGroupList((HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params)).get("rtnList"));
	}
}