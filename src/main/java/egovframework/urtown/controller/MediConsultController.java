package egovframework.urtown.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MediConsultController {
	Logger logger = LoggerFactory.getLogger(MediConsultController.class.getName());

	@RequestMapping(value = "/urtown/mediConsultReq.do")
	public ModelAndView mediConsultReq(Model model, HttpServletRequest request) throws Exception {
		return new ModelAndView("urtown/mediConsultReq");
	}
	
	@RequestMapping(value = "/urtown/mediConsultMgr.do")
	public ModelAndView mediConsultMgr(Model model) throws Exception {
		return new ModelAndView("urtown/mediConsultMgr");
	}
	
	@RequestMapping(value = "/urtown/mediConsultMgrPopup.do")
	public ModelAndView mediConsultMgrPopup(Model model) throws Exception {
		return new ModelAndView("urtown/mediConsultMgrPopup");
	}
	
	@RequestMapping(value = "/urtown/mediConsultMgrPopupEcg.do")
	public ModelAndView mediConsultMgrPopupEcg(Model model, HttpServletRequest request) throws Exception {
		model.addAttribute("url", request.getParameter("url"));
		model.addAttribute("name", request.getParameter("name"));
		return new ModelAndView("urtown/mediConsultMgrPopupEcg");
		
	}
	
	@RequestMapping(value = "/urtown/mediConsultFAQ.do")
	public ModelAndView mediConsultFAQ(Model model) throws Exception {
		return new ModelAndView("urtown/mediConsultFAQ");
	}
	
	@RequestMapping(value = "/urtown/mediConsultHis.do")
	public ModelAndView mediConsultHis(Model model) throws Exception {
		return new ModelAndView("urtown/mediConsultHis");
	}
	
	@RequestMapping(value = "/urtown/connectSkype.do", method=RequestMethod.GET)
	public ModelAndView connectSkype(Model model, @RequestParam(value="error", required=false) String error) throws Exception {
		ModelAndView mav = new ModelAndView("urtown/connectSkype");
		if(error != null) {
			mav.addObject("error", error);
		}
		return mav;
	}
}