package egovframework.bbs.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.bbs.service.BBSReplyService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.systemmgr.service.SystemMgrUserService;


@Service("bBSReplyService")
public class BBSReplyServiceImpl extends EgovAbstractServiceImpl implements BBSReplyService {
	Logger logger = LoggerFactory.getLogger(BBSReplyServiceImpl.class.getName()); 
	
	@Resource(name = "bBSReplyMapper")
	private BBSReplyMapper replyMapper;
	
	@Resource(name = "systemMgrUserService")
	private SystemMgrUserService userService;
	
	@Override
	public List<Map<String, Object>> getBBSReplyList(Map<String, Object> param) throws Exception {
		return replyMapper.readReplyListByBBS(param);
	}

	@Override
	public int getBBSReplyListCount(Map<String, Object> param) throws Exception {
		return replyMapper.readReplyListCountByBBS(param);
	}

	@Override
	public int createBBSReply(Map<String, Object> param) throws Exception {
		param.put("reg_usr", userService.getLoginUserInfo().getUsername());
		return replyMapper.createReply(param);
	}

	@Override
	public int deleteBBSReply(Map<String, Object> param) throws Exception {
		return replyMapper.deleteReply(param);
	}
}