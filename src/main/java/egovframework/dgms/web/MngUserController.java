package egovframework.dgms.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import egovframework.common.util.PwdEncryptor;
import egovframework.dgms.service.MngUserService;

@Controller
public class MngUserController {
Logger logger = LoggerFactory.getLogger(MngUserController.class.getName());
    
	@Resource(name = "mngUserService")
	private MngUserService mngUserService;

	@RequestMapping(value = "/dgms/mngUser.do")
	public String dgmsMngUser(Model model) throws Exception {
		return "dgms/mngUser";
	}
	

	/**
	 * 사용자 정보를 조회함
	 * @param c
	 * @param params
	 * @return
	 */
	@RequestMapping(value = "/dgms/selectMngUserDetailInfoJsonp.do")
	public @ResponseBody JSONPObject  selectMngUserDetailInfoJsonp(@RequestParam("callback") String c, @RequestParam("params") String params) {

		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		logger.debug("params:"+params); 
		paramMap = (HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params);
		List<HashMap<String, Object>> rtnList = null;
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		
		try {
			rtnList = (List<HashMap<String, Object>>)mngUserService.selectMngUserInfo((HashMap<String, Object>)paramMap);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", mngUserService.selectMngUserInfoTot((HashMap<String, Object>)paramMap));
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		System.out.println("result size: " + rtnList.size());
		System.out.println("result: " + rtnList);
		return new JSONPObject(c,rtnMap);
	}
	

	/**
	 * 사용자 정보를 저장함
	 * @param c
	 * @param models
	 * @return
	 */
	@RequestMapping(value = "/dgms/insertMngUserInfoJsonp.do")
	public @ResponseBody JSONPObject insertMngUserInfoJsonp(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/dgms/insertMngUserInfoJsonp.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		logger.debug("models:"+models); 
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:"+paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				mngUserService.insertMngUserInfo(paramMap);
				
				if (paramMap.get("LOGIN_PWD")!=null && !paramMap.get("LOGIN_PWD").toString().trim().equals(""))
				{
					paramMap.put("LOGIN_PWD",PwdEncryptor.getEncrypt(paramMap.get("LOGIN_PWD").toString().trim()));
					mngUserService.updateMngPassInfo(paramMap);
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
	 * 사용자 정보를 수정함
	 * @param c
	 * @param models
	 * @return
	 */
	@RequestMapping(value = "/dgms/updateMngUserInfoJsonp.do")
	public @ResponseBody JSONPObject updateMngUserInfoJsonp(@RequestParam("callback") String c, @RequestParam("models") String models) {  
		logger.debug("---------------->/dgms/updateMngUserInfoJsonp.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		logger.debug("models:"+models); 
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:"+paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				mngUserService.updateMngUserInfo(paramMap);
				
				if (paramMap.get("LOGIN_PWD")!=null && !paramMap.get("LOGIN_PWD").toString().trim().equals(""))
				{
					paramMap.put("LOGIN_PWD",PwdEncryptor.getEncrypt(paramMap.get("LOGIN_PWD").toString().trim()));
					mngUserService.updateMngPassInfo(paramMap);
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
	 */
	@RequestMapping(value = "/dgms/deleteMngUserInfoJsonp.do")
	public @ResponseBody JSONPObject deleteMngUserInfoJsonp(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/dgms/deleteMngUserInfoJsonp.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		logger.debug("models:"+models); 
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:"+paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				mngUserService.deleteMngUserInfo(paramMap);
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
	
	
	
	
}