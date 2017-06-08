package egovframework.dgms.service;

import java.util.HashMap;
import java.util.List;

public interface FaqService {

	public List<HashMap<String, Object>> selectFaqInfo(HashMap<String, Object> map) throws Exception;
	
	public int selectFaqInfoTot(HashMap<String, Object> map) throws Exception;
	
	public void insertFaqInfo(HashMap<String, Object> map) throws Exception;
	
	public void updateFaqInfo(HashMap<String, Object> map) throws Exception;
	
	public void deleteFaqInfo(HashMap<String, Object> map) throws Exception;
	
	/*public List<HashMap<String, Object>> selectFaqMasterInfo(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> selectCdNmCombo(HashMap<String, Object> map) throws Exception;*/
	
    
    
}
