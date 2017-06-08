package egovframework.urtown.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.codec.binary.Base64;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.util.JSONPObject;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.Globals;
import egovframework.com.login.service.CmmLoginUser;
import egovframework.dgms.service.CommonService;
import egovframework.urtown.service.CheckupResService;
import egovframework.urtown.service.MediConsultService;

@Controller
public class CheckupResController {
Logger logger = LoggerFactory.getLogger(CheckupResController.class.getName());

	@Resource(name = "checkupResService")
	private CheckupResService checkupResService;
	
	@Resource(name = "mediConsultService")
	private MediConsultService mediConsultService;

	@Resource(name = "commonService")
	private CommonService commonService;
	
	@RequestMapping(value = "/urtown/checkupRes.do")
	public ModelAndView checkupRes(Model model) throws Exception {
		return new ModelAndView("urtown/checkupRes");
	}
	
	/**
	 * 건강측정정보 조회
	 * @param c
	 * @param params
	 * @return
	 */
	@RequestMapping(value = "/urtown/checkupres/list.do")
	public @ResponseBody JSONPObject checkupResList(@RequestParam("callback") String c, @RequestParam("params") String params) throws Exception {
		logger.debug("---------------->/urtown/checkupres/list.do");
		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		logger.debug("params: " + params); 
		paramMap = (HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params);
		// set parameter login user area_id
		//CmmLoginUser userDetails = (CmmLoginUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		//paramMap.put("AREA_GB", userDetails.getAreaId());
		List<HashMap<String, Object>> rtnList = null;
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();

		try {
			// select call
			rtnList = checkupResService.selectCheckupResByMap(paramMap);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", rtnList.size());
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
//		System.out.println("result size: " + rtnList.size());
//		System.out.println("result: " + rtnList);
		return new JSONPObject(c, rtnMap);
	}
	
	
	/**
	 * 건강측정정보 입력
	 * @param c
	 * @param models
	 * @return
	 */
	@RequestMapping(value = "/urtown/checkupres/create.do")
	public @ResponseBody JSONPObject createCheckupRes(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/urtown/checkupres/create.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		logger.debug("models: " + models); 
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList: " + paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				System.out.println("before paramMap: " + paramMap);

				// set params for insert sql
				// 1. getNextRequestNo
				HashMap<String, Object> mParam = new HashMap<>();
				Date dt = new Date(System.currentTimeMillis());
				// date of request
				String strToday = new SimpleDateFormat("yyyyMMdd").format(dt);
				mParam.put("CHECKUP_NO", strToday);
				logger.debug("param CHECKUP_NO: " + strToday);
				Long nextChkNo = checkupResService.getNextCheckupNo(mParam);
				if(nextChkNo == null) {
					nextChkNo = Long.valueOf(strToday + "0001");
				}
				logger.debug("next CHECKUP_NO: " + nextChkNo);
				paramMap.put("CHECKUP_NO", nextChkNo);
				
				// 2. getNextSequence
				mParam.put("SEQ_NM", "SQ_TB_CHECKUP_RES");
				String nextSeq = commonService.getSequence(mParam);
				paramMap.put("CHECKUP_SQ", Long.valueOf(nextSeq));
				
				System.out.println("after paramMap: " + paramMap);

				// insert call
				checkupResService.createCheckupRes(paramMap);
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
	 * 건강측정정보 수정 
	 * @param c
	 * @param models
	 * @return
	 */
	@RequestMapping(value = "/urtown/checkupres/update.do")
	public @ResponseBody JSONPObject updateMngUserInfoJsonp(@RequestParam("callback") String c, @RequestParam("models") String models) {  
		logger.debug("---------------->/urtown/checkupres/update.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		logger.debug("models:" + models); 
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList: " + paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				// update call
				checkupResService.updateCheckupRes(paramMap);
				// updata mediconsult_status
				paramMap.put("STATUS_CD", "500050");
				mediConsultService.updateMediConsultStatus(paramMap);
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
	 * 건강측정정보 삭제
	 * @param c
	 * @param models
	 * @return
	 */
	@RequestMapping(value = "/urtown/checkupres/delete.do")
	public @ResponseBody JSONPObject deleteMngUserInfoJsonp(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/urtown/checkupres/delete.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		logger.debug("models: " + models); 
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList: " + paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				// delete call
				checkupResService.deleteCheckupRes(paramMap);
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
	 * 유저번호를 이용해 해당 건강측정정보 조회
	 * @param c
	 * @param params
	 * @return
	 */
	@RequestMapping(value = "/urtown/getCheckupResByUserNo.do")
	public @ResponseBody JSONPObject getCheckupResByUserNo(@RequestParam("callback") String c, @RequestParam("params") String params) throws Exception {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap = (HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params);
		List<HashMap<String, Object>> rtnList = checkupResService.getCheckupResByUserNo(paramMap);
		return new JSONPObject(c,rtnList);
	}
	
	@RequestMapping(value = "/urtown/saveCanvasImg.do")
	public @ResponseBody JSONPObject saveCanvasImg(@RequestParam Map<String,Object> paramMap) throws Exception {
		ModelAndView model = new ModelAndView();
		HashMap<String, Object> map = (HashMap<String, Object>)paramMap;
		String filePath = (String)map.get("filePath");
		String data = (String)map.get("imgUpload");
		
		if( filePath.lastIndexOf("/") > -1 ){
			filePath = Globals.Filepath_ECGDir + filePath.substring(filePath.lastIndexOf("/")+1);	
		} 
		
		data = data.replace("data:image/png;base64,", "");
		byte[] imgBytes = Base64.decodeBase64(data.getBytes());
		
		FileOutputStream osf = new FileOutputStream(new File(filePath));
		osf.write(imgBytes);
		osf.close();
		osf.flush();
		 
		return null;
	}	
}