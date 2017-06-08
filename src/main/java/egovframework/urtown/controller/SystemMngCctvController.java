package egovframework.urtown.controller;

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
import egovframework.dgms.service.CommonService;
import egovframework.urtown.service.SystemMngCctvService;

@Controller
public class SystemMngCctvController {
Logger logger = LoggerFactory.getLogger(SystemMngCctvController.class.getName());
    
	@Resource(name = "systemMngCctvService")
	private SystemMngCctvService systemMngCctvService;

	@Resource(name = "commonService")
	private CommonService commonService;

	@RequestMapping(value = "/urtown/checkCctvView.do")
	public String cctv(Model model) throws Exception {
		return "urtown/checkCctvView";
	}
	
	@RequestMapping(value = "/urtown/systemMngCctv.do")
	public String mngCctv(Model model) throws Exception {
		return "urtown/systemMngCctv";
	}
	
	@RequestMapping(value = "/urtown/systemMultiCctv.do")
	public String multiCctv(Model model) throws Exception {
		return "urtown/checkMultiCctv";
	}
	

	/**
	 * CCTV 정보를 조회함
	 * @param c
	 * @param params
	 * @return
	 */
	@RequestMapping(value = "/urtown/selectMngCctvInfoJsonp.do")
	public @ResponseBody JSONPObject  selectMngCctvInfoJsonp(@RequestParam("callback") String c, @RequestParam("params") String params) {

		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		logger.debug("params:"+params);
		//paramMap.put("G_AreaIdVal", params);
		System.out.println(params);
		paramMap = (HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params);
		List<HashMap<String, Object>> rtnList = null;
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		
		try {
			rtnList = (List<HashMap<String, Object>>)systemMngCctvService.selectMngCctvInfo((HashMap<String, Object>)paramMap);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", systemMngCctvService.selectMngCctvInfoTot((HashMap<String, Object>)paramMap));
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c,rtnMap);
	}
	

	/**
	 * CCTV 정보를 저장함
	 * @param c
	 * @param models
	 * @return
	 */
	@RequestMapping(value = "/urtown/insertMngCctvInfoJsonp.do")
	public @ResponseBody JSONPObject insertMngCctvInfoJsonp(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/urtown/insertMngCctvInfoJsonp.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		logger.debug("models:"+models); 
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:"+paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> keySeq = new HashMap<String, Object>();
				keySeq.put("SEQ_NM", "SEQ_CCTV");
				
				String Sequence = (String)commonService.getSequence((HashMap<String, Object>)keySeq); 
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				paramMap.put("CCTV_SEQ", Sequence);
				systemMngCctvService.insertMngCctvInfo(paramMap);
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
	 * CCTV 정보를 수정함
	 * @param c
	 * @param models
	 * @return
	 */ 
	@RequestMapping(value = "/urtown/updateMngCctvInfoJsonp.do")
	public @ResponseBody JSONPObject updateMngCctvInfoJsonp(@RequestParam("callback") String c, @RequestParam("models") String models) {  
		logger.debug("---------------->/urtown/updateMngCctvInfoJsonp.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		logger.debug("models:"+models); 
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:"+paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				systemMngCctvService.updateMngCctvInfo(paramMap);
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
	 * CCTV 정보를 삭제함
	 * @param c
	 * @param models
	 * @return
	 */ 
	@RequestMapping(value = "/urtown/deleteMngCctvInfoJsonp.do")
	public @ResponseBody JSONPObject deleteMngCctvInfoJsonp(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/urtown/deleteMngCctvInfoJsonp.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		logger.debug("models:"+models); 
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:"+paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				systemMngCctvService.deleteMngCctvInfo(paramMap);
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
	 * CCTV 정보를 조회함
	 * @param c
	 * @param params
	 * @return
	 */
	@RequestMapping(value = "/urtown/selectMngCctvInfoJsonp2.do")
	public @ResponseBody JSONPObject  selectMngCctvInfoJsonp2(@RequestParam("callback") String c, @RequestParam("param") String params) {

		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		logger.debug("params:"+params);
		paramMap.put("G_AreaIdVal", params);
		System.out.println(params);
		//paramMap = (HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params);
		List<HashMap<String, Object>> rtnList = null;
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		
		try {
			rtnList = (List<HashMap<String, Object>>)systemMngCctvService.selectMngCctvInfo((HashMap<String, Object>)paramMap);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", systemMngCctvService.selectMngCctvInfoTot((HashMap<String, Object>)paramMap));
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c,rtnMap);
	}
}