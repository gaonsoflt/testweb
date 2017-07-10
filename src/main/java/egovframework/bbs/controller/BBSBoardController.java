package egovframework.bbs.controller;

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

import egovframework.bbs.service.BBSBoardService;
import egovframework.com.cmm.EgovWebUtil;

@RequestMapping("/bbs/board")
@Controller
public class BBSBoardController {
Logger logger = LoggerFactory.getLogger(BBSBoardController.class.getName());
    
	@Resource(name = "bBSBoardService")
	private BBSBoardService boardService;
	
	@RequestMapping(value = "/readList.do")
	public @ResponseBody JSONPObject readList(@RequestParam("callback") String c, @RequestParam("params") String params) {
		logger.debug("params:" + params); 
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		try {
			Map<String, Object> param = EgovWebUtil.parseJsonToMap(params);
			List<Map<String, Object>> rtnList = boardService.getBBSList(param);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", boardService.getBBSListCount(param));
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return new JSONPObject(c, rtnMap);
	}
	
	@RequestMapping(value = "/read.do")
	public @ResponseBody JSONPObject read(@RequestParam("callback") String c, @RequestParam("params") String params) {
		logger.debug("params:" + params); 
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			Map<String, Object> paramMap = EgovWebUtil.parseJsonToMap(params);
			rtnMap = boardService.getBBS(paramMap);
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return new JSONPObject(c, rtnMap);
	}

	@RequestMapping(value = "/create.do")
	public @ResponseBody JSONPObject create(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/create.do");
		logger.debug("models:" + models); 
		List<Map<String, Object>> paramMapList = EgovWebUtil.parseJsonToList(models);
		try {
			for(int i = 0; i < paramMapList.size(); i++){
				boardService.createBBS(paramMapList.get(i));
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
	public @ResponseBody JSONPObject update(@RequestParam("callback") String c, @RequestParam("models") String models) {  
		logger.debug("---------------->/update.do");
		logger.debug("models:" + models); 
		List<Map<String, Object>> paramMapList = EgovWebUtil.parseJsonToList(models);
		try {
			for(int i = 0; i < paramMapList.size(); i++){
				boardService.updateBBS(paramMapList.get(i));
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
	public @ResponseBody JSONPObject delete(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/delete.do");
		logger.debug("models:" + models); 
		List<Map<String, Object>> paramMapList = EgovWebUtil.parseJsonToList(models);
		try {
			for(int i = 0; i < paramMapList.size(); i++){
				boardService.deleteBBS(paramMapList.get(i));
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