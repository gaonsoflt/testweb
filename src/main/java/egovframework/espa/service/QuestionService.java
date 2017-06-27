package egovframework.espa.service;

import java.util.HashMap;
import java.util.List;

public interface QuestionService {

	public List<HashMap<String, Object>> getQuestionList(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> getQuestion(HashMap<String, Object> map) throws Exception;

	public int getQuestionAllCount(HashMap<String, Object> map) throws Exception;
	
	public int createQuestion(HashMap<String, Object> map) throws Exception;
	
	public int updateQuestion(HashMap<String, Object> map) throws Exception;
	
	public int deleteQuestion(HashMap<String, Object> map) throws Exception;  
	
	public List<HashMap<String, Object>> getSupportLanguage(HashMap<String, Object> map) throws Exception;
}
