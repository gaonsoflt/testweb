package egovframework.bbs.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("bBSBoardMapper")
public interface BBSBoardMapper {
	
	public List<Map<String, Object>> readBBSList(Map<String, Object> map) throws Exception;
	
	public Map<String, Object> readBBSDetail(Map<String, Object> map) throws Exception;
	
	public int readBBSListCount(Map<String, Object> map) throws Exception;
	
	public int createBBS(Map<String, Object> map) throws Exception;
	
	public int updateBBS(Map<String, Object> map) throws Exception;
	
	public int deleteBBS(Map<String, Object> map) throws Exception;
	
	public int deleteBBSBoard(Map<String, Object> map) throws Exception; 
}
