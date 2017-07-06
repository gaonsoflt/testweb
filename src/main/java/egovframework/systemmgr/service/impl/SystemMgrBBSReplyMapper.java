package egovframework.systemmgr.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("systemMgrBBSReplyMapper")
public interface SystemMgrBBSReplyMapper {
	
	public List<Map<String, Object>> readReplyListByBBS(Map<String, Object> map) throws Exception;
	
	public int createReply(Map<String, Object> map) throws Exception;
	
	public int updateReply(Map<String, Object> map) throws Exception;
	
	public int deleteReply(Map<String, Object> map) throws Exception; 
}
