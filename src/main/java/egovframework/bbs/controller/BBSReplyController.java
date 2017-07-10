package egovframework.bbs.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.util.JSONPObject;

import egovframework.bbs.service.BBSReplyService;
import egovframework.com.cmm.EgovWebUtil;

@RequestMapping("/bbs/board/reply")
@Controller
public class BBSReplyController {
Logger logger = LoggerFactory.getLogger(BBSReplyController.class.getName());
    
	@Resource(name = "bBSReplyService")
	private BBSReplyService replyService;
	
	@RequestMapping(value = "/readList.do", method = RequestMethod.GET)
	public @ResponseBody List<Map<String, Object>> readList(@RequestParam("buid") String bbsUID) {
//		logger.debug("params:" + params); 
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		List<Map<String, Object>> rtnList = new ArrayList<>();
		try {
//			Map<String, Object> param = EgovWebUtil.parseJsonToMap(params);
			Map<String, Object> param = new HashMap<>();
			param.put("bbs_uid", bbsUID);
			rtnList = replyService.getBBSReplyList(param);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", replyService.getBBSReplyListCount(param));
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return rtnList;
	}
	
	@RequestMapping(value = "/create.do")
	public ModelAndView create(HttpServletRequest request) {
		logger.debug("---------------->/create.do");
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("reply", request.getParameter("text"));
		param.put("bbs_uid", request.getParameter("buid"));
		param.put("parent_reply_seq", request.getParameter("pSeq"));
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		try {
			replyService.createBBSReply(param);
			mav.addObject("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("success", false);
		}
		return mav;
	}
	
	
	@RequestMapping(value = "/delete.do")
	public @ResponseBody JSONPObject delete(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/delete.do");
		logger.debug("models:" + models); 
		List<Map<String, Object>> paramMapList = EgovWebUtil.parseJsonToList(models);
		try {
			for(int i = 0; i < paramMapList.size(); i++){
				Map<String, Object> param = paramMapList.get(i);
				replyService.deleteBBSReply(param);
			}
		} catch (Exception e) {
			e.printStackTrace();
			Map<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, models);
	}
}