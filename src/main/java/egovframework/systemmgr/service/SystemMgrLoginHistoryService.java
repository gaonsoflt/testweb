package egovframework.systemmgr.service;

import java.util.HashMap;
import java.util.List;

public interface SystemMgrLoginHistoryService {

	public List<HashMap<String, Object>> selectLoginHistory(HashMap<String, Object> map) throws Exception;
	
	public int selectSystemMngLoginLogTot(HashMap<String, Object> map) throws Exception;

	public int insertLoginHistory(HashMap<String, Object> map) throws Exception;
	
	/*
	public void updateSystemMngUserInfo(HashMap<String, Object> map) throws Exception;
	
	public void updateMngPassInfo(HashMap<String, Object> map) throws Exception;
	
	public void deleteSystemMngUserInfo(HashMap<String, Object> map) throws Exception;  
	*/
}
