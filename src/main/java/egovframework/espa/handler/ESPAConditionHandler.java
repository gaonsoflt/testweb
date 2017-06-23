package egovframework.espa.handler;

import egovframework.espa.dao.ESPAExecuteVO;

public interface ESPAConditionHandler {
	public void checkCondition(ESPAExecuteVO vo) throws Exception;
}
