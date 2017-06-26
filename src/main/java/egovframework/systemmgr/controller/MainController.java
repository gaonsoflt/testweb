package egovframework.systemmgr.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.espa.service.ConfigService;

@Controller
public class MainController {
Logger logger = LoggerFactory.getLogger(MainController.class.getName());
	@Autowired
	ConfigService config;

	@RequestMapping(value = "/main.do")
	public String login(Model model) throws Exception {
		logger.debug("....................................................../main.do");
		return "redirect:/dashboard.do";
	}

	@RequestMapping(value = "/dashboard.do")
	public String showDashboard(Model model) throws Exception {
		model.addAttribute("menuId", "");
		return "systemmgr/dashboard";
	}

	/*
	 * BBS
	 */
	@RequestMapping(value = "/bbs/notice.do")
	public ModelAndView bbsNotice(Model model) throws Exception {
		return new ModelAndView("bbs/notice");
	}
	
	/*
	 * ESPA
	 */
	@RequestMapping(value = "/mgr/question.do")
	public ModelAndView mgrQuestion(Model model) throws Exception {
		ModelAndView mav = new ModelAndView("espa/mgr/question");
		mav.addObject("default_timeout", config.getEspaConfigVoValue("DEFAULT_TIMEOUT"));
		mav.addObject("default_ban_kw", config.getEspaConfigVoValue("DEFAULT_BAN_KW"));
		return mav; 
	}
	
	@RequestMapping(value = "/mgr/config.do")
	public ModelAndView mgrConfig(Model model) throws Exception {
		return new ModelAndView("espa/mgr/config");
	}
	
	/*
	 * Systemmgr
	 */
	@RequestMapping(value = "/sm/code.do")
	public ModelAndView codeView(Model model) throws Exception {
		return new ModelAndView("systemmgr/commonCode");
	}
	
	@RequestMapping(value = "/sm/history/login.do")
	public ModelAndView loginHistoryView(Model model) throws Exception {
		return new ModelAndView("systemmgr/loginHis");
	}

	@RequestMapping(value = "/sm/menu.do")
	public ModelAndView menuView(Model model) throws Exception {
		return new ModelAndView("systemmgr/menu");
	}
	
	@RequestMapping(value = "/sm/userauth.do")
	public ModelAndView userAuthView(Model model) throws Exception {
		return new ModelAndView("systemmgr/userAuth");
	}
	
	@RequestMapping(value = "/sm/user.do")
	public ModelAndView userView(Model model) throws Exception {
		return new ModelAndView("systemmgr/user");
	}
}
