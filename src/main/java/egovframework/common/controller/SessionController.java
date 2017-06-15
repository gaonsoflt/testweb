package egovframework.common.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

@Controller
@SessionAttributes("menuId") // Model.addAttribute();
public class SessionController {
	Logger logger = LoggerFactory.getLogger(SessionController.class.getName());

	@RequestMapping(value = "/session/setMenuId.do")
	public ModelAndView setMenuId(Model model, @RequestParam("menuId") String menuId) throws Exception {
		logger.debug("set session: menuId=" + menuId);
		model.addAttribute("menuId", menuId);
		return null;
	}

	@RequestMapping(value = "/redirect.do", method = RequestMethod.GET)
	public ModelAndView login_success(HttpSession session, HttpServletRequest request) throws Exception {
		logger.info("................................... redirecting");
		RedirectView redirectView = new RedirectView("sm/user/view.do");
		redirectView.setContextRelative(true);
		redirectView.setExposeModelAttributes(false);
		ModelAndView mav = new ModelAndView(redirectView);

		return mav;
	}
}