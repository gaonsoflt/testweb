package egovframework.espa.core.execute.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.espa.core.execute.ESPAExcuteCode;
import egovframework.espa.core.execute.ESPAExecuteException;
import egovframework.espa.dao.ESPAExecuteResultVO;
import egovframework.espa.dao.ESPAExecuteVO;
import egovframework.espa.service.ConfigService;
import egovframework.espa.util.StringUtil;

public abstract class ESPAExecuteHandler {
	private Logger logger = LoggerFactory.getLogger(ESPAExecuteHandler.class.getName());
	ESPAExecuteVO vo;
	ConfigService config;
	ESPAExecuteGradingHandler gradingHandler;
	
	public ESPAExecuteHandler() {
		this.gradingHandler = new ESPAExecuteGradingHandlerImpl();
	}
	
	private boolean banKeyword = false;
	// check execution code(comile, ban, condition)
	private boolean ready = true;
	private ESPAExecuteException exception;
	private List<ESPAExecuteResultVO> result;
	
	protected abstract boolean createSourceFile() throws ESPAExecuteException;
	protected abstract boolean compile() throws ESPAExecuteException;
	protected abstract long run() throws ESPAExecuteException;
	protected abstract boolean createInputFile(String content) throws ESPAExecuteException;
	protected abstract String readOutputFile() throws ESPAExecuteException;

	protected boolean checkCondBanKeyword(String[] keywords) throws ESPAExecuteException {
		logger.debug("check ban_keyword");
		for (String keyword : keywords) {
			if (!keyword.isEmpty()) {
				boolean included = StringUtil.existString(vo.getCode(), keyword);

				if (included) {
					logger.error("ban_keyword [" + keyword + "] is included");
					setBanKeyword(true);
					throw new ESPAExecuteException("include ban keyword in code", ESPAExcuteCode.ERR_BAN_KW);
				}
				logger.debug("ban_keyword [" + keyword + "] is not included");
			}
		}
		logger.debug("pass to check ban_keyword");
		return true;
	}
	
	protected boolean checkCodeSize(String code) throws ESPAExecuteException {
		if(code.length() > vo.getMaxCodeSize()) {
			throw new ESPAExecuteException("this size of code is too larger than the max size of code (" + vo.getMaxCodeSize() + ")", ESPAExcuteCode.ERR_CODE_SIZE);
		}
		logger.debug("pass to check code size");
		return true;
	}
	
	
	public void execute() throws ESPAExecuteException {
		long start = System.nanoTime();

		// 0. check ban_keyword
		checkCondBanKeyword(vo.getBanKeyword());
		checkCodeSize(vo.getCode());

		// 1. create execute file(.java, .c, ccp...)
		if(createSourceFile()) {
			logger.debug("success to create execute file");		
		}
		
		// 2. execute compile
		if(compile()) {
			logger.debug("success to excute compile");
		}
		
		// ready(true) = completed compile and not include ban keyword
		logger.debug("create input/output file size: " + vo.getGrading().size());
		for (int i = 0; i < vo.getGrading().size(); i++) {
			ESPAExecuteResultVO result = new ESPAExecuteResultVO();
			HashMap<String, Object> grading = vo.getGrading().get(i);
			result.setQuestionSeq(Long.valueOf(vo.getQuestionSeq()));
			result.setGradingSeq(Long.valueOf(grading.get("grading_seq").toString()));
			result.setGradingOrder(Long.valueOf(grading.get("grading_order").toString()));
			result.setUserSeq(vo.getUserSeq());
			result.setDeploySeq(vo.getDeploySeq());
			result.setSubmitDt(vo.getSubmitDt());

			logger.debug("create input file: " + (i + 1));
			try {
				// 3. create grading input file as much as grading size
				if(createInputFile(grading.get("grading_input").toString())) {
					logger.debug("success to create iuput file");
				}
				
				// 4. execute run
				long executeTime = run();
				logger.debug("success to excute run");
				result.setExecuteTime(executeTime);
				
				// 5. read executed output file
				String output = readOutputFile();
				logger.debug("Output: " + output);
				
				// 6. read grading output
				// logger.debug("success to read grading Output file");
				String gradingOutput = grading.get("grading_output").toString();
				logger.debug("gradingOutput: " + gradingOutput);
				
				// 7. compare with output between output file
				double socoreRate = gradingHandler.grade(gradingOutput, output);
				if (socoreRate == 0) {
					result.setException(new ESPAExecuteException("not equals with grading output between output",
							ESPAExcuteCode.ERR_NOT_EQUALS));
				}
				result.setSocoreRate(socoreRate);
			} catch (ESPAExecuteException e) {
				logger.error("fail to execute run");
				result.setException(e);
			}
			getResult().add(result);
		}
		start = System.nanoTime() - start;
		logger.debug("total execution time: " + (start / 1000000) + "ms");
	}

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

	public ESPAExecuteGradingHandler getGradingHandler() {
		return gradingHandler;
	}

	public void setGradingHandler(ESPAExecuteGradingHandler gradingHandler) {
		this.gradingHandler = gradingHandler;
	}
}
