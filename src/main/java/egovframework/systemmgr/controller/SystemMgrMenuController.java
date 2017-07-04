package egovframework.systemmgr.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.util.JSONPObject;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.login.service.CmmLoginUser;
import egovframework.common.service.CommonService;
import egovframework.systemmgr.dao.SystemMgrMenuVO;
import egovframework.systemmgr.service.SystemMgrMenuService;

@RequestMapping("/sm/menu")
@Controller
public class SystemMgrMenuController {
Logger logger = LoggerFactory.getLogger(SystemMgrMenuController.class.getName());

	@Resource(name = "systemMgrMenuService")
	private SystemMgrMenuService menuService;
	
	@Resource(name = "commonService")
	private CommonService commonService;
	

	/**
	 * 조회
	 * @param c
	 * @param params
	 * @return
	 */
	@RequestMapping(value = "/read.do")
	public @ResponseBody JSONPObject selectMenuInfoList(@RequestParam("callback") String c, @RequestParam("params") String params) throws Exception {
		logger.debug("----------------> /read.do");
		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		logger.debug("params: " + params); 
		paramMap = (HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params);

		List<HashMap<String, Object>> rtnList = null;
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		System.out.println(paramMap); 

		try {
			rtnList = menuService.selectMenuInfo(paramMap);
			System.out.println(rtnList);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", rtnList.size());
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, rtnMap);
	}
	
	
	/**
	 * 의료상담 접수 정보를 저장함
	 * @param c
	 * @param models
	 * @return
	 */
	@RequestMapping(value = "/create.do")
	public @ResponseBody JSONPObject createMenuInfo(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("----------------> /create.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		logger.debug("models: " + models); 
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList: " + paramMapList); 

		// set parameter login user area_id
		CmmLoginUser userDetails = (CmmLoginUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
//				paramMap.put("MENU_SQ", nextSequence());
				System.out.println("paramMap: " + paramMap);
				// insert call
				menuService.createMenuInfo(paramMap);
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
	 * 의료상담 접수  정보 수정함
	 * @param c
	 * @param models
	 * @return
	 */
	@RequestMapping(value = "/update.do")
	public @ResponseBody JSONPObject updateMenuInfo(@RequestParam("callback") String c, @RequestParam("models") String models) {  
		logger.debug("----------------> /update.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();
		logger.debug("models:" + models); 
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList: " + paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				menuService.updateMenuInfo(paramMap);
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
	 * 의료상담 접수 정보를 삭제함
	 * @param c
	 * @param models
	 * @return
	 */
	@RequestMapping(value = "/delete.do")
	public @ResponseBody JSONPObject deleteMenuInfo(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("----------------> /delete.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();
		logger.debug("models: " + models); 
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		
		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				logger.debug("paramMap: " + paramMap);
				
				// delete call
				menuService.deleteMenuInfo(paramMap);
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
	 * 사이트에 메뉴를 그리기 위해서 호출하는 함수
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getMenuInfoByUserAuth.do")
	public ModelAndView getMenuInfoByUserAuth(@RequestParam Map<String,Object> paramMap) throws Exception {
		ModelAndView model = new ModelAndView();
    	CmmLoginUser userDetails = (CmmLoginUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    	paramMap.put("USER_NO", userDetails.getUserseq());
		logger.debug("===============================pamam: " + paramMap);
		List<SystemMgrMenuVO> rtnList = menuService.getMenuInfoByUserAuth((HashMap<String, Object>)paramMap);
		logger.debug("rtnList: " + rtnList);
		model.addObject("rtnList", rtnList);
		model.setViewName("jsonView");
		return model; 
	}
	
//	@RequestMapping(value = "/notify.do")
//	public void refreshConfig() {
//		try {
//	    	CmmLoginUser userDetails = (CmmLoginUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//	    	HashMap<String,Object> paramMap = new HashMap<>(); 
//	    	paramMap.put("USER_NO", userDetails.getUserseq());
//			logger.debug("[BBAEK] refresh before: " + menuService.getMenuVo());
//			menuService.refreshMenu(paramMap);
//			logger.debug("[BBAEK] refresh after: " + menuService.getMenuVo());
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//	}
}