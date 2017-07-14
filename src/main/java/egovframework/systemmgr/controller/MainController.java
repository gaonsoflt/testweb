package egovframework.systemmgr.controller;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import egovframework.espa.service.ConfigService;
import egovframework.espa.service.QuestionDeployService;
import egovframework.espa.service.QuestionMgrService;
import egovframework.systemmgr.service.SystemMgrBBSService;
import egovframework.systemmgr.service.SystemMgrMenuService;

@Controller
public class MainController {
Logger logger = LoggerFactory.getLogger(MainController.class.getName());
	@Autowired
	ConfigService config;
	
	@Resource(name = "systemMgrMenuService")
	private SystemMgrMenuService menuService;
	

	@RequestMapping(value = "/main.do")
	public String login(Model model) throws Exception {
		logger.debug("....................................................../main.do");
		return "redirect:/dashboard.do";
	}

	@RequestMapping(value = "/dashboard.do")
	public ModelAndView showDashboardView(Model model) throws Exception {
		ModelAndView mav = new ModelAndView("systemmgr/dashboard");
		mav.addObject("menu", menuService.getMenuVo("notice"));
		model.addAttribute("menuId", "");
		return mav;
	}

	/*
	 * BBS
	 */
	@RequestMapping(value = "/bbs/notice.do")
	public ModelAndView bbsNoticeView(Model model) throws Exception {
		ModelAndView mav = new ModelAndView("bbs/notice");
		mav.addObject("menu", menuService.getMenuVo("notice"));
		return mav;
	}
	
	@Resource(name = "systemMgrBBSService")
	private SystemMgrBBSService bbsService;
	
	@RequestMapping(value = "/bbs/board.do")
	public ModelAndView bbsCommonView(Model model, @RequestParam(value="bbs", required=true) int bbsID)  throws Exception {
		logger.debug("param: bbs=" + bbsID);
		ModelAndView mav = new ModelAndView("bbs/bbs");
		Map<String, Object> bbsInfo = bbsService.getBBSDetail(bbsID);
		mav.addObject("bbsInfo", bbsInfo);
		mav.addObject("menu", menuService.getMenuVo(bbsInfo.get("bbs_id").toString()));
		return mav;
	}
	
	/*
	 * ESPA Student
	 */
	@RequestMapping(value = "/class/classplan.do")
	public ModelAndView classPlanView(Model model) throws Exception {
		ModelAndView mav = new ModelAndView("espa/class/classPlan");
		mav.addObject("menu", menuService.getMenuVo("classPlan"));
		return mav;
	}
	@RequestMapping(value = "/class/classref.do")
	public ModelAndView classRefView(Model model) throws Exception {
		ModelAndView mav = new ModelAndView("espa/class/classRef");
		mav.addObject("menu", menuService.getMenuVo("classRef"));
		return mav;
	}
	@RequestMapping(value = "/class/question/deploy/result.do")
	public ModelAndView questionResultView(Model model) throws Exception {
		ModelAndView mav = new ModelAndView("espa/class/questionResult");
		mav.addObject("menu", menuService.getMenuVo("questionResult"));
		return mav;
	}
	@RequestMapping(value = "/class/question/deploy.do")
	public ModelAndView questionView(Model model) throws Exception {
		ModelAndView mav = new ModelAndView("espa/class/question");
		mav.addObject("menu", menuService.getMenuVo("question"));
		return mav;
	}
	
	/*
	 * ESPA Management
	 */
	@RequestMapping(value = "/mgr/question.do")
	public ModelAndView mgrQuestionView(Model model) throws Exception {
		ModelAndView mav = new ModelAndView("espa/mgr/questionMgr");
		mav.addObject("menu", menuService.getMenuVo("espaMgrQuestion"));
		return mav; 
	}
	
	@Resource(name = "questionMgrService")
	private QuestionMgrService questionService;
	
	@RequestMapping(value = "/mgr/question/form.do")
	public ModelAndView formView(Model model, @RequestParam(value="id", required=false)String seq)  throws Exception {
		logger.debug("param: question_seq=" + seq);
		ModelAndView mav = new ModelAndView("espa/mgr/questionMgrForm");
		try {
			long _seq = Long.valueOf(seq);
			mav.addObject("questionInfo", questionService.getQuestion(_seq).get(0));
		}catch (Exception e) {
			
		}
		mav.addObject("default_timeout", config.getEspaConfigVoValue("DEFAULT_TIMEOUT"));
		mav.addObject("default_ban_kw", config.getEspaConfigVoValue("DEFAULT_BAN_KW"));
		mav.addObject("default_max_codesize", config.getEspaConfigVoValue("DEFAULT_MAX_CODESIZE"));
		mav.addObject("menu", menuService.getMenuVo("espaMgrQuestion"));
		return mav;
	}
	
	@RequestMapping(value = "/mgr/question/deploy.do")
	public ModelAndView mgrDeployView(Model model) throws Exception {
		ModelAndView mav = new ModelAndView("espa/mgr/questionDeploy");
		mav.addObject("menu", menuService.getMenuVo("espaMgrQuestionDeploy"));
		return mav;
	}
	
	@RequestMapping(value = "/mgr/question/deploy/result.do")
	public ModelAndView mgrResultView(Model model) throws Exception {
		ModelAndView mav = new ModelAndView("espa/mgr/questionResultAll");
		mav.addObject("menu", menuService.getMenuVo("espaMgrQuestionResult"));
		return mav;
	}
	
	
	@Resource(name = "questionDeployService")
	private QuestionDeployService deployService;
	
	@RequestMapping(value = "/mgr/question/deploy/result/detail.do")
	public ModelAndView mgrResultDetailView(Model model, @RequestParam(value="deploy", required=false)String seq)  throws Exception {
		ModelAndView mav = new ModelAndView("espa/mgr/questionResult");
		mav.addObject("deploy_seq", seq);
		mav.addObject("depQuesInfo", deployService.getDeployedQuestionDetail(Long.valueOf(seq)));
		mav.addObject("menu", menuService.getMenuVo("espaMgrQuestionResult"));
		return mav;
	}
	
	@RequestMapping(value = "/mgr/config.do")
	public ModelAndView mgrConfigView(Model model) throws Exception {
		ModelAndView mav = new ModelAndView("espa/mgr/config");
		mav.addObject("menu", menuService.getMenuVo("espaMgrConfig"));
		return mav;
	}
	
	/*
	 * Systemmgr
	 */
	@RequestMapping(value = "/sm/code.do")
	public ModelAndView codeView(Model model) throws Exception {
		ModelAndView mav = new ModelAndView("systemmgr/commonCode");
		mav.addObject("menu", menuService.getMenuVo("systemMgrCode"));
		return mav;
	}
	
	@RequestMapping(value = "/sm/history/login.do")
	public ModelAndView loginHistoryView(Model model) throws Exception {
		ModelAndView mav = new ModelAndView("systemmgr/loginHis");
		mav.addObject("menu", menuService.getMenuVo("systemMgrHisLogin"));
		return mav;
	}

	@RequestMapping(value = "/sm/menu.do")
	public ModelAndView menuView(Model model) throws Exception {
		ModelAndView mav = new ModelAndView("systemmgr/menu");
		mav.addObject("menu", menuService.getMenuVo("systemMgrMenuInfo"));
		return mav;
	}
	
	@RequestMapping(value = "/sm/userauth.do")
	public ModelAndView userAuthView(Model model) throws Exception {
		ModelAndView mav = new ModelAndView("systemmgr/userAuth");
		mav.addObject("menu", menuService.getMenuVo("systemMgrUserAuth"));
		return mav;
	}
	
	@RequestMapping(value = "/sm/usergroup.do")
	public ModelAndView userGroupView(Model model) throws Exception {
		ModelAndView mav = new ModelAndView("systemmgr/userGroup");
		mav.addObject("menu", menuService.getMenuVo("systemMgrUserGroup"));
		return mav;
	}
	
	@RequestMapping(value = "/sm/user.do")
	public ModelAndView userView(Model model) throws Exception {
		ModelAndView mav = new ModelAndView("systemmgr/user");
		mav.addObject("menu", menuService.getMenuVo("systemMgrUser"));
		return mav;
	}
	
	@RequestMapping(value = "/sm/bbs.do")
	public ModelAndView bbsView(Model model) throws Exception {
		ModelAndView mav = new ModelAndView("systemmgr/bbs");
		mav.addObject("menu", menuService.getMenuVo("systemMgrBBS"));
		return mav;
	}
}
