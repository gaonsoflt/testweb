package egovframework.dgms.service;

import java.util.HashMap;
import java.util.List;

public interface MngGrpService {

	public List<HashMap<String, Object>> selectMngGrpInfo(HashMap<String, Object> map) throws Exception;
	
	public int selectMngGrpInfoTot(HashMap<String, Object> map) throws Exception;
	
	public void insertMngGrpInfo(HashMap<String, Object> map) throws Exception;
	
	public void updateMngGrpInfo(HashMap<String, Object> map) throws Exception;
	
	public void deleteMngGrpInfo(HashMap<String, Object> map) throws Exception;
	
	/*public List<HashMap<String, Object>> selectMngGrpMasterInfo(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> selectCdNmCombo(HashMap<String, Object> map) throws Exception;*/
	
    
    
}
