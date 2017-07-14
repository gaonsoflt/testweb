package egovframework.bbs.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.bbs.service.BBSBoardService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.systemmgr.service.SystemMgrUserService;
import egovframework.systemmgr.service.impl.SystemMgrBBSMapper;


@Service("bBSBoardService")
public class BBSBoardServiceImpl extends EgovAbstractServiceImpl implements BBSBoardService {
	Logger logger = LoggerFactory.getLogger(BBSBoardServiceImpl.class.getName()); 
	
	@Resource(name = "systemMgrUserService")
	private SystemMgrUserService userService;
	
	@Resource(name = "systemMgrBBSMapper")
	private SystemMgrBBSMapper bbsRefMapper;
	
	@Resource(name = "bBSBoardMapper")
	private BBSBoardMapper boardMapper;
	
	@Resource(name = "bBSReplyMapper")
	private BBSReplyMapper replyMapper;
	
	@Override
	public List<Map<String, Object>> getBoard(Map<String, Object> param) throws Exception {
		logger.debug("param: " + param);
		return boardMapper.readBoard(param); 
	}

	@Override
	public Map<String, Object> getBoardItem(Map<String, Object> param) throws Exception {
		logger.debug("param: " + param);
		return boardMapper.readBoardItem(param);
	}
	
	@Override
	public Map<String, Object> getBoardItem(String boardID) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("board_id", boardID);
		logger.debug("param: " + param);
		return boardMapper.readBoardItem(param);
	}

	@Override
	public int getBoardCount(Map<String, Object> param) throws Exception {
		logger.debug("param: " + param);
 		return boardMapper.readBoardCount(param);
 	}
	
	@Override
	public int saveBoardItem(Map<String, Object> param) throws Exception {
		param.put("mod_usr", userService.getLoginUserInfo().getUsername());
		int exeCnt = 0;
		logger.debug("param: " + param);
		exeCnt = boardMapper.updateBoardItem(param);
		logger.debug("update: " + exeCnt);
		if(exeCnt <= 0) {
			param.put("board_id", UUID.randomUUID().toString());
			param.put("reg_usr", userService.getLoginUserInfo().getUsername());
			param.put("mod_usr", userService.getLoginUserInfo().getUsername());
			logger.debug("param: " + param);
			exeCnt = boardMapper.createBoardItem(param);
			logger.debug("insert: " + exeCnt);
		}
		return exeCnt;
	}

	@Override
	public int createBoardItem(Map<String, Object> param) throws Exception {
		param.put("board_id", UUID.randomUUID().toString());
		param.put("reg_usr", userService.getLoginUserInfo().getUsername());
		param.put("mod_usr", userService.getLoginUserInfo().getUsername());
		logger.debug("generated uuid: " + param.get("board_id").toString());
		logger.debug("param: " + param);
		return boardMapper.createBoardItem(param);
	}

	@Override
	public int updateBoardItem(Map<String, Object> param) throws Exception {
		param.put("mod_usr", userService.getLoginUserInfo().getUsername());
		logger.debug("param: " + param);
		return boardMapper.updateBoardItem(param);
	}

	@Override
	public int deleteBoardItem(Map<String, Object> param) throws Exception {
		logger.debug("param: " + param);
		int exeCnt = 0;
		exeCnt = boardMapper.deleteBoardItem(param);
		if(exeCnt > 0) {
			replyMapper.deleteReplyByBoard(param);
		}
		return exeCnt;
	}
}