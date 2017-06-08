package egovframework.dgms.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface AppInfService {
	
	/**
	 * 사용자 정보를 검색( 디바이스 정보 포함 )
	 * @param paramMap - 등록할 정보가 담긴 paramMap
	 * @return 등록 결과
	 * @exception Exception
	 */
	public List<HashMap<String, Object>> selectUserInfo(HashMap<String, Object> map) throws Exception;
	
	/**
	 * 모바일 장비 정보 등록
	 * @param paramMap - 등록할 정보가 담긴 paramMap
	 * @return 등록 결과
	 * @exception Exception
	 */
	public void insertDeviceInfo(HashMap<String,Object> paramMap) throws Exception;
	/**
	 * 모바일 장비 정보 검색
	 * @param paramMap - 등록할 정보가 담긴 paramMap
	 * @return 등록 결과
	 * @exception Exception
	 */
	public List<HashMap<String, Object>> selectDeviceInfo(HashMap<String,Object> paramMap) throws Exception;
	/**
	 * 모바일 장비 정보 업데이트(RegistrationID)
	 * @param paramMap - 등록할 정보가 담긴 paramMap
	 * @return 등록 결과
	 * @exception Exception
	 */
	public void updateDeviceInfo(HashMap<String,Object> paramMap) throws Exception;
	/**
	 * 메인 대시보드 정보 조회(심전도,혈압,약상자)
	 * @param paramMap - 등록할 정보가 담긴 paramMap
	 * @return 등록 결과
	 * @exception Exception
	 */
	public List<HashMap<String, Object>> selectMeasureScheduleInfo(HashMap<String, Object> map) throws Exception;
	/**
	 * 모바일 알림(PUS) 정보 등록
	 * @param paramMap - 등록할 정보가 담긴 paramMap
	 * @return 등록 결과
	 * @exception Exception
	 */
	public void insertMobilePushInfo(HashMap<String,Object> paramMap) throws Exception;
	/**
	 * 모바일 알림(PUS) 정보 업데이트
	 * @param paramMap - 등록할 정보가 담긴 paramMap
	 * @return 등록 결과
	 * @exception Exception
	 */
	public void updateMobilePushInfo(HashMap<String,Object> paramMap) throws Exception;
	/**
	 * 방송하지 않은 Push 정보 조회
	 * @param paramMap - 등록할 정보가 담긴 paramMap
	 * @return 등록 결과
	 * @exception Exception
	 */
	public List<HashMap<String, Object>> selectNotSendMobilePushInfo(HashMap<String,Object> paramMap) throws Exception;
	/**
	 * GPS 정보 등록
	 * @param paramMap - 등록할 정보가 담긴 paramMap
	 * @return 등록 결과
	 * @exception Exception
	 */
	public void insertGPSInfo(HashMap<String,Object> paramMap) throws Exception;
	/**
	 * 마지막 GPS 정보 조회
	 * @param paramMap - 등록할 정보가 담긴 paramMap
	 * @return 등록 결과
	 * @exception Exception
	 */
	public List<HashMap<String, Object>> selectLastGPSInfo(HashMap<String,Object> paramMap) throws Exception;
	/**
	 * 그룹 멤버의 정보 조회
	 * @param paramMap -조회할 정보가 담긴 paramMap
	 * @return 등록 결과
	 * @exception Exception
	 */
	public List<HashMap<String, Object>> getGroupMemberInfo(HashMap<String,Object> paramMap) throws Exception;
	/**
	 * 처방 정보 등록
	 * @param paramMap -처방 정보가 담긴 paramMap
	 * @return 등록 결과
	 * @exception Exception
	 */
	public void insertMyPrescriptInfo(HashMap<String,Object> paramMap) throws Exception;
	/**
	 * 처방 정보 조회
	 * @param paramMap -조회할  정보가 담긴 paramMap
	 * @return 등록 결과
	 * @exception Exception
	 */
	public List<HashMap<String, Object>> selectMyPrescriptInfo(HashMap<String,Object> paramMap) throws Exception;
	/**
	 * 처방 약품 정보 등록
	 * @param paramMap -처방 약품 정보가 담긴 paramMap
	 * @return 등록 결과
	 * @exception Exception
	 */
	public void insertMyPrescriptMedcInfo(HashMap<String,Object> paramMap) throws Exception;
	/**
	 * 약 정보 등록
	 * @param paramMap - 등록할 정보가 담긴 paramMap
	 * @return 등록 결과
	 * @exception Exception
	 */
	public void insertDrugInfo(HashMap<String,Object> paramMap) throws Exception;
	/**
	 * 약 정보 조회
	 * @param paramMap - 등록할 정보가 담긴 paramMap
	 * @return 등록 결과
	 * @exception Exception
	 */
	public List<HashMap<String, Object>> selectDrugInfo(HashMap<String,Object> paramMap) throws Exception;

	/**
	 * 문진표 메인응답 작성
	 * @param map
	 * @throws Exception
	 */
	public void insertMedcInquiryManswer(HashMap<String, Object> map) throws Exception;
	
	/**
	 * 문진표 서브응답 작성
	 * @param map
	 * @throws Exception
	 */
	public void insertMedcInquirySanswer(HashMap<String, Object> map) throws Exception;
	
	/**
	 * 문진표 정보
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	public List<HashMap<String, Object>> selectMedcInquiryAnswer(Map<String, Object> paramMap) throws Exception;
	
	/**
	 * 문진표 메인응답 수정
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	public void updateMedcInquiryManswer(HashMap<String, Object> map) throws Exception;

	/**
	 * 문진표 서브응답 수정
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	public void updateMedcInquirySanswer(HashMap<String, Object> map) throws Exception;

	/**
	 * 문진표 서브응답 삭제
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	public void deleteMedcInquirySanswer(HashMap<String, Object> map) throws Exception;


}
