package egovframework.urtown.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.util.JSONPObject;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.dgms.service.CommonService;
import egovframework.urtown.service.CheckupResService;
import egovframework.urtown.service.MediConsultService;

@Controller
public class MediConsultReqController {
Logger logger = LoggerFactory.getLogger(MediConsultReqController.class.getName());

	@Resource(name = "mediConsultService")
	private MediConsultService mediConsultService;
	
	@Resource(name = "checkupResService")
	private CheckupResService checkupResService;
	
	@Resource(name = "commonService")
	private CommonService commonService;
	
	/**
	 * 의료상담 접수 조회
	 * @param c
	 * @param params
	 * @return
	 */
	@RequestMapping(value = "/urtown/mediconsult/req/list.do")
	public @ResponseBody JSONPObject mediConsultReqList(@RequestParam("callback") String c, @RequestParam("params") String params) throws Exception {
		logger.debug("---------------->/urtown/mediconsult/req/list.do");
		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		logger.debug("params: " + params); 
		paramMap = (HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params);
		// set parameter login user area_id
		//CmmLoginUser userDetails = (CmmLoginUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		//paramMap.put("AREA_GB", userDetails.getAreaId());

		List<HashMap<String, Object>> rtnList = null;
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		System.out.println(paramMap); 

		try {
			rtnList = mediConsultService.selectMediConsultByMap(paramMap);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", rtnList.size());
		} catch (Exception e) {
			// TODO Auto-generated catch block
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
	@RequestMapping(value = "/urtown/mediconsult/req/create.do")
	public @ResponseBody JSONPObject createMediConsultReq(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/urtown/mediconsult/req/create.do");
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
				mParam.put("REQUEST_NO", strToday);
				logger.debug("param REQUEST_NO: " + strToday);
				Long nextReqNo = mediConsultService.getNextRequestNo(mParam);
				if(nextReqNo == null) {
					nextReqNo = Long.valueOf(strToday + "0001");
				}
				logger.debug("next REQUEST_NO: " + nextReqNo);
				paramMap.put("REQUEST_NO", nextReqNo);
				// TB_MEDI_CONSULT:REQUEST_NO = TB_CHECKUP_RES:CHECKUP_NO
				mParam.put("SEQ_NM", "SQ_TB_MEDI_CONSULT");
				paramMap.put("MEDI_CONSULT_SQ", Long.valueOf(commonService.getSequence(mParam)));
				
				paramMap.put("CHECKUP_NO", nextReqNo);
				paramMap.put("CHECKUP_DT", paramMap.get("CONSULT_REQ_DT"));
				paramMap.put("CHECKUP_DT2", paramMap.get("CHECKUP_REQ_DT"));
				mParam.put("SEQ_NM", "SQ_TB_CHECKUP_RES");
				paramMap.put("CHECKUP_SQ", Long.valueOf(commonService.getSequence(mParam)));
				
				mParam.put("SEQ_NM", "SQ_TB_MEDI_CONSULT_NOTE");
				paramMap.put("NOTE_SQ", Long.valueOf(commonService.getSequence(mParam)));
				
				System.out.println("after paramMap: " + paramMap);
				
				// consult insert call
				logger.debug("call create mediconsult req");
				mediConsultService.createMediConsultReq(paramMap);
				
				// checkup insert call
				logger.debug("call create checkup res");
				checkupResService.createCheckupRes(paramMap);

				// note insert call
				logger.debug("call create mediconsult note");
				mediConsultService.createConsultNote(paramMap);
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
	@RequestMapping(value = "/urtown/mediconsult/req/update.do")
	public @ResponseBody JSONPObject updateMediConsultReq(@RequestParam("callback") String c, @RequestParam("models") String models) {  
		logger.debug("---------------->/urtown/mediconsult/req/update.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		logger.debug("models:" + models); 
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList: " + paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				mediConsultService.updateMediConsultReq(paramMap);
				checkupResService.updateCheckupResDt(paramMap);
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
	 * 의료상담 접수 상태 수정함
	 * @param c
	 * @param models
	 * @return
	 */
	@RequestMapping(value = "/urtown/updateMediConsultStatus.do")
	public @ResponseBody JSONPObject updateMediConsultStatus(@RequestParam("callback") String c, @RequestParam("models") String models) {  
		logger.debug("---------------->/urtown/updateMediConsultReq.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		logger.debug("models:" + models); 
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList: " + paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
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
	 * 의료상담 접수 정보를 삭제함
	 * @param c
	 * @param models
	 * @return
	 */
	@RequestMapping(value = "/urtown/mediconsult/req/delete.do")
	public @ResponseBody JSONPObject deleteMediConsultReq(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/urtown/mediconsult/req/delete.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		logger.debug("models: " + models); 
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		

		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				logger.debug("paramMap: " + paramMap);
				paramMap = mediConsultService.getDelSeq(paramMap);
				logger.debug("delete sequence paramMap: " + paramMap);
				
				// delete call for note
				mediConsultService.deleteConsultNote(paramMap);
				// delete call for checkup
				checkupResService.deleteCheckupRes(paramMap);
				// delete call
				mediConsultService.deleteMediConsultReq(paramMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
			HashMap<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, models);
	}
}