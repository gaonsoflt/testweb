package egovframework.espa.dao;

public class ESPAExecuteResultVO {
	private long executeTime = 0;
	private boolean banKeyword = false;

	public long getExecuteTime() {
		return executeTime;
	}

	public void setExecuteTime(long executeTime) {
		this.executeTime = executeTime;
	}

	public boolean isBanKeyword() {
		return banKeyword;
	}

	public void setBanKeyword(boolean banKeyword) {
		this.banKeyword = banKeyword;
	}

}
