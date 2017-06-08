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
import egovframework.dgms.service.CommonService;
import egovframework.urtown.service.MediFAQService;

@Controller
public class MediFAQController {
	Logger logger = LoggerFactory.getLogger(MediFAQController.class.getName());

	@Resource(name = "mediFAQService")
	private MediFAQService mediFAQService;

	@Resource(name = "commonService")
	private CommonService commonService;

	@RequestMapping({ "/urtown/mediconsult/faq/list.do" })
	public @ResponseBody JSONPObject selectMediFAQ(@RequestParam("callback") String c, @RequestParam("params") String params)
			throws Exception {
		this.logger.debug("---------------->/urtown/mediconsult/faqs.do");
		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		this.logger.debug("params: " + params);
		paramMap = (HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params);

		List<HashMap<String, Object>> rtnList = null;
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		System.out.println(paramMap);
		try {
			rtnList = this.mediFAQService.selectMediFAQ(paramMap);
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

	@RequestMapping({ "/urtown/mediconsult/faq/create.do" })
	public @ResponseBody JSONPObject createMediFAQ(@RequestParam("callback") String c, @RequestParam("models") String models) {
		this.logger.debug("---------------->/urtown/mediconsult/faq/create.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		this.logger.debug("models: " + models);
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		this.logger.debug("paramMapList: " + paramMapList);
		try {
			for (int i = 0; i < paramMapList.size(); i++) {
				HashMap<String, Object> paramMap = (HashMap<String, Object>) paramMapList.get(i);
				System.out.println("before paramMap: " + paramMap);

				HashMap<String, Object> mParam = new HashMap<String, Object>();

				mParam.put("SEQ_NM", "SQ_TB_MEDI_FAQ");
				String nextSeq = this.commonService.getSequence(mParam);
				paramMap.put("FAQ_SQ", Long.valueOf(nextSeq));
				System.out.println("after paramMap: " + paramMap);

				this.mediFAQService.createMediFAQ(paramMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
			HashMap<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, models);
	}

	@RequestMapping({ "/urtown/mediconsult/faq/update.do" })
	public @ResponseBody JSONPObject updateConsultNote(@RequestParam("callback") String c, @RequestParam("models") String models) {
		this.logger.debug("---------------->/urtown/mediconsult/faq/update.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		this.logger.debug("models:" + models);
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		this.logger.debug("paramMapList: " + paramMapList);
		try {
			for (int i = 0; i < paramMapList.size(); i++) {
				HashMap<String, Object> paramMap = (HashMap<String, Object>) paramMapList.get(i);
				this.mediFAQService.updateMediFAQ(paramMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
			HashMap<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, models);
	}

	@RequestMapping({ "/urtown/mediconsult/faq/delete.do" })
	public @ResponseBody JSONPObject deleteConsultNote(@RequestParam("callback") String c, @RequestParam("models") String models) {
		this.logger.debug("---------------->/urtown/mediconsult/faq/delete.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		this.logger.debug("models: " + models);
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		this.logger.debug("paramMapList: " + paramMapList);
		try {
			for (int i = 0; i < paramMapList.size(); i++) {
				HashMap<String, Object> paramMap = (HashMap<String, Object>) paramMapList.get(i);

				this.mediFAQService.deleteMediFAQ(paramMap);
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