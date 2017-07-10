package egovframework.bbs.service;

import java.util.Map;
import java.util.List;

public interface BBSReplyService {

	public List<Map<String, Object>> getBBSReplyList(Map<String, Object> param) throws Exception;
	
	public int getBBSReplyListCount(Map<String, Object> param) throws Exception;
	
	public int createBBSReply(Map<String, Object> param) throws Exception;
	
	public int deleteBBSReply(Map<String, Object> param) throws Exception;  
}
