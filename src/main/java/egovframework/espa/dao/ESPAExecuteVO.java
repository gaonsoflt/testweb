package egovframework.espa.dao;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

public class ESPAExecuteVO {
	private String questionSeq;
	private String code;
	private String language;
	private long timeout;
	private String[] banKeyword;
	private List<HashMap<String, Object>> condition;
	private List<HashMap<String, Object>> grading;
	private boolean isTest;
	private Exception error;
	
	public String getCode() {
		return code;
	}

	public String getQuestionSeq() {
		return questionSeq;
	}

	public void setQuestionSeq(String questionSeq) {
		this.questionSeq = questionSeq;
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

	public Exception getError() {
		return error;
	}
	
	public void setError(Exception error) {
		this.error = error;
	}

	@Override
	public String toString() {
		return "ESPAExecuteVO [questionSeq=" + questionSeq + ", code=" + code + ", language=" + language + ", timeout="
				+ timeout + ", banKeyword=" + Arrays.toString(banKeyword) + ", condition=" + condition + ", grading="
				+ grading + ", isTest=" + isTest + ", error=" + error + "]";
	} 
}


