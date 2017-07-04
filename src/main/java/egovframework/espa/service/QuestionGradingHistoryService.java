package egovframework.espa.service;

import java.util.HashMap;
import java.util.List;

public interface QuestionGradingHistoryService {

	public List<HashMap<String, Object>> getGradingResultListByUser(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> getGradingResultList(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> getUserGrading(HashMap<String, Object> map) throws Exception;
}
