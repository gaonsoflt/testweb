package egovframework.espa.dao;

import java.sql.Timestamp;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import egovframework.espa.core.execute.ESPAExcuteCode;
import egovframework.espa.core.execute.ESPAExecuteException;
import egovframework.espa.core.execute.handler.ESPAExecuteGradingHandler;

public class ESPAExecuteVO {
	private long questionSeq;
	private long deploySeq;
	private long userSeq;
	private String code;
	private Timestamp submitDt;
	private String language;
	private long timeout;
	private String[] banKeyword;
	private long maxCodeSize;
	private List<HashMap<String, Object>> condition;
	private List<HashMap<String, Object>> grading;
	private ESPAExecuteGradingHandler gradingHandler;
	private boolean isTest;
	private ESPAExecuteException error;
	private ESPAExcuteCode errCode;
	private String errMsg;
	
	//execute result
	private List<ESPAExecuteResultVO> resultList;
	
	public List<ESPAExecuteResultVO> getResultList() {
		return resultList;
	}

	public void setResultList(List<ESPAExecuteResultVO> resultList) {
		this.resultList = resultList;
	}

	public String getCode() {
		return code;
	}

	public long getMaxCodeSize() {
		return maxCodeSize;
	}

	public void setMaxCodeSize(long maxCodeSize) {
		this.maxCodeSize = maxCodeSize;
	}

	public long getQuestionSeq() {
		return questionSeq;
	}

	public void setQuestionSeq(long questionSeq) {
		this.questionSeq = questionSeq;
	}

	public long getDeploySeq() {
		return deploySeq;
	}

	public void setDeploySeq(long deploySeq) {
		this.deploySeq = deploySeq;
	}

	public long getUserSeq() {
		return userSeq;
	}

	public void setUserSeq(long userSeq) {
		this.userSeq = userSeq;
	}

	public long getTimeout() {
		return timeout;
	}

	public void setTimeout(long timeout) {
		this.timeout = timeout;
	}

	public String[] getBanKeyword() {
		return banKeyword;
	}
	
	public String getBanKeyword(int index) {
		return banKeyword[index];
	}

	public void setBanKeyword(String banKeyword) {
		setBanKeyword(banKeyword, ",");
	}
	
	public void setBanKeyword(String banKeyword, String split) {
		this.banKeyword = banKeyword.split(split);
	}
	
	public void setBanKeyword(String[] banKeyword) {
		this.banKeyword = banKeyword;
	}

	public void setCode(String code) {
		this.code = code;
	}
	
	public Timestamp getSubmitDt() {
		return submitDt;
	}

	public void setSubmitDt(Timestamp submitDt) {
		this.submitDt = submitDt;
	}

	public String getLanguage() {
		return language;
	}

	public void setLanguage(String language) {
		this.language = language;
	}

	public List<HashMap<String, Object>> getCondition() {
		return condition;
	}
	
	public void setCondition(List<HashMap<String, Object>> condition) {
		this.condition = condition;
	}
	
	public List<HashMap<String, Object>> getGrading() {
		return grading;
	}
	
	public void setGrading(List<HashMap<String, Object>> grading) {
		this.grading = grading;
	}
	
	public boolean isTest() {
		return isTest;
	}

	public void setTest(boolean isTest) {
		this.isTest = isTest;
	}

	public ESPAExecuteException getError() {
		return error;
	}
	
	public void setError(ESPAExecuteException error) {
		this.error = error;
		this.errCode = error.getErrCode();
		this.errMsg = error.getMessage();
	}
	
	public ESPAExcuteCode getErrCode() {
		return errCode;
	}

	public String getErrMsg() {
		return errMsg;
	}
	
	public ESPAExecuteGradingHandler getGradingHandler() {
		return gradingHandler;
	}

	public void setGradingHandler(ESPAExecuteGradingHandler gradingHandler) {
		this.gradingHandler = gradingHandler;
	}

	@Override
	public String toString() {
		return "ESPAExecuteVO [questionSeq=" + questionSeq + ", deploySeq=" + deploySeq + ", userSeq=" + userSeq
				+ ", code=" + code + ", submitDt=" + submitDt + ", language=" + language + ", timeout=" + timeout
				+ ", banKeyword=" + Arrays.toString(banKeyword) + ", maxCodeSize=" + maxCodeSize + ", condition="
				+ condition + ", grading=" + grading + ", gradingHandler=" + gradingHandler + ", isTest=" + isTest
				+ ", error=" + error + ", resultList=" + resultList + "]";
	}
}


