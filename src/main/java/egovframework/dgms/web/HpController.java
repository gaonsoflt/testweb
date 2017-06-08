package egovframework.dgms.web;

import java.util.*;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import egovframework.com.windowsazure.messaging.service.AzurePushService;
import egovframework.dgms.service.AppInfService;
import egovframework.dgms.service.MngUserService;

@Controller
public class HpController {
	Logger logger = LoggerFactory.getLogger(HpController.class.getName());
	

	/**
	 * 홈페이지 메인
	 * @return "index"
	 * @exception Exception
	 */
//	@RequestMapping(value = "/urtown/index.do")
//	public String hindex(ModelMap model) throws Exception {
//		logger.debug("........................................................................../urtown/index.do");
//
//		//return "com/login/login";
//		return "urtown/index";
//	}
//
//	@RequestMapping(value = "/hp/gopage.do")
//	public String gopage(@RequestParam Map<String,Object> paramMap, ModelMap model) throws Exception {
//
//		
//		String goUrl = "";
//		String f = paramMap.get("f").toString();
//		String p = paramMap.get("p").toString();
//		
//		/*if (f != null && f.equals("sub02")) //사업실적 게시판
//		{
//			return "forward:/board/gaonBoardList.do";
//		}
//		else if(f != null && f.equals("sub03")) //PR 게시판
//		{
//			return "forward:/board/gaonBoardList.do";
//		}
//		else if(f != null && f.equals("sub04") && p != null && p.equals("02")) //Company history 게시판
//		{
//			return "forward:/board/gaonBoardList.do";
//		}*/
//		goUrl = f+"/"+p;
//		
//		/* 접속 로그 등록 */
//		/*HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
//        String ip = req.getHeader("X-FORWARDED-FOR");
//
//        if (ip == null)
//            ip = req.getRemoteAddr();
//        
//        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//        String today= formatter.format(new java.util.Date());
//        
//        HttpSession session = req.getSession();
//		String uid = (String)session.getAttribute("uid");
//		
//		Map<String, Object> commparamMap = new HashMap<String, Object>();
//		commparamMap.put("access_page", "/gopage.do");
//		commparamMap.put("access_ip", ip);
//		commparamMap.put("access_datetime", today);
//		commparamMap.put("access_url", "/gopage.do?"+goUrl);
//		commparamMap.put("login_id",uid );
//		
//		commonService.insertAccessLog(commparamMap);*/
//		
//		return goUrl;
//	}
//	
//	@RequestMapping(value = "/gopage.do",method= RequestMethod.POST)
//	public String gopostpage(@RequestParam Map<String,Object> paramMap, ModelMap model) throws Exception {
//
//		
//		String goUrl = "";
//		String f = paramMap.get("f").toString();
//		String p = paramMap.get("p").toString();
//		
//		if (f != null && f.equals("sub02")) //사업실적 게시판
//		{
//			return "forward:/board/gaonBoardList.do";
//		}
//		else if(f != null && f.equals("sub03")) //PR 게시판
//		{
//			return "forward:/board/gaonBoardList.do";
//		}
//		goUrl = f+"/"+p;
//		
//		return goUrl;
//	}
	
	
}
