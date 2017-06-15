package egovframework.systemmgr.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MainController {
Logger logger = LoggerFactory.getLogger(MainController.class.getName());

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
	public String bbsNotice(Model model) throws Exception {
		return "bbs/notice";
	}
	
	/*
	 * ESPA
	 */
	@RequestMapping(value = "/mgr/question.do")
	public String mgrQuestion(Model model) throws Exception {
		return "espa/mgr/question";
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
