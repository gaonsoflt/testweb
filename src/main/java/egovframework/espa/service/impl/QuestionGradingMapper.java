package egovframework.espa.service.impl;

import java.util.Map;
import java.util.List;

import egovframework.espa.dao.ESPAExecuteResultVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("questionGradingMapper")
public interface QuestionGradingMapper {
	
	public List<Map<String, Object>> selectGradingList(Map<String, Object> map) throws Exception;
	
	public int insertGrading(Map<String, Object> map) throws Exception;
	
	public int updateGrading(Map<String, Object> map) throws Exception;
	
	public int deleteGradingByQuestionSeq(Map<String, Object> map) throws Exception;
	
	public int deleteGrading(Map<String, Object> map) throws Exception;
	
	public int updateGradingTestResult(ESPAExecuteResultVO map) throws Exception;
}
