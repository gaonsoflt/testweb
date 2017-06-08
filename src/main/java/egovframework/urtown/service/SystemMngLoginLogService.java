package egovframework.urtown.service;

import java.util.HashMap;
import java.util.List;

public interface SystemMngLoginLogService {

	public List<HashMap<String, Object>> selectSystemMngLoginLog(HashMap<String, Object> map) throws Exception;
	
	public int selectSystemMngLoginLogTot(HashMap<String, Object> map) throws Exception;
	/*
	public void insertSystemMngUserInfo(HashMap<String, Object> map) throws Exception;
	
	public void updateSystemMngUserInfo(HashMap<String, Object> map) throws Exception;
	
	public void updateMngPassInfo(HashMap<String, Object> map) throws Exception;
	
	public void deleteSystemMngUserInfo(HashMap<String, Object> map) throws Exception;  
	*/
}
