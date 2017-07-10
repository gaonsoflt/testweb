package egovframework.bbs.service.impl;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.bbs.service.BBSBoardService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.systemmgr.service.impl.SystemMgrBBSMapper;


@Service("bBSBoardService")
public class BBSBoardServiceImpl extends EgovAbstractServiceImpl implements BBSBoardService {
	Logger logger = LoggerFactory.getLogger(BBSBoardServiceImpl.class.getName()); 
	
	@Resource(name = "systemMgrBBSMapper")
	private SystemMgrBBSMapper bbsRefMapper;
	
	@Resource(name = "bBSBoardMapper")
	private BBSBoardMapper boardMapper;
	
	@Resource(name = "bBSReplyMapper")
	private BBSReplyMapper replyMapper;
	
	@Override
	public List<Map<String, Object>> getBBSList(Map<String, Object> param) throws Exception {
		return boardMapper.readBBSList(param); 
	}

	@Override
	public Map<String, Object> getBBS(Map<String, Object> param) throws Exception {
		Map<String, Object> detail = boardMapper.readBBSDetail(param);
		detail.put("reply", replyMapper.readReplyListCountByBBS(param));
		return detail;
	}

	@Override
	public int getBBSListCount(Map<String, Object> param) throws Exception {
 		return boardMapper.readBBSListCount(param);
	}

	@Override
	public int createBBS(Map<String, Object> param) throws Exception {
		param.put("bbs_uid", UUID.randomUUID().toString());
		logger.debug("generated uuid: " + param.get("bbs_uid").toString());
		return boardMapper.createBBS(param);
	}

	@Override
	public int updateBBS(Map<String, Object> param) throws Exception {
		return boardMapper.updateBBS(param);
	}

	@Override
	public int deleteBBS(Map<String, Object> param) throws Exception {
		return boardMapper.deleteBBS(param);
	}
}