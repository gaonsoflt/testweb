package egovframework.systemmgr.service;

import java.util.HashMap;
import java.util.List;

public interface SystemMgrUserService {

	public List<HashMap<String, Object>> selectSystemMngUserInfo(HashMap<String, Object> map) throws Exception;
	
	public int selectSystemMngUserInfoTot(HashMap<String, Object> map) throws Exception;
	
	public void insertSystemMngUserInfo(HashMap<String, Object> map) throws Exception;
	
	public void updateSystemMngUserInfo(HashMap<String, Object> map) throws Exception;
	
	public void updateMngPassInfo(HashMap<String, Object> map) throws Exception;
	
	public void deleteSystemMngUserInfo(HashMap<String, Object> map) throws Exception;  
}
