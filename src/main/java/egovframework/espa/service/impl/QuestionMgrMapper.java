package egovframework.espa.service.impl;

import java.util.Map;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("questionMgrMapper")
public interface QuestionMgrMapper {
	
	public List<Map<String, Object>> selectQuestionList(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> selectQuestion(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> selectQuestionByDeploySeq(Map<String, Object> map) throws Exception;

	public int selectQuestionAllCount(Map<String, Object> map) throws Exception;
	
	public int insertQuestion(Map<String, Object> map) throws Exception;
	
	public int updateQuestion(Map<String, Object> map) throws Exception;
	
	public int deleteQuestion(Map<String, Object> map) throws Exception;
}
