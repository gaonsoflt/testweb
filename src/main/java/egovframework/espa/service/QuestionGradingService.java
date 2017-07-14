package egovframework.espa.service;

import java.util.Map;
import java.util.List;

public interface QuestionGradingService {

	public List<Map<String, Object>> getGradingList(Map<String, Object> map) throws Exception;
	
	public int createGrading(Map<String, Object> map) throws Exception;
	
	public int updateGrading(Map<String, Object> map) throws Exception;
	
	public int deleteGrading(Map<String, Object> map) throws Exception;  
}
