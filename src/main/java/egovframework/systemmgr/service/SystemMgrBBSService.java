package egovframework.systemmgr.service;

import java.util.List;
import java.util.Map;

public interface SystemMgrBBSService {

	public Map<String, Object> getBBSList(Map<String, Object> param) throws Exception;
	
	public Map<String, Object> getBBSDetail(int seq) throws Exception;
	
	public int insertBBS(List<Map<String, Object>> params) throws Exception;
	
	public int updateBBS(List<Map<String, Object>> params) throws Exception;
	
	public int deleteBBS(List<Map<String, Object>> params) throws Exception;
}
