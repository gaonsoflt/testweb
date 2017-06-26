package egovframework.espa.dao;

import egovframework.espa.core.execute.ESPAExecuteException;

public class ESPAExecuteResultVO {
	private long questionSeq;
	private long gradingSeq;
	private long executeTime = 0;
	private String executeOutStream;
	private boolean correct = true;
	private ESPAExecuteException exception;
	
	public long getQuestionSeq() {
		return questionSeq;
	}

	public void setQuestionSeq(long questionSeq) {
		this.questionSeq = questionSeq;
	}

	public long getGradingSeq() {
		return gradingSeq;
	}

	public void setGradingSeq(long gradingSeq) {
		this.gradingSeq = gradingSeq;
	}

	public boolean isCorrect() {
		return correct;
	}

	public void setCorrect(boolean correct) {
		this.correct = correct;
	}

	public ESPAExecuteException getException() {
		return exception;
	}

	public void setException(ESPAExecuteException exception) {
		this.correct = false;
		this.exception = exception;
	}

	public String getExecuteOutStream() {
		return executeOutStream;
	}

	public void setExecuteOutStream(String executeOutStream) {
		this.executeOutStream = executeOutStream;
	}

	public long getExecuteTime() {
		return executeTime;
	}

	public void setExecuteTime(long executeTime) {
		this.executeTime = executeTime;
	}
}
