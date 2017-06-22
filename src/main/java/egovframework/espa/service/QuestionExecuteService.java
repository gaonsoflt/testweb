package egovframework.espa.service;

import java.util.HashMap;

import egovframework.espa.dao.ESPAExecuteVO;

public interface QuestionExecuteService {

	public ESPAExecuteVO executeTest(HashMap<String, Object> map) throws Exception;
	public ESPAExecuteVO execute(HashMap<String, Object> map) throws Exception;
}
