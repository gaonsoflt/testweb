package egovframework.dgms.service;

import java.util.HashMap;
import java.util.List;

public interface MngFaultService {

	public List<HashMap<String, Object>> selectMngFaultInfo(HashMap<String, Object> map) throws Exception;
	
	public int selectMngFaultInfoTot(HashMap<String, Object> map) throws Exception;
	
	public void insertMngFaultInfo(HashMap<String, Object> map) throws Exception;
	
	public void updateMngFaultInfo(HashMap<String, Object> map) throws Exception;
	
	public void deleteMngFaultInfo(HashMap<String, Object> map) throws Exception;
	
	/*public List<HashMap<String, Object>> selectMngFaultMasterInfo(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> selectCdNmCombo(HashMap<String, Object> map) throws Exception;*/
	
    
    
}
