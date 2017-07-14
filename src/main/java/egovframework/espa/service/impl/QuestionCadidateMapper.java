package egovframework.espa.service.impl;

import java.util.Map;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("questionCadidateMapper")
public interface QuestionCadidateMapper {
	public List<Map<String, Object>> readCandidate(Map<String, Object> map) throws Exception;
	
	public int createCandidate(Map<String, Object> map) throws Exception;
}
