package egovframework.dgms.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.util.JSONPObject;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.dgms.service.InfoGpsService;
import egovframework.dgms.service.MyPrescriptService;

@Controller
public class InfoGpsController {
	Logger logger = LoggerFactory.getLogger(InfoGpsController.class.getName());

	@Resource(name = "infoGpsService")
	private InfoGpsService infoGpsService;

	@RequestMapping(value = "/dgms/infoGps.do")
	public String dgmsInfoGps(Model model) throws Exception {
		return "dgms/infoGps";
	}
	
	@RequestMapping(value = "/dgms/selectLastGPSInfo.do")
	public @ResponseBody JSONPObject selectLastGPSInfo(HttpServletResponse resp, @RequestParam(value="callback") String c, @RequestParam(value="user_id") String user_id)throws Exception{
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("user_id", user_id);
		List<HashMap<String, Object>> rtnList = null;
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		
		try{
			rtnList = infoGpsService.selectLastGPSInfo((HashMap<String, Object>)map);
			rtnMap.put("rtnList", rtnList);
		}catch(Exception e){
			e.printStackTrace();
		}
		JSONPObject rt = new JSONPObject(c, rtnMap);
		return rt;
	}
}