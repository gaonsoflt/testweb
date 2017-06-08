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
import egovframework.dgms.service.MngEquipUseService;

@Controller
public class MngEquipUseController {
Logger logger = LoggerFactory.getLogger(MngEquipUseController.class.getName());

	@Resource(name = "mngEquipUseService")
	private MngEquipUseService mngEquipUseService;

	@RequestMapping(value = "/dgms/mngEquipUse.do")
	public String dgmsMngEquipUse(Model model) throws Exception {
		return "dgms/mngEquipUse";
	}
	
	/**
	 * 검사 소견을 조회함
	 * @param c
	 * @param params
	 * @return
	 */
	@RequestMapping(value = "/dgms/selectMngEquipUseDetailInfoJsonp.do")
	public @ResponseBody JSONPObject  selectMngEquipUseDetailInfoJsonp(@RequestParam("callback") String c, @RequestParam("params") String params) {

		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		logger.debug("params:"+params); 
		paramMap = (HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params);
		List<HashMap<String, Object>> rtnList = null;
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		
		try {
			rtnList = (List<HashMap<String, Object>>)mngEquipUseService.selectMngEquipUseInfo((HashMap<String, Object>)paramMap);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", mngEquipUseService.selectMngEquipUseInfoTot((HashMap<String, Object>)paramMap));
			
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
	 * 검사 소견을 저장함
	 * @param c
	 * @param models
	 * @return
	 */
	@RequestMapping(value = "/dgms/insertMngEquipUseInfoJsonp.do")
	public @ResponseBody JSONPObject insertMngEquipUseInfoJsonp(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/dgms/insertMngEquipUseInfoJsonp.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		logger.debug("models:"+models); 
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:"+paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				mngEquipUseService.insertMngEquipUseInfo(paramMap);
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
	 * 검사 소견을 수정함
	 * @param c
	 * @param models
	 * @return
	 */
	@RequestMapping(value = "/dgms/updateMngEquipUseInfoJsonp.do")
	public @ResponseBody JSONPObject updateMngEquipUseInfoJsonp(@RequestParam("callback") String c, @RequestParam("models") String models) {  
		logger.debug("---------------->/dgms/updateMngEquipUseInfoJsonp.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		logger.debug("models:"+models); 
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:"+paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				mngEquipUseService.updateMngEquipUseInfo(paramMap);
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
	 * 검사 소견을 삭제함
	 * @param c
	 * @param models
	 * @return
	 */
	@RequestMapping(value = "/dgms/deleteMngEquipUseInfoJsonp.do")
	public @ResponseBody JSONPObject deleteMngEquipUseInfoJsonp(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/dgms/deleteMngEquipUseInfoJsonp.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		logger.debug("models:"+models); 
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:"+paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				mngEquipUseService.deleteMngEquipUseInfo(paramMap);
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