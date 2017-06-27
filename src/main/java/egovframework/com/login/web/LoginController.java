package egovframework.com.login.web;

import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.login.service.CmmLoginUser;
import egovframework.com.user.service.UserInfoService;
import egovframework.common.service.CommonService;
import egovframework.systemmgr.service.SystemMgrMenuService;

@Controller
public class LoginController {
	Logger logger = LoggerFactory.getLogger(LoginController.class.getName());

    @Resource(name = "userInfoService")
    protected UserInfoService userInfoService;
    
    @Resource(name = "commonService")
    private CommonService commonService;
    
	@Resource(name = "systemMgrMenuService")
	private SystemMgrMenuService menuService;
    
	@RequestMapping(value = "/com/login/login.do", method=RequestMethod.GET)
	public ModelAndView login(Model model, 
			@RequestParam(value="areaId", required=false) String areaId, 
			@RequestParam(value="error", required=false) String error) throws Exception {
		logger.debug("........................................................................../com/login/login.do");
		ModelAndView mav = new ModelAndView("com/login/login");
		return mav;
	}
	
    @RequestMapping(value = "/com/login/logout.do", method = RequestMethod.GET)
    public String logout(HttpSession session)  throws Exception{
    	CmmLoginUser userDetails = (CmmLoginUser)session.getAttribute("userLoginInfo");
        logger.debug("Byebye logout! {}, {}", session.getId(), userDetails.getUsername());
        session.invalidate();
        return "redirect:/com/login/login";
//        return "redirect:/espa/index.do";
    }
     
    @RequestMapping(value = "/com/login/login_success.do", method = RequestMethod.GET)
    public String login_success(HttpSession session, HttpServletRequest request)  throws Exception{
    	CmmLoginUser userDetails = (CmmLoginUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        session.setAttribute("userLoginInfo", userDetails);
        // refresh to cached menu data
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("USER_NO", userDetails.getUserseq());
        menuService.refreshMenu(param);
        
//        return "redirect:/sm/user/view.do";
//        return "redirect:/main/dashboard/view.do";
        return "redirect:/main.do";
    }
}

