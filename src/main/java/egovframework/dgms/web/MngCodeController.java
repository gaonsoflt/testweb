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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.util.JSONPObject;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.dgms.service.MngCodeService;

@Controller
public class MngCodeController {
	Logger logger = LoggerFactory.getLogger(MngCodeController.class.getName());
    
	@Resource(name = "mngCodeService")
	private MngCodeService mngCodeService;

	@RequestMapping(value = "/dgms/mngCode.do")
	public String dgmsMngCode(Model model) throws Exception {
		return "dgms/mngCode";
	}
	
	/**
	 * 공통코드의 마스터 정보를 조회함
	 * @param c
	 * @param params
	 * @return
	 */
	@RequestMapping(value = "/dgms/selectMngCodeMasterInfoJsonp.do")
	public @ResponseBody JSONPObject  selectMngCodeMasterInfoJsonp(@RequestParam("callback") String c, @RequestParam("params") String params) {

		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		logger.debug("params:"+params); 
		paramMap = (HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params);
		logger.debug("paramMap:"+paramMap); 
		List<HashMap<String, Object>> rtnList = null;
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		
		try {
			rtnList = (List<HashMap<String, Object>>)mngCodeService.selectMngCodeMasterInfo((HashMap<String, Object>)paramMap);
			rtnMap.put("rtnList", rtnList);
			//rtnMap.put("total", mngCodeService.selectMngCodeInfoTot((HashMap<String, Object>)paramMap));
			
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
	 * 공통코드의 디테일 정보를 조회함
	 * @param c
	 * @param params
	 * @return
	 */
	@RequestMapping(value = "/dgms/selectMngCodeDetailInfoJsonp.do")
	public @ResponseBody JSONPObject  selectMngCodeDetailInfoJsonp(@RequestParam("callback") String c, @RequestParam("params") String params) {

		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		logger.debug("params:"+params); 
		paramMap = (HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params);
		logger.debug("paramMap:"+paramMap); 
		List<HashMap<String, Object>> rtnList = null;
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		
		try {
			rtnList = (List<HashMap<String, Object>>)mngCodeService.selectMngCodeInfo((HashMap<String, Object>)paramMap);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", mngCodeService.selectMngCodeInfoTot((HashMap<String, Object>)paramMap));
			
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
	 * 공통코드 정보를 저장함
	 * @param c
	 * @param models
	 * @return
	 */
	@RequestMapping(value = "/dgms/insertMngCodeInfoJsonp.do")
	public @ResponseBody JSONPObject insertMngCodeInfoJsonp(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/dgms/insertMngCodeInfoJsonp.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		logger.debug("models:"+models); 
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:"+paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				mngCodeService.insertMngCodeInfo(paramMap);
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
	 * 공통코드 정보를 수정함
	 * @param c
	 * @param models
	 * @return
	 */
	@RequestMapping(value = "/dgms/updateMngCodeInfoJsonp.do")
	public @ResponseBody JSONPObject updateMngCodeInfoJsonp(@RequestParam("callback") String c, @RequestParam("models") String models) {  
		logger.debug("---------------->/dgms/updateMngCodeInfoJsonp.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		logger.debug("models:"+models); 
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:"+paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				mngCodeService.updateMngCodeInfo(paramMap);
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
	 * 공통코드 정보를 삭제함
	 * @param c
	 * @param models
	 * @return
	 */
	@RequestMapping(value = "/dgms/deleteMngCodeInfoJsonp.do")
	public @ResponseBody JSONPObject deleteMngCodeInfoJsonp(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/dgms/deleteMngCodeInfoJsonp.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		logger.debug("models:"+models); 
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:"+paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				mngCodeService.deleteMngCodeInfo(paramMap);
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
	 * 코드명을 조회함
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/dgms/selectCdNmCombo.do")
	public ModelAndView selectCdNmCombo(@RequestParam Map<String,Object> paramMap) throws Exception {
		ModelAndView model = new ModelAndView();
		
		List<HashMap<String, Object>> rtnList = (List<HashMap<String, Object>>)mngCodeService.selectCdNmCombo((HashMap<String, Object>)paramMap);
		
		model.addObject("rtnList", rtnList);
		model.setViewName("jsonView");
		return model;
	}
	
	/**
	 * 코드분류명을 조회함
	 * @param c
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/dgms/selectCdNmComboJsonp.do")
	public @ResponseBody JSONPObject selectCdNmComboJsonp(@RequestParam("callback") String c,@RequestParam("params") String params) throws Exception {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap = (HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params);
		List<HashMap<String, Object>> rtnList = (List<HashMap<String, Object>>)mngCodeService.selectCdNmCombo((HashMap<String, Object>)paramMap);
		return new JSONPObject(c,rtnList);
	}
	
	
	
	
	
	@RequestMapping(value = "/dgms/selectMngCodeInfo.do")
	public ModelAndView selectMngCodeInfo(@RequestBody Map<String, Object> paramMap) throws Exception {
		ModelAndView model = new ModelAndView();
		
/*		logger.debug("paramMap:"+paramMap.size()); 
		logger.debug("SKIP:"+paramMap.get("SKIP").toString());
		logger.debug("PAGE:"+paramMap.get("PAGE").toString());
		logger.debug("PAGESIZE:"+paramMap.get("PAGESIZE").toString());
		logger.debug("TAKE:"+paramMap.get("TAKE").toString());
		logger.debug("paramMap:"+paramMap);*/
		
		List<HashMap<String, Object>> rtnList = (List<HashMap<String, Object>>)mngCodeService.selectMngCodeInfo((HashMap<String, Object>)paramMap);
		model.addObject("total", mngCodeService.selectMngCodeInfoTot((HashMap<String, Object>)paramMap));
		
/*		if( Objects.equals(rtnList.size(),0)){
			model.addObject("total", 0);
		}else{
			model.addObject("total", rtnList.size());
		}*/
		
		model.addObject("rtnList", rtnList);
		//model.addObject("error", "에러...............");
		model.setViewName("jsonView");
		return model;
	}
	
	
	@RequestMapping(value = "/dgms/selectMngCodeInfoCombo.do")
	public ModelAndView selectMngCodeInfoCombo(@RequestParam Map<String,Object> paramMap) throws Exception {
		ModelAndView model = new ModelAndView();
		
		List<HashMap<String, Object>> rtnList = (List<HashMap<String, Object>>)mngCodeService.selectMngCodeInfoCombo((HashMap<String, Object>)paramMap);
		
		model.addObject("rtnList", rtnList);
		model.setViewName("jsonView");
		return model;
	}
	

	
	
	
	
/*	@RequestMapping(value="/dgms/updateMngCodeInfo.do")
	public void updateMngCodeInfo(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("---------------->/dgms/updateMngCodeInfo.do");
		mngCodeService.updateMngCodeInfo((HashMap<String, Object>)paramMap);
		
	}*/
	
/*	@RequestMapping(value = "/dgms/updateMngCodeInfo.do", method=RequestMethod.POST)
	public @ResponseBody String updateMngCodeInfo(@RequestBody testVo paramMap){ //@RequestParam Map<String,Object> @RequestBody Map<String, Object> 
		logger.debug("---------------->/dgms/updateMngCodeInfo.do");
		logger.debug("paramMap:"+paramMap.getPage());
		
		ObjectMapper mapper = new ObjectMapper(); // create once, reuse
		
		try {
			mngCodeService.updateMngCodeInfo((HashMap<String, Object>)paramMap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}*/
	

	
/*	@RequestMapping(value = "/dgms/updateMngCodeInfo.do", method=RequestMethod.POST)
	public @ResponseBody String updateMngCodeInfo(@RequestBody Map<String, Object> paramMap){ //@RequestParam Map<String,Object> @RequestBody Map<String, Object> 
		logger.debug("---------------->/dgms/updateMngCodeInfo.do");
		logger.debug("paramMap:"+paramMap.size());
		//logger.debug("skip:"+paramMap.get("skip").toString());
		//logger.debug("page:"+paramMap.get("page").toString());
		logger.debug("paramMap:"+paramMap);

		try {
			mngCodeService.updateMngCodeInfo((HashMap<String, Object>)paramMap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}*/
	
	
	
	
	
	@RequestMapping(value = "/dgms/updateMngCodeInfo.do", method=RequestMethod.POST)
	public @ResponseBody String updateMngCodeInfo(@RequestBody List<Map<String, Object>> paramMapList) {
		logger.debug("---------------->/dgms/updateMngCodeInfo.do");
		logger.debug("paramMapList:"+paramMapList.size());

		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				mngCodeService.updateMngCodeInfo(paramMap);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	

	
	
	@RequestMapping(value = "/dgms/insertMngCodeInfo.do", method=RequestMethod.POST)
	public @ResponseBody String insertMngCodeInfo(@RequestBody List<Map<String, Object>> paramMapList) {
		logger.debug("---------------->/dgms/insertMngCodeInfo.do");
		logger.debug("paramMapList:"+paramMapList.size());

		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				mngCodeService.insertMngCodeInfo(paramMap);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	

	@RequestMapping(value = "/dgms/deleteMngCodeInfo.do", method=RequestMethod.POST)
	public @ResponseBody String deleteMngCodeInfo(@RequestBody List<Map<String, Object>> paramMapList) {
		logger.debug("---------------->/dgms/deleteMngCodeInfo.do");
		logger.debug("paramMapList:"+paramMapList.size());

		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				mngCodeService.deleteMngCodeInfo(paramMap);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	

	
	

}