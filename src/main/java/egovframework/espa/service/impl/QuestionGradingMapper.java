package egovframework.espa.service.impl;

import java.util.HashMap;
import java.util.List;

import egovframework.espa.dao.ESPAExecuteResultVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("questionGradingMapper")
public interface QuestionGradingMapper {
	
	public List<HashMap<String, Object>> selectGradingList(HashMap<String, Object> map) throws Exception;
	
	public int insertGrading(HashMap<String, Object> map) throws Exception;
	
	public int updateGrading(HashMap<String, Object> map) throws Exception;
	
	public int deleteGrading(HashMap<String, Object> map) throws Exception;
	
	public int updateGradingTestResult(ESPAExecuteResultVO map) throws Exception;
}
