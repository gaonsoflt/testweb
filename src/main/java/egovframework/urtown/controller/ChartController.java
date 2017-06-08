package egovframework.urtown.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.util.JSONPObject;
import com.google.gson.Gson;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.login.service.CmmLoginUser;
import egovframework.dgms.service.CommonService;
import egovframework.urtown.service.CheckupResService;

@Controller
public class ChartController {
Logger logger = LoggerFactory.getLogger(ChartController.class.getName());

	@Resource(name = "checkupResService")
	private CheckupResService checkupResService;

	@Resource(name = "commonService")
	private CommonService commonService;
	
	
	@RequestMapping(value = "/urtown/chart/user.do")
	public ModelAndView selectCheckupResByUserNo(@RequestParam HashMap<String,Object> paramMap) throws Exception {
		logger.debug("---------------->/urtown/chart/user.do");
		// set parameter login user area_id
		CmmLoginUser userDetails = (CmmLoginUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		paramMap.put("AREA_GB", userDetails.getAreaId());
		logger.debug("params: " + paramMap); 
		List<HashMap<String, Object>> rtnList = null;
		String result = "";
		// select call
		rtnList = checkupResService.selectCheckupResByUserNo(paramMap);
		result = new Gson().toJson(rtnList);
		System.out.println("===============================");
		System.out.println("size: " + rtnList.size());
		System.out.println("contents: " + result);
		System.out.println("===============================");
		
		ModelAndView model = new ModelAndView();
		model.addObject("rtnList", rtnList);
		model.setViewName("jsonView");
		return model;
	}
}