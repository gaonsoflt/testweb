package egovframework.espa.service;

import java.util.HashMap;

public interface QuestionService {
	public HashMap<String, Object> readDeployedQuestionListForSubmit(HashMap<String, Object> map);
	
	public HashMap<String, Object> readDeployedQuestionDetailForSubmit(HashMap<String, Object> map);
}
