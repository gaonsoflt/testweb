package egovframework.dgms.service;

import java.util.HashMap;
import java.util.List;

public interface MngEquipUseService {

	public List<HashMap<String, Object>> selectMngEquipUseInfo(HashMap<String, Object> map) throws Exception;
	
	public int selectMngEquipUseInfoTot(HashMap<String, Object> map) throws Exception;
	
	public void insertMngEquipUseInfo(HashMap<String, Object> map) throws Exception;
	
	public void updateMngEquipUseInfo(HashMap<String, Object> map) throws Exception;
	
	public void deleteMngEquipUseInfo(HashMap<String, Object> map) throws Exception;

	public List<HashMap<String, Object>> getUserListByUserID(HashMap<String, Object> map) throws Exception;
	
	/*public List<HashMap<String, Object>> selectMngEquipUseMasterInfo(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> selectCdNmCombo(HashMap<String, Object> map) throws Exception;*/
	
    
    
}
