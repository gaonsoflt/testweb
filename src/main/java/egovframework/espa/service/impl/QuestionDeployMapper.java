package egovframework.espa.service.impl;

import java.util.Map;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("questionDeployMapper")
public interface QuestionDeployMapper {
	
	public List<Map<String, Object>> readDeployList(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> readDeploy(Map<String, Object> map) throws Exception;

	public int readDeployAllCount(Map<String, Object> map) throws Exception;
	
	public int createDeploy(Map<String, Object> map) throws Exception;
	
	public int updateDeploy(Map<String, Object> map) throws Exception;
	
	public int deleteDeploy(Map<String, Object> map) throws Exception;  
	
	// for student
	public List<Map<String, Object>> readDeployedQuestionListByUser(Map<String, Object> map) throws Exception;
	
	public Map<String, Object> readDeployedQuestionDetailByUser(Map<String, Object> map) throws Exception;
	
	public int readAvailableDeployedQuestion(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> readGroupsOfAvailableDeployedQuestion(Map<String, Object> map) throws Exception;
	
}
