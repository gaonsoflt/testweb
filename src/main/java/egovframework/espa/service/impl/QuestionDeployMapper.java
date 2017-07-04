package egovframework.espa.service.impl;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("questionDeployMapper")
public interface QuestionDeployMapper {
	
	public List<HashMap<String, Object>> readDeployList(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> readDeploy(HashMap<String, Object> map) throws Exception;

	public int readDeployAllCount(HashMap<String, Object> map) throws Exception;
	
	public int createDeploy(HashMap<String, Object> map) throws Exception;
	
	public int updateDeploy(HashMap<String, Object> map) throws Exception;
	
	public int deleteDeploy(HashMap<String, Object> map) throws Exception;  
	
	// for student
	public List<HashMap<String, Object>> readDeployedQuestionList(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> readDeployedQuestionListByUser(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> readDeployedQuestionDetailByUser(HashMap<String, Object> map) throws Exception;

	public int readAvailableDeployedQuestion(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> readGroupsOfAvailableDeployedQuestion(HashMap<String, Object> map) throws Exception;
}
