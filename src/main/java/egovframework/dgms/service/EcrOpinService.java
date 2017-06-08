package egovframework.dgms.service;

import java.util.HashMap;
import java.util.List;

public interface EcrOpinService {

	public List<HashMap<String, Object>> selectEcrOpinInfo(HashMap<String, Object> map) throws Exception;
	
	public int selectEcrOpinInfoTot(HashMap<String, Object> map) throws Exception;
	
	public void insertEcrOpinInfo(HashMap<String, Object> map) throws Exception;
	
	public void updateEcrOpinInfo(HashMap<String, Object> map) throws Exception;
	
	public void deleteEcrOpinInfo(HashMap<String, Object> map) throws Exception;
	
	/*public List<HashMap<String, Object>> selectEcrOpinMasterInfo(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> selectCdNmCombo(HashMap<String, Object> map) throws Exception;*/
	
    
}
