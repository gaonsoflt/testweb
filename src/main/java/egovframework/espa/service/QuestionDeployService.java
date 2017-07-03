package egovframework.espa.service;

import java.util.HashMap;
import java.util.List;

public interface QuestionDeployService {

	public List<HashMap<String, Object>> getDeployList(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> getDeploy(HashMap<String, Object> map) throws Exception;

	public int getDeployAllCount(HashMap<String, Object> map) throws Exception;
	
	public int createDeploy(HashMap<String, Object> map) throws Exception;
	
	public int updateDeploy(HashMap<String, Object> map) throws Exception;
	
	public int deleteDeploy(HashMap<String, Object> map) throws Exception;  
}