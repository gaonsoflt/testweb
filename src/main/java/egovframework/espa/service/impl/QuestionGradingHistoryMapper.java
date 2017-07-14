package egovframework.espa.service.impl;

import java.util.Map;
import java.util.List;

import egovframework.espa.dao.ESPAExecuteResultVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("questionGradingHistoryMapper")
public interface QuestionGradingHistoryMapper {
	public List<Map<String, Object>> readLatestGradingHistoryByUser(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> readGradingResultUserList(Map<String, Object> map) throws Exception;
	
	public int createGradingHistory(ESPAExecuteResultVO vo) throws Exception;
}
