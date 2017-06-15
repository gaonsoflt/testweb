package egovframework.systemmgr.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.util.JSONPObject;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.systemmgr.service.SystemMgrLoginHistoryService;

@RequestMapping("/sm/history/login")
@Controller
public class SystemMgrLoginLogController {
Logger logger = LoggerFactory.getLogger(SystemMgrLoginLogController.class.getName());
    
	@Resource(name = "systemMgrLoginHistoryService")
	private SystemMgrLoginHistoryService systemMngLoginLogService;


	/**
	 * 사용자 정보를 조회함
	 * @param c
	 * @param params
	 * @return
	 */
	@RequestMapping(value = "/read.do")
	public @ResponseBody JSONPObject selectMngLoginLogJsonp(@RequestParam("callback") String c, @RequestParam("params") String params) {

		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		logger.debug("params:"+params); 
		paramMap = (HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params);
		List<HashMap<String, Object>> rtnList = null;
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		
		try {
			rtnList = (List<HashMap<String, Object>>)systemMngLoginLogService.selectLoginHistory(paramMap);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", systemMngLoginLogService.selectSystemMngLoginLogTot(paramMap));
			
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
	
//
//	/**
//	 * 로그인 정보를 저장함
//	 * @param c
//	 * @param models
//	 * @return
//	 */
//	@RequestMapping(value = "/createLogin.do")
//	public @ResponseBody JSONPObject createLogin(@RequestParam("callback") String c, @RequestParam("models") String models) {
//		logger.debug("---------------->/createLogin.do");
//		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();
//		logger.debug("models:" + models); 
//		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
//		logger.debug("paramMapList:" + paramMapList); 
//
//		try {
//			for(int i=0; i < paramMapList.size(); i++){
//				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
//				systemMngLoginLogService.insertLoginHistory(paramMap);
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//			HashMap<String, Object> rtnMap = new HashMap<String, Object>();
//			rtnMap.put("error", e.toString());
//			return new JSONPObject(c, rtnMap);
//		}
//		return new JSONPObject(c, models);
//	}
	
	/*
	/**
	 * 사용자 정보를 수정함
	 * @param c
	 * @param models
	 * @return
	 * /
	@RequestMapping(value = "/urtown/updateMngUserInfoJsonp.do")
	public @ResponseBody JSONPObject updateMngUserInfoJsonp(@RequestParam("callback") String c, @RequestParam("models") String models) {  
		logger.debug("---------------->/urtown/updateMngUserInfoJsonp.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		logger.debug("models:"+models); 
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:"+paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				systemMngUserService.updateSystemMngUserInfo(paramMap);
				
				if (paramMap.get("LOGIN_PWD")!=null && !paramMap.get("LOGIN_PWD").toString().trim().equals(""))
				{
					paramMap.put("LOGIN_PWD",PwdEncryptor.getEncrypt(paramMap.get("LOGIN_PWD").toString().trim()));
					systemMngUserService.updateMngPassInfo(paramMap);
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			HashMap<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, models);
	}
	
	
	/**
	 * 사용자 정보를 삭제함
	 * @param c
	 * @param models
	 * @return
	 * /
	@RequestMapping(value = "/urtown/deleteMngUserInfoJsonp.do")
	public @ResponseBody JSONPObject deleteMngUserInfoJsonp(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/urtown/deleteMngUserInfoJsonp.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		logger.debug("models:"+models); 
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:"+paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				systemMngUserService.deleteSystemMngUserInfo(paramMap);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			HashMap<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, models);
	}
	*/
	
}