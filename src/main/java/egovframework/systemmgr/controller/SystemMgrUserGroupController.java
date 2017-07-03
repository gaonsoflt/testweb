package egovframework.systemmgr.controller;

import java.util.HashMap;

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
import egovframework.systemmgr.service.SystemMgrUserGroupService;

@RequestMapping("/sm/usergroup")
@Controller
public class SystemMgrUserGroupController {
	Logger logger = LoggerFactory.getLogger(SystemMgrUserGroupController.class.getName());
	
	@Resource(name = "systemMgrUserGroupService")
	private SystemMgrUserGroupService systemMngUserGroupService;
	
	@RequestMapping({ "readNoGroupUser.do" })
	public @ResponseBody JSONPObject readNoGroupUser(@RequestParam("callback") String c, @RequestParam("params") String params) throws Exception {
		logger.debug("---------------->/readNoGroupUser.do");
		logger.debug("params: " + params);
		return new JSONPObject(c, systemMngUserGroupService.getNoGroupUser((HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params)));
	}
	
	@RequestMapping({ "readGroupUser.do" })
	public @ResponseBody JSONPObject readGroupUser(@RequestParam("callback") String c, @RequestParam("params") String params) throws Exception {
		logger.debug("---------------->/readGroupUser.do");
		logger.debug("params: " + params);
		return new JSONPObject(c, systemMngUserGroupService.getGroupUser((HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params)));
	}
	
	@RequestMapping({ "readUserGroup.do" })
	public @ResponseBody JSONPObject readUserGroup(@RequestParam("callback") String c, @RequestParam("params") String params) throws Exception {
		logger.debug("---------------->/readUserGroup.do");
		logger.debug("params: " + params);
		return new JSONPObject(c, systemMngUserGroupService.getGroupByUser((HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params)));
	}
	
	@RequestMapping({ "readLoginUserGroup.do" })
	public @ResponseBody JSONPObject readLoginUserGroup(@RequestParam("callback") String c, @RequestParam("params") String params) throws Exception {
		logger.debug("---------------->/readLoginUserGroup.do");
		return new JSONPObject(c, systemMngUserGroupService.getGroupByLoginUser());
	}
	
//	@RequestMapping({ "/update.do" })
//	public @ResponseBody JSONPObject updateGroupUser(@RequestParam("callback") String c, @RequestParam("params") String params, @RequestParam("models") String models) throws Exception {
//		logger.debug("---------------->/updateGroupUser.do");
//		logger.debug("params: " + params);
//		logger.debug("models: " + models); 
//		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();
//		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
//		int executeCnt = 0;
//		try {
//			for (int i = 0; i < paramMapList.size(); i++) {
//				HashMap<String, Object> paramMap = (HashMap<String, Object>) paramMapList.get(i);
//				executeCnt += systemMngUserGroupService.updateGroupUser(paramMap);
//			}
//			logger.debug("executeCnt: " + executeCnt);
//		} catch (Exception e) {
//			e.printStackTrace();
//			HashMap<String, Object> rtnMap = new HashMap<String, Object>();
//			rtnMap.put("error", e.toString());
//			return new JSONPObject(c, rtnMap);
//		}
//		return new JSONPObject(c, models);
//	}
	
	@RequestMapping(value = "/update.do")
	public ModelAndView updateGroupUser(@RequestParam HashMap<String, Object> paramMap) throws Exception {
		logger.debug("---------------->/updateGroupUser.do");
		logger.debug("===============================params: " + paramMap);
		ModelAndView model = new ModelAndView();
		int executeCnt = 0;
		try {
			executeCnt = systemMngUserGroupService.updateGroupUser(paramMap);
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