package egovframework.dgms.web;

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
import egovframework.dgms.service.MngIntegService;
import egovframework.dgms.service.MoniteringService;

@Controller
public class MoniteringController {
	Logger logger = LoggerFactory.getLogger(MoniteringController.class.getName());
	
	@Resource(name = "moniteringService")
	private MoniteringService moniteringService;

	
	@RequestMapping(value = "/dgms/monitering.do")
	public String dgmsMonitering(Model model) throws Exception {
		return "dgms/monitering";
	}
	
	
	
	@RequestMapping(value = "/dgms/selectChartDataMornitering.do")
	public @ResponseBody HashMap<String, Object> selectChartDataMornitering(@RequestParam Map<String,Object> paramMap) throws Exception{
		List<HashMap<String, Object>> rtnList = (List<HashMap<String, Object>>)moniteringService.selectChartDataMornitering((HashMap<String, Object>)paramMap);
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("rtnList", rtnList);
		
		return result;
	}
	
	@RequestMapping(value = "/dgms/selectMorniteringData1.do")
	public @ResponseBody JSONPObject selectMorniteringData1(@RequestParam("callback") String c, @RequestParam("params") String params) throws Exception{
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		List<HashMap<String, Object>> rtnList = null;

		logger.debug("params:"+params); 
		paramMap = (HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params); 
		logger.debug("paramMap:"+paramMap); 

		try{
			rtnList = (List<HashMap<String, Object>>)moniteringService.selectMorniteringData1((HashMap<String, Object>)paramMap);
			rtnMap.put("rtnList", rtnList);
		}catch(Exception e){
			// TODO Auto-generated catch block
			e.printStackTrace();
			rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
		}
		
		return new JSONPObject(c, rtnMap);
	}

	
	@RequestMapping(value = "/dgms/selectMorniteringData2.do")
	public @ResponseBody JSONPObject selectMorniteringData2(@RequestParam("callback") String c, @RequestParam("params") String params) throws Exception{
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		List<HashMap<String, Object>> rtnList = null;

		logger.debug("params:"+params); 
		paramMap = (HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params); 
		logger.debug("paramMap:"+paramMap); 

		try{
			rtnList = (List<HashMap<String, Object>>)moniteringService.selectMorniteringData2((HashMap<String, Object>)paramMap);
			rtnMap.put("rtnList", rtnList);
		}catch(Exception e){
			// TODO Auto-generated catch block
			e.printStackTrace();
			rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
		}
		
		return new JSONPObject(c, rtnMap);
	}	
	
	
	@RequestMapping(value = "/dgms/selectMorniteringData3.do")
	public @ResponseBody JSONPObject selectMorniteringData3(@RequestParam("callback") String c, @RequestParam("params") String params) throws Exception{
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		List<HashMap<String, Object>> rtnList = null;

		logger.debug("params:"+params); 
		paramMap = (HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params); 
		logger.debug("paramMap:"+paramMap); 

		try{
			rtnList = (List<HashMap<String, Object>>)moniteringService.selectMorniteringData3((HashMap<String, Object>)paramMap);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", moniteringService.selectMorniteringData3Tot((HashMap<String, Object>)paramMap));
		}catch(Exception e){ 
			// TODO Auto-generated catch block
			e.printStackTrace();
			rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
		}
		
		return new JSONPObject(c, rtnMap);
	} 
	
	@RequestMapping(value = "/dgms/selectMorniteringDataCNT1.do")
	public @ResponseBody HashMap<String, Object> selectMorniteringDataCNT1(@RequestParam Map<String,Object> paramMap) throws Exception{
		List<HashMap<String, Object>> rtnList = (List<HashMap<String, Object>>)moniteringService.selectMorniteringDataCNT1((HashMap<String, Object>)paramMap);
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("rtnList", rtnList);
		result.put("total", moniteringService.selectMorniteringData3Tot((HashMap<String, Object>)paramMap));
		
		return result;
	}
	
	
	
	
	
	/*
	@RequestMapping(value = "/dgms/selectMoniteringUnusualInfo.do")
	public @ResponseBody JSONPObject selectMoniteringUnusualInfo(@RequestParam("callback") String c, @RequestParam("params") String params) throws Exception{
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		List<HashMap<String, Object>> rtnList = null;

		logger.debug("params:"+params); 
		paramMap = (HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params); 
		logger.debug("paramMap:"+paramMap); 
		
		try{
			rtnList = (List<HashMap<String, Object>>)moniteringService.selectMoniteringUnusualInfo((HashMap<String, Object>)paramMap);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", moniteringService.selectMoniteringUnusualInfo((HashMap<String, Object>)paramMap));
		}catch(Exception e){
			// TODO Auto-generated catch block
			e.printStackTrace();
			rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
		}
		
		return new JSONPObject(c, rtnMap);
	}
	
	@RequestMapping(value = "/dgms/selectChartDataMornitering.do")
	public @ResponseBody HashMap<String, Object> selectChartDataMornitering(@RequestParam Map<String,Object> paramMap) throws Exception{
		List<HashMap<String, Object>> rtnList = (List<HashMap<String, Object>>)moniteringService.selectChartDataMornitering((HashMap<String, Object>)paramMap);
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("rtnList", rtnList);
		
		return result;
	}
	*/
	
}