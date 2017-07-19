package egovframework.espa.service.impl;

import java.util.Map;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("questionCandidateMapper")
public interface QuestionCandidateMapper {
	public List<Map<String, Object>> readCandidateList(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> readNotCandidateList(Map<String, Object> map) throws Exception;
	
	public int createCandidate(Map<String, Object> map) throws Exception;
	
	public int createCandidateByGroup(Map<String, Object> map) throws Exception;
	
	public int deleteCandidateByDeploySeq(Map<String, Object> map) throws Exception;
	
	public int deleteCandidate(Map<String, Object> map) throws Exception;
}
