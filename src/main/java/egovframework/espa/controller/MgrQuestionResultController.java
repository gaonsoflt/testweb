package egovframework.espa.controller;

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
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.util.JSONPObject;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.espa.service.QuestionDeployService;
import egovframework.espa.service.QuestionGradingHistoryService;
import egovframework.systemmgr.service.SystemMgrMenuService;

@RequestMapping("/mgr/question/deploy/result")
@Controller
public class MgrQuestionResultController {
	Logger logger = LoggerFactory.getLogger(MgrQuestionResultController.class.getName());

	@Resource(name = "questionGradingHistoryService")
	private QuestionGradingHistoryService gradingHisService;
	
	@RequestMapping(value = "/list.do")
	public @ResponseBody JSONPObject list(@RequestParam("callback") String c, @RequestParam("params") String params) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		logger.debug("params:" + params);
		paramMap = EgovWebUtil.parseJsonToMap(params);
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			List<Map<String, Object>> rtnList = gradingHisService.getDeployedQuestinResultList(paramMap);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", rtnList.size());
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return new JSONPObject(c, rtnMap);
	}

	/**
	 * ESPA manager result detail user list
	 * @param c
	 * @param params
	 * @return
	 */
	@RequestMapping(value = "/detail/users.do")
	public @ResponseBody JSONPObject detailList(@RequestParam("callback") String c, @RequestParam("params") String params) {
		logger.debug("params:" + params);
		 Map<String, Object> param = EgovWebUtil.parseJsonToMap(params);
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			List<Map<String, Object>> rtnList = gradingHisService.getGradingResultOfUserList(param);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", rtnList.size());
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return new JSONPObject(c, rtnMap);
	}
	
	@Resource(name = "questionDeployService")
	private QuestionDeployService deployService;
	
	@Resource(name = "systemMgrMenuService")
	private SystemMgrMenuService menuService;
	
	@RequestMapping(value = "detail.do")
	public ModelAndView mgrResultDetailView(Model model, @RequestParam(value="deploy", required=false)String seq)  throws Exception {
		ModelAndView mav = new ModelAndView("espa/mgr/questionResult");
		mav.addObject("deploy_seq", seq);
		mav.addObject("depQuesInfo", gradingHisService.getDeployedQuestinResult(Long.valueOf(seq)));
		mav.addObject("menu", menuService.getMenuVo("espaMgrQuestionResult"));
		return mav;
	}

}