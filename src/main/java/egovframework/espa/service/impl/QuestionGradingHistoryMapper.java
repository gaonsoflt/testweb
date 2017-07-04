package egovframework.espa.service.impl;

import java.util.HashMap;
import java.util.List;

import egovframework.espa.dao.ESPAExecuteResultVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("questionGradingHistoryMapper")
public interface QuestionGradingHistoryMapper {
	public List<HashMap<String, Object>> readLatestGradingHistoryByUser(HashMap<String, Object> map) throws Exception;
	
	public int createGradingHistory(ESPAExecuteResultVO vo) throws Exception;
}
