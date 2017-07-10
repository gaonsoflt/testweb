package egovframework.bbs.service;

import java.util.Map;
import java.util.List;

public interface BBSBoardService {

	public List<Map<String, Object>> getBBSList(Map<String, Object> param) throws Exception;
	
	public Map<String, Object> getBBS(Map<String, Object> param) throws Exception;

	public int getBBSListCount(Map<String, Object> param) throws Exception;
	
	public int createBBS(Map<String, Object> param) throws Exception;
	
	public int updateBBS(Map<String, Object> param) throws Exception;
	
	public int deleteBBS(Map<String, Object> param) throws Exception;  
}
