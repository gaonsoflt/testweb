package egovframework.espa.core.execute.handler;

import java.util.ArrayList;
import java.util.List;

import egovframework.espa.core.execute.ESPAExecuteException;
import egovframework.espa.dao.ESPAExecuteResultVO;
import egovframework.espa.dao.ESPAExecuteVO;
import egovframework.espa.service.ConfigService;

public abstract class ESPAExecuteHandler {
	ESPAExecuteVO vo;
	ConfigService config;
	
	private boolean banKeyword = false;
	// comile, ban, condition
	private boolean ready = true;
	private ESPAExecuteException exception;
	private List<ESPAExecuteResultVO> result;
	
	public abstract void execute() throws ESPAExecuteException;

	public boolean isBanKeyword() {
		return banKeyword;
	}

	public void setBanKeyword(boolean banKeyword) {
		this.banKeyword = banKeyword;
	}

	public boolean isReady() {
		return ready;
	}

	public void setReady(boolean ready) {
		this.ready = ready;
	}

	public ESPAExecuteException getException() {
		return exception;
	}

	public void setException(ESPAExecuteException exception) {
		this.ready = false;
		this.exception = exception;
	}

	public List<ESPAExecuteResultVO> getResult() {
		if(result == null) {
			result = new ArrayList<>();
		}
		return result;
	}

	public void setResult(List<ESPAExecuteResultVO> result) {
		this.result = result;
	}
}
