package egovframework.dgms.service;

import java.util.HashMap;
import java.util.List;

public interface MngUserService {

	public List<HashMap<String, Object>> selectMngUserInfo(HashMap<String, Object> map) throws Exception;
	
	public int selectMngUserInfoTot(HashMap<String, Object> map) throws Exception;
	
	public void insertMngUserInfo(HashMap<String, Object> map) throws Exception;
	
	public void updateMngUserInfo(HashMap<String, Object> map) throws Exception;
	
	public void updateMngPassInfo(HashMap<String, Object> map) throws Exception;
	
	public void deleteMngUserInfo(HashMap<String, Object> map) throws Exception;
	
	/*public List<HashMap<String, Object>> selectMngUserMasterInfo(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> selectCdNmCombo(HashMap<String, Object> map) throws Exception;*/
	
    
    
}
