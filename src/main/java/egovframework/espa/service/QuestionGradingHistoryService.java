package egovframework.espa.service;

import java.util.Map;
import java.util.List;

public interface QuestionGradingHistoryService {

	public List<Map<String, Object>> getGradingResultListByUser(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> getDeployedQuestinResultList(Map<String, Object> map) throws Exception;
	
	public Map<String, Object> getDeployedQuestinResult(long deploySeq) throws Exception;
	
	public Map<String, Object> getDeployedQuestinResult(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> getGradingResultOfUserList(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> getGradingResultUser(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> getGradingResultUserDetail(Map<String, Object> map) throws Exception;
}
