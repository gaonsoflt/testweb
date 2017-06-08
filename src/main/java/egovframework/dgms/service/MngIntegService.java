package egovframework.dgms.service;

import java.util.HashMap;
import java.util.List;

public interface MngIntegService {
	 

	public List<HashMap<String, Object>> selectMngIntegDetailInfoJsonp(HashMap<String, Object> map) throws Exception;

	public int selectMngIntegInfoTot(HashMap<String, Object> map) throws Exception;
	
	/*

	public List<HashMap<String, Object>> selectMngIntegInfo(HashMap<String, Object> map) throws Exception;
	
	public int selectMngIntegInfoTot(HashMap<String, Object> map) throws Exception;
	
	public void insertMngIntegInfo(HashMap<String, Object> map) throws Exception;
	
	public void updateMngIntegInfo(HashMap<String, Object> map) throws Exception;
	
	public void deleteMngIntegInfo(HashMap<String, Object> map) throws Exception;
 

	public List<HashMap<String, Object>> selectMngIntegMasterInfo(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> selectCdNmCombo(HashMap<String, Object> map) throws Exception;*/
	
    
}
