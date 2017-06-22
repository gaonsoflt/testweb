package egovframework.espa.service.impl;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("questionConditionMapper")
public interface QuestionConditionMapper {
	
	public List<HashMap<String, Object>> selectConditionList(HashMap<String, Object> map) throws Exception;
	
	public int insertCondition(HashMap<String, Object> map) throws Exception;
	
	public int updateCondition(HashMap<String, Object> map) throws Exception;
	
	public int deleteCondition(HashMap<String, Object> map) throws Exception;  
}
