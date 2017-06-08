package egovframework.com.user.service;

import java.io.Serializable;

public class UserInfoVo implements Serializable {

/**
	 * 
	 */
	private static final long serialVersionUID = 1447595107172095792L;
	
/*	USER_SEQ	VARCHAR2(20)	N			사용자SEQ
	AREA_ID	VARCHAR2(20)	N			행정구역ID
	USER_NM	VARCHAR2(500)	N			성명
	MOBILE_NO	VARCHAR2(11)	Y			핸드폰
	LOGIN_PWD	VARCHAR2(4000)	N			패스워드
	SEX	CHAR(1)	N			성별
	BIRTHDAY	CHAR(6)	N			생년
	ADDR_CIDO	VARCHAR2(20)	N			주소_시도SEQ
	USER_TYPE	VARCHAR2(20)	N			사용자분류
	USER_ID	VARCHAR2(500)	N			사용자ID
	USE_YN	CHAR(1)	Y			사용여부
	PATIENT_SEQ	VARCHAR2(20)	Y			환자SEQ
	INS_SEQ	VARCHAR2(20)	N			등록자
	INS_DT	CHAR(12)	N			등록일
	UPT_SEQ	VARCHAR2(20)	Y			수정자
	UPT_DT	CHAR(12)	Y			수정일
	AUTH_TYPE	VARCHAR2(20)	N			권한유형
	ADDR_CIGUNGU	VARCHAR2(20)	N			주소_시군구SEQ*/
	
	public String userSeq;
	public String areaId;
	public String userNm;
	public String mobileNo;
	
	public String loginPwd;
	public String userId;
	public String userType;
	public String useYn;
	
	
	
	/**
	 * @return the userSeq
	 */
	public String getUserSeq() {
		return userSeq;
	}
	/**
	 * @param userSeq the userSeq to set
	 */
	public void setUserSeq(String userSeq) {
		this.userSeq = userSeq;
	}
	/**
	 * @return the areaId
	 */
	public String getAreaId() {
		return areaId;
	}
	/**
	 * @param areaId the areaId to set
	 */
	public void setAreaId(String areaId) {
		this.areaId = areaId;
	}
	/**
	 * @return the userNm
	 */
	public String getUserNm() {
		return userNm;
	}
	/**
	 * @param userNm the userNm to set
	 */
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	/**
	 * @return the mobileNo
	 */
	public String getMobileNo() {
		return mobileNo;
	}
	/**
	 * @param mobileNo the mobileNo to set
	 */
	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}
	/**
	 * @return the loginPwd
	 */
	public String getLoginPwd() {
		return loginPwd;
	}
	/**
	 * @param loginPwd the loginPwd to set
	 */
	public void setLoginPwd(String loginPwd) {
		this.loginPwd = loginPwd;
	}
	/**
	 * @return the userId
	 */
	public String getUserId() {
		return userId;
	}
	/**
	 * @param userId the userId to set
	 */
	public void setUserId(String userId) {
		this.userId = userId;
	}
	/**
	 * @return the userType
	 */
	public String getUserType() {
		return userType;
	}
	/**
	 * @param userType the userType to set
	 */
	public void setUserType(String userType) {
		this.userType = userType;
	}
	/**
	 * @return the useYn
	 */
	public String getUseYn() {
		return useYn;
	}
	/**
	 * @param useYn the useYn to set
	 */
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	
	
	
}


