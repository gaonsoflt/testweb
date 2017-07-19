package egovframework.espa.service.impl;

import java.util.Map;

import egovframework.espa.dao.ESPAExecuteVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("questionAnswerHistoryMapper")
public interface QuestionAnswerHistoryMapper {
	public boolean checkUserSubmitCount(Map<String, Object> map) throws Exception;
	
	public int insertAnswerHistory(Map<String, Object> map) throws Exception;
	
	public int updateAnswerError(ESPAExecuteVO vo) throws Exception;
}
