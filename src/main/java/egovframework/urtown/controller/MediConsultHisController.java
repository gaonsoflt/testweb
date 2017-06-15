package egovframework.urtown.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.hsqldb.lib.Iterator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.util.JSONPObject;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.systemmgr.service.SystemMgrUserService;
import egovframework.urtown.service.MediConsultService;

@Controller
public class MediConsultHisController {
	Logger logger = LoggerFactory.getLogger(MediConsultHisController.class.getName());

	@Resource(name = "mediConsultService")
	private MediConsultService mediConsultService;
	
	@Resource(name = "systemMgrUserService")
	private SystemMgrUserService systemMngUserService;

	
	@RequestMapping({ "/urtown/mediconsult/his/patientList.do" })
	public @ResponseBody JSONPObject hisPatientList(@RequestParam("callback") String c, @RequestParam("params") String params)
			throws Exception {
		this.logger.debug("---------------->/urtown/mediconsult/his/patientList.do");
		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		this.logger.debug("params: " + params);
		paramMap = (HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params);
		paramMap.put("STATUS_CD", 500090);
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			List<HashMap<String, Object>> rtnList = mediConsultService.selectMediConsultHisPatientList(paramMap);
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

	@RequestMapping({ "/urtown/mediconsult/his/consultList.do" })
	public @ResponseBody JSONPObject hisConsultList(@RequestParam("callback") String c, @RequestParam("params") String params)
			throws Exception {
		this.logger.debug("---------------->/urtown/mediconsult/his/consultList.do");
		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		this.logger.debug("params: " + params);
		paramMap = (HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params);
		paramMap.put("STATUS_CD", 500090);
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			List<HashMap<String, Object>> rtnList = mediConsultService.selectMediConsultListByUser(paramMap);
			
			java.util.Iterator<HashMap<String, Object>> it = rtnList.iterator();
			
			while(it.hasNext()){
				HashMap map = (HashMap) it.next();
				if(!map.containsKey("CONSULT_NOTE")){
					map.put("CONSULT_NOTE", "");
				}
			}
			
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
}