package egovframework.dgms.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class DgmsMainController {
Logger logger = LoggerFactory.getLogger(DgmsMainController.class.getName());
    
	@RequestMapping(value = "/dgms/index.do")
	public String dgmsIndex(Model model) throws Exception {
		return "dgms/index";
	}

//	@RequestMapping(value = "/dgms/main.do")
//	public String dgmsMain(Model model) throws Exception {
//		logger.debug("........................................................................../dgms/main.do---->dgms/dashboard.jsp");
//		return "urtown/checkNotice";
//	}
//	
	
	@RequestMapping(value = "/dgms/main.do", method=RequestMethod.GET)
	public ModelAndView login(Model model, 
			@RequestParam(value="areaId", required=false) String areaId) throws Exception {
		logger.debug("........................................................................../dgms/main.do");
		ModelAndView mav = new ModelAndView("urtown/checkNotice");
		if(areaId != null) {
			mav.addObject("areaId", areaId);
		}
		return mav;
	}
	
	
	@RequestMapping(value = "/dgms/top.do")
	public String dgmsTop(Model model) throws Exception {
		return "dgms/top";
	}
	
	@RequestMapping(value = "/dgms/bottom.do")
	public String dgmsBottom(Model model) throws Exception {
		return "dgms/bottom";
	}
	
	@RequestMapping(value = "/dgms/preview.do")
	public String dgmsPreview(Model model) throws Exception {
		return "dgms/preview";
	}
	
	@RequestMapping(value = "/dgms/right.do")
	public String dgmsRight(Model model) throws Exception {
		return "dgms/right";
	}
	

}

