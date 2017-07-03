package egovframework.espa.service.impl;

import egovframework.espa.dao.ESPAExecuteResultVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("questionGradingHistoryMapper")
public interface QuestionGradingHistoryMapper {
	public int insertGradingHistory(ESPAExecuteResultVO map) throws Exception;
}
