package egovframework.espa.service.impl;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("questionCadidateMapper")
public interface QuestionCadidateMapper {
	public List<HashMap<String, Object>> readCandidate(HashMap<String, Object> map) throws Exception;
	
	public int createCandidate(HashMap<String, Object> map) throws Exception;
}
