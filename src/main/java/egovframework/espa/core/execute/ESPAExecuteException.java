package egovframework.espa.core.execute;

public class ESPAExecuteException extends Exception {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private final ESPAExcuteCode ERR_CODE;
	
	public ESPAExecuteException(String msg) {
		super(msg);
		this.ERR_CODE = ESPAExcuteCode.ERR_UNKNOW;
	}
	
	public ESPAExecuteException(String msg, ESPAExcuteCode code) {
		super(msg);
		this.ERR_CODE = code;
	}
	
	public ESPAExcuteCode getErrCode() {
		return this.ERR_CODE;
	}
}
