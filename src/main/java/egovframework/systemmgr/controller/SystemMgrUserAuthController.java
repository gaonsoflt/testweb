package egovframework.systemmgr.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.util.JSONPObject;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.login.service.CmmLoginUser;
import egovframework.common.service.CommonService;
import egovframework.dgms.service.MngCodeService;
import egovframework.systemmgr.service.SystemMgrUserAuthService;
import egovframework.systemmgr.service.SystemMgrUserService;

@RequestMapping("/sm/userauth")
@Controller
public class SystemMgrUserAuthController {
	Logger logger = LoggerFactory.getLogger(SystemMgrUserAuthController.class.getName());
	
	@Resource(name = "systemMgrUserAuthService")
	private SystemMgrUserAuthService userAuthService;
	
	@Resource(name = "systemMgrUserService")
	private SystemMgrUserService systemMngUserService;
	
	@Resource(name = "mngCodeService")
	private MngCodeService mngCodeService;
	
	@Resource(name = "commonService")
	private CommonService commonService;

	@RequestMapping({ "/readauth.do" })
	public @ResponseBody JSONPObject selectAuthList(@RequestParam("callback") String c, @RequestParam("params") String params) throws Exception {
		this.logger.debug("----------------> /readauth.do");
		this.logger.debug("params: " + params);
		
		return new JSONPObject(c, userAuthService.selectUserAuth((HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params)));
	}
	
	@RequestMapping({ "/updateInsert.do" })
	public @ResponseBody JSONPObject updateInsertUserAuth(@RequestParam("callback") String c, @RequestParam("params") String params, @RequestParam("models") String models) {
		this.logger.debug("---------------->/updateInsert.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();
		this.logger.debug("models:" + models);
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		this.logger.debug("params: " + params);
		paramMap = (HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params);
		
		// set parameter login user area_id
		CmmLoginUser userDetails = (CmmLoginUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		HashMap<String, Object> param;
		try {
			for (int i = 0; i < paramMapList.size(); i++) {
				param = (HashMap<String, Object>) paramMapList.get(i);
//				param.put("AUTH_SQ", nextSequence());
				String type = (String) paramMap.get("TYPE");
				param.put("TYPE", type);
				if(type.equals("USER_NO")) {
					param.put("USER_NO", paramMap.get("USER_NO"));
				} else {
					param.put("USER_TYPE", paramMap.get("USER_TYPE"));
				}
				this.logger.debug("paramMap:" + param);
				// 업데이트 시 완료 상태로 변경
				userAuthService.updateInsertUserAuth(param);
			}
		} catch (Exception e) {
			e.printStackTrace();
			HashMap<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, models);
	}

	@RequestMapping(value = "/getUserAuth.do")
	public ModelAndView getMenuInfo(@RequestParam Map<String,Object> paramMap) throws Exception {
		ModelAndView model = new ModelAndView();
		logger.debug("===============================pamam: " + paramMap);
		HashMap<String, Object> result = userAuthService.getUserAuth((HashMap<String, Object>) paramMap).get(0);
		logger.debug("result: " + result);
		model.addObject("result", result);
		model.setViewName("jsonView");
		return model;
	}
	
	private Long nextSequence() throws NumberFormatException, Exception {
		HashMap<String, Object> mParam = new HashMap<>();
		mParam.put("SEQ_NM", "SQ_TB_USER_AUTH");
		return Long.valueOf(commonService.getSequence(mParam));
	}

}