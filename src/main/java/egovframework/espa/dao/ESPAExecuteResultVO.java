package egovframework.espa.dao;

import java.sql.Timestamp;

import egovframework.espa.core.execute.ESPAExecuteException;

public class ESPAExecuteResultVO {
	private long questionSeq;
	private long deploySeq;
	private long userSeq;
	private long gradingSeq;
	private long gradingOrder;
	private Timestamp submitDt;
	private long executeTime = 0;
	private String executeOutStream;
	private double socoreRate = 0; // 1.0 ~ 0.0
	private boolean correct = true;
	private ESPAExecuteException exception;
	
	
	public long getUserSeq() {
		return userSeq;
	}

	public void setUserSeq(long userSeq) {
		this.userSeq = userSeq;
	}

	public long getDeploySeq() {
		return deploySeq;
	}

	public void setDeploySeq(long deploySeq) {
		this.deploySeq = deploySeq;
	}

	public void setCorrect(boolean correct) {
		this.correct = correct;
	}

	public long getQuestionSeq() {
		return questionSeq;
	}

	public void setQuestionSeq(long questionSeq) {
		this.questionSeq = questionSeq;
	}

	public double getSocoreRate() {
		return socoreRate;
	}

	public long getGradingOrder() {
		return gradingOrder;
	}

	public void setGradingOrder(long gradingOrder) {
		this.gradingOrder = gradingOrder;
	}

	public void setSocoreRate(double socoreRate) {
		this.socoreRate = socoreRate;
		if(socoreRate > 0) {
			this.correct = true;
		} else {
			this.correct = false;
		}
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

	public ESPAExecuteException getException() {
		return exception;
	}

	public void setException(ESPAExecuteException exception) {
		setSocoreRate(0);
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
	
	public Timestamp getSubmitDt() {
		return submitDt;
	}

	public void setSubmitDt(Timestamp submitDt) {
		this.submitDt = submitDt;
	}

	@Override
	public String toString() {
		return "ESPAExecuteResultVO [questionSeq=" + questionSeq + ", deploySeq=" + deploySeq + ", userSeq=" + userSeq
				+ ", gradingSeq=" + gradingSeq + ", gradingOrder=" + gradingOrder + ", submitDt=" + submitDt
				+ ", executeTime=" + executeTime + ", executeOutStream=" + executeOutStream + ", socoreRate="
				+ socoreRate + ", correct=" + correct + ", exception=" + exception + "]";
	}
}
