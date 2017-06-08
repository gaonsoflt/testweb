package egovframework.com.login.web;

import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.mobile.device.Device;
import org.springframework.mobile.device.DeviceUtils;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.login.service.CmmLoginUser;
import egovframework.com.user.service.UserInfoService;
import egovframework.dgms.service.CommonService;

@Controller
public class LoginController {
	Logger logger = LoggerFactory.getLogger(LoginController.class.getName());

    @Resource(name = "userInfoService")
    protected UserInfoService userInfoService;
    
    @Resource(name = "commonService")
    private CommonService commonService;
    
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
 
    	/************************* LOGIN LOG *************************/
    	/**ip**/ 
//        String ip = request.getHeader("X-FORWARDED-FOR");  
//        if(ip == null || ip.length() == 0){
//            ip = request.getHeader("Proxy-Client-IP");
//        }
//        if(ip == null || ip.length() == 0){
//            ip = request.getHeader("WL-Proxy-Client-IP"); 
//        }
//        if(ip == null || ip.length() == 0){
//            ip = request.getRemoteAddr() ;
//        }
//        
//        /**device**/
//    	String browser = request.getHeader("User-Agent");
//        Device device = DeviceUtils.getCurrentDevice(request);        
//        if (device == null) {
//            return "device is null";
//        }
//        String deviceType = "unknown";
//        if (device.isNormal()) {
//            deviceType = "nomal";
//            if(browser.indexOf("MSIE") > 0 || browser.indexOf("Trident") > 0){
//            	browser = "IE";
//            }else if(browser.indexOf("Opera") > 0 || browser.indexOf("OPR") > 0){
//            	browser = "Opera";
//            }else if(browser.indexOf("Firefix") > 0){
//            	browser = "Firefox";
//        	}else if(browser.indexOf("Safari") > 0) {
//            	 if(browser.indexOf("Chrome") > 0){
//            		 browser = "Chrome";
//            	 }else{
//            		 browser = "Safari";
//            	 }
//            }
//            deviceType += "("+browser+")";
//        } else if (device.isMobile()) {
//            deviceType = "mobile";
//        } else if (device.isTablet()) {
//            deviceType = "tablet";
//        }
//
//        /**insert login log**/
//		HashMap<String, Object> keySeq = new HashMap<String, Object>();
//		keySeq.put("SEQ_NM", "SEQ_LOGIN_LOG");
//		String Sequence = (String)commonService.getSequence((HashMap<String, Object>)keySeq); 
//		
//        HashMap<String, Object>  map = new HashMap<String, Object>();
//        map.put("LOGIN_SEQ", Sequence);
//        map.put("USER_SEQ", userDetails.getUserseq());
//        map.put("LOGIN_IP", ip);
//        map.put("LOGIN_MEHD", deviceType);
//        
//        userInfoService.insertUserLoginLog(map);
    	/************************* LOGIN LOG *************************/

/*        //권한
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        logger.info(auth.toString());

        // 유저
        User user = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        logger.info(user.toString());*/ 
        
        session.setAttribute("userLoginInfo", userDetails);
        
        return "redirect:/sm/user/view.do";
    }
}

