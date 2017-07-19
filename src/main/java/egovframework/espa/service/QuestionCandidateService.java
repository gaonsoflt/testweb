package egovframework.espa.service;

import java.util.List;
import java.util.Map;

public interface QuestionCandidateService {
	public List<Map<String, Object>> getDeployedQuestionList(Map<String, Object> param) throws Exception;
	
	public List<Map<String, Object>> getCandidateList(Map<String, Object> param) throws Exception;
	
	public List<Map<String, Object>> getNotCandidateList(Map<String, Object> param) throws Exception;
	
	public int saveCandidate(Map<String, Object> param) throws Exception;
}