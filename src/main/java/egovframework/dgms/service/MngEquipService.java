package egovframework.dgms.service;

import java.util.HashMap;
import java.util.List;

public interface MngEquipService {

	public List<HashMap<String, Object>> selectMngEquipInfo(HashMap<String, Object> map) throws Exception;
	
	public int selectMngEquipInfoTot(HashMap<String, Object> map) throws Exception;
	
	public void insertMngEquipInfo(HashMap<String, Object> map) throws Exception;
	
	public void updateMngEquipInfo(HashMap<String, Object> map) throws Exception;
	
	public void deleteMngEquipInfo(HashMap<String, Object> map) throws Exception;
	
	/*public List<HashMap<String, Object>> selectMngEquipMasterInfo(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> selectCdNmCombo(HashMap<String, Object> map) throws Exception;*/
	
    
    
}
