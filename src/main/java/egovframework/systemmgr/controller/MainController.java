package egovframework.systemmgr.controller;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.espa.service.ConfigService;
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
	public ModelAndView showDashboard(Model model) throws Exception {
		ModelAndView mav = new ModelAndView("systemmgr/dashboard");
		mav.addObject("menu", menuService.getMenuVo("notice"));
		model.addAttribute("menuId", "");
		return mav;
	}

	/*
	 * BBS
	 */
	@RequestMapping(value = "/bbs/notice.do")
	public ModelAndView bbsNotice(Model model) throws Exception {
		ModelAndView mav = new ModelAndView("bbs/notice");
		mav.addObject("menu", menuService.getMenuVo("notice"));
		return mav;
	}
	
	/*
	 * ESPA Student
	 */
	@RequestMapping(value = "/question.do")
	public ModelAndView question(Model model) throws Exception {
		ModelAndView mav = new ModelAndView("espa/student/question");
		mav.addObject("menu", menuService.getMenuVo("question"));
		return mav;
	}
	
	/*
	 * ESPA Management
	 */
	@RequestMapping(value = "/mgr/question.do")
	public ModelAndView mgrQuestion(Model model) throws Exception {
		ModelAndView mav = new ModelAndView("espa/mgr/questionMgr");
		mav.addObject("default_timeout", config.getEspaConfigVoValue("DEFAULT_TIMEOUT"));
		mav.addObject("default_ban_kw", config.getEspaConfigVoValue("DEFAULT_BAN_KW"));
		mav.addObject("default_max_codesize", config.getEspaConfigVoValue("DEFAULT_MAX_CODESIZE"));
		mav.addObject("menu", menuService.getMenuVo("espaMgrQuestion"));
		return mav; 
	}
	
	@RequestMapping(value = "/mgr/question/deploy.do")
	public ModelAndView mgrDeploy(Model model) throws Exception {
		ModelAndView mav = new ModelAndView("espa/mgr/questionDeploy");
		mav.addObject("menu", menuService.getMenuVo("espaMgrQuestionDeploy"));
		return mav;
	}
	
	@RequestMapping(value = "/mgr/score.do")
	public ModelAndView mgrScore(Model model) throws Exception {
		ModelAndView mav = new ModelAndView("espa/mgr/config");
		mav.addObject("menu", menuService.getMenuVo("espaMgrScore"));
		return mav;
	}
	
	@RequestMapping(value = "/mgr/config.do")
	public ModelAndView mgrConfig(Model model) throws Exception {
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
}
