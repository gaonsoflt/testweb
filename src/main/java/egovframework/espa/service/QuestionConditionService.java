package egovframework.espa.service;

import java.util.HashMap;
import java.util.List;

public interface QuestionConditionService {

	public List<HashMap<String, Object>> getConditionList(HashMap<String, Object> map) throws Exception;
	
	public int createCondition(HashMap<String, Object> map) throws Exception;
	
	public int updateCondition(HashMap<String, Object> map) throws Exception;
	
	public int deleteCondition(HashMap<String, Object> map) throws Exception;  
}
