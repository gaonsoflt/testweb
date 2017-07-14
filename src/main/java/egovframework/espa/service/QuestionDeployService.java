package egovframework.espa.service;

import java.util.Map;
import java.util.List;

public interface QuestionDeployService {

	public List<Map<String, Object>> getDeployList(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> getDeploy(Map<String, Object> map) throws Exception;

	public int getDeployAllCount(Map<String, Object> map) throws Exception;
	
	public int createDeploy(Map<String, Object> map) throws Exception;
	
	public int updateDeploy(Map<String, Object> map) throws Exception;
	
	public int deleteDeploy(Map<String, Object> map) throws Exception;  
	
	public Map<String, Object> getDeployedQuestionListByUser(Map<String, Object> map);
	
	public Map<String, Object> getDeployedQuestionDetailByUser(Map<String, Object> map);
	
	public Map<String, Object> getDeployedQuestionDetail(long seq);
	
	public Map<String, Object> getGroupOfDeployedQuestionByUser(Map<String, Object> map);
	
	public Map<String, Object> getGroupOfDeployedQuestion(Map<String, Object> map);
}
