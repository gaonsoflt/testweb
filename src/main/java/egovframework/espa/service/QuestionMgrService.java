package egovframework.espa.service;

import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.File;
import java.util.List;

public interface QuestionMgrService {

	public List<Map<String, Object>> getQuestionList(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> getQuestion(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> getQuestion(long seq) throws Exception;
	
	public Map<String, Object> importQuestion(MultipartHttpServletRequest req) throws Exception;
	
	public File exportQuestion(long seq) throws Exception;

	public int getQuestionAllCount(Map<String, Object> map) throws Exception;
	
	public int saveQuestion(Map<String, Object> map) throws Exception;
	
	public int createQuestion(Map<String, Object> map) throws Exception;
	
	public int updateQuestion(Map<String, Object> map) throws Exception;
	
	public int deleteQuestion(Map<String, Object> map) throws Exception;  
	
	public List<Map<String, Object>> getSupportLanguage(Map<String, Object> map) throws Exception;
}
