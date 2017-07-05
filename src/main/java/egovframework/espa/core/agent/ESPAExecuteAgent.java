package egovframework.espa.core.agent;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.espa.core.execute.ESPAExcuteCode;
import egovframework.espa.core.execute.ESPAExecuteException;
import egovframework.espa.core.execute.handler.ESPAExecuteHandler;
import egovframework.espa.core.execute.handler.ESPAExecuteJavaHandler;
import egovframework.espa.core.execute.handler.ESPAExecuteResultHandler;
import egovframework.espa.dao.ESPAExecuteVO;
import egovframework.espa.service.ConfigService;

public class ESPAExecuteAgent {
	private Logger logger = LoggerFactory.getLogger(ESPAExecuteAgent.class.getName());
	
	private ESPAExecuteVO executeVo;
	private ConfigService config;
	private ESPAExecuteResultHandler resultHandler;
	
	public ESPAExecuteAgent(ESPAExecuteVO executeVo, ConfigService config) {
		this.executeVo = executeVo;
		this.config = config;
	}
	
	public void setExecuteVo(ESPAExecuteVO executeVo) {
		this.executeVo = executeVo;
	}

	public void setResultHandler(ESPAExecuteResultHandler resultHandler) {
		this.resultHandler = resultHandler;
	}

	public ConfigService getConfig() {
		return config;
	}

	public void setConfig(ConfigService config) {
		this.config = config;
	}

	public void execute() throws ESPAExecuteException {
		ESPAExecuteHandler handler = null;
		if(executeVo == null) {
			throw new NullPointerException("ESPAExecuteVO is null");
		}
		
		if(executeVo.getLanguage().equals("JAVA")) {
			handler = new ESPAExecuteJavaHandler(executeVo, config);
		} else if(executeVo.getLanguage().equals("C")) {
			throw new ESPAExecuteException("not support execute C", ESPAExcuteCode.ERR_NOT_SUPPORT);
		} else if(executeVo.getLanguage().equals("C++")) {
			throw new ESPAExecuteException("not support execute C++", ESPAExcuteCode.ERR_NOT_SUPPORT);
		} else if(executeVo.getLanguage().equals("Phython")) {
			throw new ESPAExecuteException("not support execute Phython", ESPAExcuteCode.ERR_NOT_SUPPORT);
		} else {
			throw new ESPAExecuteException("not support language: " + executeVo.getLanguage(), ESPAExcuteCode.ERR_NOT_SUPPORT);
		}
		logger.debug("Start ESPAExecuteHandler: " + executeVo.getLanguage());
		try{
			handler.execute();
		} catch (ESPAExecuteException e) {
			e.printStackTrace();
			executeVo.setError(e);
			e.getMessage();
		}
		
		executeVo.setResultList(handler.getResult());
		logger.debug("Finish ESPAExecuteHandler");
		if(resultHandler != null) {
			logger.debug("Handle resultHandler");
			resultHandler.handleResult(executeVo);
		}
	}
}
