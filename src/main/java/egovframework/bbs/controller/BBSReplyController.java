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

import egovframework.bbs.service.BBSReplyService;

@RequestMapping("/bbs/board/reply")
@Controller
public class BBSReplyController {
Logger logger = LoggerFactory.getLogger(BBSReplyController.class.getName());
    
	@Resource(name = "bBSReplyService")
	private BBSReplyService replyService;
	
	@RequestMapping(value = "/readList.do", method = RequestMethod.GET)
	public @ResponseBody List<Map<String, Object>> readList(@RequestParam("buid") String boardID) {
//		logger.debug("params:" + params); 
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		List<Map<String, Object>> rtnList = new ArrayList<>();
		try {
//			Map<String, Object> param = EgovWebUtil.parseJsonToMap(params);
			Map<String, Object> param = new HashMap<>();
			param.put("board_id", boardID);
			rtnList = replyService.getBBSReplyList(param);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", replyService.getBBSReplyListCount(param));
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return rtnList;
	}
	
	@RequestMapping(value = "/create.do", method = RequestMethod.POST)
	public ModelAndView create(HttpServletRequest request) {
		logger.debug("---------------->/create.do");
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("reply", request.getParameter("text"));
		param.put("board_id", request.getParameter("buid"));
		param.put("parent_reply_seq", request.getParameter("pSeq"));
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		try {
			if(replyService.createBBSReply(param) > 0) {
				mav.addObject("success", true);
			} else {
				mav.addObject("success", false);
			}
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("success", false);
		}
		return mav;
	}
	
	
	@RequestMapping(value = "/delete.do")
	public ModelAndView delete(@RequestParam("seq") int seq) {
		logger.debug("---------------->/delete.do");
		Map<String, Object> param = new HashMap<>();
		param.put("reply_seq", seq);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		try {
			if(replyService.deleteBBSReply(param) > 0) {
				mav.addObject("success", true);
			} else {
				mav.addObject("success", false);
			}
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("success", false);
		}
		return mav;
	}
}