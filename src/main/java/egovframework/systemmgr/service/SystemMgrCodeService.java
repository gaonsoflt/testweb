package egovframework.systemmgr.service;

import java.util.HashMap;
import java.util.List;

public interface SystemMgrCodeService {

	public List<HashMap<String, Object>> selectMngCodeInfo(HashMap<String, Object> map) throws Exception;
	
	public int selectMngCodeInfoTot(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> selectMngCodeInfoCombo(HashMap<String, Object> map) throws Exception;
	
	public void insertMngCodeInfo(HashMap<String, Object> map) throws Exception;
	
	public void updateMngCodeInfo(HashMap<String, Object> map) throws Exception;
	
	public void deleteMngCodeInfo(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> selectMngCodeMasterInfo(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> selectCdNmCombo(HashMap<String, Object> map) throws Exception;
	
    
    
}
