package egovframework.espa.service;

import java.util.HashMap;
import java.util.List;

public interface QuestionGradingService {

	public List<HashMap<String, Object>> getGradingList(HashMap<String, Object> map) throws Exception;
	
	public int createGrading(HashMap<String, Object> map) throws Exception;
	
	public int updateGrading(HashMap<String, Object> map) throws Exception;
	
	public int deleteGrading(HashMap<String, Object> map) throws Exception;  
}
