package egovframework.espa.service;

import java.util.Map;
import java.util.List;

public interface QuestionConditionService {

	public List<Map<String, Object>> getConditionList(Map<String, Object> map) throws Exception;
	
	public int createCondition(Map<String, Object> map) throws Exception;
	
	public int updateCondition(Map<String, Object> map) throws Exception;
	
	public int deleteCondition(Map<String, Object> map) throws Exception;  
}
