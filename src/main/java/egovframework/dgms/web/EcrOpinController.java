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
import egovframework.dgms.service.EcrOpinService;


@Controller
public class EcrOpinController {
Logger logger = LoggerFactory.getLogger(EcrOpinController.class.getName());
    
	@Resource(name = "ecrOpinService")
	private EcrOpinService ecrOpinService;

	@RequestMapping(value = "/dgms/ecrOpin.do")
	public String dgmsEcrOpin(Model model) throws Exception {
		return "dgms/ecrOpin";
	}
	
	/**
	 * 검사 소견을 조회함
	 * @param c
	 * @param params
	 * @return
	 */
	@RequestMapping(value = "/dgms/selectEcrOpinDetailInfoJsonp.do")
	public @ResponseBody JSONPObject  selectEcrOpinDetailInfoJsonp(@RequestParam("callback") String c, @RequestParam("params") String params) {

		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		logger.debug("params:"+params); 
		paramMap = (HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params);
		List<HashMap<String, Object>> rtnList = null;
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		
		try {
			rtnList = (List<HashMap<String, Object>>)ecrOpinService.selectEcrOpinInfo((HashMap<String, Object>)paramMap);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", ecrOpinService.selectEcrOpinInfoTot((HashMap<String, Object>)paramMap));
			
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
	@RequestMapping(value = "/dgms/insertEcrOpinInfoJsonp.do")
	public @ResponseBody JSONPObject insertEcrOpinInfoJsonp(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/dgms/insertEcrOpinInfoJsonp.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		logger.debug("models:"+models); 
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:"+paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				ecrOpinService.insertEcrOpinInfo(paramMap);
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
	@RequestMapping(value = "/dgms/updateEcrOpinInfoJsonp.do")
	public @ResponseBody JSONPObject updateEcrOpinInfoJsonp(@RequestParam("callback") String c, @RequestParam("models") String models) {  
		logger.debug("---------------->/dgms/updateEcrOpinInfoJsonp.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		logger.debug("models:"+models); 
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:"+paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				ecrOpinService.updateEcrOpinInfo(paramMap);
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
	@RequestMapping(value = "/dgms/deleteEcrOpinInfoJsonp.do")
	public @ResponseBody JSONPObject deleteEcrOpinInfoJsonp(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/dgms/deleteEcrOpinInfoJsonp.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		logger.debug("models:"+models); 
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:"+paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				ecrOpinService.deleteEcrOpinInfo(paramMap);
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
