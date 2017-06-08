package egovframework.dgms.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

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
import egovframework.dgms.service.CommonService;


@Controller
public class CommonController {
	Logger logger = LoggerFactory.getLogger(CommonController.class.getName());
    
	@Resource(name = "commonService")
	private CommonService commonService;
	
	@RequestMapping(value = "/dgms/getSequence.do")
	public ModelAndView getSequence(@RequestParam Map<String,Object> paramMap) throws Exception {
		ModelAndView model = new ModelAndView();
		String Sequence = (String)commonService.getSequence((HashMap<String, Object>)paramMap);
		model.addObject("Sequence", Sequence);
		model.setViewName("jsonView");
		return model;
	}

	/**
	 * 코드ID로 조회
	 * @param c
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/dgms/getCodeListByCdID.do")
	public @ResponseBody JSONPObject getCodeListByCdID(@RequestParam("callback") String c,@RequestParam("params") String params) throws Exception {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap = (HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params);
		List<HashMap<String, Object>> rtnList = (List<HashMap<String, Object>>)commonService.getCodeListByCdID((HashMap<String, Object>)paramMap);
		return new JSONPObject(c,rtnList);
	}

	
	
	@RequestMapping(value = "/dgms/getCodeListByCdIDModel.do")
	public ModelAndView getCodeListByCdIDModel(@RequestParam Map<String,Object> paramMap) throws Exception { 
		//List<HashMap<String, Object>> rtnList = (List<HashMap<String, Object>>)commonService.getCodeListByCdID((HashMap<String, Object>)paramMap);
		String list = paramMap.get("list") != null ? paramMap.get("list").toString() : null;
		List rtnList = new ArrayList<HashMap<String, Object>>();
		ModelAndView model = new ModelAndView(); 
		
		
		
		if(list != null){
			String[] cdIdList = paramMap.get("list").toString().split(","); 
			
			for(int i=0; i<cdIdList.length; i++){ 
				HashMap<String, Object> paramMap2 = new HashMap<String, Object>(); 
				paramMap2.put("CD_ID", cdIdList[i]);
				
				List tempList = (List<HashMap<String, Object>>)commonService.getCodeListByCdID(paramMap2);
				Iterator it = tempList.iterator();
				
				while(it.hasNext()){
					HashMap map = (HashMap)it.next();
					rtnList.add(map);
				}
			}//for	
			
		}else{
			rtnList = (List<HashMap<String, Object>>)commonService.getCodeListByCdID((HashMap<String, Object>)paramMap);
		}
		
		model.addObject("rtnList", rtnList);
		model.setViewName("jsonView");
		return model;
	}
	
	/**
	 * kendoAutoComplete 에서 사용함
	 * 
	 * @param c
	 * @param params
	 * cf.
	 *   TABLE: "TB_USER_INFO"
	 *   COLUNM: "USER_NM"
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/dgms/getAutoComplete.do")
	public @ResponseBody JSONPObject getAutoComplete(@RequestParam("callback") String c,@RequestParam("params") String params) throws Exception {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap = (HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params);
		List<HashMap<String, Object>> rtnList = commonService.getAutoComplete(paramMap);
		return new JSONPObject(c,rtnList);
	}
	
	@RequestMapping(value = "/dgms/getAutoCompleteNew.do")
	public @ResponseBody JSONPObject getAutoCompleteNew(@RequestParam("callback") String c,@RequestParam("params") String params) throws Exception {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap = (HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params);
		List<HashMap<String, Object>> rtnList = commonService.getAutoCompleteNew(paramMap);
		return new JSONPObject(c,rtnList);
	}
	
	@RequestMapping(value = "/dgms/getUserAutoComplete.do")
	public @ResponseBody JSONPObject getUserAutoComplete(@RequestParam("callback") String c,@RequestParam("params") String params) throws Exception {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap = (HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params);
		List<HashMap<String, Object>> rtnList = commonService.getUserAutoComplete(paramMap);
		return new JSONPObject(c,rtnList);
	}
	
	@RequestMapping(value = "/dgms/getUserInfo.do")
	public ModelAndView getUserInfo(@RequestParam HashMap<String,Object> paramMap) throws Exception {
		ModelAndView model = new ModelAndView();
		List<HashMap<String, Object>> rtnList = commonService.getUserAutoComplete(paramMap);
		model.addObject("rtnList", rtnList);
		model.setViewName("jsonView");
		return model;
	}
	
	
	
	@RequestMapping(value = "/dgms/getDuplicateCount.do")
	public ModelAndView getDuplicateCount(@RequestParam Map<String,Object> paramMap) throws Exception {
		ModelAndView model = new ModelAndView();
		
		int cnt = commonService.getDuplicateCount((HashMap<String, Object>)paramMap);
		model.addObject("cnt", cnt);
		model.setViewName("jsonView");
		
		return model;
	}
	
	
}
