package egovframework.espa.service;

import java.util.Map;
import java.util.List;

public interface QuestionGradingHistoryService {

	public List<Map<String, Object>> getGradingResultListByUser(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> getGradingResultList(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> getGradingResultOfUserList(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> getUserGrading(Map<String, Object> map) throws Exception;
}
