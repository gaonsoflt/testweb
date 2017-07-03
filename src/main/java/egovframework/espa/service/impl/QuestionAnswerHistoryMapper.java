package egovframework.espa.service.impl;

import java.util.HashMap;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("questionAnswerHistoryMapper")
public interface QuestionAnswerHistoryMapper {
	public int insertAnswerHistory(HashMap<String, Object> map) throws Exception;
}
