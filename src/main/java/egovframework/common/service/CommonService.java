package egovframework.common.service;

import java.util.HashMap;
import java.util.List;

public interface CommonService {
	
	public String getSequence(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> getCodeListByCdID(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> getAutoComplete(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> getAutoCompleteNew(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> getUserAutoComplete(HashMap<String, Object> map) throws Exception;
	
	public int getDuplicateCount(HashMap<String, Object> map) throws Exception;
	
}
