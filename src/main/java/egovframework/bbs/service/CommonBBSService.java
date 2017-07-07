package egovframework.bbs.service;

import java.util.Map;
import java.util.List;

public interface CommonBBSService {

	public List<Map<String, Object>> getBBSList(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> getBBS(Map<String, Object> map) throws Exception;

	public int getBBSListCount(Map<String, Object> map) throws Exception;
	
	public int createBBS(Map<String, Object> map) throws Exception;
	
	public int updateBBS(Map<String, Object> map) throws Exception;
	
	public int deleteBBS(Map<String, Object> map) throws Exception;  
}
