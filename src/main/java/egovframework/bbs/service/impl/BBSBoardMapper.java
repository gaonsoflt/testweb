package egovframework.bbs.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("bBSBoardMapper")
public interface BBSBoardMapper {
	
	public List<Map<String, Object>> readBoard(Map<String, Object> map) throws Exception;
	
	public Map<String, Object> readBoardItem(Map<String, Object> map) throws Exception;
	
	public int readBoardCount(Map<String, Object> map) throws Exception;
	
	public int createBoardItem(Map<String, Object> map) throws Exception;
	
	public int updateBoardItem(Map<String, Object> map) throws Exception;
	
	public int deleteBoardItem(Map<String, Object> map) throws Exception;
	
	public int deleteBoard(Map<String, Object> map) throws Exception; 
}
