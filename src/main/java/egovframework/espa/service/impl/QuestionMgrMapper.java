package egovframework.espa.service.impl;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("questionMgrMapper")
public interface QuestionMgrMapper {
	
	public List<HashMap<String, Object>> selectQuestionList(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> selectQuestion(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> selectQuestionByDeploySeq(HashMap<String, Object> map) throws Exception;

	public int selectQuestionAllCount(HashMap<String, Object> map) throws Exception;
	
	public int insertQuestion(HashMap<String, Object> map) throws Exception;
	
	public int updateQuestion(HashMap<String, Object> map) throws Exception;
	
	public int deleteQuestion(HashMap<String, Object> map) throws Exception;
}
