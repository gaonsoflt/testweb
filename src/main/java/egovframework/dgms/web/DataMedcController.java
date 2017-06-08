package egovframework.dgms.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.SimpleTimeZone;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.util.JSONPObject;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.dgms.service.DataMedcService;

@Controller
public class DataMedcController {
	
	Logger logger = LoggerFactory.getLogger(DataMedcController.class.getName());
	    
	@Resource(name = "dataMedcService")
	private DataMedcService dataMedcService;

	@RequestMapping(value = "/dgms/dataMedc.do")
	public String dgmsDataMedc(Model model, ModelMap modelmap,@RequestParam Map<String,Object> paramMap) throws Exception {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String today= formatter.format(new java.util.Date());
	    
        Calendar cal = 
        		Calendar.getInstance(new SimpleTimeZone(0x1ee6280, "KST"));
        cal.add(Calendar.MONTH ,-1); // 3달전 날짜 가져오기

        java.util.Date monthago = cal.getTime();

        String threemonthago=formatter.format(monthago);
        modelmap.put("todate", today);
        modelmap.put("fromdate", threemonthago);
	    
        if (paramMap.get("mdate")!=null && paramMap.get("mdate")!="")
		{
			modelmap.put("todate", paramMap.get("mdate"));
			modelmap.put("fromdate", paramMap.get("mdate"));
		}
        
		return "dgms/dataMedc";
	}
	



	@RequestMapping(value = "/dgms/selectDataMedcDetailInfoJsonp.do")
	public @ResponseBody JSONPObject  selectDataMedcDetailInfoJsonp(@RequestParam("callback") String c, @RequestParam("params") String params) {

		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		logger.debug("params:"+params); 
		paramMap = (HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params);
		List<HashMap<String, Object>> rtnList = null;
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		
		try {
			rtnList = (List<HashMap<String, Object>>)dataMedcService.selectDataMedcInfo((HashMap<String, Object>)paramMap);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", dataMedcService.selectDataMedcInfoTot((HashMap<String, Object>)paramMap));
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c,rtnMap);
	}
	
	/********************************************************
	 * 해당년월에 측정한 혈압 데이터 조회(차트용)
	 * @param paramMap post / json type
	 *              {"id":"1234", "pw":"0000"}
	 * @return json
	 * @throws Exception
	 ********************************************************/
	@RequestMapping(value = "/dgms/selectChartDataMedcDetailInfo.do")
	public @ResponseBody HashMap<String, Object> selectChartDataMedcDetailInfo(@RequestParam Map<String,Object> paramMap) throws Exception {
		List<HashMap<String, Object>> rtnList = (List<HashMap<String, Object>>)dataMedcService.selectChartDataMedcDetailInfo((HashMap<String, Object>)paramMap);
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("rtnList", rtnList);
		
		return result;
	}

	/*@RequestMapping(value = "/dgms/insertDataMedcInfoJsonp.do")
	public @ResponseBody JSONPObject insertDataMedcInfoJsonp(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/dgms/insertDataMedcInfoJsonp.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		logger.debug("models:"+models); 
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:"+paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				dataMedcService.insertDataMedcInfo(paramMap);
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
	

	@RequestMapping(value = "/dgms/updateDataMedcInfoJsonp.do")
	public @ResponseBody JSONPObject updateDataMedcInfoJsonp(@RequestParam("callback") String c, @RequestParam("models") String models) {  
		logger.debug("---------------->/dgms/updateDataMedcInfoJsonp.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		logger.debug("models:"+models); 
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:"+paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				dataMedcService.updateDataMedcInfo(paramMap);
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
	
	

	@RequestMapping(value = "/dgms/deleteDataMedcInfoJsonp.do")
	public @ResponseBody JSONPObject deleteDataMedcInfoJsonp(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/dgms/deleteDataMedcInfoJsonp.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		logger.debug("models:"+models); 
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:"+paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				dataMedcService.deleteDataMedcInfo(paramMap);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			HashMap<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, models);
	}*/
	
	
}