package egovframework.espa.service;

import java.util.HashMap;

import egovframework.espa.dao.ESPAExecuteVO;

public interface QuestionExecuteService {

	public void executeTest(HashMap<String, Object> map) throws Exception;
	public void execute(HashMap<String, Object> map) throws Exception;
}
