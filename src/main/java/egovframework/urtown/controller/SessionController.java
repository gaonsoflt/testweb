package egovframework.urtown.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

@Controller
@SessionAttributes("menuId") // Model.addAttribute();
public class SessionController {
Logger logger = LoggerFactory.getLogger(SessionController.class.getName());
	
	@RequestMapping(value = "/urtown/session/setMenuId.do")
	public ModelAndView setMenuId(Model model, @RequestParam("menuId") String menuId) throws Exception {
		logger.debug("set session: menuId=" + menuId);
		model.addAttribute("menuId", menuId);
		return null;
	}
}