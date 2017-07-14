package egovframework.bbs.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.util.JSONPObject;

import egovframework.bbs.service.BBSBoardService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.systemmgr.service.SystemMgrBBSService;
import egovframework.systemmgr.service.SystemMgrMenuService;

@RequestMapping("/bbs/board")
@Controller
public class BBSBoardController {
Logger logger = LoggerFactory.getLogger(BBSBoardController.class.getName());
    
	@Resource(name = "systemMgrMenuService")
	private SystemMgrMenuService menuService;

	@Resource(name = "bBSBoardService")
	private BBSBoardService boardService;
	
	@Resource(name = "systemMgrBBSService")
	private SystemMgrBBSService bbsService;
	
	@RequestMapping(value = "/form.do")
	public ModelAndView bbsCommonView(Model model, @RequestParam(value="bbs", required=true) int bbsID, @RequestParam(value="board", required=false) String boardID)  throws Exception {
		logger.debug("param: bbs id=" + bbsID + ", board_id=" + boardID);
		ModelAndView mav = new ModelAndView("bbs/bbsForm");
		Map<String, Object> bbsInfo = bbsService.getBBSDetail(bbsID);
		mav.addObject("bbsInfo", bbsInfo);
		mav.addObject("boardInfo", boardService.getBoardItem(boardID));
		mav.addObject("menu", menuService.getMenuVo(bbsInfo.get("bbs_id").toString()));
		return mav;
	}
	
	@RequestMapping(value = "/readList.do")
	public @ResponseBody JSONPObject readList(@RequestParam("callback") String c, @RequestParam("params") String params) {
		logger.debug("params:" + params); 
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		try {
			Map<String, Object> param = EgovWebUtil.parseJsonToMap(params);
			List<Map<String, Object>> rtnList = boardService.getBoard(param);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", boardService.getBoardCount(param));
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return new JSONPObject(c, rtnMap);
	}
	
	@RequestMapping(value = "/read.do")
	public @ResponseBody JSONPObject read(@RequestParam("callback") String c, @RequestParam("params") String params) {
		logger.debug("params:" + params); 
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			Map<String, Object> param = EgovWebUtil.parseJsonToMap(params);
			rtnMap = boardService.getBoardItem(param);
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return new JSONPObject(c, rtnMap);
	}

	@RequestMapping(value = "/save.do", method = RequestMethod.POST)
	public ModelAndView save(HttpServletRequest request, @RequestParam String action, @RequestParam(value="file", required=false)MultipartFile file) throws Exception {
		HashMap<String, Object> param = new HashMap<String, Object>();
		logger.debug("[BBAEK] action: " + action);
		try {
			param.put("board_id", request.getParameter("board"));
			param.put("bbs_seq", request.getParameter("bbs"));
			if(action.equals("save")) {
				param.put("title", request.getParameter("title"));
				param.put("content", request.getParameter("content"));
				boardService.saveBoardItem(param);
			} else if(action.equals("delete")) {
				boardService.deleteBoardItem(param);
			}
			return new ModelAndView("redirect:/bbs/board.do?bbs=" + param.get("bbs_seq").toString());
		} catch (Exception e) {
			e.printStackTrace();
			return new ModelAndView("/egovframework/cmmn/bizError");
		}
		
//		String answerType = request.getParameter("answer_type");
//		if(answerType.equals("file")) {
//			param.put("answer", FileUtil.readFile(file));
//		} else {
//			param.put("answer", request.getParameter("submit_editor"));
//		}
//		// insert answer history
//		if(questionAnswerService.saveAnswer(param)) {
//			param.put("user_seq", userService.getLoginUserInfo().getUserseq());
//			executeService.execute(param);
////			ESPAExecuteVO result = executeService.execute(param);
////			result.setCode("");
////			result.setGrading(null);
////			mav.addObject("result", result);
//		}
	}
	
	@RequestMapping(value = "/delete.do")
	public @ResponseBody JSONPObject delete(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/delete.do");
		logger.debug("models:" + models); 
		List<Map<String, Object>> paramMapList = EgovWebUtil.parseJsonToList(models);
		try {
			for(int i = 0; i < paramMapList.size(); i++){
				boardService.deleteBoardItem(paramMapList.get(i));
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