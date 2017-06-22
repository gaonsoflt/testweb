package egovframework.espa.service;

import java.util.HashMap;
import java.util.List;

public interface ESPAConfigService {

	public List<HashMap<String, Object>> readESPAConfig(HashMap<String, Object> map) throws Exception;
	
	public int readESPAConfigAllTot(HashMap<String, Object> map) throws Exception;
	
	public int createESPAConfig(HashMap<String, Object> map) throws Exception;
	
	public int updateESPAConfig(HashMap<String, Object> map) throws Exception;
	
	public int deleteESPAConfig(HashMap<String, Object> map) throws Exception;
}
