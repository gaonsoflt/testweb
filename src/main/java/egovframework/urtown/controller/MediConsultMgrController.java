package egovframework.urtown.controller;

import java.util.ArrayList;
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
import egovframework.common.service.CommonService;
import egovframework.urtown.service.MediConsultService;

@Controller
public class MediConsultMgrController {
	Logger logger = LoggerFactory.getLogger(MediConsultMgrController.class.getName());

	@Resource(name = "mediConsultService")
	private MediConsultService mediConsultService;

	@Resource(name = "commonService")
	private CommonService commonService;

	@RequestMapping({ "/urtown/mediconsult/mgr/waitingList.do" })
	public @ResponseBody JSONPObject mgrWaitingList(@RequestParam("callback") String c, @RequestParam("params") String params)
			throws Exception {
		this.logger.debug("---------------->/urtown/mediconsult/mgr/waitingList.do");
		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		this.logger.debug("params: " + params);
		paramMap = (HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params);

		List<HashMap<String, Object>> rtnList = null;
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		System.out.println(paramMap);
		try {
			rtnList = mediConsultService.selectMediConsultWaitingList(paramMap);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", Integer.valueOf(rtnList.size()));
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, rtnMap);
	}

	@RequestMapping({ "/urtown/mediconsult/mgr/consultnotes.do" })
	public @ResponseBody JSONPObject selectConsultNote(@RequestParam("callback") String c, @RequestParam("params") String params)
			throws Exception {
		this.logger.debug("---------------->/urtown/mediconsult/mgr/consultnotes.do");
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		this.logger.debug("params: " + params);
		paramMap = (HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params);

		List<HashMap<String, Object>> rtnList = null;
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			rtnList = mediConsultService.selectConsultNote(paramMap);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", Integer.valueOf(rtnList.size()));
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, rtnMap);
	}
	
	@RequestMapping({ "/urtown/mediconsult/mgr/detailInfo.do" })
	public @ResponseBody JSONPObject selectMediConsultDetailInfo(@RequestParam("callback") String c, @RequestParam("params") String params)
			throws Exception {
		this.logger.debug("---------------->/urtown/mediconsult/mgr/selectMediConsultDetailInfo.do");
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		this.logger.debug("params: " + params);
		paramMap = (HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params);
		
		List<HashMap<String, Object>> rtnList = new ArrayList<>();
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			rtnList.add(mediConsultService.selectMediConsultDetailInfo(paramMap));
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", Integer.valueOf(rtnList.size()));
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, rtnMap);
	}

	@RequestMapping({ "/urtown/mediconsult/mgr/consultnote/create.do" })
	public @ResponseBody JSONPObject createConsultNote(@RequestParam("callback") String c, @RequestParam("models") String models) {
		this.logger.debug("---------------->/urtown/mediconsult/mgr/consultnote/create.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		this.logger.debug("models: " + models);
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		this.logger.debug("paramMapList: " + paramMapList);
		try {
			for (int i = 0; i < paramMapList.size(); i++) {
				HashMap<String, Object> paramMap = (HashMap<String, Object>) paramMapList.get(i);
				System.out.println("before paramMap: " + paramMap);

				HashMap<String, Object> mParam = new HashMap<String, Object>();

				mParam.put("SEQ_NM", "SQ_TB_MEDI_CONSULT_NOTE");
				String nextSeq = this.commonService.getSequence(mParam);
				paramMap.put("NOTE_SQ", Long.valueOf(nextSeq));
				System.out.println("after paramMap: " + paramMap);

				mediConsultService.createConsultNote(paramMap);
				paramMap.put("STATUS_CD", 500090); // hardcoding: TB_CODE_MASTER CD_ID(500090) = complete
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

	@RequestMapping({ "/urtown/mediconsult/mgr/consultnote/update.do" })
	public @ResponseBody JSONPObject updateConsultNote(@RequestParam("callback") String c, @RequestParam("models") String models) {
		this.logger.debug("---------------->/urtown/mediconsult/mgr/consultnote/update.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		this.logger.debug("models:" + models);
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		this.logger.debug("paramMapList: " + paramMapList);
		
		HashMap<String, Object> paramMap;
		try {
			for (int i = 0; i < paramMapList.size(); i++) {
				paramMap = (HashMap<String, Object>) paramMapList.get(i);
				paramMap.put("STATUS_CD", 500090); // hardcoding: TB_CODE_MASTER CD_ID(500090) = complete
				// 상담노트 업데이트 
				mediConsultService.updateConsultNote(paramMap);
				// 업데이트 시 완료 상태로 변경
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

	@RequestMapping({ "/urtown/mediconsult/mgr/consultnote/delete.do" })
	public @ResponseBody JSONPObject deleteConsultNote(@RequestParam("callback") String c, @RequestParam("models") String models) {
		this.logger.debug("---------------->/urtown/mediconsult/mgr/consultnote/delete.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		this.logger.debug("models: " + models);
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		this.logger.debug("paramMapList: " + paramMapList);
		try {
			for (int i = 0; i < paramMapList.size(); i++) {
				HashMap<String, Object> paramMap = (HashMap<String, Object>) paramMapList.get(i);

				mediConsultService.deleteConsultNote(paramMap);
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