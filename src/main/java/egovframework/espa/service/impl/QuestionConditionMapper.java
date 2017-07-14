package egovframework.espa.service.impl;

import java.util.Map;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("questionConditionMapper")
public interface QuestionConditionMapper {
	
	public List<Map<String, Object>> selectConditionList(Map<String, Object> map) throws Exception;
	
	public int insertCondition(Map<String, Object> map) throws Exception;
	
	public int updateCondition(Map<String, Object> map) throws Exception;
	
	public int deleteCondition(Map<String, Object> map) throws Exception;  
}
