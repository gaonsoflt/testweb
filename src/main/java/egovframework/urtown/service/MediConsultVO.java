package egovframework.urtown.service;

import java.io.Serializable;
import java.sql.Date;

public class MediConsultVO implements Serializable {

	private static final long serialVersionUID = 1447595107172095792L;
	
	public Double mediConsultSq;
	public String areaGb;
	public Double requestNo;
	public String statusCd;
	public Integer userNo;
	public Date consultReqDt;
	public Double checkupNo;
	public String issueNote;
	public Date regDt;
	public String regUser;
	public Date modDt;
	public String modUser;
	
	
	public Double getMediConsultSq() {
		return mediConsultSq;
	}
	public void setMediConsultSq(Double mediConsultSq) {
		this.mediConsultSq = mediConsultSq;
	}
	public String getAreaGb() {
		return areaGb;
	}
	public void setAreaGb(String areaGb) {
		this.areaGb = areaGb;
	}
	public Double getRequestNo() {
		return requestNo;
	}
	public void setRequestNo(Double requestNo) {
		this.requestNo = requestNo;
	}
	public String getStatusCd() {
		return statusCd;
	}
	public void setStatusCd(String statusCd) {
		this.statusCd = statusCd;
	}
	public Integer getUserNo() {
		return userNo;
	}
	public void setUserNo(Integer userNo) {
		this.userNo = userNo;
	}
	public Date getConsultReqDt() {
		return consultReqDt;
	}
	public void setConsultReqDt(Date consultReqDt) {
		this.consultReqDt = consultReqDt;
	}
	public Double getCheckupNo() {
		return checkupNo;
	}
	public void setCheckupNo(Double checkupNo) {
		this.checkupNo = checkupNo;
	}
	public String getIssueNote() {
		return issueNote;
	}
	public void setIssueNote(String issueNote) {
		this.issueNote = issueNote;
	}
	public Date getRegDt() {
		return regDt;
	}
	public void setRegDt(Date regDt) {
		this.regDt = regDt;
	}
	public String getRegUser() {
		return regUser;
	}
	public void setRegUser(String regUser) {
		this.regUser = regUser;
	}
	public Date getModDt() {
		return modDt;
	}
	public void setModDt(Date modDt) {
		this.modDt = modDt;
	}
	public String getModUser() {
		return modUser;
	}
	public void setModUser(String modUser) {
		this.modUser = modUser;
	}
}


